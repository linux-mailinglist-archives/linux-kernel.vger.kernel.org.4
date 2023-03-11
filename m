Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33846B6139
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCKVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCKVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:51:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1C521EF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so34375877edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571486; x=1681163486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPkEkboXCEvGQOJLs4aF6ZhqJfv9Ne9y1/jeaB9rp0I=;
        b=FtDYtRmYudyXOa6xRqhPbHyRbYf0JybwghD58q/7JcyzUrHKjYrShq6EpUcS511R6r
         UMTkCiSqzisx95d30p2f8+qlwg4gor0JLj05gKTRCuiC4gHsP8V1z9ng29Pq2UCOhLRB
         ZxDdRS1nIqOydXAADA7zl9A7pL16vDUvTcUmQ+6NR0/C5iUN8fCcSvXKf3z64VRdPPsk
         Ss8nc/c2w+x3UavBPllw99x2gMiyrwjGImK8LzTdG62UBI/Z2qt/8EYntT9zSiDazOKq
         PU/EB3E+boklwoELUEI6U7eL85w3riKoBuROUySrwnLlHDAACr4GoRjNhFI+CCrtFONJ
         yfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571486; x=1681163486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPkEkboXCEvGQOJLs4aF6ZhqJfv9Ne9y1/jeaB9rp0I=;
        b=W7CrmPPfYhDKfNmasKHiknOSe2GSOc2Giy8riZiaZUZ7vlSwKfp0PlXC6YfMimFXmd
         QmYgQSWKkf5pOUkJkzuimVgm7L5vuihLZiPH4J9RiNpYK2PXUAxQoSAIyukYBTP95Sq4
         k47ZjQi/bUdeLg3lDj+/HgsiOyDYkAPqBn+BtNmCMQr99eW4+l+4hdh4FhgxQaAzEm6w
         1o4v9ifhBnC4iByGdpgKy3s3xuMPS3Ec/AG8DujwFB+KJLtnCE55NjM9zKl3ofW2dheU
         uLI2b7006OmnGGWGg0Vp8NWBM97YhapZ1CrSvqZ1fFy+NWowb/aOZq0lYSBTkWesNZKI
         RlzA==
X-Gm-Message-State: AO0yUKU29WIH0BTxhk/Woresec49YFlff1LMjL99+Txf6h1sLiM2eleD
        P4GPXNsSr515DNEZvLDf9so=
X-Google-Smtp-Source: AK7set+KSxeA2XX82oS+cOYzeFW2kH1OcfNVnVtYJZt3RpnK5l9bcAzeMbrps6pBQwVDXX7gD/DtOA==
X-Received: by 2002:a05:6402:280b:b0:4bc:edde:14e2 with SMTP id h11-20020a056402280b00b004bcedde14e2mr7419460ede.0.1678571485984;
        Sat, 11 Mar 2023 13:51:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id z13-20020a50cd0d000000b004acbda55f6bsm1640543edi.27.2023.03.11.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:51:25 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:51:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 for rf3wireOffset
Message-ID: <180723eee77f70ffda1f8f0656c2f256f005c4ef.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused priv->phy_reg_def[RF90_PATH_C].rf3wireOffset and
priv->phy_reg_def[RF90_PATH_D].rf3wireOffset.
rf3wireOffset is used in _rtl92e_phy_rf_read and _rtl92e_phy_rf_write
which are used in:
rtl92e_set_rf_reg and rtl92e_get_rf_reg are used in:
rtl92e_set_bandwidth (eRFPath only for 0 and 1)
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_phy_switch_channel_step (eRFPath only for 0 and 1)
_rtl92e_dm_check_tx_power_tracking_thermal (eRFPath only for 0)
rtl92e_check_bb_and_rf is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_bb_config_para_file (eRFPath only for 0)
rtl92e_config_rf_path is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
Remove dead code and constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index a0dd628b1bf5..1013ab95bc7b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -367,8 +367,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 
 	priv->phy_reg_def[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
 	priv->phy_reg_def[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
-	priv->phy_reg_def[RF90_PATH_C].rf3wireOffset = rFPGA0_XC_LSSIParameter;
-	priv->phy_reg_def[RF90_PATH_D].rf3wireOffset = rFPGA0_XD_LSSIParameter;
 
 	priv->phy_reg_def[RF90_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;
 	priv->phy_reg_def[RF90_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index ec39de9e89fe..19acc44648e1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -58,8 +58,6 @@
 #define rFPGA0_XD_HSSIParameter2	0x83c
 #define rFPGA0_XA_LSSIParameter		0x840
 #define rFPGA0_XB_LSSIParameter		0x844
-#define rFPGA0_XC_LSSIParameter		0x848
-#define rFPGA0_XD_LSSIParameter		0x84c
 #define rFPGA0_RFWakeUpParameter	0x850
 #define rFPGA0_RFSleepUpParameter	0x854
 #define rFPGA0_XAB_SwitchControl	0x858
-- 
2.39.2

