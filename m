Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD6675EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjATUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjATUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:18:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159C79EB5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so1330452wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5PEEpYbd9JR0sOvYfHmr/vW+Rpo6V/62Q72U9s8gzY=;
        b=DbUQV68qiUmqYwTvudP7uOeZobN81AfWmNWt0Nh3auBFSBNVx+O3ch4S55njTe4jBn
         X44UQKRcWOggjFtlTVeAxFqaRafmwdKlcU1PBvd8v3zF6wubTdyz/QgnC+zZcclCoi5F
         3UOBcTONrozvF6Uy4xJ4WKuBTCReitgoOaJSPO+FVp/xJnEZilXZIGw6HiIC6qcvjD3v
         I8W8FuLxeuY/h6iNKFoSqlb9OqJSe44VMU0PfNTzp6W6bWXVtRGZ0UcQNbnEYQGZ3Ly2
         11BgQDZT71InEewOUFTD56aLyLEACYqSifYr3BW+Dq52B9aPkFZxdWRenY0ULlOVAZk7
         GodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5PEEpYbd9JR0sOvYfHmr/vW+Rpo6V/62Q72U9s8gzY=;
        b=dMJkX9M/y4CC1fzy4Qo6k4oUBTnV3Ppu4zZYjisYg5yV9QmBK5FoMU/M1c3uKarNLd
         w8FTooGhiDZUkdtydPiBX5Nd1guDhS89DbWqgmsQc7OJG4HDiMNQOpugcp7a69PJ4dLu
         opCxwyqWjkPC59IeKUOGVV+5F7EGcRAFwP9Rzk2FRrcmVjdgtl//ggX6uDlWbmmPCSkw
         rIycQU80hW797DOc0XpU3EAtcjLMacPCH6UtrWEmGpVB6mEIjNxirmgNNfXx/ywlTQqD
         yVEPz5nyCP8DzZy1o86Wh2Vk7j2XTgdYXUhEg0ZKOo9/dSlw9Y5BRTM0eLHC7LHSrirj
         gPow==
X-Gm-Message-State: AFqh2kqJK/EwXThlnU9o5JWwuoOqeJaE8qN/oHrjkXzb9NqQShYYTgyL
        /3DouE74U5V4yv857oyfLlg=
X-Google-Smtp-Source: AMrXdXuNKBtCSjWeKMf84yR1Y+Ktlm218N/xzFttX8ZwRtQc6uvcg3ZxwI4TuuOPDdBCdIO/LTHXvA==
X-Received: by 2002:adf:f992:0:b0:2bb:62bf:f5cb with SMTP id f18-20020adff992000000b002bb62bff5cbmr2670640wrr.4.1674245909015;
        Fri, 20 Jan 2023 12:18:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000024500b00267bcb1bbe5sm37671154wrz.56.2023.01.20.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:18:28 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:18:26 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8192e: Remove u4RegValue which is always zero
Message-ID: <2aa104c0f7a5cede7eea289fe92390295592b0e9.1674244819.git.philipp.g.hortmann@gmail.com>
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

As the array antenna_tx_pwr_diff is always zero, u4RegValue is always set
to zero. Replace u4RegValue to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index c969c40c3979..d56c58ecc19f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -586,7 +586,6 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8	powerlevel = 0, powerlevelOFDM24G = 0;
-	u32	u4RegValue;
 
 	if (priv->epromtype == EEPROM_93C46) {
 		powerlevel = priv->tx_pwr_level_cck[channel - 1];
@@ -603,13 +602,8 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 			priv->antenna_tx_pwr_diff[1] = 0;
 			priv->antenna_tx_pwr_diff[0] = 0;
 
-			u4RegValue = priv->antenna_tx_pwr_diff[2] << 8 |
-				      priv->antenna_tx_pwr_diff[1] << 4 |
-				      priv->antenna_tx_pwr_diff[0];
-
 			rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
-					  (bXBTxAGC|bXCTxAGC|bXDTxAGC),
-					  u4RegValue);
+					  (bXBTxAGC | bXCTxAGC | bXDTxAGC), 0);
 		}
 	}
 	switch (priv->rf_chip) {
-- 
2.39.0

