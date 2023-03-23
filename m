Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7A6C724F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:28:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F6772A8;
        Thu, 23 Mar 2023 14:28:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1908148wmq.5;
        Thu, 23 Mar 2023 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tYenVJRpu5Lx3WoUkk81zuugYuoL/NEIBzRRA2Hsl4=;
        b=LGeekIVL2V4GItnQaCRznOyxFgUgTFIrkksiNUck3BLBgTA1gRRBAsP2YZClmiVynb
         DgaEZ4hIzQ8JJYJ4TXRBDLwX6DVMNGtI/Vdedii9knjVS8FkTQ1QyaMP58PZcsT4bZFx
         l2NMHj1KGvn22ccbKWDskLSU0mtZQgicR4twxLOm1HDU1NADeRSKpOjp55z5cAC2Q3kb
         jVzwreB0YANEwfySQSefm6cm1QZyuw0g5IUahksd0VXidC8Ggns4tlB6NbTuKFq/lBK9
         5Qz7ZC8n6D21Gqb/Zm2CrDqZvktCV37cfzxIhPtLW9yRY1Rdcc1jsa1d3sXe0f2/A/BP
         KuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tYenVJRpu5Lx3WoUkk81zuugYuoL/NEIBzRRA2Hsl4=;
        b=tQun4ru/kSKAMEp0JAopmCpvc14AMyrJ6jLK0sgHcFLlxDCjG90/ePyGxYBiMUHB2x
         U+o1MuiEvholgHvhbPBnixsXTdGIsorLI0OKq1V7wfjqQwl26cAtJVAFfCdt9SfM6phj
         5SWzlMailJPQh3eGcblgPc8dK0N9JfabOL0BH3plDyFTk1oXp/kRJ4kSEGQW1WNq2dOk
         g1XDnx1q4RV44PN+IvXa4HQOAo+/r+TzGNII45NMscmR8WKoKt0C8cIV/NzcGLQF3By4
         l6D4QHm5zUJYC1GSRdcpJr2v0fgogD4b1jDMD5C/ty0qvRHiRRdne45EuSlM+uOrURto
         A8Ag==
X-Gm-Message-State: AO0yUKX/0BYeTJG3GejuBGbGezbxaHrz6NjRycl35GVwUAYnlrJeiB+N
        x4fRMPe7jjqX1/SjG/ZPnC0=
X-Google-Smtp-Source: AK7set+Ts110wYYXC49x+NmncFCL9/MoZTa54wVG4XMrQWy22y64hFFk7joUInYvja61fm4lvQfAZA==
X-Received: by 2002:a1c:6a0b:0:b0:3ed:76c3:50e9 with SMTP id f11-20020a1c6a0b000000b003ed76c350e9mr677108wmc.17.1679606904037;
        Thu, 23 Mar 2023 14:28:24 -0700 (PDT)
Received: from localhost.localdomain ([46.211.10.218])
        by smtp.googlemail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm3015096wmc.17.2023.03.23.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:28:23 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) Sort ASUS board list
Date:   Thu, 23 Mar 2023 23:27:49 +0200
Message-Id: <20230323212751.2474-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Rearrange board list in alphabetical order by: LC_ALL=C sort -u

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775-platform.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 2db71b62e03d4..5ba888b7eb8c8 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1052,14 +1052,6 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
-	"Pro A520M-C",
-	"Pro A520M-C II",
-	"PRO H410T",
-	"ProArt B550-CREATOR",
-	"ProArt X570-CREATOR WIFI",
-	"ProArt Z490-CREATOR 10G",
-	"Pro B550M-C",
-	"Pro WS X570-ACE",
 	"PRIME A520M-A",
 	"PRIME A520M-A II",
 	"PRIME A520M-E",
@@ -1078,6 +1070,14 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME H410M-R",
 	"PRIME X570-P",
 	"PRIME X570-PRO",
+	"PRO H410T",
+	"Pro A520M-C",
+	"Pro A520M-C II",
+	"Pro B550M-C",
+	"Pro WS X570-ACE",
+	"ProArt B550-CREATOR",
+	"ProArt X570-CREATOR WIFI",
+	"ProArt Z490-CREATOR 10G",
 	"ROG CROSSHAIR VIII DARK HERO",
 	"ROG CROSSHAIR VIII EXTREME",
 	"ROG CROSSHAIR VIII FORMULA",
@@ -1109,14 +1109,14 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING A520M-PLUS",
 	"TUF GAMING A520M-PLUS II",
 	"TUF GAMING A520M-PLUS WIFI",
+	"TUF GAMING B550-PLUS",
+	"TUF GAMING B550-PLUS WIFI II",
+	"TUF GAMING B550-PRO",
 	"TUF GAMING B550M-E",
 	"TUF GAMING B550M-E WIFI",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",
 	"TUF GAMING B550M-PLUS WIFI II",
-	"TUF GAMING B550-PLUS",
-	"TUF GAMING B550-PLUS WIFI II",
-	"TUF GAMING B550-PRO",
 	"TUF GAMING X570-PLUS",
 	"TUF GAMING X570-PLUS (WI-FI)",
 	"TUF GAMING X570-PLUS_BR",
-- 
2.39.2

