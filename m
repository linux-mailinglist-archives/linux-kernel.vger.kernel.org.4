Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB6711426
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbjEYSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjEYSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA51992;
        Thu, 25 May 2023 11:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A73648B2;
        Thu, 25 May 2023 18:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05667C433D2;
        Thu, 25 May 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039649;
        bh=NybuOARIeQPHnMskvSwF0Aq/qo48rTF7fRrWfOjNa00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOlF+UinN2D/DILMp2vlNwCVq00NbF6AHNOwNVvwd4yF30Z+c92UEJJWZ7cy2hRru
         2XrCv+t1ld+cPvALOP7wEgRTcMjRp3lr0cmc4p6TWaeI/6zsAquAPO5u1iMbJ4PsIj
         sMzIUkrNbIq66lXxX5a0Q3YAcUmLZN8fUJvuSlIC8f/uRiovvL03BniqZkQQIQp/OC
         LAPT7ZqjcflWolxPSgz1OjcmkjyKO5xCIsYhEU7FmsLggCrrHPqWyd4ssE+bpFN3sy
         Fl6j/LQ/JHIGBLAvVZxegxlTPXfCRhOUE06wVlr2R0kwvJvmKj/gtEMU/NTbtxneuU
         z7qihtKDoO2/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, ying.xue@windriver.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.3 35/67] tipc: add tipc_bearer_min_mtu to calculate min mtu
Date:   Thu, 25 May 2023 14:31:12 -0400
Message-Id: <20230525183144.1717540-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 3ae6d66b605be604644d4bb5708a7ffd9cf1abe8 ]

As different media may requires different min mtu, and even the
same media with different net family requires different min mtu,
add tipc_bearer_min_mtu() to calculate min mtu accordingly.

This API will be used to check the new mtu when doing the link
mtu negotiation in the next patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/bearer.c    | 13 +++++++++++++
 net/tipc/bearer.h    |  3 +++
 net/tipc/udp_media.c |  5 +++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 35cac7733fd3a..0e9a29e1536b7 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -541,6 +541,19 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)
 	return mtu;
 }
 
+int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)
+{
+	int mtu = TIPC_MIN_BEARER_MTU;
+	struct tipc_bearer *b;
+
+	rcu_read_lock();
+	b = bearer_get(net, bearer_id);
+	if (b)
+		mtu += b->encap_hlen;
+	rcu_read_unlock();
+	return mtu;
+}
+
 /* tipc_bearer_xmit_skb - sends buffer to destination over bearer
  */
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 490ad6e5f7a3c..bd0cc5c287ef8 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -146,6 +146,7 @@ struct tipc_media {
  * @identity: array index of this bearer within TIPC bearer array
  * @disc: ptr to link setup request
  * @net_plane: network plane ('A' through 'H') currently associated with bearer
+ * @encap_hlen: encap headers length
  * @up: bearer up flag (bit 0)
  * @refcnt: tipc_bearer reference counter
  *
@@ -170,6 +171,7 @@ struct tipc_bearer {
 	u32 identity;
 	struct tipc_discoverer *disc;
 	char net_plane;
+	u16 encap_hlen;
 	unsigned long up;
 	refcount_t refcnt;
 };
@@ -232,6 +234,7 @@ int tipc_bearer_setup(void);
 void tipc_bearer_cleanup(void);
 void tipc_bearer_stop(struct net *net);
 int tipc_bearer_mtu(struct net *net, u32 bearer_id);
+int tipc_bearer_min_mtu(struct net *net, u32 bearer_id);
 bool tipc_bearer_bcast_support(struct net *net, u32 bearer_id);
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
 			  struct sk_buff *skb,
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index c2bb818704c8f..0a85244fd6188 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -738,8 +738,8 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 			udp_conf.local_ip.s_addr = local.ipv4.s_addr;
 		udp_conf.use_udp_checksums = false;
 		ub->ifindex = dev->ifindex;
-		if (tipc_mtu_bad(dev, sizeof(struct iphdr) +
-				      sizeof(struct udphdr))) {
+		b->encap_hlen = sizeof(struct iphdr) + sizeof(struct udphdr);
+		if (tipc_mtu_bad(dev, b->encap_hlen)) {
 			err = -EINVAL;
 			goto err;
 		}
@@ -760,6 +760,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		else
 			udp_conf.local_ip6 = local.ipv6;
 		ub->ifindex = dev->ifindex;
+		b->encap_hlen = sizeof(struct ipv6hdr) + sizeof(struct udphdr);
 		b->mtu = 1280;
 #endif
 	} else {
-- 
2.39.2

