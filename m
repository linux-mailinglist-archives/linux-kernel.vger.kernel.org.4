Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8968E6C8CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCYIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjCYIgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:36:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BE18AB6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ew6so16478161edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dc8fh90KbqBXiSamQ6fXKYW6QBeBG1tBvztL+KlOiwQ=;
        b=opPGtoK1ZjhdTj4xeZNlU8az/JqYZ0c0T3Kqnlu5mzLAB6A+8TgqpzNBRFdFy+OX2J
         Xv7eWBWQWIzQggVobHI4TeDcsfuu8/9EZ5TzIgXhOSOCgjN7ZUvxi1YuFYrxCdhn+kKt
         oxeAzyytXgEcSOTaGkW1aZ/qLe4VM32x/EilKO+YQgCDYtsllsNMNPXe8fGd78HrMAQ7
         IO7ztMd8Y0rvH73VavPpqKGQJBOzB3SPywZ69bZF/T5kiuMdQcyX2z1xsfT2pQgour9B
         lKPJ3HwK2gCCvSxT1lPB7yKL/xOuPo+xqZelWRX8PTc7BzpE8Lg9csstHmOqA0ujLtUH
         /99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc8fh90KbqBXiSamQ6fXKYW6QBeBG1tBvztL+KlOiwQ=;
        b=5l/k+SdoFaVEP8Nrk1EuJAPfoGjroAQdWqf6/0I8ZES57X2DkDJhrCtTjGlrbzR6kb
         FFFF8K/4ZkHgq+ZlVEe6WP1j6qhb/GX4+m4Cu30tzXJQLm/0TuEj8Hc9EDzgX+Eyj4dY
         X88wPtyUTxxr0gMjbnHKQLSO6hh6sTqHZojHUiDhMOBULdwnSPYFyCYN9/LZJQw88XfG
         Fz9vvAcRxq1SheuQrRlkm0A+vSW1Zg3J05xNs0tf1D/h1ds0LyRdhxJZ70hJteelixnX
         y6gFDH7+P2ku8yl3076lsAyt8KNzV5majm/VoKQPU+0MQFU1bT4tnCizPMKipSoiFPS2
         aMvw==
X-Gm-Message-State: AAQBX9ex/8hJemjAOxvcGxFsFUGY3BE1JH/tQXWYOOT0FLrndZ8ICb6r
        4EGjURJFCLGVSdTFV5BWwQM=
X-Google-Smtp-Source: AKy350ajQinP2StLkUzxxcWkRp63A4pTcKP30b42gk70VTq4fpKond+pi4yMMaWY5nABKE/Uwr7S1Q==
X-Received: by 2002:a17:906:74ca:b0:8b1:2614:dea6 with SMTP id z10-20020a17090674ca00b008b12614dea6mr5107443ejl.1.1679733362676;
        Sat, 25 Mar 2023 01:36:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b0092fc6971000sm11387480ejb.40.2023.03.25.01.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:02 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:00 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove priv->rf_chip in
 rtl92e_config_phy
Message-ID: <c0d4e98308c9198776d8d04d1c2910f089f45a90.1679732276.git.philipp.g.hortmann@gmail.com>
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
condition in function rtl92e_config_phy as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 6579c7b81bfd..e35085253e70 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -491,25 +491,10 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 
 bool rtl92e_config_phy(struct net_device *dev)
 {
-	struct r8192_priv *priv = rtllib_priv(dev);
 	bool rtStatus = true;
 
-	switch (priv->rf_chip) {
-	case RF_8225:
-		break;
-	case RF_8256:
-		rtStatus = rtl92e_config_rf(dev);
-		break;
-
-	case RF_8258:
-		break;
-	case RF_PSEUDO_11N:
-		break;
+	rtStatus = rtl92e_config_rf(dev);
 
-	default:
-		netdev_err(dev, "Invalid RF Chip ID.\n");
-		break;
-	}
 	return rtStatus;
 }
 
-- 
2.39.2

