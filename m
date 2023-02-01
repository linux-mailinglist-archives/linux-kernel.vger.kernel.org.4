Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F330686C69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBARHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBARHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:07:19 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717113D77;
        Wed,  1 Feb 2023 09:07:16 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1D103CDFDF;
        Wed,  1 Feb 2023 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675271235; bh=oEhtXi5Cp2INDY3zPTIo52DB0I1+lAGCjPcLcIpaDFU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=hlmabRtzYoS1PcRzF0Rb+tgv0qZCuNrfPMKRHpBMLEix5ztcgu6t6Je1Ss+os9QTw
         0lxMpVc+QbkGAs61I4+V9fzsrPRuSLXIbhV0T/cbeX5qb7WFaRgRlGff1KVIA61/v5
         u2/2Tb/ka6IJxApszJLb6Hk1GwlnXKzO5MKBe5SY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 01 Feb 2023 18:07:00 +0100
Subject: [PATCH v2 3/4] media: i2c: ov2685: Add controls from fwnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v2-3-210400f2b63e@z3ntu.xyz>
References: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=oEhtXi5Cp2INDY3zPTIo52DB0I1+lAGCjPcLcIpaDFU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2pxAEugegsWx8BDNcW3lxPTH2z+UdUfc568iKMji
 Zluxm/mJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9qcQAAKCRBy2EO4nU3XVvW9D/
 91MFrxf/QOOEiv+4vFvK8Wf5vYcQof0Z5w6csy8eCFOzHeAnm15N292R4is+ezXc3veNWsWxhKkp2B
 erO6x1vXHVtmnLUPKarMU+USkID+984KH1QufKZU9pRtTJ0MPSKAmeBbzjTyROBf0EYbgV/NwyF6+y
 R1xYnEzA6RhLlheOX4TltTu19t7eixtfHZkTmwk62OCNZDQSdademjz3SwuIF1rJTFphNgvh0ErYoW
 tT0xDKsw0wABEOSAOPk8vHJl70pBcAjwFjcNGpbQbi3lAZ+X0FJhTa+acCtIV/PuUGSiMRL4OKinug
 JL3l899Vu2eqx7+DnBBzWkxwTvGejd9M0A2EgVPRaKdml8MbJm7K8M5XQ0/UaCyJtX4WD5w4DQyl+D
 F01WgDpJTyH/9yahUdIMWIIp/nSqGd6tMsf8AQ+i53qYZ+YAmXumIaRmTCbpeK1wJuvAbSxdjoj+Ql
 noTvPy+3sHuZ0/ZyuEtBuY5Jntd5YAr8hsjNuukhxZ11Inmg7zaOi7mba0dFlWpQ9hl7EPB23vc4fQ
 oczHsjjc0EuDzkd2lQjXHO3HLJzSQGkM43hBpcLRPlkW3Axyy0KLnQ0a8HCf7JbOB8QQu+HjTOH9Sz
 qPHuW2S4lZCb3qZpUdrRgLc+8Y2yAc0ZTyjSlYSw+DW03H6bxhubpJ/JmZ/w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
controls to the ov2685 driver by attempting to parse them from firmware.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index 844a91dbc8e5..e9e59a3ed7d5 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -17,6 +17,7 @@
 #include <media/media-entity.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 #define CHIP_ID				0x2685
@@ -613,13 +614,14 @@ static int ov2685_initialize_controls(struct ov2685 *ov2685)
 	const struct ov2685_mode *mode;
 	struct v4l2_ctrl_handler *handler;
 	struct v4l2_ctrl *ctrl;
+	struct v4l2_fwnode_device_properties props;
 	u64 exposure_max;
 	u32 pixel_rate, h_blank;
 	int ret;
 
 	handler = &ov2685->ctrl_handler;
 	mode = ov2685->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 8);
+	ret = v4l2_ctrl_handler_init(handler, 10);
 	if (ret)
 		return ret;
 	handler->lock = &ov2685->mutex;
@@ -661,6 +663,15 @@ static int ov2685_initialize_controls(struct ov2685 *ov2685)
 				ARRAY_SIZE(ov2685_test_pattern_menu) - 1,
 				0, 0, ov2685_test_pattern_menu);
 
+	/* set properties from fwnode (e.g. rotation, orientation) */
+	ret = v4l2_fwnode_device_parse(&ov2685->client->dev, &props);
+	if (ret)
+		goto err_free_handler;
+
+	ret = v4l2_ctrl_new_fwnode_properties(handler, &ov2685_ctrl_ops, &props);
+	if (ret)
+		goto err_free_handler;
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(&ov2685->client->dev,

-- 
2.39.1

