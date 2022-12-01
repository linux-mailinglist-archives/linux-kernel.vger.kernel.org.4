Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF263EC57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLAJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLAJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780889AED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:22:07 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vp12so2696093ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=AEJ5Dr7zB416GNoTNHNKS9rh5+Y2xhjAKHwoZGCbN23KANzvgKbjQsTMwcHfU9//gc
         7eEuqNfoarSzqd6Hub73JzuxHzfZ3zuKU8KbpyRTmxVxZ8jxQLHg56ngi90cCF+1I+IA
         ETujKamyy5Lki/kXzCCBzo3ZCdibteSRokDjyYZX6sa+sYTcCUzC47vjDpeOoHjJTFgi
         LldbFFMwGZoiqaX8LPCS0KrhY+dGHtSyCwpi8DfDbiKu4JcKUTRiGGW0qYhoXcVNL1xz
         C1ymFTKcSVgFRNt9TI20M1niY9gxYghKhHzmRWDYslmPMfNQ9FTKs+DyFqKxnbtnlWCx
         997A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=i0yGl02n6kxRnNhZistUJDyf9h2Cj6zcfTmaJwKUDJTyoiZWzth7ARw70TmvFcgRIi
         IhrMskPxeGll0wHPE4VivhElr3MhYp/nInN90anjwcVwoRdrpN0IQNAQS96PCD4tuqUY
         xALGO3DmgUOrHvUls4CzYxU6mvUQhNJkkfn18VcNqyL0YgKvQSA40VbZTa3qGBduUnfQ
         aVgsH7egVIIEkWuYmUARt4L5o+fxFqH34D/L2ZE8tjfQgXCJ2IibIfwCU0onAb5r27ow
         P3/p5ybUTVvGY3+4qgNFewxKtKX8qY0gTPnUMctDWwLSaaaI68xi9wW3CAcUs5EAb77k
         10bQ==
X-Gm-Message-State: ANoB5pkAYrmg0KG5HPzpGSTRdZw/3Qhul7opxDBSZnb1peqF55LyfDww
        M+wV+NNVdhYhFKa32QbO0yE=
X-Google-Smtp-Source: AA0mqf4U7Jfjt9v07Np5vCGzYbUwDTHC1Yq1KbW+C75UIdsapP471QhHYnSvQepDZC4sLwYcl3Z1lw==
X-Received: by 2002:a17:906:1ecf:b0:7ad:902c:d1d6 with SMTP id m15-20020a1709061ecf00b007ad902cd1d6mr43010098ejj.143.1669886525782;
        Thu, 01 Dec 2022 01:22:05 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:05 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/7] drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
Date:   Thu,  1 Dec 2022 10:21:26 +0100
Message-Id: <20221201092131.62867-6-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
References: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a compute-only module marketed towards AI and vision
acceleration. This particular version can be found on the Amlogic A311D
SoC.

The feature bits are taken from the Khadas downstream kernel driver
6.4.4.3.310723AAA.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index f2fc645c7956..3f6fd9a3c088 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -130,6 +130,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.minor_features10 = 0x90044250,
 		.minor_features11 = 0x00000024,
 	},
+	{
+		.model = 0x8000,
+		.revision = 0x7120,
+		.product_id = 0x45080009,
+		.customer_id = 0x88,
+		.eco_id = 0,
+		.stream_count = 8,
+		.register_max = 64,
+		.thread_count = 256,
+		.shader_core_count = 1,
+		.vertex_cache_size = 16,
+		.vertex_output_buffer_size = 1024,
+		.pixel_pipes = 1,
+		.instruction_count = 512,
+		.num_constants = 320,
+		.buffer_size = 0,
+		.varyings_count = 16,
+		.features = 0xe0287cac,
+		.minor_features0 = 0xc1799eff,
+		.minor_features1 = 0xfefbfadb,
+		.minor_features2 = 0xeb9d6fbf,
+		.minor_features3 = 0xedfffced,
+		.minor_features4 = 0xd30dafc7,
+		.minor_features5 = 0x7b5ac333,
+		.minor_features6 = 0xfc8ee200,
+		.minor_features7 = 0x03fffa6f,
+		.minor_features8 = 0x00fe0ef0,
+		.minor_features9 = 0x0088003c,
+		.minor_features10 = 0x108048c0,
+		.minor_features11 = 0x00000010,
+	},
 };
 
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
-- 
2.38.1

