Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D305675ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjATUSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjATUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:18:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F307BF5DB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n7so5831066wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oBOra3KNxpaRSP68PMJL5xu9uXddKdpCIitMmZNYSE=;
        b=CBsQrGnuSh6+NaBDW1SBSpRTpQBE/F0Rg4GJEBjY/08vaqawQjnlallftotbxBbOmW
         SuGWfGDDBN4MuDvY/swBkwo6JVnuQJdq6sU42z/YOKEUo6D5yL1flMH1RiqjHbkRMmmj
         Tk00YIjAciXBY8xeHOwrhcl5eFK2kCbDhtKIl6W3doR8FIg9DPqgxrH/ASU/4jfh5zoN
         UMAPGo16Vvc6Z5RCf0t96koDz8mzrwRcWTndSvisbdbCAT80SWrPOfOE0xIS62JmFrkw
         1CecAwJR/rztp2/kJVAISF/0sJ7JWa8vng8NRq4moTaqOKbn7jGvE+e4meDFewIKyrWo
         mUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oBOra3KNxpaRSP68PMJL5xu9uXddKdpCIitMmZNYSE=;
        b=i1/sbTW9sLFIgeB9RJ0lLC7iBNpZ0J7N2NbzMAQn96Jzy2Xsqpa8U1vFEDiLGOMMMM
         XkNz+wMAABiYn1xuBiaMarBkdHQMkS6WpICMgyD6Mgdrm88Pbe5Np4yW9eC3yxtE+sjb
         KHyf2USi13KYN+W0JePsNHQOnTycb3AQsZqFuwN2jBdQmSgQHU+6G2llooOfD6l8MK3/
         1wQ0U1vaDNrGhOrFyjAdeoWcwZ/+i/6o9r2+pYHQxMH3q340Cy8j4MLAAH/R9tsE9Mx9
         dWXAB/xlqifIDeBDF+IMWlvw27Nm1pmq5RfwmeBHkoi3gRZHwWHoWXXSfbU0KN66ZtS8
         KbVQ==
X-Gm-Message-State: AFqh2kpkgZIWOiX+i2AUrmdaSIrhEKtJnatLYd1XCIk21EPgyh8UmI91
        WuEqT6Dhbch9JK8TJk3hhyI=
X-Google-Smtp-Source: AMrXdXsIFCTq6hEbWWf/o020nkiB199+vRtRtyvkfbZdA/Jadj3+6h4DAkjQMdLGFipxRXGPKq7fKQ==
X-Received: by 2002:a05:6000:98f:b0:2bd:c6ce:7bee with SMTP id by15-20020a056000098f00b002bdc6ce7beemr3017695wrb.5.1674245884844;
        Fri, 20 Jan 2023 12:18:04 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm34844003wru.63.2023.01.20.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:18:04 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:18:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192e: Init tx_pwr_level_cck_a and friends
 directly
Message-ID: <9874e99fb9a803be2a89e81e2ecd01ba80398ea1.1674244819.git.philipp.g.hortmann@gmail.com>
References: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays EEPROMRfACCKChnl1TxPwLevel, EEPROMRfAOfdmChnlTxPwLevel,
EEPROMRfCCCKChnl1TxPwLevel, EEPROMRfCOfdmChnlTxPwLevel are initialized to
zero and never changed. Delete the arrays and set the variables directly
to zero to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 12 ++++--------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  4 ----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 7187ee4c75f6..fdf37c56066c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -427,14 +427,10 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		} else if (priv->epromtype == EEPROM_93C56) {
 
 			for (i = 0; i < 14; i++) {
-				priv->tx_pwr_level_cck_a[i] =
-					 priv->EEPROMRfACCKChnl1TxPwLevel[0];
-				priv->tx_pwr_level_ofdm_24g_a[i] =
-					 priv->EEPROMRfAOfdmChnlTxPwLevel[0];
-				priv->tx_pwr_level_cck_c[i] =
-					 priv->EEPROMRfCCCKChnl1TxPwLevel[0];
-				priv->tx_pwr_level_ofdm_24g_c[i] =
-					 priv->EEPROMRfCOfdmChnlTxPwLevel[0];
+				priv->tx_pwr_level_cck_a[i] = 0;
+				priv->tx_pwr_level_ofdm_24g_a[i] = 0;
+				priv->tx_pwr_level_cck_c[i] = 0;
+				priv->tx_pwr_level_ofdm_24g_c[i] = 0;
 			}
 			priv->legacy_ht_tx_pwr_diff =
 				 priv->eeprom_legacy_ht_tx_pwr_diff;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 11f3f88491b2..596693fbee4c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -423,10 +423,6 @@ struct r8192_priv {
 
 	u8 eeprom_tx_pwr_level_cck[14];
 	u8 eeprom_tx_pwr_level_ofdm24g[14];
-	u8 EEPROMRfACCKChnl1TxPwLevel[3];
-	u8 EEPROMRfAOfdmChnlTxPwLevel[3];
-	u8 EEPROMRfCCCKChnl1TxPwLevel[3];
-	u8 EEPROMRfCOfdmChnlTxPwLevel[3];
 	u16 eeprom_ant_pwr_diff;
 	u8 eeprom_thermal_meter;
 	u8 eeprom_crystal_cap;
-- 
2.39.0

