Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC376B9EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCNSn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCNSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:43:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB1B6D05
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o12so65956785edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819406; x=1681411406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1s6Yk/yWtlCX9fg4ML/GfDhv7pAqeBZ0tu9hAhPDEqY=;
        b=fxAhfQl45raltob89lwevzlkzxHc89XaRkIphYOQFCnW/fkSqzg+EJH+8r2f1xLm+B
         aB+umYoqB796rSd+OCFc6L0IswAK+oCzrig1Ite3NT9CF2af9Me3LIMsRSig7lsjK+St
         n/n6/1OiBGo9g/T6RAwMNypNlFs4FILhRGcz/Nsc7tEEOBR/D3Uj8iislEhyN8gHJpqx
         EahkBi9XYGpg7ASvV8pPCseGtSdsseeMMMyEk6BFVnB4rS9YuSzyNvXZ0pGv2WyW1d8S
         pF1WaDFN/fI7fdSsU5NrOhRFXkwanVCIKv5w76vwlaxcKYG+FuaE2Y0DDGD0fNy5uWB5
         Bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819406; x=1681411406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s6Yk/yWtlCX9fg4ML/GfDhv7pAqeBZ0tu9hAhPDEqY=;
        b=EqOLJSwHRdj/qs/cpWw14YhYvn3OpcK3+h4uDB5z9xzhh0VqgzUtmbzlLKS+9CEDMT
         sEZ4VXeBVP+dZ8v9SHev8ditRZBKllwIvYANmg4ID7k+tMQBwfVwRtROUkfCRy1CdCU0
         wKVhLEFSchiAnu5/GUBmlJTDuJLow62GY2jrhv6TVw6rtKhZP8wiz+QZf32yW1f+VNnt
         xyw35indxsOHqyu1RGcfOqtoo1N0uY9o8Pb3mKdKgoCdlwPk8/EnT0sUpYsDtb86a4/+
         x7lqJRudUnFEEj2e4/pzBF3WnoUNkQH7iSjgDG6QSlzM/yIwGowFi9ZRaaKMqfLah/0b
         yl2Q==
X-Gm-Message-State: AO0yUKV6nLLfmdOA0R792WgnwW5w/01HxQtialDH4e4PbeQpP/UGNous
        eSU8GiGrdjo7nqd5s27n+Bc=
X-Google-Smtp-Source: AK7set9zNMSHSq9eFpUG0x2uaPc2fZJ+86vcuIt/Y2t9FqHX52cMclEswWh2d2W/wCo9f0RMemQO/A==
X-Received: by 2002:a17:906:5c:b0:88c:f97c:7c87 with SMTP id 28-20020a170906005c00b0088cf97c7c87mr14743490ejg.2.1678819406565;
        Tue, 14 Mar 2023 11:43:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b008c979c74732sm1446505ejb.156.2023.03.14.11.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:26 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] staging: rtl8192e: Join constants
 MACPHY_Array_PGLength with ..LengthPciE
Message-ID: <6d86257ddf3fecbf2bb104f1eeedbf09a56e0861.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants MACPHY_Array_PGLength with MACPHY_Array_PGLengthPciE to
RTL8192E_MACPHY_ARR_PG_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e42b77f91528..86d51eb7af17 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -287,7 +287,7 @@ void rtl92e_config_mac(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (priv->tx_pwr_data_read_from_eeprom) {
-		dwArrayLen = MACPHY_Array_PGLength;
+		dwArrayLen = RTL8192E_MACPHY_ARR_PG_LEN;
 		pdwArray = Rtl819XMACPHY_Array_PG;
 
 	} else {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index e9ff224953f9..73a532b96777 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
 
 #define Rtl819XMACPHY_Array_PG			Rtl8192PciEMACPHY_Array_PG
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 174a4dfb1855..70c31d56ea14 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -19,8 +19,8 @@ extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
 extern u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_LEN 18
 extern u32 Rtl8192PciEMACPHY_Array[RTL8192E_MACPHY_ARR_LEN];
-#define MACPHY_Array_PGLengthPciE 30
-extern u32 Rtl8192PciEMACPHY_Array_PG[MACPHY_Array_PGLengthPciE];
+#define RTL8192E_MACPHY_ARR_PG_LEN 30
+extern u32 Rtl8192PciEMACPHY_Array_PG[RTL8192E_MACPHY_ARR_PG_LEN];
 #define RTL8192E_AGCTAB_ARR_LEN 384
 extern u32 Rtl8192PciEAGCTAB_Array[RTL8192E_AGCTAB_ARR_LEN];
 
-- 
2.39.2

