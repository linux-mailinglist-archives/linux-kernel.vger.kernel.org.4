Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8156C8CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjCYIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjCYIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:35:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD818174
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r29so3848765wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733331; x=1682325331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtF6AKurBTM+JKZ/Gr3b6r0bPCKeZarTQibx8Hu6cr8=;
        b=mCmYVGja+bfDuj6JPK5LDBpQhwzHI9yyNlpIWbzdx1oBXQg/fiEIGfHvT0OGkz4l56
         dkXamSHJsNBNw5m5TtptIlc9HOkGGRC2B5C4oMa6b0uWqh3OwecuZWaRGTP28uEYW+xU
         urwGHPOvYAsQCOCbcfdVWfJa6yVDSovUQkrpo2iWx7YbLbSjowoNRDAs2EkdxrIaHF/I
         Q3rnZ0DBwRn9XX7hMslY9ADSlAnQPG82RCMTLTsO1FAa/6g6kz1sfNW5XUaena9k3OIZ
         SH7FO6kn6kb4fsaF9PDKsKG64FkHbx0sk/bXghrAycXYrRWANKzY4J4rBos3avPmPXef
         nCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733331; x=1682325331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtF6AKurBTM+JKZ/Gr3b6r0bPCKeZarTQibx8Hu6cr8=;
        b=b5eH+1V8c0KBa0v1TODz8I2vxCWP58KLM8y5XzKnmOTHMACdYfwgqUgIctN816WK4T
         qiLq+a8rN+bkX5k+bw/Jn27IU6XY9B69Uwr2Bds1N63kS+4yitcfRON0sHKxmrRzukJR
         BvTOCoin/0WC9NyWQ/4r7fekkEB6IjKRJ2jfsAP2i7GxvFgeVOK+3uKbuhiR/PEOqDEh
         xQcfrjIlpttT4IgpGeUzaIv0uJhhaeaMzMIKBWRZW92i7jOgAL5mycKGODv3ZILljfr7
         WF75pZM6GWAr7UIdIGbplDLF9RqQhAtZNGqak/j0ReycgAYrEKl/r+zs2EcCjguBjn0U
         pBRQ==
X-Gm-Message-State: AAQBX9dUREktiUBVYIKzVaPSsxzupiTP+QlHGpMTkgRdEX/s1gjRI8GC
        f8JFV3wxm419a+r4v2oOXdQEjZmTmT0=
X-Google-Smtp-Source: AKy350YNMWw2Nh59duWNphLeS/1CwE8/oS1wR8DKdFfu6iw2lDY3Go2dKL1CQLYhfmo0+AwrVJw3yQ==
X-Received: by 2002:a5d:4d88:0:b0:2c7:1c72:69ac with SMTP id b8-20020a5d4d88000000b002c71c7269acmr3220509wru.2.1679733330992;
        Sat, 25 Mar 2023 01:35:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm20102657wrz.34.2023.03.25.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:35:30 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:35:28 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_phy_rf_write
Message-ID: <77628b7ecade212401d7da5e3c0b79f8ef55b5c1.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
conditions in function _rtl92e_phy_rf_write as those are dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index c4fd412cf3d6..acd1e1869d78 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -129,24 +129,22 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 	struct bb_reg_definition *pPhyReg = &priv->phy_reg_def[eRFPath];
 
 	Offset &= 0x3f;
-	if (priv->rf_chip == RF_8256) {
-		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
 
-		if (Offset >= 31) {
-			priv->rf_reg_0value[eRFPath] |= 0x140;
-			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
-					  bMaskDWord,
-					  (priv->rf_reg_0value[eRFPath] << 16));
-			NewOffset = Offset - 30;
-		} else if (Offset >= 16) {
-			priv->rf_reg_0value[eRFPath] |= 0x100;
-			priv->rf_reg_0value[eRFPath] &= (~0x40);
-			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
-					  bMaskDWord,
-					  (priv->rf_reg_0value[eRFPath] << 16));
-			NewOffset = Offset - 15;
-		} else
-			NewOffset = Offset;
+	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
+
+	if (Offset >= 31) {
+		priv->rf_reg_0value[eRFPath] |= 0x140;
+		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
+				  bMaskDWord,
+				  (priv->rf_reg_0value[eRFPath] << 16));
+		NewOffset = Offset - 30;
+	} else if (Offset >= 16) {
+		priv->rf_reg_0value[eRFPath] |= 0x100;
+		priv->rf_reg_0value[eRFPath] &= (~0x40);
+		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
+				  bMaskDWord,
+				  (priv->rf_reg_0value[eRFPath] << 16));
+		NewOffset = Offset - 15;
 	} else {
 		NewOffset = Offset;
 	}
@@ -158,15 +156,13 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 	if (Offset == 0x0)
 		priv->rf_reg_0value[eRFPath] = Data;
 
-	if (priv->rf_chip == RF_8256) {
-		if (Offset != 0) {
-			priv->rf_reg_0value[eRFPath] &= 0xebf;
-			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
-					  bMaskDWord,
-					  (priv->rf_reg_0value[eRFPath] << 16));
-		}
-		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
+	if (Offset != 0) {
+		priv->rf_reg_0value[eRFPath] &= 0xebf;
+		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
+				  bMaskDWord,
+				  (priv->rf_reg_0value[eRFPath] << 16));
 	}
+	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
 }
 
 void rtl92e_set_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
-- 
2.39.2

