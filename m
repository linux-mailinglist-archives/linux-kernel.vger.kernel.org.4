Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956669285E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjBJUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjBJUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:34:14 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB75775D;
        Fri, 10 Feb 2023 12:34:13 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 222ACCE079;
        Fri, 10 Feb 2023 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676061222; bh=NimFQ8qTxjNMgj+QJDqXqhUucdJGF+U/6niOgptmXB8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=vT6EaXsmYjbRdliJC/oZgD/XpS9m6T2sInNLpwkwxGt69M1CxvOtFPLZHFudEMYik
         cVbhaMQxcLozFm2Z5L/405bqsGSkEJZGt74/GoTfIz7xxHybUEjndubYAWv/K71Bia
         bQrecKGDqlWp7+iDdeWNhcP6xKMnfoGaPyI3TdE8=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 10 Feb 2023 21:33:17 +0100
Subject: [PATCH 1/2] media: i2c: ov5670: Use dev_err_probe in probe
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230210-ov5670-single-lane-v1-1-71835d39c1ce@z3ntu.xyz>
References: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
In-Reply-To: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=NimFQ8qTxjNMgj+QJDqXqhUucdJGF+U/6niOgptmXB8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj5qokHxG/8/bw3S2N9IqcfHeeZIpYxPYx71uRA
 d76VwsUEcmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+aqJAAKCRBy2EO4nU3X
 VrOAEACSF5Wq58lQPsy3r7xIH2SMSNKdyDtDAguCSDEp67NGovwnk3CukeZbQyi/GQP4489Xx9H
 YgfS5Nk6q0eCtSZm2Gv/IbX9NiJGODjspG/PV0Q52VqDPsjFJCDpDwRgeOc60hpabx0cKm1+ScT
 1UF+ODRntvxUfY6IgxpJz6aYQpVAvsSMbbiaYIkzwiXkgTLwvBNkDIBe2/cUI448QeMWsV4lTTP
 iwDH2Lmv2IRN9iqu7VNYH2fXdPOej0GG3XCCI7fMxj45cYPMoxzvZseaMex8s4eCvhRrM1oJ1GR
 MaAJOxbnkCBuWpyP1e0Zqh+GwpMTiA1VBb8Wyrikje+C6/TWOiwBdipshL3p3728rO+eC9N9qxA
 YE3UVmNEsaTG4GnPYSrH46kq9CzekDeWbA+eYgzryqZ5SsMEw38E0XSYIWI/b16wz0Wkc+AVaPV
 qHlzMm4RPKb6p7ZzRju8wdOF2bqeOFJF2sHNtAxhfKnCJrMwRXaeS6982V4jU99FXxgUkuuXIdM
 UuiFLzFS3C8dxi+plGV9dk8mU54yzSsmij7LfYQJNSHbvE/9dTVhA/tb8ii9l1IXrJrwnAGFO6H
 RXGuWOcNXJN7Vvj4h4T28o4r04OzUf7i0ZLSPEFtrAELZc9udK8sBvgQHSyLhpI8mH3Cx52qGht
 PbsLfGibgZdnAQQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the unusual const char *err_msg usage with dev_err_probe which
also handles -EPROBE_DEFER better by not printing the message to kmsg.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov5670.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
index f79d908f4531..189920571df2 100644
--- a/drivers/media/i2c/ov5670.c
+++ b/drivers/media/i2c/ov5670.c
@@ -2648,17 +2648,13 @@ static int ov5670_gpio_probe(struct ov5670 *ov5670)
 static int ov5670_probe(struct i2c_client *client)
 {
 	struct ov5670 *ov5670;
-	const char *err_msg;
 	u32 input_clk = 0;
 	bool full_power;
 	int ret;
 
 	ov5670 = devm_kzalloc(&client->dev, sizeof(*ov5670), GFP_KERNEL);
-	if (!ov5670) {
-		ret = -ENOMEM;
-		err_msg = "devm_kzalloc() error";
-		goto error_print;
-	}
+	if (!ov5670)
+		return -ENOMEM;
 
 	ov5670->xvclk = devm_clk_get(&client->dev, NULL);
 	if (!IS_ERR_OR_NULL(ov5670->xvclk))
@@ -2680,29 +2676,23 @@ static int ov5670_probe(struct i2c_client *client)
 	v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
 
 	ret = ov5670_regulators_probe(ov5670);
-	if (ret) {
-		err_msg = "Regulators probe failed";
-		goto error_print;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Regulators probe failed\n");
 
 	ret = ov5670_gpio_probe(ov5670);
-	if (ret) {
-		err_msg = "GPIO probe failed";
-		goto error_print;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "GPIO probe failed\n");
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
 		ret = ov5670_runtime_resume(&client->dev);
-		if (ret) {
-			err_msg = "Power up failed";
-			goto error_print;
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "Power up failed\n");
 
 		/* Check module identity */
 		ret = ov5670_identify_module(ov5670);
 		if (ret) {
-			err_msg = "ov5670_identify_module() error";
+			dev_err_probe(&client->dev, ret, "ov5670_identify_module() error\n");
 			goto error_power_off;
 		}
 	}
@@ -2714,7 +2704,7 @@ static int ov5670_probe(struct i2c_client *client)
 
 	ret = ov5670_init_controls(ov5670);
 	if (ret) {
-		err_msg = "ov5670_init_controls() error";
+		dev_err_probe(&client->dev, ret, "ov5670_init_controls() error\n");
 		goto error_mutex_destroy;
 	}
 
@@ -2727,7 +2717,7 @@ static int ov5670_probe(struct i2c_client *client)
 	ov5670->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&ov5670->sd.entity, 1, &ov5670->pad);
 	if (ret) {
-		err_msg = "media_entity_pads_init() error";
+		dev_err_probe(&client->dev, ret, "media_entity_pads_init() error\n");
 		goto error_handler_free;
 	}
 
@@ -2741,7 +2731,7 @@ static int ov5670_probe(struct i2c_client *client)
 	/* Async register for subdev */
 	ret = v4l2_async_register_subdev_sensor(&ov5670->sd);
 	if (ret < 0) {
-		err_msg = "v4l2_async_register_subdev() error";
+		dev_err_probe(&client->dev, ret, "v4l2_async_register_subdev() error\n");
 		goto error_pm_disable;
 	}
 
@@ -2764,9 +2754,6 @@ static int ov5670_probe(struct i2c_client *client)
 	if (full_power)
 		ov5670_runtime_suspend(&client->dev);
 
-error_print:
-	dev_err(&client->dev, "%s: %s %d\n", __func__, err_msg, ret);
-
 	return ret;
 }
 

-- 
2.39.1

