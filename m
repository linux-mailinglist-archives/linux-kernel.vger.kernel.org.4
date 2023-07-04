Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07468747321
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGDNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjGDNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:46:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A210C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:46:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso55869635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688478404; x=1691070404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLPwBxjHcLUc9IEFGdPILXC50hi/EmBYVhtJNix+/jY=;
        b=UgU/bMP8xJh/E43+3wths9hSeTNAzsVeYo6fvWf0/99j7oXNhgmr9BxoWx3DeRN1Fv
         KHTGrxufbFrksohY1wMS4/3Q31wKtXpXXPgA4aColzJZn0R4tqMpNSwpg6lmg2wmwjZi
         9I2WWcMMnxe54rbCad+pyNNIjrv2FflOU7AHqy4dgipjL7czFAqj6mGOgBsdmBUL9nAW
         uFlrHDlo344imM8CKihoHv20PakaEOEkts846Q7a1F5uTi6F/r8F3fR0CyBnNfKqdLeF
         lAS8u2xNo9FwF2emaE/ZNyE1Oxzcpc3tY3ZfwlYxMFM4qS6l0RUrWKlKBI0WA4irpnbh
         /kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478404; x=1691070404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLPwBxjHcLUc9IEFGdPILXC50hi/EmBYVhtJNix+/jY=;
        b=kPu7KDeqkhofD+c35Oc7A2XJ1p+pKgMPZgkpf0wejmoPS6ei1mow3G3fywCkr6Dggl
         Oru3FkXBKnUqqlPFynBcb/c8q5YlHiNnCvt7ihSZJa4ZeS1qkpecUNCk+zDZ7ySESQyL
         hMj6om45Iic08Ek8FntUc29SnRpwj2tKHMQTokmSAbAPWi1IdsN8fJ89TuRBH1IicOos
         HEtC6wpOzHu106ikpZlyB9DolSL9ClUHZ/gDqCiKZ32VhQZ0CMmFYYJTQp+lc39FWf8+
         NYMzcwBFJYvGo5U7cPZ+LbHW+xx3xVqqZZzIIDaP5eI5PkR/3VH3k80jv3/C0+oF6D1x
         xGaA==
X-Gm-Message-State: AC+VfDws3MxUvGnIPfotfRKo0y3maf3iXpVOc63J4+/WWHi7fP+ENB0C
        RJ2whTwFLt5AXDZWspQMYLW+Aw==
X-Google-Smtp-Source: ACHHUZ7NFLnFh7QCERg8voCkzFBTB9iIZvSEyNFpdpKCCDtANjwmOll2nhVwOL9Exha8b9thgLPWRw==
X-Received: by 2002:a05:600c:3655:b0:3f7:e48b:974d with SMTP id y21-20020a05600c365500b003f7e48b974dmr11494318wmq.27.1688478403961;
        Tue, 04 Jul 2023 06:46:43 -0700 (PDT)
Received: from [192.168.133.175] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm9274680wrt.37.2023.07.04.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:46:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 04 Jul 2023 14:46:24 +0100
Subject: [PATCH bpf-next v5 2/7] net: export inet_lookup_reuseport and
 inet6_lookup_reuseport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v5-2-f6686a0dbce0@isovalent.com>
References: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the existing reuseport helpers for IPv4 and IPv6 so that they
can be invoked in the follow up commit. Export them so that building
DCCP and IPv6 as a module works.

No change in functionality.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h |  7 +++++++
 include/net/inet_hashtables.h  |  5 +++++
 net/ipv4/inet_hashtables.c     | 15 ++++++++-------
 net/ipv6/inet6_hashtables.c    | 19 ++++++++++---------
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 56f1286583d3..032ddab48f8f 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,6 +48,13 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum);
+
 struct sock *inet6_lookup_listener(struct net *net,
 				   struct inet_hashinfo *hashinfo,
 				   struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 99bd823e97f6..8734f3488f5d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -379,6 +379,11 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e7391bf310a7..920131e4a65d 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -332,10 +332,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    __be32 saddr, __be16 sport,
-					    __be32 daddr, unsigned short hnum)
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
@@ -346,6 +346,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
 
 /*
  * Here are some nice properties to exploit here. The BSD API
@@ -369,8 +370,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet_lookup_reuseport(net, sk, skb, doff,
+						       saddr, sport, daddr, hnum);
 			if (result)
 				return result;
 
@@ -399,7 +400,7 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b64b49012655..b7c56867314e 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -111,12 +111,12 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    const struct in6_addr *saddr,
-					    __be16 sport,
-					    const struct in6_addr *daddr,
-					    unsigned short hnum)
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
@@ -127,6 +127,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
 
 /* called with rcu_read_lock() */
 static struct sock *inet6_lhash2_lookup(struct net *net,
@@ -143,8 +144,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet6_lookup_reuseport(net, sk, skb, doff,
+							saddr, sport, daddr, hnum);
 			if (result)
 				return result;
 
@@ -175,7 +176,7 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;

-- 
2.40.1

