Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB664FEC2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiLRLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLRLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A263CA;
        Sun, 18 Dec 2022 03:32:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso3358947wmb.1;
        Sun, 18 Dec 2022 03:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pbmmyFC1PRzbhY0ju1h8WYqW4QNOGc54qUO49wYIb0=;
        b=jCDsQlfkx0e63LiHu050H2soe6xVvWqRctC6450L4tfFQikkSRK5GMLlBQ1kITmjf1
         6xdwrjmqQpjNbQbbYiHOjqktEY/9qQqZB0PPMXDVIY23COsts0zV6PKAwXDjL/+ggtA4
         FTk71gKMMxR1uosPNOPKfU7mPSJYHUN/50I0OaoSsd5U1CBOI7rVm6GvrGIfeiKCYwaN
         XntuBXFwZWYzM4BohgzZv/EQEud8wut9Z45O7jBL5LOhYwKA3eEU7GhxfkXFxjMaruNa
         qd8VgBH6wqZAKSEoYWngNCdIr94JOXYNt3U83nuhubaUklO5CWBfoqQI2fbYnmcd0TYQ
         eSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pbmmyFC1PRzbhY0ju1h8WYqW4QNOGc54qUO49wYIb0=;
        b=KMNAWN1kREm4OIslYfugIo6+6r66R+f1yuLXQ892JtkJItI3WpT9T0vcA2HUWz8jJj
         X54F9DZdcn+TSbCCgd/NlGxdA9ndq/9KZyHRGpumtav9mOcywQewHtkSnIOXrAkIPHh5
         bvaG/n8qpA53Brm5Et/F8NGAG6KJxbvIvuugdfQWtlnM3sIcrHMK1VJa4FIHaLXJfRQ5
         a9/LqlXDxdgKwhxnDssYGtwB/b7NwyeJdHMJSXugwB3os/31m6t88WDXK2G2BFaQAbr3
         PlxgnM2TPZOVDLQMbfQU+R5g7mXzLuCd+w/6tK3uA6Faw85Ha49mttZ7x7GlJvNAnkWu
         ll1g==
X-Gm-Message-State: ANoB5pnHiAtS9Q+iplBipa0Z5eLpumcOzdsT7+hsjmNPzQ0+FYFRtR+g
        05c+qu5xxPe6QubNNdKZF/SAYlugQ1Q85M/B
X-Google-Smtp-Source: AA0mqf4f/BdGEhFCMc0GEwgRmfVZ9HxBGiOItzgkUMtnEpcF/cnCDU9ihr1zAMcYETc9K0HD8l8HGQ==
X-Received: by 2002:a7b:c358:0:b0:3d1:f882:43eb with SMTP id l24-20020a7bc358000000b003d1f88243ebmr29548154wmj.10.1671363124970;
        Sun, 18 Dec 2022 03:32:04 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:04 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 5/6] hwmon: (aquacomputer_d5next) Make fan sensor offsets u16
Date:   Sun, 18 Dec 2022 12:31:30 +0100
Message-Id: <20221218113131.3752-6-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218113131.3752-1-leonard.anderweit@gmail.com>
References: <20221218113131.3752-1-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make fan sensor offsets u16 as u8 is insufficient for upcoming devices.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index cc53231067f4..d28d7079917a 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -83,7 +83,7 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_5V_VOLTAGE		0x39
 #define D5NEXT_12V_VOLTAGE		0x37
 #define D5NEXT_VIRTUAL_SENSORS_START	0x3f
-static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
+static u16 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
 /* Control report offsets for the D5 Next pump */
 #define D5NEXT_TEMP_CTRL_OFFSET		0x2D	/* Temperature sensor offsets location */
@@ -115,7 +115,7 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };	/* Pump and fan speed (fr
 #define OCTO_POWER_CYCLES		0x18
 #define OCTO_SENSOR_START		0x3D
 #define OCTO_VIRTUAL_SENSORS_START	0x45
-static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
+static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Control report offsets for the Octo */
 #define OCTO_TEMP_CTRL_OFFSET		0xA
@@ -134,7 +134,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_SENSOR_START		0x34
 #define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
-static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
+static u16 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Control report offsets for the Quadro */
 #define QUADRO_TEMP_CTRL_OFFSET		0xA
@@ -313,7 +313,7 @@ struct aqc_data {
 	int checksum_offset;
 
 	int num_fans;
-	u8 *fan_sensor_offsets;
+	u16 *fan_sensor_offsets;
 	u16 *fan_ctrl_offsets;
 	int num_temp_sensors;
 	int temp_sensor_start_offset;
-- 
2.38.1

