Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3B712F62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbjEZV6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbjEZV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:58:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966CE57;
        Fri, 26 May 2023 14:58:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39831cb47fbso870176b6e.1;
        Fri, 26 May 2023 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685138198; x=1687730198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oobY8Hnr+V4wGPCWsnIMgT9DHlRXZoBkbIC6BEX23SU=;
        b=aWxVHnmKMVbtSgYUQYksmmw46grMNqXatXG37GenPMK6H2zm72YHpscZDwyPN8T/m1
         Tecjxqo/3hceavTncqvVwiooAL9aqvP0Q4boolJrJzMvIMasnWtNDTbHcgVfVcD68LxZ
         oA3lbIbMtjcQNCA+LK6FbF2oChOcTdMzhedMmlavhDXJ6Fzd/H0BiIs2L9s15HNyrKuw
         2LCRpsRUDZjMlVzham69+vGuVb984kaoKlkPdtqfibEn2/zQFiOFGJ2y6oo+brMzSa45
         +zOTYntAgaV2e59iBia3KAgwUNlxWlQc8SKKdNCfz5QzrBqpzq7il/w93zw/3lBiWvx4
         lsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138198; x=1687730198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oobY8Hnr+V4wGPCWsnIMgT9DHlRXZoBkbIC6BEX23SU=;
        b=R/bwr0YRj3E6S9hL9/hf71FgHRt6UUsWzyp7MhtOLDWbfDuO0zrhJAjn7gdG0wMVa5
         KIk0jmytE9vz+joxHzrpcLQw1VEBbVcqYoCVNTtFgZhjDDoiJDB7Q5L8DuEIBlZhTWtf
         Td5DMGBNkkIb+ryhuAMuuU7kMuw40V6kFJpf6X1ILRG0nFA1l0g487VANZy4eomBoGpv
         D+j5M05NTrwZeekP/JqM5Fg0UIQgf4kWIyY+0GycJ8yz2eDzHMm2SeZndjEhzkZrFiZG
         FwK2D4VTuxZn3tIVAtI1+g2/KCQ99VyUn/33vj/tHexxQDh3svU5Q5GQWKUUOpQ0WkeI
         D71w==
X-Gm-Message-State: AC+VfDwPMA1EE5AJ5g0aCIiQYKBsUbQfCxwBhGpDBaj89i1gXzKeUvOD
        DLVAabFZu4z/SV56roTIAJYdGniBwvY=
X-Google-Smtp-Source: ACHHUZ5vqRPNUlPl/PxXDCBxq23GlkCHJUIAAGgBUV49sTtbrptu+KjfMeiPo/Vb3A3vPP0+oPWnDQ==
X-Received: by 2002:a05:6808:8ca:b0:398:523a:f1ee with SMTP id k10-20020a05680808ca00b00398523af1eemr1741000oij.21.1685138198134;
        Fri, 26 May 2023 14:56:38 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id q6-20020acaf206000000b00399ee6330a9sm756978oih.52.2023.05.26.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 14:56:37 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Differentiate new BIOS for the Mini
Date:   Fri, 26 May 2023 18:56:22 -0300
Message-Id: <20230526215621.16075-1-samsagax@gmail.com>
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

Newer BIOS got some other changes aside from string changes. Add a board
enum to differentiate it from the old OneXplayer Mini AMD BIOS.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 0ec7588610ad..423307ed4930 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -47,6 +47,7 @@ enum oxp_board {
 	aya_neo_air_pro,
 	aya_neo_geek,
 	oxp_mini_amd,
+	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
 };
 
@@ -104,7 +105,7 @@ static const struct dmi_system_id dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
 		},
-		.driver_data = (void *)oxp_mini_amd,
+		.driver_data = (void *)oxp_mini_amd_a07,
 	},
 	{
 		.matches = {
@@ -206,6 +207,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				*val = (*val * 255) / 100;
 				break;
 			case oxp_mini_amd_pro:
@@ -247,6 +249,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				val = (val * 100) / 255;
 				break;
 			case aok_zoe_a1:
-- 
2.40.1

