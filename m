Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078246B6134
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCKVvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCKVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:51:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308948E14
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so34437618edy.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571433; x=1681163433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+E3iul2trnE9AHj4wvDXfrCtnPg8Q0ZfdG1IJq4SqQ=;
        b=bfo3xiabuGMhrdlbZSwKqkqKgZeoPtJbPH8r0n5evQhlf6UQCHyYmSg5HJzTf2wakS
         RxcxFen0zRgAFwTOKukKHuuM9W1kJyr55k7ZNV2oQS1kPXNh3IxTPf4TXq5D0Tn0q2oP
         s1D90qrKQbEIfnChlQjHhBskzv9QZAbvnQ0gq/beiKrqa2OtO/qKSaLK2OlIcH4/9Mba
         6dcLQYV8kJ/h5z8E2+YuzrktD0WYdnaWZeU8g54BzEkpa1b7pZDs2O+W5NIrHuSLZeqT
         Rw4iyZPRRXyzBmrSZR7XOAYdaLT1VVgF9je/JMiU3xn/uyWSiiGnlwTtA+mOVZEpr8NQ
         uFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571433; x=1681163433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+E3iul2trnE9AHj4wvDXfrCtnPg8Q0ZfdG1IJq4SqQ=;
        b=lm1nw2gcU2T39NwegusLjQ7EH7NJLsL2Bq/4L+6FmkkxgyZLfI82b3wqJPsseYsNXt
         Hw6l7oSH1Qq08hMB53pFthBkQPJ90smsJFa+My/0tEsX8Kl+OmTLxNe7jS5WQknhGy5p
         I22tDDQ7eTEukMK222dEgFPrW2HfHgrN/uOSS5EIsy0u0gFcKwy+yPfWfLBTH0AAXutm
         7/MxXFG10phyXq/a4d2nLnfNyEll8mHP1VVECQlzgAtvSLuINTfv9x32Lmva/nyeRFja
         0cCxiIf35v3hdVQ2VZBmXxST86kCb0eiL5+qpcxk21jnjJUgJuHUcAr6q3z1pPjfs4jy
         t+rw==
X-Gm-Message-State: AO0yUKX7EyWes7A8zrVWjCntEO7Q7RzqxoEV3EKS6GbihLXiS1MaRzKG
        zCOq7DnL4/IH0SSVVWRS3wYzQpJNmfs=
X-Google-Smtp-Source: AK7set9ULwvvVP36i3vUVdIsFBYyLxTyoUX9Rh6hmVJR2cJoH0xep56z0OmOtChAnVPbiGdY+oQlxg==
X-Received: by 2002:a17:906:208a:b0:8ae:cd8e:3957 with SMTP id 10-20020a170906208a00b008aecd8e3957mr10222277ejq.4.1678571433637;
        Sat, 11 Mar 2023 13:50:33 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id xc14-20020a170907074e00b008b904cb2bcdsm1543297ejb.11.2023.03.11.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:50:33 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:50:31 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 in rtl92e_config_rf
Message-ID: <3a62c8803712e7bf905886e670fe334a13d5d753.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused case RF90_PATH_C and case RF90_PATH_D. The termination
condition for the loop is set to
priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. Because of this
eRFPath cannot reach the values 2 for RF90_PATH_C and 3 for RF90_PATH_D.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 73a86e1d0701..ecbcf0d5bb68 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -74,12 +74,10 @@ bool rtl92e_config_rf(struct net_device *dev)
 
 		switch (eRFPath) {
 		case RF90_PATH_A:
-		case RF90_PATH_C:
 			u4RegValue = rtl92e_get_bb_reg(dev, pPhyReg->rfintfs,
 						       bRFSI_RFENV);
 			break;
 		case RF90_PATH_B:
-		case RF90_PATH_D:
 			u4RegValue = rtl92e_get_bb_reg(dev, pPhyReg->rfintfs,
 						       bRFSI_RFENV<<16);
 			break;
@@ -120,12 +118,10 @@ bool rtl92e_config_rf(struct net_device *dev)
 
 		switch (eRFPath) {
 		case RF90_PATH_A:
-		case RF90_PATH_C:
 			rtl92e_set_bb_reg(dev, pPhyReg->rfintfs, bRFSI_RFENV,
 					  u4RegValue);
 			break;
 		case RF90_PATH_B:
-		case RF90_PATH_D:
 			rtl92e_set_bb_reg(dev, pPhyReg->rfintfs,
 					  bRFSI_RFENV<<16, u4RegValue);
 			break;
-- 
2.39.2

