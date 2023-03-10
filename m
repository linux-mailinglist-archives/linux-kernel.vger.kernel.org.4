Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9B6B38CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCJIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjCJIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744EC57D27
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so17303464edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq0v9YVI3wtTDDjRzU92twoQtmr2PxAaTyrW0UMmWQw=;
        b=DPozms87b/PKkkvHKub1WKUztXE4+jPb5NnQzzW1kMEuhkF8hKSWBzkPblC7l61XQh
         EZ1IRrjDeI6vRq9phb5K1GGpS+AbLi8zw0oHClXEhj+1S/M50sK6Zh87BFVW8E/x1k86
         GPNd3m060qI+rO6sDrrMjMqBIjYU5L0drL2gxFllMpKGHFfM6Ib4pIGPrHMslE4+1xS7
         IPPJxK0q+RZLSIQg8FCsIpBBqs8h+Gwp/umX+b9Mhp0jaWndX2nPWxVv7fpU6/ZKK7xn
         EzRJ/uL5ZIzsIfu46DzMC6ihuntdr1MWemfP1ze9dgz+6G5NssJ18c5vqAveeFWzRxqS
         HsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq0v9YVI3wtTDDjRzU92twoQtmr2PxAaTyrW0UMmWQw=;
        b=z/7cIWcy4nLDGP5x26av/tWp02wg/wL8hejf2fqjgYqTEp/yNPkKPFePeHowv4fWzi
         3REZ9oiIirRK4oIgPBxkcnEx76m8OHnfE6PAD7jMcd8oHQLOCJfA8bfUfEfO3/9iHqFv
         AYX2EN2OiRaNFJuk6R7I9LLiL6909FpaGbN1bgaO9g7+4H3mnFRioe547MNf6molQ5qc
         JHSb0qIKkwC4N/D8DU0gNKiCs21EO4jyznIPNqjU4yg9U1mvDr++dILf4b08rlTPXqdd
         YUjqNG8KV136hlb1X7roL6LKP7jFWdIHkF+nwuJVDdY6meAOwTkIbbVgadc4Jcnu5IkY
         x3xA==
X-Gm-Message-State: AO0yUKWHF64w4MYAV7VD9Mec8y/BHKY7qdb+nya22LmyNs294miaH50d
        cAMPDNkrimHyRBi0bBzBsrE=
X-Google-Smtp-Source: AK7set9zvfifLV+DAdB0O75/g20ZDKcfqNMOyFRopgBKGXG/WmOUXZN7jRDevDU5HDD2DOXlzO0/3g==
X-Received: by 2002:a17:906:6d85:b0:8c3:3439:24d9 with SMTP id h5-20020a1709066d8500b008c3343924d9mr19667016ejt.24.1678437306035;
        Fri, 10 Mar 2023 00:35:06 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: MapCharToHexDigit() is not used
Date:   Fri, 10 Mar 2023 09:34:45 +0100
Message-Id: <20230310083449.23775-2-straube.linux@gmail.com>
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

The function MapCharToHexDigit() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 16 ----------------
 drivers/staging/rtl8723bs/include/hal_com.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e42556d03bce..b74817fc4316 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -859,22 +859,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num)
 	return true;
 }
 
-/*  */
-/* 	Description: */
-/* 		Translate a character to hex digit. */
-/*  */
-u32 MapCharToHexDigit(char chTmp)
-{
-	if (chTmp >= '0' && chTmp <= '9')
-		return chTmp - '0';
-	else if (chTmp >= 'a' && chTmp <= 'f')
-		return 10 + (chTmp - 'a');
-	else if (chTmp >= 'A' && chTmp <= 'F')
-		return 10 + (chTmp - 'A');
-	else
-		return 0;
-}
-
 bool GetU1ByteIntegerFromStringInDecimal(char *Str, u8 *pInt)
 {
 	u16 i = 0;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 6356b8c2ef81..8a7d31d1eaca 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -147,8 +147,6 @@ u8 GetHalDefVar(struct adapter *adapter, enum hal_def_variable variable,
 
 bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
-u32 MapCharToHexDigit(char chTmp);
-
 bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
 			  char RightQualifier);
 
-- 
2.39.2

