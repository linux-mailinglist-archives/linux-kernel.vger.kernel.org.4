Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526906B6137
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCKVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCKVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:51:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304172821C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so34343903edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571473; x=1681163473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6eYhhrlk3QpT3Cy5PgSpe5WK/nBGJNkoN3eiwTzKHM=;
        b=YmBNqxtAmKGEE3Iiif77W37hUZVglXlHDs5uRhhFokF6a5Fv1yXiePXuf63OzZAqUn
         dB/OO3UQF3DcYJoH9s1FIGrAmLgCaVD/rOTV8nZo15I0pLgQxtGXo9AKobLW9g20KVLP
         zcNhH1qhMWBk7dTdX9u+bSnk/+J3oM5zEB43m37g7QAbyXXWkKyncS7myOtJKQ8F683v
         CW1pWIdPlC5iTzFPxsJUo6YQCPaicONJxYJ7hFRKck1RSm7ISuJDrwN8aUtsw8s8Gdh9
         X4m1zmPtTfKHlEWFJ8c9wHZOtIRSQkhdxMGjLfLVnkJUxzvBNTGj606Q+loccB7sR5u4
         a4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571473; x=1681163473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6eYhhrlk3QpT3Cy5PgSpe5WK/nBGJNkoN3eiwTzKHM=;
        b=sDfMGJvyI0rsoxqKJmHqZBWkWaJ/Q4Xhtp3Lz3dBhiSnn4mBUA4YB8lZbrj8n5OVsb
         fXTzd6KH2LpxCcSw37rAWmUFPnh8SBslZYSyraDCgFa8qWe9oWtWW7OwAO9mDiQc6aJ+
         acbBKu83hYJlB9HbPys6+zPUnCQ669FerhIN0RoC3uFug66UeJaYTg+L4yR4xcK90Kqj
         0eDJIFqNkRLwtkZY1iPZOPdm0cIrxY8mHqQKwF8qHrkXJXM1KmzZDZxvpkg9u9KqFozm
         2YQ0EDNCyodSAjIFa6FZ9cMsUxDFjdF4LRyZOU0tykphXTzSWH6Llk9raWYjtS27N0bv
         Iebg==
X-Gm-Message-State: AO0yUKVP0U6BNmDU8SAxmG/oH+O3bc1z+gPHhNlaqwYLt+rFZAgys8m7
        0dppzzE9ABf/PAd+AL4As/c=
X-Google-Smtp-Source: AK7set8CUc6ZVyzcT29H+6rTnMe9iPW7jMymRuvZHdtUs/1Ax3OLDsqsoS4HDzmVlaoUiSeaFxaUMA==
X-Received: by 2002:a17:906:74cd:b0:88f:1255:59c with SMTP id z13-20020a17090674cd00b0088f1255059cmr9241551ejl.1.1678571473218;
        Sat, 11 Mar 2023 13:51:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906869a00b008b23b22b062sm1507539ejx.114.2023.03.11.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:51:12 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:51:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 for rfintfo and ..fe
Message-ID: <3c2237e2b4094129143594a5ab45691e9961e100.1678569965.git.philipp.g.hortmann@gmail.com>
References: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused priv->phy_reg_def[RF90_PATH_C].rfintfo and
priv->phy_reg_def[RF90_PATH_D].rfintfo and
remove unused priv->phy_reg_def[RF90_PATH_C].rfintfe and
priv->phy_reg_def[RF90_PATH_D].rfintfe.
The termination condition for the loop is set to
priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2.
Because of this pPhyReg = &priv->phy_reg_def[eRFPath]; pPhyReg cannot
point to array element 2 for RF90_PATH_C and 3 for RF90_PATH_D.
Remove unused constants as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 4 ----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 19fdf56e5e91..a0dd628b1bf5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -361,13 +361,9 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 
 	priv->phy_reg_def[RF90_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE;
 	priv->phy_reg_def[RF90_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE;
-	priv->phy_reg_def[RF90_PATH_C].rfintfo = rFPGA0_XC_RFInterfaceOE;
-	priv->phy_reg_def[RF90_PATH_D].rfintfo = rFPGA0_XD_RFInterfaceOE;
 
 	priv->phy_reg_def[RF90_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE;
 	priv->phy_reg_def[RF90_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE;
-	priv->phy_reg_def[RF90_PATH_C].rfintfe = rFPGA0_XC_RFInterfaceOE;
-	priv->phy_reg_def[RF90_PATH_D].rfintfe = rFPGA0_XD_RFInterfaceOE;
 
 	priv->phy_reg_def[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
 	priv->phy_reg_def[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 5a47b232945f..ec39de9e89fe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -66,8 +66,6 @@
 #define rFPGA0_XCD_SwitchControl	0x85c
 #define rFPGA0_XA_RFInterfaceOE		0x860
 #define rFPGA0_XB_RFInterfaceOE		0x864
-#define rFPGA0_XC_RFInterfaceOE		0x868
-#define rFPGA0_XD_RFInterfaceOE		0x86c
 #define rFPGA0_XAB_RFInterfaceSW	0x870
 #define rFPGA0_XAB_RFParameter		0x878
 #define rFPGA0_XCD_RFParameter		0x87c
-- 
2.39.2

