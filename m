Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA267FDEA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjA2JnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjA2Jm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:42:58 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E797683;
        Sun, 29 Jan 2023 01:42:53 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1997FCDE2A;
        Sun, 29 Jan 2023 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674985372; bh=wpSIFiFaQeJjpP8EjFtZNN2+bMm1UD9zAgvnDvRYovM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=l48RjCz+Cfmfm0bJfpsAWmWNGlylZQM+N2a+m5yTqO/S5SVwqCKHpK9bUuR+ME0kV
         7lcOBpk/pP2AXdDHSGtQVyJhz91qZX7Pox432PdnN+Lzt8y3iRiVn3s2p5ewu6Zv3c
         bQnlbJToe7mxGen7DZv44iR4jfRXNtPKCqG/gBOo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 29 Jan 2023 10:42:37 +0100
Subject: [PATCH 3/4] media: i2c: ov2685: Add controls from fwnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v1-3-f281bd49399c@z3ntu.xyz>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wpSIFiFaQeJjpP8EjFtZNN2+bMm1UD9zAgvnDvRYovM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj1j+ZRG8/vFXpNlQCejfrorbGALJ4DzE5NPq2PhbN
 gmDYKE+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9Y/mQAKCRBy2EO4nU3XVqfMD/
 9BlHLJDxQXyX2cvIcxslpCQxeF8y8lfwJcDX/CrSmPEhMdn6FEsJFLBC/VoWdYxj9n2F8Jjo8/hSA7
 bev0yJAnvZkB+YzYzJQ7/I+S15dRUdy9Y7KBQp5k1qxHdslgVy1TV2yXmXaYMdUWu3JxQbHFTUo0YJ
 WGV2jjBd96d+qgEjCojCrSouM3iDNVN0JLUd7QMtuNsSTw7lw6piceP9ovQwZTd90U1fV3rItn+bpQ
 Kvsu+2jBFol2KurLWre0YQUGu7TM29f9fIer0vzI49bXHxS8a3DEGt6GMmP62NPL1BXrjTYgdK8qtn
 r+ZClWu/t0XiTdi/2TtdQHQmgn4BMbN3SM6KLRL5qUDQd4/nAYENWACDlybU/XV194F14E7jXwuBc+
 TVb5IULaggBbhLsj7htcA3PQAzXpVwCmGxe0t5j6FiJyeZIl/z/OmfZ46F0ApOiiTSgA85qS/7NjnB
 25exPZf7PYcjYKyNPmW6KVCV6RjJBNe3NvRW67JNusoXKbfGUDH57PkpqIBbwDLRmk37Vhwyrh4+NZ
 mUB+N3VYXfiSkHQZKG+1a27nbhIz3cfafnQM23SIVhJKcaaB+ttL79AnmUimuqoM8JveDbASgxznfG
 47VpcdiPrlPWy35N9i36O3NcVDHeW7mra0+hOwReaPkdTE/uOSg52dv4sUTg==
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
 drivers/media/i2c/ov2685.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index 844a91dbc8e5..bfced11b178b 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -17,6 +17,7 @@
 #include <media/media-entity.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 #define CHIP_ID				0x2685
@@ -613,6 +614,7 @@ static int ov2685_initialize_controls(struct ov2685 *ov2685)
 	const struct ov2685_mode *mode;
 	struct v4l2_ctrl_handler *handler;
 	struct v4l2_ctrl *ctrl;
+	struct v4l2_fwnode_device_properties props;
 	u64 exposure_max;
 	u32 pixel_rate, h_blank;
 	int ret;
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

