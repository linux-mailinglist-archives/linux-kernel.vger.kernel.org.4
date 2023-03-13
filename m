Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6296B7516
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjCMLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCMLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:03:03 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98459DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:03:02 -0700 (PDT)
Received: from fpc (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4245E44C1012;
        Mon, 13 Mar 2023 11:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4245E44C1012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678705381;
        bh=5LoZA215t4bYN3ajNP/GMkPoTgfBEMgLLTzCQDMXJNk=;
        h=Date:From:To:Cc:Subject:From;
        b=NcjmfSxhOVlsjNSeozqHqI0ADI8wgA8AFk3LX3DTNHct6g9nguJdY+tY/8xrkwr1t
         SH06C8NP6uFGnsI8waf0xuuAu5QdxjVvnppvHyrEbf0jAkAtaQTyA5ew2s6w70h10x
         P7uvqrDLSYB5ZM6QtR0cV0Scwcc9g3O35GlxgESo=
Date:   Mon, 13 Mar 2023 14:02:56 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
Message-ID: <20230313110256.driiufx5edha7xhh@fpc>
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
@@ -221,6 +221,9 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
@@ -308,8 +311,11 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
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
