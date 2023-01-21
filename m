Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69CE6765EF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjAULR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAULRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:17:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA72D72;
        Sat, 21 Jan 2023 03:17:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b7so6908170wrt.3;
        Sat, 21 Jan 2023 03:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIu5RIaStJjELLMP+VqICNKzFrnn8LSqHAmq0aRaUzU=;
        b=NKXTix0nOvRLx/leHgW4iDn7RI1MVx2V2+M5uSaiesOkxWWvFvcTd5NruHVRylCQlR
         rjJF05LiLx92Os7gMcC34VbfKDnv2Ay8Pa5gpAhMyzLi5fyOOGgfEeDf81czqvHoax+U
         PtfU7OMwBuExjTwZbWaCEWCzAAEal1jlD4hAAeMtTVAmwivi/cDlBTAQBS4fMUyXxS76
         OV6wUn4hG9Cokug2OaHhD/EUJbWnVuiWqKmrbEWSvhZDiagqyvp/AW+jYKu5qE8PCIWQ
         4tx0RZcIMlUumpFFXv7kiP6BspuY2fEZw9Ps3+fTV7z5vgrspL9OJYNaLtfZzmqUeVD5
         SFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIu5RIaStJjELLMP+VqICNKzFrnn8LSqHAmq0aRaUzU=;
        b=qcGKu820GuGcOTi9L5yZOlscY4ytyIJ4r1j3ZWk8B3JNp+1w+dAf0WAikrsUu1zwZ2
         wMLKB3PlfRde81wdlJ8YDEj4PYpPm9u/S0wm9soFs6tl4RqHuJXYm90r5wfbbTafGzaG
         vJ5zk9kelIps1odHVOjB8rKoQgcLB7ZLX+wXxpOYIryxviVspNchYbdwtjbS/4kXUr8i
         hd9DFnI1nI1Y1VjaGQ36a1ZMJmCb+U4O+dChnv/ppzk0l0NalXR/dtBkAEzqHPe63J3Z
         Yr90Cw5ogRGmvZnZkS4JxQBQG7s00+8at+ZJS3M0bfSkmUjKgPb27hkQaN9G2fJ0cuEm
         KjVw==
X-Gm-Message-State: AFqh2kq9+scJlfOllnL+OYVl8DdXv0HU2ukhCUP1uKEPpmkbl9mASCmJ
        HDX+mg/sYVeBmzJSR2FAdHv4V1WUSulmAQ==
X-Google-Smtp-Source: AMrXdXtdihHINJFHhghqanIvzAYuxlOpMrqcsZrsp05dEKIZaBrF3OM1J8cc+z2mH4G9HD8IJ0D3Cw==
X-Received: by 2002:a05:6000:3c2:b0:2bd:d45c:3929 with SMTP id b2-20020a05600003c200b002bdd45c3929mr17615377wrg.54.1674299866051;
        Sat, 21 Jan 2023 03:17:46 -0800 (PST)
Received: from caracal.museclub.art (p200300cf9f4f4d002fdc57d9d2f68d31.dip0.t-ipconnect.de. [2003:cf:9f4f:4d00:2fdc:57d9:d2f6:8d31])
        by smtp.googlemail.com with ESMTPSA id w8-20020adf8bc8000000b002bdc39849d1sm26139795wra.44.2023.01.21.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:17:45 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (asus-ec-sensors) add missing mutex path
Date:   Sat, 21 Jan 2023 12:17:28 +0100
Message-Id: <20230121111728.168514-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121111728.168514-1-eugene.shalygin@gmail.com>
References: <20230121111728.168514-1-eugene.shalygin@gmail.com>
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

Add missing mutex path for ProArt X570-CREATOR WIFI.

Fixes: de8fbac5 (hwmon: (asus-ec-sensors) implement locking via the ACPI global lock)

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index a901e4e33d81..b4d65916b3c0 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -299,6 +299,7 @@ static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
 		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	.family = family_amd_500_series,
 };
 
-- 
2.39.0

