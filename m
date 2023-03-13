Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34996B73F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCMK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCMK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:28:24 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9412D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:28:14 -0700 (PDT)
Received: from fpc (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id C51C244C1006;
        Mon, 13 Mar 2023 10:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C51C244C1006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678703292;
        bh=gQ2d4tK9+r2AX4wtkKCyTecoxEdQ+X12B3SUKJrReEQ=;
        h=Date:From:To:Cc:Subject:From;
        b=lDPVVyhpC0Yi8lq8vXzZrUWuBy/EaJj5SKBCFAD9UYIjwhRFk3Bm9LDqqAhuykzGz
         ksC81pnJDPmefnEJxFHh2pnSxVgJiawPDbtMfqjvznO+iCEj5pF1HpTTJ2u/7C7RYF
         48cr4ehVMOj/2+mj08cget71D8SrU+1AP7GxfGyE=
Date:   Mon, 13 Mar 2023 13:28:07 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_wmi_ctrl_rx
Message-ID: <20230313102807.wdd22btl5smkkcse@fpc>
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
 
-- 
