Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12736A0AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjBWNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjBWNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:35:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971015679F;
        Thu, 23 Feb 2023 05:35:03 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A474E6602208;
        Thu, 23 Feb 2023 13:35:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159302;
        bh=d98v4XkYuSdlaBMRVhy8ckf3WPpqfT9gFqNu9PlgtLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiGnh69IV/fDTW/ttFIjrRlyQipfGpN6lJfGvE8RG2QP5PA2XxzKvXP5T0Ng30Nbu
         RPgrEYsC2hIJHKsn+o/2NYBKQ9jEsCy2fur4ybtcGZNpVj3tQ1RPclzrvY4ehkELXv
         qTproiq1OpDgtg28YiTGIaxko0qMPLWKxsSdMg0KRImVJzxDUGCaeQuSjjec5g/Wkz
         8u9XDpkT2rBpeC/ReF60wO+BuIIRTK3ZzPVxsbtrA01FkZ/pNVOuPUJdfv72MaCrET
         gNF76Um5JwfxiPt318kFBhfmNHuUfMmvoLEjMu/hZ8p1LH2fMEdCvE4SqoWq9Cr4zh
         lrM0jQS0jAynw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 10/11] drm/panfrost: Add new compatible for Mali on the MT8183 SoC
Date:   Thu, 23 Feb 2023 14:34:39 +0100
Message-Id: <20230223133440.80941-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mediatek,mt8183-mali" compatible uses platform data that calls for
getting (and managing) two regulators ("mali" and "sram") but devfreq
does not support this usecase, resulting in DVFS not working.

Since a lot of MediaTek SoCs need to set the voltages for the GPU SRAM
regulator in a specific relation to the GPU VCORE regulator, a MediaTek
SoC specific driver was introduced to automatically satisfy, through
coupling, these constraints: this means that there is at all no need to
manage both regulators in panfrost but to otherwise just manage the main
"mali" (-> gpu vcore) regulator instead.

Keeping in mind that we cannot break the ABI, the most sensible route
(avoiding hacks and uselessly overcomplicated code) to get a MT8183
node with one power supply was to add a new "mediatek,mt8183b-mali"
compatible, which effectively deprecates the former.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 5d25e77e1037..14cdeaeeb5c4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -654,6 +654,14 @@ static const struct panfrost_compatible amlogic_data = {
 	.vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
+/*
+ * The old data with two power supplies for MT8183 is here only to
+ * keep retro-compatibility with older devicetrees, as DVFS will
+ * not work with this one.
+ *
+ * On new devicetrees please use the _b variant with a single and
+ * coupled regulators instead.
+ */
 static const char * const mediatek_mt8183_supplies[] = { "mali", "sram", NULL };
 static const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
 static const struct panfrost_compatible mediatek_mt8183_data = {
@@ -663,6 +671,14 @@ static const struct panfrost_compatible mediatek_mt8183_data = {
 	.pm_domain_names = mediatek_mt8183_pm_domains,
 };
 
+static const char * const mediatek_mt8183_b_supplies[] = { "mali", NULL };
+static const struct panfrost_compatible mediatek_mt8183_b_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
+	.supply_names = mediatek_mt8183_b_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+};
+
 static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
 static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
 							   "core3", "core4" };
@@ -691,6 +707,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
 	{ .compatible = "arm,mali-valhall-jm", .data = &default_data, },
 	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
+	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
 	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
 	{}
 };
-- 
2.39.2

