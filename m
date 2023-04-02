Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4C6D36C1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDBJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDBJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED641C1C6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:52:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-930bc91df7bso77011266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429128; x=1683021128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S93CG6AlbKMkphzwNXa0JGigafN4J3sDtR60tP0Iyzc=;
        b=BJQE7ANH3TiEiq8wKmFaXIUoNuo92b0CHpEetEDbHu2ZgYuYW3JUfJFQWAyMX67xYU
         ZG5xX1JAvgY/jHoOJBWLBILwWJPzk1tNKupr6RAWHKNhkBBgi/eIKMJ+u1YziMPBuM3j
         lxxYXs1r87oV4F5ZW/bDRasox9c+51LTKZvV01MayxVPfVSxr4uB4VJOkWsRoqGKKCJH
         nm3Gq3QIft/el+6tgE43X/AaANGHNXflTSgaKcMFElA7kxNBSGMZ3EAQNn/ryZ8SBx91
         RMBVuziShC/rLOLjrHm/XJ47eAj4EczrYsqxrbZG1Y+SdYNS9TDMtIlI8xhbF+5m+jq1
         zPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429128; x=1683021128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S93CG6AlbKMkphzwNXa0JGigafN4J3sDtR60tP0Iyzc=;
        b=FVFHWQHWCza/cCVnSJ8Y7iXGxM7duE7HsSqlmsPSz4860iAXrTjUrQUI+prho0oqmA
         Pmt5mzyjCCKeE6NWWUH6u6cV5OAPPzEdiIrCm74rVa+H5LpRDHtrXJPRR66ftDPvx5X6
         WtUAHEiFtPDR4ey4/ciYJhDTNAbxnXXqyuFO3qYi5fldAKSyQI+gXMGOCPlp/k1pUVtN
         v7Cu3nfyMzLKn2KA1rN7FF9cMWrSd1AOnDBr14vXN5+Zcw/8fvSIzy0YeQw57+6eRF7q
         qmPocPNNk/By9BtIO0vrBnZqZN+58E72fGBJzW5cRO3lBk2A2ddt7RRBT5v5Y057GTVe
         GwrQ==
X-Gm-Message-State: AAQBX9fK93VC86/xKTLO77DGgZxNIdwl5jdYTF/K9FLP/XCb7Nf1RNGf
        iX6U5Bs6AcYcmLkOvRnVqto=
X-Google-Smtp-Source: AKy350ZFqFI5fGPRi2gn6daBAO5qPda3KZp8VbbEqiSGZyXV/sirXSpl6Fr/emOX0oYoBNTCdvfrfQ==
X-Received: by 2002:a17:906:224e:b0:92c:fc0:b229 with SMTP id 14-20020a170906224e00b0092c0fc0b229mr10688924ejr.0.1680429127797;
        Sun, 02 Apr 2023 02:52:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906101400b00947732c6521sm3061047ejm.79.2023.04.02.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:52:07 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:52:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] staging: rtl8192e: Remove case customer_id =
 RT_CID_819x_CAMEO, ..
Message-ID: <b546933897acc20a6ac5be2bd5ef5ad979599c66.1680427945.git.philipp.g.hortmann@gmail.com>
References: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

customer_id is initialize to zero. Changing customer_id to
RT_CID_819x_CAMEO, RT_CID_819x_RUNTOP, RT_CID_Nettronix or RT_CID_PRONET
would not change the program execution as there is no equation for
RT_CID_819x_CAMEO, RT_CID_819x_RUNTOP, RT_CID_Nettronix or RT_CID_PRONET.
Remove useless code lines to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: No changes
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 12 ------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  |  4 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  4 ----
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index cbe66b4a6ad9..df8de35cbe0e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -435,12 +435,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	case EEPROM_CID_DEFAULT:
 		priv->customer_id = RT_CID_DEFAULT;
 		break;
-	case EEPROM_CID_CAMEO:
-		priv->customer_id = RT_CID_819x_CAMEO;
-		break;
-	case  EEPROM_CID_RUNTOP:
-		priv->customer_id = RT_CID_819x_RUNTOP;
-		break;
 	case EEPROM_CID_NetCore:
 		priv->customer_id = RT_CID_819X_NETCORE;
 		break;
@@ -451,12 +445,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		else
 			priv->chnl_plan = 0x0;
 		break;
-	case EEPROM_CID_Nettronix:
-		priv->customer_id = RT_CID_Nettronix;
-		break;
-	case EEPROM_CID_Pronet:
-		priv->customer_id = RT_CID_PRONET;
-		break;
 
 	case EEPROM_CID_WHQL:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 706d024bcfd1..4ee78b7a558e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -31,12 +31,8 @@ enum baseband_config {
 #define EEPROM_TxPwIndex_OFDM_24G	0x3A
 
 #define EEPROM_CID_DEFAULT			0x0
-#define EEPROM_CID_CAMEO				0x1
-#define EEPROM_CID_RUNTOP				0x2
 #define EEPROM_CID_TOSHIBA				0x4
 #define EEPROM_CID_NetCore				0x5
-#define EEPROM_CID_Nettronix			0x6
-#define EEPROM_CID_Pronet				0x7
 #define EEPROM_CID_WHQL					0xFE
 enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 91d634f5d3e7..2b2d8af4cf6e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -129,12 +129,8 @@ enum dcmg_txcmd_op {
 
 enum rt_customer_id {
 	RT_CID_DEFAULT	  = 0,
-	RT_CID_819x_CAMEO       = 6,
-	RT_CID_819x_RUNTOP      = 7,
 	RT_CID_TOSHIBA	  = 9,
 	RT_CID_819X_NETCORE     = 10,
-	RT_CID_Nettronix	= 11,
-	RT_CID_PRONET	   = 13,
 };
 
 enum reset_type {
-- 
2.40.0

