Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D03681206
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjA3ORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjA3ORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:17:30 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62B3E0A1;
        Mon, 30 Jan 2023 06:17:01 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 840C7100004;
        Mon, 30 Jan 2023 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675088220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDKaDW07jRg6JKv4FccRmW/KLxnvUIW9HGrFo7N25X0=;
        b=QWoP1r7BvNdLSKaNW0NenVvDRcgXcY0T0/cJkObS+sUC/Pa2A5GFFx2D9PaWiGc6LtAae1
        0nboqki4rsDD+wMquqfYMWRsZg89tll4+HAHaD38E7iDTqZ1btBWG7FPZ3KRB+L6LGyQCa
        JMvKfhcuJ5R4pDdvXfvTAkw01IarFcRwQQBWHlBgjk4CsnpRQFSY5MHTdkyOvXVuPfzlCz
        no9LSiH14O6QEYBbp4MBU+57HWSuFuXFYYbZ1B22I0PMzNUZ6VYTcTmQERw39ME9TNQkQJ
        Iju1Nh84JXWP89aNrAwgfwUVuJrdQiRQeTm7OABy3IZbe9vvwPKJ94aiCcs/IA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v4 08/21] staging: media: tegra-video: slightly simplify cleanup on errors
Date:   Mon, 30 Jan 2023 15:15:50 +0100
Message-Id: <20230130141603.323221-9-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130141603.323221-1-luca.ceresoli@bootlin.com>
References: <20230130141603.323221-1-luca.ceresoli@bootlin.com>
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

of_node_put(node) does nothing if node == NULL, so it can be moved to the
cleanup section at the bottom.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 0e5067a7986a..c2724e1ecafb 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1263,7 +1263,7 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 	struct device_node *node = vi->dev->of_node;
 	struct device_node *ep = NULL;
 	struct device_node *ports;
-	struct device_node *port;
+	struct device_node *port = NULL;
 	unsigned int port_num;
 	struct device_node *parent;
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
@@ -1286,7 +1286,6 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 			dev_err(vi->dev, "invalid port num %d for %pOF\n",
 				port_num, port);
 			ret = -EINVAL;
-			of_node_put(port);
 			goto cleanup;
 		}
 
@@ -1309,13 +1308,12 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 
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

