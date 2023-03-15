Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CF16BBD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjCOTds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCOTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:33:46 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C0618B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:33:42 -0700 (PDT)
Received: from fpc (unknown [10.10.165.16])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8554144C100F;
        Wed, 15 Mar 2023 19:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8554144C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678908819;
        bh=GBHDW8IQ1HO6elN8PiKG6USdry3dR3Epa0+PVvmsvIg=;
        h=Date:From:To:Cc:Subject:From;
        b=PgiSRVYUMGpPyT5ocnDRNP0NREniKd5iDhXCAVA97iSp9thMOupubowOt2Y44fKt6
         /HerXihyDX6xuIIx9CZ8atSJv1kt6IHiIg3/Ef5NvcTUhuqwatQN29Qhwhbww0pubG
         lYbeYv3bacqzaYxfWJPCQJbA4DAl16Q3VA50tFSI=
Date:   Wed, 15 Mar 2023 22:33:35 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_wmi_ctrl_rx
Message-ID: <20230315193335.7doao26b2u3lzvq3@fpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/google/kmsan.git master

--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -1147,6 +1147,12 @@ void ath9k_htc_rxep(void *drv_priv, struct sk_buff *skb,
 	if (!data_race(priv->rx.initialized))
 		goto err;
 
+	/* Validate the obtained SKB so that it is handled without error
+	 * inside rx_tasklet handler.
+	 */
+	if (unlikely(skb->len < sizeof(struct ieee80211_hdr)))
+		goto err;
+
 	spin_lock_irqsave(&priv->rx.rxbuflock, flags);
 	list_for_each_entry(tmp_buf, &priv->rx.rxbuf, list) {
 		if (!tmp_buf->in_process) {
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index fe62ff668f75..9d0d9d0e1aa8 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -475,6 +475,10 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
 		skb_pull(skb, sizeof(struct htc_frame_hdr));
 
 		endpoint = &htc_handle->endpoint[epid];
+
+		/* The endpoint RX handlers should implement their own
+		 * additional SKB sanity checking
+		 */
 		if (endpoint->ep_callbacks.rx)
 			endpoint->ep_callbacks.rx(endpoint->ep_callbacks.priv,
 						  skb, epid);
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 19345b8f7bfd..2e7c361b62f5 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -204,6 +204,10 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
+	/* Once again validate the SKB. */
+	if (unlikely(skb->len < wmi->cmd_rsp_len))
+		return;
+
 	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
 
@@ -221,6 +225,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	/* Validate the obtained SKB. */
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
-- 
