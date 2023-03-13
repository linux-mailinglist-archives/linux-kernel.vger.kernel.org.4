Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B56B7A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCMOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCMOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:36:29 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AC234D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:36:26 -0700 (PDT)
Received: from fpc (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 457F244C1004;
        Mon, 13 Mar 2023 14:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 457F244C1004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678718184;
        bh=EJyXYzLAFGH7oEtIVwWBmvW7i5R0P4Gnl47y/Tgt7MY=;
        h=Date:From:To:Cc:Subject:From;
        b=h6K6Qi+9oKo83gZ/wfxxzAmd+64JNzruUuG0ZllhJ439h3zlaa8EkN3b+KLUksB56
         TDNHaYDQhGHcg+nWqE3HFABzaiFBESfipF8oUdi8CkCxbEQ6QTvOmLjT7FD+yB1q4P
         1iU1dr5Dt+crmF2oeWpcovxF+A5IdG4LaXvUFqVY=
Date:   Mon, 13 Mar 2023 17:36:19 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230313143619.ljca56xjl4nsrm3b@fpc>
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
@@ -243,7 +243,7 @@ static unsigned int ath9k_regread(void *hw_priv, u32 reg_offset)
 			  (u8 *) &reg, sizeof(reg),
 			  (u8 *) &val, sizeof(val),
 			  100);
-	if (unlikely(r)) {
+	if (r) {
 		ath_dbg(common, WMI, "REGISTER READ FAILED: (0x%04x, %d)\n",
 			reg_offset, r);
 		return -1;
@@ -259,7 +259,7 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
 	__be32 tmpaddr[8];
-	__be32 tmpval[8];
+	__be32 tmpval[8] = {0};
 	int i, ret;
 
 	for (i = 0; i < count; i++) {
@@ -270,7 +270,7 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 			   (u8 *)tmpaddr , sizeof(u32) * count,
 			   (u8 *)tmpval, sizeof(u32) * count,
 			   100);
-	if (unlikely(ret)) {
+	if (ret) {
 		ath_dbg(common, WMI,
 			"Multiple REGISTER READ FAILED (count: %d)\n", count);
 	}
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -204,6 +204,9 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
+	if (unlikely(skb->len < wmi->cmd_rsp_len))
+		return;
+
 	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
 
@@ -221,6 +224,9 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
@@ -308,8 +314,11 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
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
