Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE000718259
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjEaNmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEaNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A46196;
        Wed, 31 May 2023 06:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A0563B33;
        Wed, 31 May 2023 13:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70519C4339C;
        Wed, 31 May 2023 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540456;
        bh=xi29KIoRxhdYMTgfrsxheAosPW6NR2gixivtVkK18bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IoCO9VjDY2KbDhgiL7ye6mLMwZKg+HZ9l3Bl2G2dTNbAARZZ4TkEppeJg/rDrEdBn
         g/SMZMZBG+unn2gj1sFva1C+rP0xwxDDiE/uiTB42dXzQm4C0ODdaWwe9H1OhmHd5N
         gHmci0B4fSyIyixiqJ98sAtMv7C6ZJgkfrkprVBns1UZaCdSsdqOqMy9oAuv8m3uGk
         5EPF+N2IqdzoQNRHaJ7clZ36GZHX6es8fFzVguo1JFwbIlJ+4c02MrxgdW9G3tQOkS
         /KSuFGQF83XZcmnfM2sKQrI1M8WJSGA/n3BqhY+B+BsbgcDmE3JcwClfPSMQDgF1HA
         fqNcvzx8jSaaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Shai Amiram <samiram@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, borisp@nvidia.com,
        john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
        asml.silence@gmail.com, richardbgobert@gmail.com,
        imagedong@tencent.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 20/37] tls: rx: strp: force mixed decrypted records into copy mode
Date:   Wed, 31 May 2023 09:40:02 -0400
Message-Id: <20230531134020.3383253-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 14c4be92ebb3e36e392aa9dd8f314038a9f96f3c ]

If a record is partially decrypted we'll have to CoW it, anyway,
so go into copy mode and allocate a writable skb right away.

This will make subsequent fix simpler because we won't have to
teach tls_strp_msg_make_copy() how to copy skbs while preserving
decrypt status.

Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/tls/tls_strp.c     | 16 +++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dbcaac8b69665..4a882f9ba1f1f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1577,6 +1577,16 @@ static inline void skb_copy_hash(struct sk_buff *to, const struct sk_buff *from)
 	to->l4_hash = from->l4_hash;
 };
 
+static inline int skb_cmp_decrypted(const struct sk_buff *skb1,
+				    const struct sk_buff *skb2)
+{
+#ifdef CONFIG_TLS_DEVICE
+	return skb2->decrypted - skb1->decrypted;
+#else
+	return 0;
+#endif
+}
+
 static inline void skb_copy_decrypted(struct sk_buff *to,
 				      const struct sk_buff *from)
 {
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 955ac3e0bf4d3..445543d92ac5c 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -315,15 +315,19 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	return 0;
 }
 
-static bool tls_strp_check_no_dup(struct tls_strparser *strp)
+static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 {
 	unsigned int len = strp->stm.offset + strp->stm.full_len;
-	struct sk_buff *skb;
+	struct sk_buff *first, *skb;
 	u32 seq;
 
-	skb = skb_shinfo(strp->anchor)->frag_list;
-	seq = TCP_SKB_CB(skb)->seq;
+	first = skb_shinfo(strp->anchor)->frag_list;
+	skb = first;
+	seq = TCP_SKB_CB(first)->seq;
 
+	/* Make sure there's no duplicate data in the queue,
+	 * and the decrypted status matches.
+	 */
 	while (skb->len < len) {
 		seq += skb->len;
 		len -= skb->len;
@@ -331,6 +335,8 @@ static bool tls_strp_check_no_dup(struct tls_strparser *strp)
 
 		if (TCP_SKB_CB(skb)->seq != seq)
 			return false;
+		if (skb_cmp_decrypted(first, skb))
+			return false;
 	}
 
 	return true;
@@ -411,7 +417,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 			return tls_strp_read_copy(strp, true);
 	}
 
-	if (!tls_strp_check_no_dup(strp))
+	if (!tls_strp_check_queue_ok(strp))
 		return tls_strp_read_copy(strp, false);
 
 	strp->msg_ready = 1;
-- 
2.39.2

