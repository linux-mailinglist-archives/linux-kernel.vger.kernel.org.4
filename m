Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A16184A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKCQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiKCQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:53 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE41C430;
        Thu,  3 Nov 2022 09:31:52 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD400240009;
        Thu,  3 Nov 2022 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrwwHbobIIX6sa8FRVg9VNOkCqkmUmHNacccQQvVQhY=;
        b=LCRKQKXjPkTmiORm/hqobINl7gHyP593/VfU97RBugMJnF7LUVdMCDcs6e4Gcta5QzxbOL
        jDy7ozn4aDjk1a/rDyJxs5A7hrnucqZlSZ1ejnyp0uEdySZaAQILE1irSiaodWgtW7f0s0
        tAZVOI5FxHyh+X8KTkX+3/YF3/zd2FK/mcEtOLKhr2NhUywZdh/EMIFCy1CvaszMh8jRO4
        3WnohUH5/P+G613meSN6FBWU5yDvNo+e9NGZjzm4pvKvIM4rXuOOI9HriRKvU/wi/lwDBP
        MrQLAoTwRmy8yKOARrE0D3zVg+FjoR+3/h2SJwG+Kt6tjtDHfLPlRW5Oh4X7ow==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 12/28] media: sun6i-csi: Add bridge dimensions and format helpers
Date:   Thu,  3 Nov 2022 17:30:57 +0100
Message-Id: <20221103163113.245462-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new helpers to ease getting information about the bridge.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 20 +++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index cac1b150e544..b98a1e18ddef 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -12,6 +12,26 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_bridge.h"
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = csi_dev->bridge.mbus_format.width;
+	if (height)
+		*height = csi_dev->bridge.mbus_format.height;
+}
+
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field)
+{
+	if (mbus_code)
+		*mbus_code = csi_dev->bridge.mbus_format.code;
+	if (field)
+		*field = csi_dev->bridge.mbus_format.field;
+}
+
 /* Format */
 
 static const u32 sun6i_csi_bridge_mbus_codes[] = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index f9bf87bf3667..5e6448aa522f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -41,6 +41,13 @@ struct sun6i_csi_bridge {
 	struct sun6i_csi_bridge_source	source_parallel;
 };
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height);
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field);
+
 /* Bridge */
 
 int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
-- 
2.38.1

