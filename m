Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC36C8CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCYIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCYIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:36:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61319129
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so16446579edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvJuEJW/3WhkhbvLRnBCygzL8nJBB9Z+yoFexvWQ38s=;
        b=NUHUh1h9jI9sYJQDQzGOMmUQ8tRNwVGhP62zpq/wjfZjDja1DbUBHLk2e8shuEgvLn
         p+8lthD6QAxQDMacV9Hjf2Py8faYqHUIHxwABXmW6AaS9ewYW8zEN69hRtPy1Gm39uAq
         gUIxj8EeFZAa4M8O/wrDGzChQWsJW4pAYRqb5wGUY+fexZB8JgkkGBb1Lgq07QOvb2Fx
         K1d15Epka6+dFgXJtHL4kiElh14o5/pckyiFZaLoYemeHXWy0Lb8+/3LHbZFd+sn+oSn
         jdD3Oc27/pSt5Qhwir1ZtltwOnebx2212OUYlXHpHiuFMVaHbUr3fbu/MQwG2UUyMx7n
         azsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvJuEJW/3WhkhbvLRnBCygzL8nJBB9Z+yoFexvWQ38s=;
        b=uk3e2tKftke8DF3axtJhEtfIRwJ/5wsEH3sHuc6sV7T6GSnrxS07c/+nfidhJwzGpK
         Byb81eqD/fujq0wgS/dbl2PQ/vOQO71WpKAGn+P5d8deffUMvBYS40si5YIUmF1fEuND
         PArH/Li99oYEljxalI8YViZysDQzOPCa4FsOzw5hzAAexsRyhAGfK3cTyBxZObvEAiYL
         pIBOpDNu2C4H9ffq2FemUgCzx3F4LTITWwNs212s68nYKTE1hwZO3js9/OGgEjFQq8RV
         VpIaU9HsTFXGyFERmdPTLXZoNNHC1UBGBQISGS6nauTOcmSET5A2TNy+fgIgGjkfJW8j
         Wm6g==
X-Gm-Message-State: AAQBX9eaAlrEYJFoxvk2AWfUckEqvKGlQLd8UMxO1/W1LkgG0gs09VAC
        RqOp/HlOS43fnOTjpYIVAjo=
X-Google-Smtp-Source: AKy350b5a50DD5w6VTuZ8EksPCAQgGq7O6wFt6S1WV+bZJXmUuGi0Mtf/bTnYUTfuEME4stV4lfMIw==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a0 with SMTP id w14-20020a056402268e00b005020ffd74a0mr6647571edd.2.1679733396979;
        Sat, 25 Mar 2023 01:36:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r3-20020a50aac3000000b004fccef39ec9sm11983991edc.70.2023.03.25.01.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:36 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:34 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_set_bw_mode_work_item
Message-ID: <a872bb67f71b9992740d5f9b154f794604a2dbb0.1679732276.git.philipp.g.hortmann@gmail.com>
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
conditions in function _rtl92e_set_bw_mode_work_item as those are dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 24 +------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 73e426e052b0..1f0d3654c6a0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -849,10 +849,6 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 regBwOpMode;
 
-	if (priv->rf_chip == RF_PSEUDO_11N) {
-		priv->set_bw_mode_in_progress = false;
-		return;
-	}
 	if (!priv->up) {
 		netdev_err(dev, "%s(): Driver is not initialized\n", __func__);
 		return;
@@ -918,25 +914,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 
 	}
 
-	switch (priv->rf_chip) {
-	case RF_8225:
-		break;
-
-	case RF_8256:
-		rtl92e_set_bandwidth(dev, priv->current_chnl_bw);
-		break;
-
-	case RF_8258:
-		break;
-
-	case RF_PSEUDO_11N:
-		break;
-
-	default:
-		netdev_info(dev, "%s(): Unknown RFChipID: %d\n", __func__,
-			    priv->rf_chip);
-		break;
-	}
+	rtl92e_set_bandwidth(dev, priv->current_chnl_bw);
 
 	atomic_dec(&(priv->rtllib->atm_swbw));
 	priv->set_bw_mode_in_progress = false;
-- 
2.39.2

