Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2E6F9253
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEFNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjEFNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:53:24 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FF23A24
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 06:53:22 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vILdpZJ7QLshbvILdpEMnX; Sat, 06 May 2023 15:53:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683381200;
        bh=r2E/7o27DlnpjDgt/7U4i84YKnHKe8gQvEkHYS6ZEo4=;
        h=From:To:Cc:Subject:Date;
        b=lHlfvw7vCLJXsOvSEVtTEc2wvFWkD4EblArPxqrOu5YDJrRsXSR4s5ZSksWAVkdZv
         55glhtQuraGZycXpPsAWNDnlCpjsF7iI9pc+PHoXZr1Blt+WtwgTPjM8wwfGVImAz7
         DalbgVM/UlkBgGUuGOOYCcugmBKHHG+5wN1eeH7h6OQSkQ9On742MD7fG+MBCjwcAI
         gg3/DueVXVN9832W8oFD09ckXazRl0t5AbhLGWIw5oNU4D2ucn0BXTM1HO4dbW/K5O
         jO1e5fFIBx7HOAkq3GgASHeePGwU347WIkFlQAO1vbLTB43Cuhm4oJpTmcb34uzFLV
         zUwL97u8QjFUA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 15:53:20 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        chunfan chen <jeffc@marvell.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xinming Hu <huxm@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH wireless] mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
Date:   Sat,  6 May 2023 15:53:15 +0200
Message-Id: <7a6074fb056d2181e058a3cc6048d8155c20aec7.1683371982.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of "mwifiex_adapter->nd_info" is "struct cfg80211_wowlan_nd_info",
not "struct cfg80211_wowlan_nd_match".

Use struct_size() to ease the computation of the needed size.

The current code over-allocates some memory, so is safe.
But it wastes 32 bytes.

Fixes: 7d7f07d8c5d3 ("mwifiex: add wowlan net-detect support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index ac8001c84293..dd73ade4ddf1 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2187,9 +2187,9 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 
 	if (nd_config) {
 		adapter->nd_info =
-			kzalloc(sizeof(struct cfg80211_wowlan_nd_match) +
-				sizeof(struct cfg80211_wowlan_nd_match *) *
-				scan_rsp->number_of_sets, GFP_ATOMIC);
+			kzalloc(struct_size(adapter->nd_info, matches,
+					    scan_rsp->number_of_sets),
+				GFP_ATOMIC);
 
 		if (adapter->nd_info)
 			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
-- 
2.34.1

