Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B56B7FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCMRl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:41:25 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75B6B5E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:41:24 -0700 (PDT)
Received: from fpc (unknown [10.10.165.12])
        by mail.ispras.ru (Postfix) with ESMTPSA id C565F44C1009;
        Mon, 13 Mar 2023 17:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C565F44C1009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678729282;
        bh=dcathSfQ23gltzgIcKInyh+BoofN73T1rgTJq8y09tA=;
        h=Date:From:To:Cc:Subject:From;
        b=EPamrUk66P5gRHranF7zGO60zCKKzj/CZISJFsvQYf8/zkGcTc9/nb2juYDgObl+8
         wOK3ghCBk4KgDpyUxHdvFuUqe3MsLmwAJMWb3N4jJxt651mZ+R+bDuoAQyTr7J6qk6
         2dCvylxzSonFkJfRtMoczHI6kOdoSj9OKYshLx14=
Date:   Mon, 13 Mar 2023 20:41:18 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230313174118.325aaafflrliiehe@fpc>
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

--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -259,7 +259,7 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
 	__be32 tmpaddr[8];
-	__be32 tmpval[8];
+	__be32 tmpval[8] = {0};
 	int i, ret;
 
 	for (i = 0; i < count; i++) {
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -204,8 +204,13 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
+	if (unlikely(skb->len < wmi->cmd_rsp_len))
+		return;
+
 	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
+	else
+		return;
 
 	complete(&wmi->cmd_wait);
 }
@@ -221,6 +226,9 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
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
@@ -342,15 +353,22 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
 		wmi->last_seq_id = 0;
+		wmi->cmd_rsp_buf = NULL;
+		wmi->cmd_rsp_len = 0;
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
 	}
 
+	wmi->cmd_rsp_buf = NULL;
+	wmi->cmd_rsp_len = 0;
+
 	mutex_unlock(&wmi->op_mutex);
 
 	return 0;
 
 out:
+	wmi->cmd_rsp_buf = NULL;
+	wmi->cmd_rsp_len = 0;
 	ath_dbg(common, WMI, "WMI failure for: %s\n", wmi_cmd_to_name(cmd_id));
 	mutex_unlock(&wmi->op_mutex);
 	kfree_skb(skb);
-- 
