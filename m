Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E166BBE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjCOVDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjCOVDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F022762862;
        Wed, 15 Mar 2023 14:02:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t11so25930014lfr.1;
        Wed, 15 Mar 2023 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678914113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGfKora0XMUGhJlq+KTNPtbqhjZTdnly+3GHzi+iIMw=;
        b=GwjFYu8KxUWiC2uQPe2KjnXp+V3ECU8n1BiBIrggqPHFoq4u2mVEq9bW7uVL+dyYBR
         d34fVatv1M36XzHicKdJlpFUJwrnKym+79nylYOxjiW3uAnZb6Azup5FM1GT2qBZJnGU
         p61l8k7ljbyXUE19Hn+j5bKnBYnUbeS42eF8k1bciEkvElyQIrSnSnuv3dUGJyHh2Wct
         8MiCAFzKzIGQ69qEcEWhtH4hgLfeNfeRFgR1saOxWGp7wsFrqlmW+6YJvxWGOlNmh7aP
         4ow2uikCbw2r/2F60LMZ0f/7OW2ZB3iScswTnrFVM7Z5pB93CsT7WiCLG3hoeuH3dWyO
         SJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGfKora0XMUGhJlq+KTNPtbqhjZTdnly+3GHzi+iIMw=;
        b=Wn+nOFjh7/t0neyhoD8YQItWDVS7x4jBcDP0GS/9CW6xlkGg8m5wClPuvsCuQCFbs2
         EcU2XN7Nvr6LDYfnk9P9hxRbGCV5BI4CO3pGkgHM5QI/t1peWxKZUiYDc05ab8HfS3Ak
         1MQP89LdJA44F3A0AQQ9nkoWLtBMVWj84WHMxSjyrbR+/0hBe7KKp5/WBgjo5vXEBc0B
         KU+i7mItYSBhBNtgmYjYOmJMBK7sG5hSnC8C+LASBfejJNJS26qq2IEceHl7RclSrP7k
         OS5AvUPyAE4bNY3PHwxwVr6KcHVvTYZ3YponyhW0Ipz6sd+0xdChSsmVVjE3TSyk7Cpc
         Km/w==
X-Gm-Message-State: AO0yUKXuwctHGImjHPQT+4njTPc18MeFN7IiV0lhHN7jMO+26Ja6Xl6U
        y+YQm9jydgb76WK26WvfnnM=
X-Google-Smtp-Source: AK7set9eJV6RmHvyFLWF7Rj+PRD1Tno4Wx5sCfjAOOVL3HPX/CH+RGzhAqKioifxnksvW4btwus19Q==
X-Received: by 2002:ac2:597c:0:b0:4a4:68b9:19da with SMTP id h28-20020ac2597c000000b004a468b919damr2326982lfp.2.1678914113119;
        Wed, 15 Mar 2023 14:01:53 -0700 (PDT)
Received: from localhost.localdomain ([46.211.236.75])
        by smtp.googlemail.com with ESMTPSA id p17-20020a05651238d100b0047f7722b73csm936396lft.142.2023.03.15.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:01:52 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com,
        mischief@offblast.org, de99like@mennucci.debian.net
Subject: [PATCH 1/2] hwmon: (nct6775) Fix TUF GAMING B550M-E WIFI name
Date:   Wed, 15 Mar 2023 23:01:34 +0200
Message-Id: <20230315210135.2155-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TUF GAMING B550M-E WIFI motherboard is incorrectly named as
TUF GAMING B550M-E (WI-FI).

Validated by dmidecode output from https://github.com/linuxhw/DMI/

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 24c67dbfa8ab2..0ded82ac7fd31 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1095,7 +1095,7 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
 	"TUF GAMING B550M-E",
-	"TUF GAMING B550M-E (WI-FI)",
+	"TUF GAMING B550M-E WIFI",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",
 	"TUF GAMING B550M-PLUS WIFI II",
-- 
2.39.2

