Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7A6F250A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjD2O16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjD2O15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:27:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554551715;
        Sat, 29 Apr 2023 07:27:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6a60460a23dso780854a34.0;
        Sat, 29 Apr 2023 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682778475; x=1685370475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9uC0SS41b6yxLBt/231cxXgMxHtj2I+ZiOhX6bBzxs=;
        b=hRs/AUua/dEWfpJ/IvJmanuHY6C9jVBmqUR7gDLzL3xOh0OEXT1DtywaoMEhUKYkbB
         eKJEnnMMLuPnfM1ekIkhzczWTjsOiE2z+qdQO97penAhrCLHmDfgND1s922NFE2rPPuU
         LRDAftmm9PajGKP5MLxnLyzAI8zFTfROISgfiHWyVbn5a9JqMirRxSPmo9lxb9RbAgXC
         NQmURL19OCddlHUbC28qY9OQrliVtSjbeA7Pn4eiI+yWLV8/ZASfZnO48OYS3gjBYw0G
         ca16pkXQVotZbZgRGDHT/bRkinOjhpQ3crGULWp4/47W7ZVDN6GNE3JPvephvwvP4FOr
         i8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682778475; x=1685370475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9uC0SS41b6yxLBt/231cxXgMxHtj2I+ZiOhX6bBzxs=;
        b=gQr/ek13cd+oYAVql1xFx43g8S0qGIURA652OzR0+Xrq6tPOIuzuhoZUoDx/LJSu8q
         CexRXzKPSqNmgENEePtrcVZx0JEaNC13o44khVEwZ/1MNP1oRQAulWJPALl69qqPzuYm
         EJLQ/17YtLgWsN6fen6uGc9bE92Xx5fIOkY6ue8CGUAJzbr4pVThE6sg/ub8wMiUd7w+
         0YGFLCJSbJ0bA2SuVI+0QjeEuJiicPf30tS7t3cfy2azc8xHxb9dTn7mC7v4t/U/Q2vL
         Sz1lYe8gtglp5/EJ/vFciJGyaQCrV35kxJs6fdxT94fClR46E1VHZkrfZ2TP2Ubk+86s
         Llww==
X-Gm-Message-State: AC+VfDylfKpCwlfecTVz+6bScHqjlmDBqmO9KuGVFV5pOodExOGaLsJZ
        oiSS4NE9zXsNARqvaLD7ENg=
X-Google-Smtp-Source: ACHHUZ6ccwg0e13o650LE02Q7+Z2Q1SnE7kJm/cIYSza08okHqJ/IGZqbpChz5oRGt4Yxo0RVDeOWg==
X-Received: by 2002:a9d:7a43:0:b0:6a7:ad05:3669 with SMTP id z3-20020a9d7a43000000b006a7ad053669mr4409549otm.33.1682778475572;
        Sat, 29 Apr 2023 07:27:55 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d6a47000000b0069f1774cde8sm8428217otn.71.2023.04.29.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 07:27:55 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Use less convoluted enum cast
Date:   Sat, 29 Apr 2023 11:25:48 -0300
Message-Id: <20230429142547.328125-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change

  .driver_data = (void *) &(enum type) {enum_literal};

to more readable form:

  .driver_data = (void *) enum_literal;

and corresponding cast usage as board type flag.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
This should be patched after https://lore.kernel.org/linux-hwmon/20230426184420.99945-1-samsagax@gmail.com/
---
 drivers/hwmon/oxp-sensors.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 9093c608dee0..7828c1d36695 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -62,49 +62,49 @@ static const struct dmi_system_id dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A1 AR07"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
+		.driver_data = (void *)aok_zoe_a1,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {aya_neo_2},
+		.driver_data = (void *)aya_neo_2,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {aya_neo_air},
+		.driver_data = (void *)aya_neo_air,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
+		.driver_data = (void *)aya_neo_air_pro,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {aya_neo_geek},
+		.driver_data = (void *)aya_neo_geek,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONE XPLAYER"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {oxp_mini_amd},
+		.driver_data = (void *)oxp_mini_amd,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER Mini Pro"),
 		},
-		.driver_data = (void *) &(enum oxp_board) {oxp_mini_amd_pro},
+		.driver_data = (void *)oxp_mini_amd_pro,
 	},
 	{},
 };
@@ -296,7 +296,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
-	board = *((enum oxp_board *) dmi_entry->driver_data);
+	board = (enum oxp_board)dmi_entry->driver_data;
 
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
-- 
2.40.1

