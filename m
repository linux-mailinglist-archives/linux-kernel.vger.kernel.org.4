Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6B73C70B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjFXGE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFXGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:04:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1D2973
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d889ab483so7656a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586665; x=1690178665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhgLWURJLJ0rJaEbeqsW7RwSsP/DgHDe24zdRNsd7Jc=;
        b=bOn/KYDUcZmKIj2wiWX99Rn27ZtNBWdf28r2p7VV1TFiPpVukTl6F3QBX47yPSodsr
         Ka0jdEuQjfOnYw9SRQY+LYXU/5cPukLfvHxlN6smtiwT6Ae/x2I3kBK9z4LOEkko/lVB
         f7IIaCAB7TAL7juyAT5mHWgfpSqNneSNfoxpZojeuB3NHYRZ3+lfAzRSgbYkZpSXHq8D
         5Mjl7x1b0pCCf2VGaZ9M3EGPBxI+i2tdZKrshXgfjoWP87c1HWz/7pzLgK06lgjjIPn4
         44WuyK61QRXQtxH/FyvOIf88Dwdfs34prCbLbL9NkZ7APDAInE0a6A4znJkEPEF9v1oM
         JtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586665; x=1690178665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhgLWURJLJ0rJaEbeqsW7RwSsP/DgHDe24zdRNsd7Jc=;
        b=WZObbh/oswQfqVc5eFBYoMtTVTUrxeF+lOayFRSqMgw/wKCZzQaEznQEBEqm7D1Ajr
         wjaIQqxKLAdWLm4uICZ+JTGT8Z8SbrMV3mKNTWgwwL/BfG1inq8jtTmyL+KQWBAFvGKm
         3zQCkwzSuKJ9Y3JjaXvDa2L3d/eFS6OwbcqvxkcTacjlsdvWFS3/KZYvgKEBHYTlHQ44
         8TK7UgaRhViTJOeNTNRq5yhIi8Qd8PfQIXiUCAI/VAagX5lm/lmMNA3QFRAeAU8KRvlI
         36fuluNEX6VA3srxWoBzmNk3BXXYgAyHOkmsdwDmIEPbbuEWnni/ngrUWb7PorcHRXUF
         F4Hg==
X-Gm-Message-State: AC+VfDymP+Q3rt5XM+Y2yrwitYhrBUmX3XHIWW1Jwn94bZYAmXxI54+v
        2fqASxrDtBg9lrDFBNplNUF6c33XPYU=
X-Google-Smtp-Source: ACHHUZ510/CzRsk49Czdt+PTrGn6hMc1uVFargnZAs1Tut18/r+7Xlt1Sv/huoJlQ1WbIDffkQe+2A==
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba06 with SMTP id p12-20020a17090664cc00b00987115dba06mr17239021ejn.4.1687586665381;
        Fri, 23 Jun 2023 23:04:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906241300b00988fea46663sm493356eja.129.2023.06.23.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:23 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove variable host_decrypt as it
 is constant
Message-ID: <637350e9bc3edded665009a30d12350157e8a9a9.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ieee->host_decrypt also named priv->rtllib->host_decrypt is initialized
to 1 and then unchanged. All evaluations will result accordingly. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  3 --
 drivers/staging/rtl8192e/rtllib_module.c     |  2 -
 drivers/staging/rtl8192e/rtllib_rx.c         | 44 ++++++++++----------
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 838b9c8b0df7..2f504a4838a8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -804,7 +804,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->active_scan = 1;
 	priv->rtllib->be_scan_inprogress = false;
-	priv->rtllib->host_decrypt = 1;
 
 	priv->rtllib->fts = DEFAULT_FRAG_THRESHOLD;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 80090f8a38e7..c7f800a0c48c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1440,9 +1440,6 @@ struct rtllib_device {
 				 * WEP key changes
 				 */
 
-	/* If the host performs {en,de}cryption, then set to 1 */
-	int host_decrypt;
-
 	int ieee802_1x; /* is IEEE 802.1X used */
 
 	/* WPA data */
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 2ad2e3671ec4..2416e0c60255 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -97,8 +97,6 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	ieee->scan_age = DEFAULT_MAX_SCAN_AGE;
 	ieee->open_wep = 1;
 
-	/* Default to enabling full open WEP with host based encrypt/decrypt */
-	ieee->host_decrypt = 1;
 	ieee->ieee802_1x = 1; /* Default to supporting 802.1x */
 
 	ieee->rtllib_ap_sec_type = rtllib_ap_sec_type;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 91dd3c373aef..195ce0fecd29 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1035,29 +1035,27 @@ static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16 fc = le16_to_cpu(hdr->frame_ctl);
 	int idx = 0;
 
-	if (ieee->host_decrypt) {
-		if (skb->len >= hdrlen + 3)
-			idx = skb->data[hdrlen + 3] >> 6;
+	if (skb->len >= hdrlen + 3)
+		idx = skb->data[hdrlen + 3] >> 6;
 
-		*crypt = ieee->crypt_info.crypt[idx];
-		/* allow NULL decrypt to indicate an station specific override
-		 * for default encryption
+	*crypt = ieee->crypt_info.crypt[idx];
+	/* allow NULL decrypt to indicate an station specific override
+	 * for default encryption
+	 */
+	if (*crypt && ((*crypt)->ops == NULL ||
+		      (*crypt)->ops->decrypt_mpdu == NULL))
+		*crypt = NULL;
+
+	if (!*crypt && (fc & RTLLIB_FCTL_WEP)) {
+		/* This seems to be triggered by some (multicast?)
+		 * frames from other than current BSS, so just drop the
+		 * frames silently instead of filling system log with
+		 * these reports.
 		 */
-		if (*crypt && ((*crypt)->ops == NULL ||
-			      (*crypt)->ops->decrypt_mpdu == NULL))
-			*crypt = NULL;
-
-		if (!*crypt && (fc & RTLLIB_FCTL_WEP)) {
-			/* This seems to be triggered by some (multicast?)
-			 * frames from other than current BSS, so just drop the
-			 * frames silently instead of filling system log with
-			 * these reports.
-			 */
-			netdev_dbg(ieee->dev,
-				   "Decryption failed (not set) (SA= %pM)\n",
-				   hdr->addr2);
-			return -1;
-		}
+		netdev_dbg(ieee->dev,
+			   "Decryption failed (not set) (SA= %pM)\n",
+			   hdr->addr2);
+		return -1;
 	}
 
 	return 0;
@@ -1083,7 +1081,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		ieee->need_sw_enc = 0;
 
 	keyidx = rtllib_rx_frame_decrypt(ieee, skb, crypt);
-	if (ieee->host_decrypt && (fc & RTLLIB_FCTL_WEP) && (keyidx < 0)) {
+	if ((fc & RTLLIB_FCTL_WEP) && (keyidx < 0)) {
 		netdev_info(ieee->dev, "%s: decrypt frame error\n", __func__);
 		return -1;
 	}
@@ -1147,7 +1145,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* skb: hdr + (possible reassembled) full MSDU payload; possibly still
 	 * encrypted/authenticated
 	 */
-	if (ieee->host_decrypt && (fc & RTLLIB_FCTL_WEP) &&
+	if ((fc & RTLLIB_FCTL_WEP) &&
 		rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 		netdev_info(ieee->dev, "%s: ==>decrypt msdu error\n", __func__);
 		return -1;
-- 
2.41.0

