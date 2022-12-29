Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46D4658D50
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiL2NdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiL2Nch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:32:37 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C310FC7;
        Thu, 29 Dec 2022 05:32:35 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 22963FF810;
        Thu, 29 Dec 2022 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672320754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxGIJCef9c0twbq/D4ksS34yk0nVt24wbkjICVr+NEc=;
        b=SG3KV1fVDNj7ijnQf7DjsPLWGdQNLQJ9QsZHfvRKpIiQLNxnrm8ZBK6eBeqX71Y0CTWwQC
        DOjboBANQ9XeA2Iw2AFaWFDZrwZLpDzl3TeANGWMBCvhGWOvAbtV2xZY2gS/8Ur9vhG/+m
        WDfo+85JinfsXhooviBIv95oZuSV7X5qvO2N1z50QO7BTfjH9JSUlycXD1doJ8OWHw8TEw
        vrzLMIf87wmDHKu6YpgFB9d832tbM7UTUsl6jFAceD9R9FqBvQgfhX06jw8OyZETLUQEaf
        1lc82Kg1m+ur0RobyjLWAa3I8idQhtufehYoDiZARh5yjvmNgj9sS26Z3lQUEQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v3 07/21] staging: media: tegra-video: improve error messages
Date:   Thu, 29 Dec 2022 14:31:51 +0100
Message-Id: <20221229133205.981397-8-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_vi_channels_alloc() can primarily fail for two reasons:

 1. "ports" node not found
 2. port_num > vi->soc->vi_max_channels

Case 1 prints nothing, case 2 has a dev_err(). The caller [tegra_vi_init()]
has a generic dev_err() on any failure. This mean that in case 2 we print
two messages, and in case 1 we only print a generic message.

Remove the generic message and add a specific message when case 1 happens,
so that we always have one specific message without even increasing the
number of dev_dbg*() calls.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index ae7adf640e76..0e5067a7986a 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1272,7 +1272,7 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 
 	ports = of_get_child_by_name(node, "ports");
 	if (!ports)
-		return -ENODEV;
+		return dev_err_probe(vi->dev, -ENODEV, "%pOF: missing 'ports' node\n", node);
 
 	for_each_child_of_node(ports, port) {
 		if (!of_node_name_eq(port, "port"))
@@ -1824,11 +1824,8 @@ static int tegra_vi_init(struct host1x_client *client)
 		ret = tegra_vi_tpg_channels_alloc(vi);
 	else
 		ret = tegra_vi_channels_alloc(vi);
-	if (ret < 0) {
-		dev_err(vi->dev,
-			"failed to allocate vi channels: %d\n", ret);
+	if (ret < 0)
 		goto free_chans;
-	}
 
 	ret = tegra_vi_channels_init(vi);
 	if (ret < 0)
-- 
2.34.1

