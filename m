Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9486FFACB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbjEKTrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbjEKTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191F8A72;
        Thu, 11 May 2023 12:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0577A6515B;
        Thu, 11 May 2023 19:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D710C433AC;
        Thu, 11 May 2023 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683834056;
        bh=nF4sZu0xlvSgPOXCe6sCpUenKbq9M88q+aVA8m/JT3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xh5tAyuhhTs2ZjYD7ugeLWqYS8Ant5E+0FsweCEn+wme2iIOj0kG+xTgp17zBKXDt
         1IUdv7wIzKIv9uAleu3H6b6xY7S2j3MQOVAqn92E8VGeYLkRMi9ugyB6FmB7FEpnmT
         7iBTq/joVEsDTbBslklz4Vb1dl23oiAuQZvg74Tz1Aj4ZDJRdKQf65r+XmTtlHLJx4
         xobDLlfXa+BKvUDR2cApp0Jd/BoisgP0/MngiHE2PXJ+p/ca1Dxeuu633kmm/9IT+5
         LNYZor3Nvk+ZdK4nyqZJExXI1THgt81m4CWJx3/RXn8LpS8lUhb+c9lkw+8fU39PZG
         W/ppLqfYK8S3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/5] netfilter: nf_tables: deactivate anonymous set from preparation phase
Date:   Thu, 11 May 2023 15:40:21 -0400
Message-Id: <20230511194025.623614-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511194025.623614-1-sashal@kernel.org>
References: <20230511194025.623614-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit c1592a89942e9678f7d9c8030efa777c0d57edab ]

Toggle deleted anonymous sets as inactive in the next generation, so
users cannot perform any update on it. Clear the generation bitmask
in case the transaction is aborted.

The following KASAN splat shows a set element deletion for a bound
anonymous set that has been already removed in the same transaction.

[   64.921510] ==================================================================
[   64.923123] BUG: KASAN: wild-memory-access in nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.924745] Write of size 8 at addr dead000000000122 by task test/890
[   64.927903] CPU: 3 PID: 890 Comm: test Not tainted 6.3.0+ #253
[   64.931120] Call Trace:
[   64.932699]  <TASK>
[   64.934292]  dump_stack_lvl+0x33/0x50
[   64.935908]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.937551]  kasan_report+0xda/0x120
[   64.939186]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.940814]  nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.942452]  ? __kasan_slab_alloc+0x2d/0x60
[   64.944070]  ? nf_tables_setelem_notify+0x190/0x190 [nf_tables]
[   64.945710]  ? kasan_set_track+0x21/0x30
[   64.947323]  nfnetlink_rcv_batch+0x709/0xd90 [nfnetlink]
[   64.948898]  ? nfnetlink_rcv_msg+0x480/0x480 [nfnetlink]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c     | 12 ++++++++++++
 net/netfilter/nft_dynset.c        |  2 +-
 net/netfilter/nft_lookup.c        |  2 +-
 net/netfilter/nft_objref.c        |  2 +-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 8def00a04541e..22f67ae935e0b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -584,6 +584,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d950041364d5f..9c38b227275e8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4839,12 +4839,24 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 87f3af4645d9c..29c7ae8789e95 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -342,7 +342,7 @@ static void nft_dynset_activate(const struct nft_ctx *ctx,
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index bd3485dd930f5..9d18c5428d53c 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -167,7 +167,7 @@ static void nft_lookup_activate(const struct nft_ctx *ctx,
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 94b2327e71dc4..3ff91bcaa5f24 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -183,7 +183,7 @@ static void nft_objref_map_activate(const struct nft_ctx *ctx,
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
-- 
2.39.2

