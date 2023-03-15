Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1F6BBD55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCOTfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjCOTfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:35:36 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950538ABCF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:35:30 -0700 (PDT)
Received: from fpc (unknown [10.10.165.16])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9E4ED44C100F;
        Wed, 15 Mar 2023 19:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9E4ED44C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678908928;
        bh=aqQ96mk6bjNY5p/8x2uV3oa0ZhGJDmI+dFV4k3UcAyM=;
        h=Date:From:To:Cc:Subject:From;
        b=bLau1QyGJV0Qh5MPDbB/J8Cyb7E8iI/97+VKGxcYmABkUQtmWkAV5Js7345CH0vvy
         Et+I24WQRs+5ltW+vvFeOiKwrPhGfxRVkSDPUCN/STux/ueVsIKDpqlbj+ml/VN1rS
         YHzR7OLvcaK3oT0I6h9NT9L1uAXz19d5XqRheQPE=
Date:   Wed, 15 Mar 2023 22:35:21 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230315193521.jcox7j3is24gk6mj@fpc>
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
@@ -200,20 +200,6 @@ void ath9k_fatal_work(struct work_struct *work)
 	ath9k_htc_reset(priv);
 }
 
-static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
-{
-	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
-
-	/* Once again validate the SKB. */
-	if (unlikely(skb->len < wmi->cmd_rsp_len))
-		return;
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
@@ -242,14 +228,26 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 
 	/* Check if there has been a timeout. */
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
+	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id ||
+	    be16_to_cpu(hdr->seq_no) == 0) {
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
+		goto free_skb;
+	}
+
+	/* Next, process WMI command response */
+	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
+
+	/* Once again validate the SKB. */
+	if (unlikely(skb->len < wmi->cmd_rsp_len)) {
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
-	/* WMI command response */
-	ath9k_wmi_rsp_callback(wmi, skb);
+	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
+		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
+
+	complete(&wmi->cmd_wait);
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 free_skb:
 	kfree_skb(skb);
@@ -287,7 +285,8 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 
 static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 			       struct sk_buff *skb,
-			       enum wmi_cmd_id cmd, u16 len)
+			       enum wmi_cmd_id cmd, u16 len,
+			       u8 *rsp_buf, u32 rsp_len)
 {
 	struct wmi_cmd_hdr *hdr;
 	unsigned long flags;
@@ -297,6 +296,11 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
+
+	/* record the rsp buffer and length */
+	wmi->cmd_rsp_buf = rsp_buf;
+	wmi->cmd_rsp_len = rsp_len;
+
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -337,11 +341,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
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
