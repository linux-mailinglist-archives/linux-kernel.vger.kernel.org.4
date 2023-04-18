Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D26E5B64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjDRICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:02:12 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABB18684;
        Tue, 18 Apr 2023 01:01:35 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 84CE824000B;
        Tue, 18 Apr 2023 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+VzAfaSqgxKGJT/6W+d7FGRqtXq2O0GiseDQOgCfqU=;
        b=CGSJMVEfNn8zDkV84d82TAiUJl2y5+Pwo1O9aV9Ce6AJUmPS1EFtWXRwjBkjvUpbugSmJF
        gWNi3LaMjt3p0GQ1boGQjjxiRUhwx0e1IVVbR7U82AwdGKH9DRehcs9Qf0Q5uvaPNNYp53
        LBwqkFoviljVP5xY31IOwLko5O0Y2bEwke3syBsV21u6A75adHeimqpA7r0Y3at6Kj2tRU
        rxMP8LdJ3mFOz6Ll0PnuOdpJaaZ3sMNKH/bFqvduwga4so63TVUXUK9xPChmKRrjYecbBt
        w5mwIpP+OXS7y1YT0hCEpk6JM31QPYZPS/HVg/RcmtRji64IiXrR/r3EfatQHg==
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
Subject: [PATCH v6 07/20] staging: media: tegra-video: slightly simplify cleanup on errors
Date:   Tue, 18 Apr 2023 10:00:41 +0200
Message-Id: <20230418080054.452955-8-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put(node) does nothing if node == NULL, so it can be moved to the
cleanup section at the bottom.

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
 drivers/staging/media/tegra-video/vi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 1c0424bf1ab0..ce4ff4cbf587 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1352,7 +1352,7 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 	struct device_node *node = vi->dev->of_node;
 	struct device_node *ep = NULL;
 	struct device_node *ports;
-	struct device_node *port;
+	struct device_node *port = NULL;
 	unsigned int port_num;
 	struct device_node *parent;
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
@@ -1375,7 +1375,6 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 			dev_err(vi->dev, "invalid port num %d for %pOF\n",
 				port_num, port);
 			ret = -EINVAL;
-			of_node_put(port);
 			goto cleanup;
 		}
 
@@ -1398,13 +1397,12 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 
 		lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
 		ret = tegra_vi_channel_alloc(vi, port_num, port, lanes);
-		if (ret < 0) {
-			of_node_put(port);
+		if (ret < 0)
 			goto cleanup;
-		}
 	}
 
 cleanup:
+	of_node_put(port);
 	of_node_put(ports);
 	return ret;
 }
-- 
2.34.1

