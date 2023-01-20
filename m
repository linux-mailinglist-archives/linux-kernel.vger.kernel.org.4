Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9216675ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjATUR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjATUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:17:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B644707D2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:17:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so5819501wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOF6sBpuGhuHA/s9uQZVEpVdnpfpby63eHc5MQV10o=;
        b=bKw+hyonZwvdOtEcuIAl+Q81FXgLbybNyU7fzkiwmtX4n/ww57YCHua3t++ImQ7tGs
         tJacpa/4rVctETWyNisGfsSVKCt5KklVHrTAVfTsh+pzrF2UhWE40esDBo5HPX+Npu3b
         bI7eq2t76QwuhYqqUkfWYBDfxN/K1CgLZXAiuroZwmNSWyiiOm8QYYAj7bJgtS3ll3ua
         biJaEKlxmu6DRKjBtOzHDyfnoyGxo9DSxuBGRYzHbmVIzQubrvt0tQdYgR5f/DtuNLH1
         03XrUDOtz1DKoBa6xaagJkFJ9guI0SRB/X1GjZTNDXcezSfHkDD8EizNcu0E215uBG9u
         N4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EOF6sBpuGhuHA/s9uQZVEpVdnpfpby63eHc5MQV10o=;
        b=T0Xg603hr/saU3hoDy/cZ7pNjeWZ6b90elli4XlpDkTlMYYaG04/Ju/9B3xPx7sSTu
         0xGT5EwSpWsfz8HlEXryJiy1zlBmGywW+vRFoBOUAaFPAYulkzAqMRW39SHaKnhvGVny
         mOhvRzzmvupkLRx0unAit3JS/EQCKjJERh3HMVAm5shmOVgNqGWVHFoSsELrUDqb2OMJ
         d2ezHYbK3Z+i3Bz36Hnv4oK4njFcrtCicNhBNiYIsJtZnOx3m1PPMdhvOlkOr0p5CzT4
         KPmR4qxmJe75WXaO+Psona3zfb6Q0PJcyn8KRdfyk3Fq/K2xnEIarQtOEBUx5Grn+4+c
         5PoA==
X-Gm-Message-State: AFqh2koP1bHIJRk1zKm9VCcLRtczQJT7x3xpAwo3gqhXcJmbEleC7XvG
        JGuas9NobshGgzWzt0jpyZQaAyQGIhU=
X-Google-Smtp-Source: AMrXdXvmy02qc7sy3ncZEnMW7LArNaX1QryMNXdNAOvnsMjlzXtQkMR/27pkNQpFHpad78FayBBN3A==
X-Received: by 2002:a05:6000:1088:b0:2be:5295:bd9e with SMTP id y8-20020a056000108800b002be5295bd9emr797718wrw.7.1674245872660;
        Fri, 20 Jan 2023 12:17:52 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm37249409wrj.94.2023.01.20.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:17:52 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:17:50 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: Combine three loops to one to init
 tx_pwr_level_...
Message-ID: <c268ccf158997c65756b7b092ae79cc2b69bd47f.1674244819.git.philipp.g.hortmann@gmail.com>
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
zero and never changed. The three loops contain the same code. Only the
index of the upper named arrays go from 0 to 2. Therefore the three loops
can be combined to one loop from 0 to 13 which removes useless code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 227c13d552fc..7187ee4c75f6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -426,7 +426,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 						     0xf0) >> 4;
 		} else if (priv->epromtype == EEPROM_93C56) {
 
-			for (i = 0; i < 3; i++) {
+			for (i = 0; i < 14; i++) {
 				priv->tx_pwr_level_cck_a[i] =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[0];
 				priv->tx_pwr_level_ofdm_24g_a[i] =
@@ -436,26 +436,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				priv->tx_pwr_level_ofdm_24g_c[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[0];
 			}
-			for (i = 3; i < 9; i++) {
-				priv->tx_pwr_level_cck_a[i]  =
-					 priv->EEPROMRfACCKChnl1TxPwLevel[1];
-				priv->tx_pwr_level_ofdm_24g_a[i] =
-					 priv->EEPROMRfAOfdmChnlTxPwLevel[1];
-				priv->tx_pwr_level_cck_c[i] =
-					 priv->EEPROMRfCCCKChnl1TxPwLevel[1];
-				priv->tx_pwr_level_ofdm_24g_c[i] =
-					 priv->EEPROMRfCOfdmChnlTxPwLevel[1];
-			}
-			for (i = 9; i < 14; i++) {
-				priv->tx_pwr_level_cck_a[i]  =
-					 priv->EEPROMRfACCKChnl1TxPwLevel[2];
-				priv->tx_pwr_level_ofdm_24g_a[i] =
-					 priv->EEPROMRfAOfdmChnlTxPwLevel[2];
-				priv->tx_pwr_level_cck_c[i] =
-					 priv->EEPROMRfCCCKChnl1TxPwLevel[2];
-				priv->tx_pwr_level_ofdm_24g_c[i] =
-					 priv->EEPROMRfCOfdmChnlTxPwLevel[2];
-			}
 			priv->legacy_ht_tx_pwr_diff =
 				 priv->eeprom_legacy_ht_tx_pwr_diff;
 			priv->antenna_tx_pwr_diff[0] = 0;
-- 
2.39.0

