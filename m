Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C729865D27F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjADMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjADMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:24:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD1DC;
        Wed,  4 Jan 2023 04:24:13 -0800 (PST)
Received: from desktop-fedora.fritz.box (unknown [IPv6:2001:4091:a244:801c:ff2e:9846:2bd1:fe62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A1926602D11;
        Wed,  4 Jan 2023 12:24:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672835051;
        bh=kHN/2peZ8F1bPcjIV89sdIjVmYmqi4lFfl55EO+Tx1A=;
        h=From:To:Cc:Subject:Date:From;
        b=b5VYnbfiEb6qzgpodn3wW4SltjOTnj01m6TbhuUy+A82dvqxrckXJYckhO/WjSwC9
         ffVBeWgiTf/Mub6aQVk9giGog2gZoNAO7LN/E3ajlOVjWPzWeds0EJp09N8EM4jAVD
         eCgqd18FXYAtd1cEv/q1VenmPVULNDL7ojOudWPBh6gP670TBRpImO1tqwfyueO26v
         bPAzOqKPnI/575yMdFeKhzyI/IPab4Sp73sBfkw6ye5m0wvU/m6SnSYIgoSeFjUznk
         C/H7iRLKyMIcq/QJSatAYb05m6tUunPoOD1OhVQsMR3xyFbpRI1LuvJ5NdrSP1XlJg
         8IGmtsQtyNKFA==
From:   Robert Mader <robert.mader@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     nicholas@rothemail.net, javierm@redhat.com, jacopo@jmondi.org,
        Robert Mader <robert.mader@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH v2] media: i2c: imx258: Parse and register properties
Date:   Wed,  4 Jan 2023 13:23:37 +0100
Message-Id: <20230104122337.123055-1-robert.mader@collabora.com>
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
V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
values.
The motivation is to allow libcamera detect these values from the
device tree and propagate them further to e.g. Pipewire.

While at it, reserve space for 3 additional controls even if
v4l2_ctrl_new_fwnode_properties() can only register 2 of
them, to fix the existing implementation which reserve space for 8
controls but actually registers 9.

Changes in v2:
 - Reserve 11 instead of 10 controls
 - Change order of variable declaration
 - Slightly extend description

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/media/i2c/imx258.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index eab5fc1ee2f7..3b560865b657 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <asm/unaligned.h>
 
 #define IMX258_REG_VALUE_08BIT		1
@@ -1148,6 +1149,7 @@ static const struct v4l2_subdev_internal_ops imx258_internal_ops = {
 static int imx258_init_controls(struct imx258 *imx258)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 vblank_def;
 	s64 vblank_min;
@@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
 	int ret;
 
 	ctrl_hdlr = &imx258->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 11);
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

