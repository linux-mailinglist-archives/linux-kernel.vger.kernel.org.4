Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D073ED29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFZVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2720210C9;
        Mon, 26 Jun 2023 14:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC7460F7B;
        Mon, 26 Jun 2023 21:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0860C433C9;
        Mon, 26 Jun 2023 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816199;
        bh=0RcTU8BE4wi3TAoiFAjaJKZcctDdXBIhGiXOfkEehZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fush2epC0OJxfNOSMYf31us2BNMnutmkX/srpFwiYQUeWF1Dbs1Cr2T0m6icpxAd3
         wFbwsqDW5+pkTC7AiKvpwRgQR8zLr6Ar9f2USTGiZTZG74sKfp1eWOux6ROg+ioz4D
         xjlIh+IF+VkGV5PqiJRglNUA3qxR2iuHf2oeuZob+Kmb7zFJYWn9Q/OlgtTKx7uLn2
         jtzMwJcuPGjJW1FyTzd6k6DNDjcHjaOtk6eo9llBxZ9cNkzpS+aespAuywQXS3t3Lz
         uHQvrUAe9l8Xu066KFKK1HBRoyVPDs+cQB4vnFP6y6XmRyFvh0J4p06GYovXksy3nS
         Y1HQsOPuxQDUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 02/16] wifi: mac80211: Use active_links instead of valid_links in Tx
Date:   Mon, 26 Jun 2023 17:49:42 -0400
Message-Id: <20230626214956.178942-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626214956.178942-1-sashal@kernel.org>
References: <20230626214956.178942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 7b3b9ac899b54f53f7c9fc07e1c562f56b2187fa ]

Fix few places on the Tx path where the valid_links were used instead
of active links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.e24832691fc8.I9ac10dc246d7798a8d26b1a94933df5668df63fc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 45cb8e7bcc613..3beb10aebaa9c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4430,7 +4430,7 @@ static void ieee80211_mlo_multicast_tx(struct net_device *dev,
 				       struct sk_buff *skb)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	unsigned long links = sdata->vif.valid_links;
+	unsigned long links = sdata->vif.active_links;
 	unsigned int link;
 	u32 ctrl_flags = IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX;
 
@@ -5893,7 +5893,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 		rcu_read_unlock();
 
 		if (WARN_ON_ONCE(link == ARRAY_SIZE(sdata->vif.link_conf)))
-			link = ffs(sdata->vif.valid_links) - 1;
+			link = ffs(sdata->vif.active_links) - 1;
 	}
 
 	IEEE80211_SKB_CB(skb)->control.flags |=
@@ -5929,7 +5929,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 		band = chanctx_conf->def.chan->band;
 	} else {
 		WARN_ON(link_id >= 0 &&
-			!(sdata->vif.valid_links & BIT(link_id)));
+			!(sdata->vif.active_links & BIT(link_id)));
 		/* MLD transmissions must not rely on the band */
 		band = 0;
 	}
-- 
2.39.2

