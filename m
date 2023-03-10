Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7676B38D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCJIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCJIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E75D746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so17429673edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gReelpVe4zvSWiZRdb8tfO79qo06lsPORLYzKHhKDKI=;
        b=SWku8Pd8dDAyAUoUWp4nVPyVnmqu8m9KfnggqUW6hqjOiOCxQGQmhrjYXw/XTV5q6D
         NJUXM9/K6dyg3UTvC+ZwmN+X5axinHki4oXxkcUtDTYfFO2NlDbzTgCKZzzSC2gW8GiZ
         Z03AgvUWM6axMuK6GFIRshNHF2bKNtJQJQJYxVkp39Rm+MKkUluYXjfjkjwo1dOKVxHb
         d6EjEiVwg0J01uiAs9VIsITZCCiLvo/e++CIrqX2XzLrrNg6Y/WM7KVAYJ9k7KxEGQVZ
         ywzDlwkF6hFvWI9Sd1EzfekYpi06EiIKtKGysvRyRuzyXzb3LTgCvJXBo1PMq7OSbOId
         kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gReelpVe4zvSWiZRdb8tfO79qo06lsPORLYzKHhKDKI=;
        b=z0sY5n4v+NGx95Ajbvo75vRllQ9DylXX8N37SvFFnVr8RIQNgy/IuPSh7gzfgKW02p
         AWcXpFRTjh6OCDmdSnCKQ5pslgbQNnTzVyC0EpFXC/yOjN3Zowm1m8d3QxGbIuCqFHbG
         n9wBTyf1TzhUD8rZhQhcDriOj+i266sHdf8aSjX3GDt9MHSnF0BlWukKgtN6ix9PwmHt
         Db6VP3VhMaN/xfWzmNkmtSEuV0Y6Mwo2uOdvD1XtlT7HjnFxao0Av6uIYowxs2zkB6xp
         jmOzjuCjg8d7DISDVeW0klUKsf64QL1ThGMAtvJK16hgKOaRaES0vH1C1Drnxd2qBHsG
         HD5A==
X-Gm-Message-State: AO0yUKVvZHVNZfH4MVw6fRNFq/ceHR1NMPEzFWtzNnWG0cTU/TGg5nRs
        tXNyhF4xifFJif7dV9h3XQU=
X-Google-Smtp-Source: AK7set9/L1r/raS/hQPUMv+1ex7lPMAWTlgp4gB5S+woMqEvmkEeH771z0d1gMu8z/MXFLlSmUU3EQ==
X-Received: by 2002:a17:907:d14:b0:8f6:711b:8d67 with SMTP id gn20-20020a1709070d1400b008f6711b8d67mr34277473ejc.26.1678437308048;
        Fri, 10 Mar 2023 00:35:08 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: ParseQualifiedString() is not used
Date:   Fri, 10 Mar 2023 09:34:46 +0100
Message-Id: <20230310083449.23775-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310083449.23775-1-straube.linux@gmail.com>
References: <20230310083449.23775-1-straube.linux@gmail.com>
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

The function ParseQualifiedString() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 24 ---------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  3 ---
 2 files changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index b74817fc4316..ff0e41bf72b0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -877,30 +877,6 @@ bool GetU1ByteIntegerFromStringInDecimal(char *Str, u8 *pInt)
 	return true;
 }
 
-/*  <20121004, Kordan> For example,
- *  ParseQualifiedString(inString, 0, outString, '[', ']') gets "Kordan" from
- *  a string "Hello [Kordan]".
- *  If RightQualifier does not exist, it will hang in the while loop
- */
-bool ParseQualifiedString(
-	char *In, u32 *Start, char *Out, char LeftQualifier, char RightQualifier
-)
-{
-	u32 i = 0, j = 0;
-	char c = In[(*Start)++];
-
-	if (c != LeftQualifier)
-		return false;
-
-	i = (*Start);
-	while ((c = In[(*Start)++]) != RightQualifier)
-		; /*  find ']' */
-	j = (*Start) - 2;
-	strncpy((char *)Out, (const char *)(In+i), j-i+1);
-
-	return true;
-}
-
 bool isAllSpaceOrTab(u8 *data, u8 size)
 {
 	u8 cnt = 0, NumOfSpaceAndTab = 0;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 8a7d31d1eaca..31fdb5c45de3 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -147,9 +147,6 @@ u8 GetHalDefVar(struct adapter *adapter, enum hal_def_variable variable,
 
 bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
-bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
-			  char RightQualifier);
-
 bool GetU1ByteIntegerFromStringInDecimal(char *str, u8 *in);
 
 bool isAllSpaceOrTab(u8 *data, u8 size);
-- 
2.39.2

