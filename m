Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB9734188
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbjFQN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjFQN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:57:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46B30E3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-97ea801b0d0so44276066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010246; x=1689602246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5r8DhT5L5h8r0JwLA0gY98CPzBjOeUot4BZYb8MwDFg=;
        b=po6/GxT79Pm4LMgotSpY2CrnosQiuatHhG2r+ox8rDNPiFx02/4VBAPMsg7qRulaT8
         L9pPMyf82WjyPwbVdVo749dObJ8wijFGR6luwWbw5wZPinUZLa84i/2FrCg4lna97tK4
         0P6v9mk5cow8xGHEDAlukGsncTt2T7wMgrjXaQnEB4vt2vDfCKE53x7VFO6D0s1GhU9Y
         nAL5Bscb1WmQhuNKAE0egkJ0ffmVwDRe9CVnSmrQiDBtuPKssDny2xc4ccPrfVB++iHw
         RwnPWReZl87ir4wnbnqD2V+9GCq4uM5FOzyOoLww81a04g6gF/CMPzZN4+6vMNPY3/Sa
         L6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010246; x=1689602246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r8DhT5L5h8r0JwLA0gY98CPzBjOeUot4BZYb8MwDFg=;
        b=lzygR5W7Wbzn8mAx1OXLGeeINTjgYZs8OoOI9mivXdCdM4+7aUzUaPa2dEw5nCUcUY
         fFm+aV7EIFNnLoT/IRF3BH+LG8QRltbEjCXc8Nu+xQj7mipNfb/zyOoNKa6g3ffQT+AQ
         FheE/CfGLdbCV+kgcdOuXAUxZPCzLiERpGWwBMtaj40mtBvzJWZ1kIHFuB6aIuHBf/dF
         bHr2fFAPkN+x3viJsUr+nYcDQHMfBJyGGtZt4NDTdSrkm4jjTuFx+bFNhT+xtoYKZyNF
         1Ogyf+gXOH3DfJuTP6ToAEivloDHaQ1EMjCfwq+05koSX5FBRJaagVUH9TAjvA2FOgJV
         3qOQ==
X-Gm-Message-State: AC+VfDxvSCpnwldT296ls0NRE4cHBaYpyy2kA1AXtBJ2L8hnu5owr6PM
        pu4OfmU0jV07gF3KqfYQTbUmlvgzOFw=
X-Google-Smtp-Source: ACHHUZ7bVJVqEU8KH/THe0uY1XocKcopdUINfLGItCXNEVmxIfwG88jbBbM3dW3HtE8pTCJfq0ZfZw==
X-Received: by 2002:a17:906:6493:b0:987:6960:36c5 with SMTP id e19-20020a170906649300b00987696036c5mr1352539ejm.6.1687010245981;
        Sat, 17 Jun 2023 06:57:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709066b0e00b00987435d6266sm982342ejr.190.2023.06.17.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:57:25 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:57:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] staging: rtl8192e: Rename RTLLIB_NOLINK to
 MAC80211_NOLINK
Message-ID: <74feefdf800304deaf918efbc04344865f7aa01d.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename RTLLIB_NOLINK to MAC80211_NOLINK to align with rtlwifi driver.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 34 ++++++++++----------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7b7500c6b181..b4c618d37a71 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1192,7 +1192,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 	if (!rtllib_act_scanning(priv->rtllib, false)) {
 		if ((ieee->iw_mode == IW_MODE_INFRA) && (ieee->link_state ==
-		     RTLLIB_NOLINK) &&
+		     MAC80211_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
 			if ((ieee->pwr_save_ctrl.ReturnPoint ==
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 933656e9fc8a..68f0e1426b35 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1121,7 +1121,7 @@ struct rtllib_network {
 
 enum rtl_link_state {
 	/* the card is not linked at all */
-	RTLLIB_NOLINK = 0,
+	MAC80211_NOLINK = 0,
 
 	/* RTLLIB_ASSOCIATING* are for BSS client mode
 	 * the driver shall not perform RX filtering unless
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 9beac92c613f..68f1393b1b63 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2643,7 +2643,7 @@ static inline void rtllib_process_probe_response(
 		    || ((ieee->current_network.ssid_len == network->ssid_len) &&
 		    (strncmp(ieee->current_network.ssid, network->ssid,
 		    network->ssid_len) == 0) &&
-		    (ieee->link_state == RTLLIB_NOLINK))))
+		    (ieee->link_state == MAC80211_NOLINK))))
 			renew = 1;
 		update_network(ieee, target, network);
 		if (renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 242bb5c633e9..bbb0f61c851d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -508,7 +508,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 		 *    performing a complete syncro scan before conclude
 		 *    there are no interesting cell and to create a
 		 *    new one. In this case the link state is
-		 *    RTLLIB_NOLINK until we found an interesting cell.
+		 *    MAC80211_NOLINK until we found an interesting cell.
 		 *    If so the ieee8021_new_net, called by the RX path
 		 *    will set the state to RTLLIB_LINKED, so we stop
 		 *    scanning
@@ -1548,7 +1548,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 	/* we are interested in new only if we are not associated
 	 * and we are not associating / authenticating
 	 */
-	if (ieee->link_state != RTLLIB_NOLINK)
+	if (ieee->link_state != MAC80211_NOLINK)
 		return;
 
 	if ((ieee->iw_mode == IW_MODE_INFRA) && !(net->capability &
@@ -1682,7 +1682,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
 		 * we had found what we are searching for
 		 */
 
-		if (ieee->link_state != RTLLIB_NOLINK)
+		if (ieee->link_state != MAC80211_NOLINK)
 			break;
 
 		if (ieee->scan_age == 0 || time_after(target->last_scanned +
@@ -2495,7 +2495,7 @@ static void rtllib_start_ibss_wq(void *data)
 		ieee->ssid_set = 1;
 	}
 
-	ieee->link_state = RTLLIB_NOLINK;
+	ieee->link_state = MAC80211_NOLINK;
 	ieee->mode = WIRELESS_MODE_G;
 	/* check if we have this cell in our network list */
 	rtllib_softmac_check_all_nets(ieee);
@@ -2514,11 +2514,11 @@ static void rtllib_start_ibss_wq(void *data)
 	 * scan, that will stop at the first round because it sees the state
 	 * associated.
 	 */
-	if (ieee->link_state == RTLLIB_NOLINK)
+	if (ieee->link_state == MAC80211_NOLINK)
 		rtllib_start_scan_syncro(ieee, 0);
 
 	/* the network definitively is not here.. create a new cell */
-	if (ieee->link_state == RTLLIB_NOLINK) {
+	if (ieee->link_state == MAC80211_NOLINK) {
 		netdev_info(ieee->dev, "creating new IBSS cell\n");
 		ieee->current_network.channel = ieee->bss_start_channel;
 		if (!ieee->wap_set)
@@ -2623,7 +2623,7 @@ static void rtllib_start_bss(struct rtllib_device *ieee)
 	 */
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->link_state == RTLLIB_NOLINK)
+	if (ieee->link_state == MAC80211_NOLINK)
 		rtllib_start_scan(ieee);
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
@@ -2643,7 +2643,7 @@ void rtllib_disassociate(struct rtllib_device *ieee)
 
 	if (IS_DOT11D_ENABLE(ieee))
 		dot11d_reset(ieee);
-	ieee->link_state = RTLLIB_NOLINK;
+	ieee->link_state = MAC80211_NOLINK;
 	ieee->is_set_key = false;
 	ieee->wap_set = 0;
 
@@ -2665,11 +2665,11 @@ static void rtllib_associate_retry_wq(void *data)
 	if (ieee->link_state != RTLLIB_ASSOCIATING_RETRY)
 		goto exit;
 
-	/* until we do not set the state to RTLLIB_NOLINK
+	/* until we do not set the state to MAC80211_NOLINK
 	 * there are no possibility to have someone else trying
 	 * to start an association procedure (we get here with
 	 * ieee->link_state = RTLLIB_ASSOCIATING).
-	 * When we set the state to RTLLIB_NOLINK it is possible
+	 * When we set the state to MAC80211_NOLINK it is possible
 	 * that the RX path run an attempt to associate, but
 	 * both rtllib_softmac_check_all_nets and the
 	 * RX path works with ieee->lock held so there are no
@@ -2679,13 +2679,13 @@ static void rtllib_associate_retry_wq(void *data)
 	 * state and we are going to start the scan.
 	 */
 	ieee->beinretry = true;
-	ieee->link_state = RTLLIB_NOLINK;
+	ieee->link_state = MAC80211_NOLINK;
 
 	rtllib_softmac_check_all_nets(ieee);
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->link_state == RTLLIB_NOLINK)
+	if (ieee->link_state == MAC80211_NOLINK)
 		rtllib_start_scan(ieee);
 	spin_unlock_irqrestore(&ieee->lock, flags);
 
@@ -2763,7 +2763,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	rtllib_stop_scan(ieee);
 
 	if (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED)
-		ieee->link_state = RTLLIB_NOLINK;
+		ieee->link_state = MAC80211_NOLINK;
 
 	if (ieee->link_state == RTLLIB_LINKED) {
 		if (ieee->iw_mode == IW_MODE_INFRA)
@@ -2845,7 +2845,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	memset(&ieee->current_network, 0, sizeof(struct rtllib_network));
 
-	ieee->link_state = RTLLIB_NOLINK;
+	ieee->link_state = MAC80211_NOLINK;
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
 	ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_ATOMIC);
@@ -3036,7 +3036,7 @@ static void rtllib_MgntDisconnectIBSS(struct rtllib_device *rtllib)
 	u8	i;
 	bool	bFilterOutNonAssociatedBSSID = false;
 
-	rtllib->link_state = RTLLIB_NOLINK;
+	rtllib->link_state = MAC80211_NOLINK;
 
 	for (i = 0; i < 6; i++)
 		rtllib->current_network.bssid[i] = 0x55;
@@ -3063,7 +3063,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 	RemovePeerTS(rtllib, asSta);
 
 	if (memcmp(rtllib->current_network.bssid, asSta, 6) == 0) {
-		rtllib->link_state = RTLLIB_NOLINK;
+		rtllib->link_state = MAC80211_NOLINK;
 
 		for (i = 0; i < 6; i++)
 			rtllib->current_network.bssid[i] = 0x22;
@@ -3092,7 +3092,7 @@ rtllib_MgntDisconnectAP(
 	rtllib_MlmeDisassociateRequest(rtllib, rtllib->current_network.bssid,
 				       asRsn);
 
-	rtllib->link_state = RTLLIB_NOLINK;
+	rtllib->link_state = MAC80211_NOLINK;
 }
 
 bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
-- 
2.40.1

