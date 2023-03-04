Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFD6AAC12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCDTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:13:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE12D53D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:13:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a25so23336864edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677957204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcfDUA/sRgLUGaoFssKZvpjlOGcLsgZTKveJXBBBB9Q=;
        b=OJ5LxVkTl0ik38c6evn6jp+2Bz+7B5jqusA7T/ZI9PAwylXurqk2a99LPFTXevG5rW
         xyic2RrO/yqSNGLgPMRFer64ZADdVend4YLITF8/thnybUPfTArkF29vWQYkP6YprJoa
         dDT7oQb7p+lTi/p3hnJZL/gjxmNoFDCvG0wlIKMjuRaOs3xmVsaA18APF8Zve+HaKnak
         VFDEB7RRqKkgc9yQHXeQW5VddcJrLT0qErLNhUFZ38bqvr8JpzFk4/dGLSChztE9Tdy4
         CtFkZf+73Ee1/eUve7GSJkOM1SqR/X3SYD6pB4wxheKcnmtXn6pkLAEVzNs04WazOR7n
         tXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcfDUA/sRgLUGaoFssKZvpjlOGcLsgZTKveJXBBBB9Q=;
        b=BGVFeS8SHOetei021VcPSix4VQIyS5rD7OOlJd8E+qp+osZEJvSgErsk6aEwDMxduJ
         OkK6+/PxZ6iZaCa4oELGykpKHH3SnuK8NsGkY1n/2hrH8MA95KvEMATVmoA1xU+kKMPj
         fkS1dfECNWf0SYX6kB94r/qUtLfb74xyRDhnSH/Dypr4iTklWfOlFxkOPzCB8MswI22R
         L1/tk97mT79LuAPUEstH8bGZehetxA5oVjo9DC6b3j7RvcVSmUkejmJWFWQk0SZ2BTDO
         iwRFkJdQvyMGG7ZOE+AsjYDqXw38S4tUUoOwy47glv9WYyd9MRp9umoAUYhYM5JIzfmA
         jfZQ==
X-Gm-Message-State: AO0yUKXOn2goiQzjzWynakpKoL/jLvUEkfeepZjV4WUi/inIDeVqyfNW
        xf9pUhbv/2vdffBN21NMhF3OnTqQUEg=
X-Google-Smtp-Source: AK7set+SbLZITSzqWhSY7W6Hx/wQkZPrsDvjs7X4Ag6xyy6IB71ByFNZnKcM+z3vFIYGX9bfApuCbA==
X-Received: by 2002:a05:6402:26d4:b0:4af:81f1:5b02 with SMTP id x20-20020a05640226d400b004af81f15b02mr6984046edd.2.1677957204589;
        Sat, 04 Mar 2023 11:13:24 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v5-20020a50d085000000b004af5968cb3bsm2744136edd.17.2023.03.04.11.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:13:24 -0800 (PST)
Date:   Sat, 4 Mar 2023 20:13:22 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciEPHY_REGArray
Message-ID: <511bd239bf033dca3efcc64a640d5343c98fa897.1677955334.git.philipp.g.hortmann@gmail.com>
References: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty array Rtl8192PciEPHY_REGArray and the code where it is used
because it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 5 +----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 --
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 --
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 6388f1220575..385ceb3a9636 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -334,10 +334,7 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 
 	AGCTAB_ArrayLen = AGCTAB_ArrayLength;
 	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
-	if (priv->rf_type == RF_2T4R) {
-		PHY_REGArrayLen = PHY_REGArrayLength;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REGArray;
-	} else if (priv->rf_type == RF_1T2R) {
+	if (priv->rf_type == RF_1T2R) {
 		PHY_REGArrayLen = PHY_REG_1T2RArrayLength;
 		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 75629f5df954..561a4c874fe3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -16,7 +16,6 @@
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
 #define RadioC_ArrayLength			RadioC_ArrayLengthPciE
 #define RadioD_ArrayLength			RadioD_ArrayLengthPciE
-#define PHY_REGArrayLength			PHY_REGArrayLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
 
 #define Rtl819XMACPHY_Array_PG			Rtl8192PciEMACPHY_Array_PG
@@ -26,7 +25,6 @@
 #define Rtl819XRadioC_Array			Rtl8192PciERadioC_Array
 #define Rtl819XRadioD_Array			Rtl8192PciERadioD_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
-#define Rtl819XPHY_REGArray			Rtl8192PciEPHY_REGArray
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
 
 extern u32 rtl819XAGCTAB_Array[];
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 1f80dbeb17b5..d04608d99cbf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -6,8 +6,6 @@
  */
 #include "table.h"
 
-u32 Rtl8192PciEPHY_REGArray[PHY_REGArrayLengthPciE] = {0x0,};
-
 u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE] = {
 	0x800, 0x00000000,
 	0x804, 0x00000001,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 7d63f5a5c1b7..177fe2173430 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -11,8 +11,6 @@
 
 #include <linux/types.h>
 
-#define PHY_REGArrayLengthPciE 1
-extern u32 Rtl8192PciEPHY_REGArray[PHY_REGArrayLengthPciE];
 #define PHY_REG_1T2RArrayLengthPciE 296
 extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
 #define RadioA_ArrayLengthPciE 246
-- 
2.39.2

