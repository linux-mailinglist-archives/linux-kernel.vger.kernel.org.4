Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4E655D90
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLYPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 10:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLYPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 10:44:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA6262B;
        Sun, 25 Dec 2022 07:44:21 -0800 (PST)
Received: from thinkpad-t460p.fritz.box (p200300c7df110b00fc6d091aa11da091.dip0.t-ipconnect.de [IPv6:2003:c7:df11:b00:fc6d:91a:a11d:a091])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08D726601811;
        Sun, 25 Dec 2022 15:44:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671983059;
        bh=YapcUwwPQt6Jen4c90jptEXYFz5PEE8azyvlgG7AcJY=;
        h=From:To:Cc:Subject:Date:From;
        b=lJsxPSH197CJQYBWl/149mJ+QiSt+J7nGtamzxZvmpdoqhNyQlloOMNRcNd/mjLiD
         LicM2zDNTL9+y46HxvJYaflVSrxl4jrR0HTrlN89T0qV5o1nQNMTuJNvsFzaZBO+Pa
         mCzlrGRi9XF0WKwD2vSleKIhsSP45pwsXvf1osq+KtgkryMYmme2xnWpPMM5iJD3Tc
         PR9OIj9QglZApaozrYS1wFTjsxfmjIF6jA/qJ9cCPHMSJrDYfEC2jxq/ECNLtZZmwT
         MGjw33JLH53TavXgvsrwEG8oMRQAhRmq0bGi7CVnuarM8JdmWTGQL7w0tMI31ac6G5
         9OAeUVlfiMFxQ==
From:   Robert Mader <robert.mader@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     nicholas@rothemail.net, javierm@redhat.com, jacopo@jmondi.org,
        Robert Mader <robert.mader@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: imx258: Parse and register properties
Date:   Sun, 25 Dec 2022 16:42:34 +0100
Message-Id: <20221225154234.378555-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Analogous to e.g. the imx219. This enables propagating
V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
can detect the correct rotation from the device tree
and propagate it further to e.g. Pipewire.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/media/i2c/imx258.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index eab5fc1ee2f7..85819043d1e3 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <asm/unaligned.h>
 
 #define IMX258_REG_VALUE_08BIT		1
@@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
 	struct v4l2_ctrl_handler *ctrl_hdlr;
+	struct v4l2_fwnode_device_properties props;
 	s64 vblank_def;
 	s64 vblank_min;
 	s64 pixel_rate_min;
@@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
 	int ret;
 
 	ctrl_hdlr = &imx258->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
 	if (ret)
 		return ret;
 
@@ -1232,6 +1234,15 @@ static int imx258_init_controls(struct imx258 *imx258)
 		goto error;
 	}
 
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto error;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx258_ctrl_ops,
+					      &props);
+	if (ret)
+		goto error;
+
 	imx258->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
-- 
2.39.0

