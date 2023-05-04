Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452696F77AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjEDVCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjEDVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:44 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04CCAD25;
        Thu,  4 May 2023 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230734;
        bh=4eWXzqJGW3r8CsJlCJi50P2D2+UPMfjU80F5mDNGm64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4elbQnqRi3jTLzFpSiA0lk6IUePnELvzLSch+U+lB44pmffUULxho7cstr32fRmp
         yyx1I+uF0AnCbCfOeFuhbpm9M+MKLg3C4I0HuLxBmbbEeVApWLWZDZ8PL8JKHyf52K
         13KvbCwD6QqP5tZR/5f610cJ4pLH1mRtE2vw0WUp2+pvQuWZgzCXbomISIxP/sd/u7
         cA0w22qS71+/mFkQ6qgxcoQVSCrPm+fOwAuiNHV/Ve2xDcRtJT8qpXrdm/z12eKFGR
         T3pJWBfjoN+FX3vOSg9dJ8gqXIA00bDqrxNK+2LL6Y+7FuE0di03m3j7FiuY4jVvTT
         CFcEQmkiCs0/A==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yp2nzCz11jJ;
        Thu,  4 May 2023 16:05:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [RFC PATCH 11/13] netdevice.h: Fix parentheses around macro parameter use
Date:   Thu,  4 May 2023 16:05:25 -0400
Message-Id: <20230504200527.1935944-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around macro parameter use in the following
pattern:

- "x - 1" changed for "(x) - 1",
- "x->member" changed for "(x)->member".

to ensure operator precedence behaves as expected.

Remove useless parentheses around macro parameter use in the following
pattern:

- m((x), y) changed for m(x, y), because comma has the lowest operator
  precedence, which makes the extra comma useless.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/linux/netdevice.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08fbd4622ccf..5a357262a45b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -283,7 +283,7 @@ struct hh_cache {
 	/* cached hardware header; allow for machine alignment needs.        */
 #define HH_DATA_MOD	16
 #define HH_DATA_OFF(__len) \
-	(HH_DATA_MOD - (((__len - 1) & (HH_DATA_MOD - 1)) + 1))
+	(HH_DATA_MOD - ((((__len) - 1) & (HH_DATA_MOD - 1)) + 1))
 #define HH_DATA_ALIGN(__len) \
 	(((__len)+(HH_DATA_MOD-1))&~(HH_DATA_MOD - 1))
 	unsigned long	hh_data[HH_DATA_ALIGN(LL_MAX_HEADER) / sizeof(long)];
@@ -4459,7 +4459,7 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_LOCK(dev, txq, cpu) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (((dev)->features & NETIF_F_LLTX) == 0) {	\
 		__netif_tx_lock(txq, cpu);		\
 	} else {					\
 		__netif_tx_acquire(txq);		\
@@ -4467,12 +4467,12 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_TRYLOCK(dev, txq)			\
-	(((dev->features & NETIF_F_LLTX) == 0) ?	\
+	((((dev)->features & NETIF_F_LLTX) == 0) ?	\
 		__netif_tx_trylock(txq) :		\
 		__netif_tx_acquire(txq))
 
 #define HARD_TX_UNLOCK(dev, txq) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (((dev)->features & NETIF_F_LLTX) == 0) {	\
 		__netif_tx_unlock(txq);			\
 	} else {					\
 		__netif_tx_release(txq);		\
@@ -4534,7 +4534,7 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
  * rcu_read_lock held.
  */
 #define for_each_dev_addr(dev, ha) \
-		list_for_each_entry_rcu(ha, &dev->dev_addrs.list, list)
+		list_for_each_entry_rcu(ha, &(dev)->dev_addrs.list, list)
 
 /* These functions live elsewhere (drivers/net/net_init.c, but related) */
 
@@ -5237,6 +5237,6 @@ extern struct net_device *blackhole_netdev;
 /* Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters. */
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
-		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+		atomic_long_add(VAL, &(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
-- 
2.25.1

