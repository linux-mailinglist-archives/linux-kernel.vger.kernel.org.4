Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD4623FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKJKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:35:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A5663E1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:35:24 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 136so1419398pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9QXzhrLhDW3RHcvqKL2KC0I9EowigNO1qRdY6DDV+A=;
        b=MuPr3tbfbxFkIWMMj5tUNTNIGbc7kJOLypJtpArKx7JWS2Q9tjNs37jv1Mtwx79lqR
         IoEJTG52Rzo4UWCWhWbKfA44s9sddH8BpnqdU8d8mzJfFdZdpmA65Bjn5wk7DE/HzDlI
         70DjIXIZABnNq8qUTU8kIKKX3Juqnbo0Q0UXWgqPs8IpXY2nF4wFtRPI0HWy0MfEkcin
         U0baAVdodfnM7OMGrOyGS/EvPg3b4eRliPCNX5NzZSU0qsM7FcUY7vOKtX9Fv3HrIgSs
         Nbc3zSP//xTVfq3UAeWly8bj561qHkN5P71wp8crK4jvqMY7qwABamSycSNCebu5EdTc
         PK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9QXzhrLhDW3RHcvqKL2KC0I9EowigNO1qRdY6DDV+A=;
        b=IvByLNd6EzJTl6gyoSzkDy2YD/gBDoNeQp+h+3Fp0U551JOKlwNqsgga+sSDmuu4RA
         F2ljYJTY9Sxr2J8Ux4Ft/wwLIu7EsXIXOu5gqrlcrO3tJFXKiJpLPCPoT8NdF8hLA2oF
         cT7yd2Nk0gEMRYxafKa+YpBU0i2wyWm1LDsYe3CYafF+0tMSBkthAwv984Os90ckNSDq
         eg781U4BRkql2f+Lqz1WNH6irRvv4ghcW0Db3ToBl47kyg08glE/zxP6R1g+DOxfb57I
         gzFWMVfQ/TBi37BMg2l29++TvgoGWJvZGH9CgMiUviMSoAkUfaPj6bTTaOWf5UD5elBY
         n8IA==
X-Gm-Message-State: ACrzQf3zKRsy2Pa/mQ/CCKYLKZuCuKLwoVyDvBAvCcvJ3xqlR3KdZgj1
        DOB6FdFfgh9i0cer5BiOAz2fWsSqGG+3Ag==
X-Google-Smtp-Source: AMsMyM6QJREfZqusAXyfOgA/K+7oaTU3V8Bs9Q1kaKbp/uTWUQ+YjLpIZGBXEswaL5EmuUFiN7fUFA==
X-Received: by 2002:a63:90c4:0:b0:46f:5a21:3b5d with SMTP id a187-20020a6390c4000000b0046f5a213b5dmr40523313pge.210.1668076523572;
        Thu, 10 Nov 2022 02:35:23 -0800 (PST)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id n4-20020a63e044000000b0044e8d66ae05sm8879450pgj.22.2022.11.10.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:35:23 -0800 (PST)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] staging: rtl8192e: replace macro defines with variables
Date:   Thu, 10 Nov 2022 21:35:11 +1100
Message-Id: <354847ce7b2f9ea4dc549bf13656192c1db7c231.1668075486.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1668075486.git.jacob.bai.au@gmail.com>
References: <cover.1668075486.git.jacob.bai.au@gmail.com>
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

remove marco defines of array length, use variables instead and
initialize them from ARRAY_SIZE().

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.c  | 31 ++++++++++------
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 36 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -----------
 3 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
index 8920283f340e..ec9e2de4c942 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
@@ -6,9 +6,10 @@
  */
 #include "r8192E_hwimg.h"
 
-u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN] = {0x0,};
+u32 RTL8192E_PHY_REG_ARRAY[] = {0x0,};
+u32 RTL8192E_PHY_REG_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_ARRAY);
 
-u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
+u32 RTL8192E_PHY_REG_1T2R_ARRAY[] = {
 	0x800, 0x00000000,
 	0x804, 0x00000001,
 	0x808, 0x0000fc00,
@@ -158,8 +159,9 @@ u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
 	0xe18, 0x161a1a1a,
 	0xe1c, 0x12121416,
 };
+u32 RTL8192E_PHY_REG_1T2R_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_1T2R_ARRAY);
 
-u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN] = {
+u32 RTL8192E_RADIOA_ARRAY[] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x00000ee0,
@@ -284,8 +286,9 @@ u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN] = {
 	0x004, 0x00000975,
 	0x007, 0x00000700,
 };
+u32 RTL8192E_RADIOA_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOA_ARRAY);
 
-u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN] = {
+u32 RTL8192E_RADIOB_ARRAY[] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x000006e0,
@@ -326,14 +329,17 @@ u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN] = {
 	0x004, 0x00000975,
 	0x007, 0x00000700,
 };
+u32 RTL8192E_RADIOB_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOB_ARRAY);
 
-u32 RTL8192E_RADIOC_ARRAY[RTL8192E_RADIOC_ARRAY_LEN] = {
-	0x0,  };
+u32 RTL8192E_RADIOC_ARRAY[] = {
+	0x0, 0x0 };
+u32 RTL8192E_RADIOC_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOC_ARRAY);
 
-u32 RTL8192E_RADIOD_ARRAY[RTL8192E_RADIOD_ARRAY_LEN] = {
-	0x0, };
+u32 RTL8192E_RADIOD_ARRAY[] = {
+	0x0, 0x0 };
+u32 RTL8192E_RADIOD_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOD_ARRAY);
 
-u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN] = {
+u32 RTL8192E_MAC_ARRAY[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0x340, 0xffffffff, 0x161a1a1a,
 	0x344, 0xffffffff, 0x12121416,
@@ -341,8 +347,9 @@ u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN] = {
 	0x12c, 0xffffffff, 0x04000802,
 	0x318, 0x00000fff, 0x00000100,
 };
+u32 RTL8192E_MAC_ARRAY_LEN = ARRAY_SIZE(RTL8192E_MAC_ARRAY);
 
-u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN] = {
+u32 RTL8192E_MAC_ARRAY_PG[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0xe00, 0xffffffff, 0x06090909,
 	0xe04, 0xffffffff, 0x00030306,
@@ -354,8 +361,9 @@ u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN] = {
 	0x12c, 0xffffffff, 0x04000802,
 	0x318, 0x00000fff, 0x00000800,
 };
+u32 RTL8192E_MAC_ARRAY_PG_LEN = ARRAY_SIZE(RTL8192E_MAC_ARRAY_PG);
 
-u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN] = {
+u32 RTL8192E_AGC_TAB_ARRAY[] = {
 	0xc78, 0x7d000001,
 	0xc78, 0x7d010001,
 	0xc78, 0x7d020001,
@@ -549,3 +557,4 @@ u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN] = {
 	0xc78, 0x693e001e,
 	0xc78, 0x6a3f001e,
 };
+u32 RTL8192E_AGC_TAB_ARRAY_LEN = ARRAY_SIZE(RTL8192E_AGC_TAB_ARRAY);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
index a436c089a779..9d2537806460 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
@@ -11,23 +11,23 @@
 
 #include <linux/types.h>
 
-#define RTL8192E_PHY_REG_ARRAY_LEN 1
-extern u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN];
-#define RTL8192E_PHY_REG_1T2R_ARRAY_LEN 296
-extern u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN];
-#define RTL8192E_RADIOA_ARRAY_LEN 246
-extern u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN];
-#define RTL8192E_RADIOB_ARRAY_LEN 78
-extern u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN];
-#define RTL8192E_RADIOC_ARRAY_LEN 2
-extern u32 RTL8192E_RADIOC_ARRAY[RTL8192E_RADIOC_ARRAY_LEN];
-#define RTL8192E_RADIOD_ARRAY_LEN 2
-extern u32 RTL8192E_RADIOD_ARRAY[RTL8192E_RADIOD_ARRAY_LEN];
-#define RTL8192E_MAC_ARRAY_LEN 18
-extern u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN];
-#define RTL8192E_MAC_ARRAY_PG_LEN 30
-extern u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN];
-#define RTL8192E_AGC_TAB_ARRAY_LEN 384
-extern u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN];
+extern u32 RTL8192E_PHY_REG_ARRAY_LEN;
+extern u32 RTL8192E_PHY_REG_ARRAY[];
+extern u32 RTL8192E_PHY_REG_1T2R_ARRAY_LEN;
+extern u32 RTL8192E_PHY_REG_1T2R_ARRAY[];
+extern u32 RTL8192E_RADIOA_ARRAY_LEN;
+extern u32 RTL8192E_RADIOA_ARRAY[];
+extern u32 RTL8192E_RADIOB_ARRAY_LEN;
+extern u32 RTL8192E_RADIOB_ARRAY[];
+extern u32 RTL8192E_RADIOC_ARRAY_LEN;
+extern u32 RTL8192E_RADIOC_ARRAY[];
+extern u32 RTL8192E_RADIOD_ARRAY_LEN;
+extern u32 RTL8192E_RADIOD_ARRAY[];
+extern u32 RTL8192E_MAC_ARRAY_LEN;
+extern u32 RTL8192E_MAC_ARRAY[];
+extern u32 RTL8192E_MAC_ARRAY_PG_LEN;
+extern u32 RTL8192E_MAC_ARRAY_PG[];
+extern u32 RTL8192E_AGC_TAB_ARRAY_LEN;
+extern u32 RTL8192E_AGC_TAB_ARRAY[];
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index e1c1f19b71a3..5e6527e835db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,26 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define AGCTAB_ArrayLength			RTL8192E_AGC_TAB_ARRAY_LEN
-#define MACPHY_ArrayLength			RTL8192E_MAC_ARRAY_LEN
-#define RadioA_ArrayLength			RTL8192E_RADIOA_ARRAY_LEN
-#define RadioB_ArrayLength			RTL8192E_RADIOB_ARRAY_LEN
-#define MACPHY_Array_PGLength			RTL8192E_MAC_ARRAY_PG_LEN
-#define RadioC_ArrayLength			RTL8192E_RADIOC_ARRAY_LEN
-#define RadioD_ArrayLength			RTL8192E_RADIOD_ARRAY_LEN
-#define PHY_REGArrayLength			RTL8192E_PHY_REG_ARRAY_LEN
-#define PHY_REG_1T2RArrayLength			RTL8192E_PHY_REG_1T2R_ARRAY_LEN
-
-#define Rtl819XMACPHY_Array_PG			RTL8192E_MAC_ARRAY_PG
-#define Rtl819XMACPHY_Array			RTL8192E_MAC_ARRAY
-#define Rtl819XRadioA_Array			RTL8192E_RADIOA_ARRAY
-#define Rtl819XRadioB_Array			RTL8192E_RADIOB_ARRAY
-#define Rtl819XRadioC_Array			RTL8192E_RADIOC_ARRAY
-#define Rtl819XRadioD_Array			RTL8192E_RADIOD_ARRAY
-#define Rtl819XAGCTAB_Array			RTL8192E_AGC_TAB_ARRAY
-#define Rtl819XPHY_REGArray			RTL8192E_PHY_REG_ARRAY
-#define Rtl819XPHY_REG_1T2RArray		RTL8192E_PHY_REG_1T2R_ARRAY
-
 extern u32 rtl819XAGCTAB_Array[];
 
 enum hw90_block {
-- 
2.34.1

