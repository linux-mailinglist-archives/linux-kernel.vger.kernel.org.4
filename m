Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5D671CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjARNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjARM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:59:31 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E96BFF43
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=HF2LUWjt1tQUCfUGxY1HeVRm5cQ
        oQ1lR1zfKcrUUkSk=; b=lAiDFfBtvV6QYmabVMIvqJpBVYdVUggicxhMHtHKLKH
        lvBVTtginAr3dX639r/8napYfrabhpZjpVjMgPgs/ArkFFlhQ+6CE+TMKhkw0dzS
        CkzNmKXfxm3v9od3HXAV1NKHBX5/8pj2CnHjzRGZS/jhEt8jaSXOewoG/zJyzYuI
        =
Received: (qmail 3892154 invoked from network); 18 Jan 2023 13:20:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jan 2023 13:20:06 +0100
X-UD-Smtp-Session: l3s3148p1@0l8z1ojy3ulehhrZ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Date:   Wed, 18 Jan 2023 13:20:02 +0100
Message-Id: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The earliest revision of these SoC may hang when underrunning. Later
revisions have that fixed. Bail out when we detect a problematic
version.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

The BSP tries to work around the issue, yet this is neither upstreamable
nor are we sure the solution is complete. Because the early SoC revision
is hardly in use, we simply "document" the problem upstream.

 drivers/media/platform/renesas/vsp1/vsp1_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index c260d318d298..b395e8eb0af9 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/sys_soc.h>
 #include <linux/videodev2.h>
 
 #include <media/rcar-fcp.h>
@@ -875,13 +876,24 @@ static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
 	return NULL;
 }
 
+static const struct soc_device_attribute vsp1_blacklist[]  = {
+	/* H3 ES1.* has underrun hang issues */
+	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+	{ /* Sentinel */ }
+};
+
 static int vsp1_probe(struct platform_device *pdev)
 {
+	const struct soc_device_attribute *attr;
 	struct vsp1_device *vsp1;
 	struct device_node *fcp_node;
 	int ret;
 	int irq;
 
+	attr = soc_device_match(vsp1_blacklist);
+	if (attr)
+		return -ENOTSUPP;
+
 	vsp1 = devm_kzalloc(&pdev->dev, sizeof(*vsp1), GFP_KERNEL);
 	if (vsp1 == NULL)
 		return -ENOMEM;
-- 
2.30.2

