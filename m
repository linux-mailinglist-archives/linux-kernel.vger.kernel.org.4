Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5E6B9EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCNSom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCNSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D142B604
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x13so18651596edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819450; x=1681411450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dX/61Oavue+o3+oO8HANeoCLyyVoQ/bbCU3a8t7lgHo=;
        b=AqeMvcLOgpXAE1QCwYtotjQd5VIjFkg25rhw5E3x23CUlSG4uIaC4Gt5aq8iz4zwCF
         enm6jsMoUxqK7byRivsVK6DrRBqrgMHG/EYi/uKh8Ltb8DISzcWfASGrICQhPIlBacIw
         sUvT9Uq5edYcIN350R+OncDWmUvBcsw4rie/pP8rncfWQwHXsPKZAqd0nNnLEoAMsOi6
         XmFDY/OlcA6Hn0GM5afV/ko+tGeYqVP8EMGEFbKgBrRy9xJ64BDIW7I6IUlqi4epziS7
         VwpYutR3PMikDI5jRALsb+3vHNflp08A7FL6Tm197rwTCdZKYpw9QUcF+/f81+a+62LC
         pTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819450; x=1681411450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX/61Oavue+o3+oO8HANeoCLyyVoQ/bbCU3a8t7lgHo=;
        b=sJ/6TcHxfKVx31locGBTP6NAlSHzjyCQ6xgh3h7HfslwrRrGhDm06ZQQA3639q7MaI
         DQRXALJMyEhnzxdSOgI5oaqx3oF6/ttfxe97FqYBtOz2YD1vNRs3SQdwBV4odCEULUCo
         XdUPmNOFHQTBh0wzTHLci+5vsVi8/XhcqglydLM9RtSS0uLNDfQhycuI5PR6F4LNtHxc
         E1Eeawy4OzUOxqwRfE0JJ3VjfJrRCXY9sd0lNQFXf/ElhjAMRozUfiPGzIUpEkFT2lcv
         EikssvBMiO5eKey5JMP3g4z/6j/9ndf22hauLdIWx8M3ro7Hi392wLUf4U3abA1vAosa
         e8qg==
X-Gm-Message-State: AO0yUKXu3G0HOWbWsB1XxbDya7SxwaDWCYcbcbruiEkuXoHsWtv9r+Yj
        crCFPka2UwKJ4/9RjMrgHjPzTf+J47c=
X-Google-Smtp-Source: AK7set+A1i7xFo2FTYFM1nHnN8PpvZpZemKGl8ZaNubUq1vQFhgeiKZik9WLyfjuK4KWSf8lLNpZsQ==
X-Received: by 2002:a17:906:738f:b0:8aa:c0d5:25b1 with SMTP id f15-20020a170906738f00b008aac0d525b1mr864003ejl.5.1678819449782;
        Tue, 14 Mar 2023 11:44:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id rq4-20020a17090788c400b00927341bf69dsm1467525ejc.88.2023.03.14.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:44:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:44:07 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] staging: rtl8192e: Join constants Rtl819XRadioB_..
 with ..RadioB_..
Message-ID: <59af481400d5f7633bcaf7fcd95b7e5f0093fd3f.1678814935.git.philipp.g.hortmann@gmail.com>
References: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Join constants Rtl819XRadioB_Array with Rtl8192PciERadioB_Array to
RTL8192E_RADIO_B_ARR to improve readability. Fix spaces around '+' to
improve coding style.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 49fdaacb788a..5b9a1b78c35e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -555,13 +555,13 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 		break;
 	case RF90_PATH_B:
 		for (i = 0; i < RTL8192E_RADIO_B_ARR_LEN; i += 2) {
-			if (Rtl819XRadioB_Array[i] == 0xfe) {
+			if (RTL8192E_RADIO_B_ARR[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioB_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIO_B_ARR[i],
 					  bMask12Bits,
-					  Rtl819XRadioB_Array[i+1]);
+					  RTL8192E_RADIO_B_ARR[i + 1]);
 
 		}
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 74c7850e514c..ee91d687de9b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define Rtl819XRadioB_Array			Rtl8192PciERadioB_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 4f36a480f6f2..eeea01681e7d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -283,7 +283,7 @@ u32 RTL8192E_RADIO_A_ARR[RTL8192E_RADIO_A_ARR_LEN] = {
 	0x007, 0x00000700,
 };
 
-u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN] = {
+u32 RTL8192E_RADIO_B_ARR[RTL8192E_RADIO_B_ARR_LEN] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x000006e0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 60917c95842b..3023440db58b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -16,7 +16,7 @@ extern u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN];
 #define RTL8192E_RADIO_A_ARR_LEN 246
 extern u32 RTL8192E_RADIO_A_ARR[RTL8192E_RADIO_A_ARR_LEN];
 #define RTL8192E_RADIO_B_ARR_LEN 78
-extern u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN];
+extern u32 RTL8192E_RADIO_B_ARR[RTL8192E_RADIO_B_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_LEN 18
 extern u32 RTL8192E_MACPHY_ARR[RTL8192E_MACPHY_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_PG_LEN 30
-- 
2.39.2

