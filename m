Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1D73C70A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFXGEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFXGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:04:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BC26B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98dfd15aae1so892566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586658; x=1690178658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIAm9Vi41k3qXg99Kf1VsByjAUO1zMDP7x9TBCdCf+c=;
        b=Xubiln78018RL+OjfjLgdzhyHqSoYf7eGj8W8zr/cHkUvLydejy95UyNGe3GGDQ0RD
         TyvHTVDPZc6A0ysmjDNq5Sx5/u3YWgBs5e0OBprkMJC+PKuWqJv4EZnwc99BFfDkdePK
         jT1basG19dwQ2/blAH5n2ycQ9kNk+We3wuM6KAY3PmztS+YQ4Cg8r7oGdKuhbhvGg93M
         DJ/1+LgcKD5zuwYSfSz/m8FKPzMQuQC4JgDyYaAxTSfx3mLfajVQqNX39G/cgV0uNiHs
         lfNwcqS/rStRwVGpRBIH9LwewVuyEugTu4w3y18w1ow2XoTwJFLyEpPkyTHn0ZIOczHQ
         VpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586658; x=1690178658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIAm9Vi41k3qXg99Kf1VsByjAUO1zMDP7x9TBCdCf+c=;
        b=iomoyxEzCL00+RDke+ARQNjmJaStemoM1VRCAhkls2LO4Lkqa6EW2/cSUdIRxAYBtM
         xi+Xn7ByIUuwpkHKtsO8E9aOkhCQB7sCW0/n/HwJyq1umBnIHGWskpxUnZz+afkPKC6v
         EiVUFS1N0W37ECt4CV1G8CYleJc50G8uO4I3tK2OhPJSKTPplQK/1T9m9zs3QKFhSAzP
         emycPimcVCLN6VuN/8VkuPBcjmLqPQuscjwtrfIljkzujdwRVN9tj1vCUdUd8TzBDV6f
         6Ux/tELExv4iYJLqAyAr0yRxIBtci+JefxQmjlvkBVKKa29865EJIu+zQYnUC+g0VpZf
         HeHQ==
X-Gm-Message-State: AC+VfDxA4rnd50xgqqVHEYShEnT2Oi4w+bO0/GXeaO0oVVwgLC6+c3sk
        lpaJRElqkdn2Eer0XsKU9IIpvsFF9c8=
X-Google-Smtp-Source: ACHHUZ44qCh9A2V2JtqXe7HfgWSDenuqjDpqkkKsb8M/mZkYBS7yj21nnhII0Pen3aSTsUDPfi9JTw==
X-Received: by 2002:a17:906:779c:b0:988:815c:b9fa with SMTP id s28-20020a170906779c00b00988815cb9famr13169971ejm.3.1687586658031;
        Fri, 23 Jun 2023 23:04:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id rs17-20020a170907037100b00988e699d07fsm496826ejb.112.2023.06.23.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:16 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8192e: Remove variable host_encrypt as it
 is constant
Message-ID: <bc4ea0492306f708f0e5cac6bf0239deb3cd9a80.1687583718.git.philipp.g.hortmann@gmail.com>
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

ieee->host_encrypt also named priv->rtllib->host_encrypt is initialized
to 1 and then unchanged. All evaluations will result accordingly. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_module.c     |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 12 ++++--------
 drivers/staging/rtl8192e/rtllib_tx.c         |  3 +--
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index cb0753f6fb18..838b9c8b0df7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -804,7 +804,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->active_scan = 1;
 	priv->rtllib->be_scan_inprogress = false;
-	priv->rtllib->host_encrypt = 1;
 	priv->rtllib->host_decrypt = 1;
 
 	priv->rtllib->fts = DEFAULT_FRAG_THRESHOLD;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index fdb7990130b5..80090f8a38e7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1441,7 +1441,6 @@ struct rtllib_device {
 				 */
 
 	/* If the host performs {en,de}cryption, then set to 1 */
-	int host_encrypt;
 	int host_decrypt;
 
 	int ieee802_1x; /* is IEEE 802.1X used */
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index d6a4d6b4ec57..2ad2e3671ec4 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -98,7 +98,6 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	ieee->open_wep = 1;
 
 	/* Default to enabling full open WEP with host based encrypt/decrypt */
-	ieee->host_encrypt = 1;
 	ieee->host_decrypt = 1;
 	ieee->ieee802_1x = 1; /* Default to supporting 802.1x */
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c1e5127f5251..23b33a239703 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -807,7 +807,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	}
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
+	encrypt = crypt && crypt->ops &&
 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
 	if (ieee->ht_info->bCurrentHTSupport) {
 		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
@@ -943,10 +943,7 @@ static struct sk_buff *rtllib_assoc_resp(struct rtllib_device *ieee, u8 *dest)
 		assoc->capability |=
 				 cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
-	if (ieee->host_encrypt)
-		crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	else
-		crypt = NULL;
+	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 
 	encrypt = (crypt && crypt->ops);
 
@@ -1115,7 +1112,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	if (crypt != NULL)
-		encrypt = ieee->host_encrypt && crypt && crypt->ops &&
+		encrypt = crypt && crypt->ops &&
 			  ((strcmp(crypt->ops->name, "R-WEP") == 0 ||
 			  wpa_ie_len));
 	else
@@ -2995,8 +2992,7 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = (ieee->current_network.capability & WLAN_CAPABILITY_PRIVACY)
-		  || (ieee->host_encrypt && crypt && crypt->ops &&
-		  (strcmp(crypt->ops->name, "R-WEP") == 0));
+		  || (crypt && crypt->ops && (strcmp(crypt->ops->name, "R-WEP") == 0));
 
 	/* simply judge  */
 	if (encrypt && (wpa_ie_len == 0)) {
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ec038ef806c3..24fd40284420 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -635,8 +635,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 
 		skb->priority = rtllib_classify(skb, IsAmsdu);
 		crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-		encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) &&
-			ieee->host_encrypt && crypt && crypt->ops;
+		encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) && crypt && crypt->ops;
 		if (!encrypt && ieee->ieee802_1x &&
 		    ieee->drop_unencrypted && ether_type != ETH_P_PAE) {
 			stats->tx_dropped++;
-- 
2.41.0

