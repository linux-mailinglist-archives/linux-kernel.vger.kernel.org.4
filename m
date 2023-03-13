Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8296B830B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCMUrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMUrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:47:41 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A927C9EB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:47:39 -0700 (PDT)
Received: from fpc (unknown [10.10.165.12])
        by mail.ispras.ru (Postfix) with ESMTPSA id EE10544C1023;
        Mon, 13 Mar 2023 20:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EE10544C1023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678740458;
        bh=d7a6eWiT/hmVQAL5F0ZZEbi5J0nOLJkaCqxQZ/PyGls=;
        h=Date:From:To:Cc:Subject:From;
        b=W5+nM6TN5tSOXFxUWy12y+X52QAnK/B1FICUTeJN3v/BcoxIrJvoY/THCowxHnAac
         /ZbDgeLjHDHOEwx0/WQvEYeC3y7ccZIT8YfFX3eckrhkEP3rTFSlOVKGj0LovKRh1n
         Qrdm04OWbQhw/fmDGU7u+nRX1I234ni/SJ8AsSoo=
Date:   Mon, 13 Mar 2023 23:47:32 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230313204732.zjcmd3ruvzw3bljo@fpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 
@@ -238,10 +231,19 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
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
@@ -308,8 +310,11 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
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
-- 
