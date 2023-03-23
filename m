Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C66C7250
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCWV2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:28:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1555901F;
        Thu, 23 Mar 2023 14:28:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1908186wmq.5;
        Thu, 23 Mar 2023 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCiXJeDXXd1U4vqqP3+jDq2xkbJCNPNvIP/hWVPRcic=;
        b=Myg4tKWEwHTl9hBLsGBoWV91e9BEPSToWSoBxlze/Zwc9YVohupbUUDYRcVqxvH9hK
         J4nnu/xiIaWoT+Ezy6WDfG/Ndu3SC/8qTGsLSPvhQ1EOWejYkefTFygX334VY0fcCMCB
         Zh7IrRcCl/2TL9f8Eayc1G+x1XHBIW0UpWRujT14l+y8krkcBFmSPiqpJOHrNEkkObu8
         Hj28kgnHVZgHvWq/ZW7TG9Tlrw0GYtCO0nJ2Jj2b/mWZsxx8mCYRBrBxhgFmkERZQvRK
         zrDdPQV4kgypctxxvOOtMBW8bi0H8JYDylnrZ1dGj141KkYsHweB3opjQbiJ3lPwilhB
         3jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCiXJeDXXd1U4vqqP3+jDq2xkbJCNPNvIP/hWVPRcic=;
        b=LcMq2k7B+VIeSrAOzdVHa/mdsdtGPWdB1+ndeAZtHLMUdvsWWZX72hspX8sFGMVQGO
         7g1xj+mLlR0QRJDhDeJ3vPp+me+Eeprphsw3/P20Ti9CoroudRp1TVUc7LuLb7aDQYF7
         iDIFz+BYRYK9Ae38I4I/ILu4KZYWjtmIrvdCkdKgTuovWikzohDj3NkSAYv6jn2Tr75K
         SooGVkBghQQc7/ZV821gotfgVyeXp5j7xfaPLbnwz4Pnj2bzXTg0LPgXU+g7G42erS8c
         H1Id3AYidIF27eQ02KeaC5k7fETGT6ATZKhgmoD+F50t+35hEneG2Gv0Ub6Qqefo7Pk5
         6EtA==
X-Gm-Message-State: AO0yUKWYGropj7BX4Dzj7lS4ktLcL9gku2Ckmse/XOdZl39eYtz289Lf
        zJvFy4/KDEQodTjfVFb+mDM=
X-Google-Smtp-Source: AK7set/5mecpa3vOZ8O2APCefxGMfr4mMoBfz03aFxHr+th/eSgWlcGZJJThnGOpwtndaQ5iXbYR+w==
X-Received: by 2002:a05:600c:2305:b0:3ee:9c0e:c78f with SMTP id 5-20020a05600c230500b003ee9c0ec78fmr761014wmo.5.1679606906156;
        Thu, 23 Mar 2023 14:28:26 -0700 (PDT)
Received: from localhost.localdomain ([46.211.10.218])
        by smtp.googlemail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm3015096wmc.17.2023.03.23.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:28:25 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (nct6775) Fix ROG B550-XE WIFI and Pro B660M-C D4 names
Date:   Thu, 23 Mar 2023 23:27:50 +0200
Message-Id: <20230323212751.2474-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323212751.2474-1-pauk.denis@gmail.com>
References: <20230323212751.2474-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROG STRIX B550-XE GAMING WIFI motherboard is incorrectly named as
ROG STRIX B550-XE GAMING (WI-FI).

Pro B660M-C D4 motherboard is incorrectly named as
Pro B660M-C-D4.

Validated by dmidecode output from https://github.com/linuxhw/DMI/

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 5ba888b7eb8c8..9a7ad64c2cc3c 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1090,7 +1090,7 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX B550-F GAMING (WI-FI)",
 	"ROG STRIX B550-F GAMING WIFI II",
 	"ROG STRIX B550-I GAMING",
-	"ROG STRIX B550-XE GAMING (WI-FI)",
+	"ROG STRIX B550-XE GAMING WIFI",
 	"ROG STRIX X570-E GAMING",
 	"ROG STRIX X570-E GAMING WIFI II",
 	"ROG STRIX X570-F GAMING",
@@ -1147,7 +1147,7 @@ static const char * const asus_msi_boards[] = {
 	"PRIME Z590-V",
 	"PRIME Z590M-PLUS",
 	"Pro B660M-C",
-	"Pro B660M-C-D4",
+	"Pro B660M-C D4",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
 	"ProArt B650-CREATOR",
-- 
2.39.2

