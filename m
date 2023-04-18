Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A36E5B54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjDRICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjDRIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:01:58 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC9729D;
        Tue, 18 Apr 2023 01:01:28 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id CABDF240009;
        Tue, 18 Apr 2023 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4hLigvdbOVO3P4ObAFFWRZdoPUgyggKpMDr+PVSErU=;
        b=ej0CFkiYcDlbNTe95lM4ZQRGtji1xCD/12axQgLoDUa2qIc82WGBOukcHlE/3ZY8oBXrMh
        ObGlJCM9Brxe2PHwcWvobDsxHSnqDX59DJqncnSrFqRpmybNbWHnRT82EaGKRXAF+n89P7
        CDI+wklPwZXQbgzUqEGXXw4Wm3FP/Yv3y+NCxwtdN+XyLMPMm0+gT/UAwDhS6U/flobopr
        V339JsO2QSz9F63yt5MlwuIiTfGJwo8riWz3c0vFGa9hFnUS+cnzt04umaPEKOGKnrOCFT
        ykX3UJmAxbcVl+1mxB37LvrwBDncjM7vglk0aj+nvr+mNAVlzKVNOseAEEnS9g==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v6 06/20] staging: media: tegra-video: improve error messages
Date:   Tue, 18 Apr 2023 10:00:40 +0200
Message-Id: <20230418080054.452955-7-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v6
No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 79dd02a1e29b..1c0424bf1ab0 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1361,7 +1361,7 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 
 	ports = of_get_child_by_name(node, "ports");
 	if (!ports)
-		return -ENODEV;
+		return dev_err_probe(vi->dev, -ENODEV, "%pOF: missing 'ports' node\n", node);
 
 	for_each_child_of_node(ports, port) {
 		if (!of_node_name_eq(port, "port"))
@@ -1921,11 +1921,8 @@ static int tegra_vi_init(struct host1x_client *client)
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

