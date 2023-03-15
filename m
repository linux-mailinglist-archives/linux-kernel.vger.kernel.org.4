Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5046BB516
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCONsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjCONr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:47:57 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D4672B28
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:47:24 -0700 (PDT)
Received: from fpc (unknown [10.10.165.16])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6FACF40737A0;
        Wed, 15 Mar 2023 13:47:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6FACF40737A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678888025;
        bh=Fu0DZqdhTXrpbcvEJF009OVu9YVP0WfEeRQxbBuqVT8=;
        h=Date:From:To:Cc:Subject:From;
        b=DVvewTP38uxIqXxTTns59BpqTgYCBXKiO12CE/V5DcaHANTqOZGLjggwjPhIPr9Wz
         9ytQPh8tLdlIof//6YgHFjBfat1gwf8x0BKqatIZNgD5Xwb89m+cvtBeb8RUySYCCc
         GsMmL8ZquEtBVEdFhOrxdmxCqD8UeKZvTXTyiNOU=
Date:   Wed, 15 Mar 2023 16:47:01 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230315134701.ojj2nzlbdbslheaz@fpc>
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

--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -200,16 +200,6 @@ void ath9k_fatal_work(struct work_struct *work)
 	ath9k_htc_reset(priv);
 }
 
-static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
-{
-	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
-
-	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
-		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
-
-	complete(&wmi->cmd_wait);
-}
-
 static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 			      enum htc_endpoint_id epid)
 {
@@ -221,6 +211,9 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
@@ -234,14 +227,24 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 
 	/* Check if there has been a timeout. */
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
+	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id ||
+	    be16_to_cpu(hdr->seq_no) == 0) {
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
-	/* WMI command response */
-	ath9k_wmi_rsp_callback(wmi, skb);
+	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
+
+	if (unlikely(skb->len < wmi->cmd_rsp_len)) {
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
+		goto free_skb;
+	}
+
+	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
+		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
+
+	complete(&wmi->cmd_wait);
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 free_skb:
 	kfree_skb(skb);
@@ -279,7 +282,8 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 
 static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 			       struct sk_buff *skb,
-			       enum wmi_cmd_id cmd, u16 len)
+			       enum wmi_cmd_id cmd, u16 len,
+			       u8 *rsp_buf, u32 rsp_len)
 {
 	struct wmi_cmd_hdr *hdr;
 	unsigned long flags;
@@ -289,6 +293,10 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
+	/* record the rsp buffer and length */
+	wmi->cmd_rsp_buf = rsp_buf;
+	wmi->cmd_rsp_len = rsp_len;
+
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -308,8 +316,11 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	unsigned long time_left;
 	int ret = 0;
 
-	if (ah->ah_flags & AH_UNPLUGGED)
-		return 0;
+	if (ah->ah_flags & AH_UNPLUGGED) {
+		ath_dbg(common, WMI, "Device unplugged for WMI command: %s\n",
+			wmi_cmd_to_name(cmd_id));
+		return -ENODEV;
+	}
 
 	skb = alloc_skb(headroom + cmd_len, GFP_ATOMIC);
 	if (!skb)
@@ -329,11 +340,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		goto out;
 	}
 
-	/* record the rsp buffer and length */
-	wmi->cmd_rsp_buf = rsp_buf;
-	wmi->cmd_rsp_len = rsp_len;
-
-	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len);
+	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len, rsp_buf, rsp_len);
 	if (ret)
 		goto out;
 
-- 
