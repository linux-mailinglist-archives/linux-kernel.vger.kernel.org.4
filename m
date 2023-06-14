Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D1730B33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjFNXKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjFNXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:10:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761592709
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d86db375so13316165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686784208; x=1689376208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YsMEeQJa4XBzvW5gd74qrU5xHhYoiMMIqwwJWAEThk=;
        b=MLir0GSsI80OvyyVCZn3NssnWIqTRqsz8fv0GbuWq4LpduopT9Y8TLIOBg3DbwlNDa
         Rx7q/kLHZ7A5faoV0axaSpfPAXG5yDDKnc/YQxBJdFz4vnbaF7h/+gX7nwUMH0nUyWTE
         OXSAQYcxDPpS1bsTMmYKDtt7RaPJLf+BQijfzgJ5V4Btm8c+NysfD8pEUBYPrMJoz46w
         l3u3ZMPsIbXmWt6Wxs9Bd0YGwm6DGueVHpmxeM3DivAWcl7XMKLRIYfYSoz9TVs4u6xT
         6qEh9OuUju17n3x4MwZZNuBobu9LzekyIypeZvYlPXYC4pLK4yZ/y0UvXLtSpO0Nq44H
         5y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686784208; x=1689376208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YsMEeQJa4XBzvW5gd74qrU5xHhYoiMMIqwwJWAEThk=;
        b=L3sa8uQa3hcyu5YgXo5IovK5OYZahMfHEsBTI2pDemQSnSe7MANkRtqCu8ARg3fcvB
         DONfIVNynKQ3IRY8TUfxdVgOxv+77a8i7JZ0keaSWu8pPm3htIgyhGZlD5+9bdsYFRtv
         27OLwV4CC51aNt9XWeTFkEgvcId1BnrJ0L36/8fCYgOV1tSsusLT8QqSf+OCpuxZi1b1
         1C6QCUF+krPKzK76zYvd7mNR55rzY6xQVQi0NguVrO+l4JzBlc6cB/gV/22JrB5vGfYr
         udRUcF0rGFJpqFEU9vn++AmO6tm/JN9lj8QbDgJSHBl6r3xi5jnxgdnSbTy87KTOWj2U
         ld6w==
X-Gm-Message-State: AC+VfDw8Fe1UuZXGmjOW8FlRN4iAI2aOBW2n6AWI5ZLchq09dbXDFZ39
        EcnqRny7VKtIoNl6FH4AIbDlLA==
X-Google-Smtp-Source: ACHHUZ5/SUE/E3B4jkUbRJ/P0kxxl7mzG3rOYtfeqz+puRu6CAvFvPcwldTDzLBOdR1NaGWqBzEzCQ==
X-Received: by 2002:a7b:c5ca:0:b0:3f8:11ec:7c06 with SMTP id n10-20020a7bc5ca000000b003f811ec7c06mr10058389wmk.39.1686784208190;
        Wed, 14 Jun 2023 16:10:08 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm18725261wmj.7.2023.06.14.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:10:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH v7 08/22] net/tcp: Add AO sign to RST packets
Date:   Thu, 15 Jun 2023 00:09:33 +0100
Message-Id: <20230614230947.3954084-9-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614230947.3954084-1-dima@arista.com>
References: <20230614230947.3954084-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up sending resets to TCP-AO hashing.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h |  12 +++++
 net/ipv4/tcp_ao.c    | 102 ++++++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c  |  76 ++++++++++++++++++++++++--------
 net/ipv6/tcp_ipv6.c  |  67 ++++++++++++++++++++++------
 4 files changed, 223 insertions(+), 34 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 72fc87cf58bf..010c77c4456e 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -121,6 +121,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
+struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+					  int sndid, int rcvid);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len);
 void tcp_ao_destroy_sock(struct sock *sk);
@@ -128,6 +130,16 @@ u32 tcp_ao_compute_sne(u32 sne, u32 seq, u32 new_seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid, u16 port);
+int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
+		struct tcp_ao_key *key, const u8 *tkey,
+		const union tcp_ao_addr *daddr,
+		const union tcp_ao_addr *saddr,
+		const struct tcphdr *th, u32 sne);
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 u8 *keyid, u32 *sne);
+
 /* ipv4 specific functions */
 int tcp_v4_parse_ao(struct sock *sk, int optname, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3889628bdcc1..a45ab30265bf 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -56,8 +56,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
  * it's known that the keys in ao_info are matching peer's
  * family/address/port/VRF/etc.
  */
-static struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
-						 int sndid, int rcvid)
+struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+					  int sndid, int rcvid)
 {
 	struct tcp_ao_key *key;
 
@@ -70,6 +70,7 @@ static struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(tcp_ao_established_key);
 
 static inline int ipv4_prefix_cmp(const struct in_addr *addr1,
 				  const struct in_addr *addr2,
@@ -387,6 +388,61 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
 	return err;
 }
 
+int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
+		    struct tcp_ao_key *key, const u8 *tkey,
+		    const union tcp_ao_addr *daddr,
+		    const union tcp_ao_addr *saddr,
+		    const struct tcphdr *th, u32 sne)
+{
+	__u8 tmp_hash[TCP_AO_MAX_HASH_SIZE] __tcp_ao_key_align;
+	int tkey_len = tcp_ao_digest_size(key);
+	int hash_offset = ao_hash - (char *)th;
+	struct tcp_sigpool hp;
+
+	if (tcp_sigpool_start(key->tcp_sigpool_id, &hp))
+		goto clear_hash_noput;
+
+	if (crypto_ahash_setkey(crypto_ahash_reqtfm(hp.req), tkey, tkey_len))
+		goto clear_hash;
+
+	if (crypto_ahash_init(hp.req))
+		goto clear_hash;
+
+	if (tcp_ao_hash_sne(&hp, sne))
+		goto clear_hash;
+	if (family == AF_INET) {
+		if (tcp_v4_ao_hash_pseudoheader(&hp, daddr->a4.s_addr,
+						saddr->a4.s_addr, th->doff * 4))
+			goto clear_hash;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (family == AF_INET6) {
+		if (tcp_v6_ao_hash_pseudoheader(&hp, &daddr->a6,
+						&saddr->a6, th->doff * 4))
+			goto clear_hash;
+#endif
+	} else {
+		WARN_ON_ONCE(1);
+		goto clear_hash;
+	}
+	if (tcp_ao_hash_header(&hp, th, false,
+			       ao_hash, hash_offset, tcp_ao_maclen(key)))
+		goto clear_hash;
+	ahash_request_set_crypt(hp.req, NULL, tmp_hash, 0);
+	if (crypto_ahash_final(hp.req))
+		goto clear_hash;
+
+	memcpy(ao_hash, tmp_hash, tcp_ao_maclen(key));
+	tcp_sigpool_end(&hp);
+	return 0;
+
+clear_hash:
+	tcp_sigpool_end(&hp);
+clear_hash_noput:
+	memset(ao_hash, 0, tcp_ao_maclen(key));
+	return 1;
+}
+EXPORT_SYMBOL_GPL(tcp_ao_hash_hdr);
+
 int tcp_ao_hash_skb(unsigned short int family,
 		    char *ao_hash, struct tcp_ao_key *key,
 		    const struct sock *sk, const struct sk_buff *skb,
@@ -449,6 +505,48 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid, 0);
 }
 
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 u8 *keyid, u32 *sne)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_ao_info *ao_info;
+
+	/* If there's no socket - than initial sisn/disn are unknown.
+	 * Drop the segment. RFC5925 (7.7) advises to require graceful
+	 * restart [RFC4724]. Alternatively, the RFC5925 advises to
+	 * save/restore traffic keys before/after reboot.
+	 * Linux TCP-AO support provides TCP_AO_ADD_KEY and TCP_REPAIR
+	 * options to restore a socket post-reboot.
+	 */
+	if (!sk)
+		return -ENOTCONN;
+
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
+		return -1;
+	} else {
+		struct tcp_ao_key *rnext_key;
+
+		if (sk->sk_state == TCP_TIME_WAIT)
+			return -1;
+		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+		if (!ao_info)
+			return -ENOENT;
+
+		*key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+		if (!*key)
+			return -ENOENT;
+		*traffic_key = snd_other_key(*key);
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		*keyid = rnext_key->rcvid;
+		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
+					  READ_ONCE(ao_info->snd_sne_seq),
+					  ntohl(seq));
+	}
+	return 0;
+}
+
 static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 				     struct tcp_ao_info *ao,
 				     struct tcp_ao_key *ao_key)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 05fa0aab0b8d..9638bab8ed92 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -655,6 +655,49 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
+#define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
+
+static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
+				 const struct tcp_ao_hdr *aoh,
+				 struct ip_reply_arg *arg, struct tcphdr *reply,
+				 __be32 reply_options[REPLY_OPTIONS_LEN])
+{
+#ifdef CONFIG_TCP_AO
+	char key_buf[TCP_AO_MAX_HASH_SIZE] __tcp_ao_key_align;
+	char *traffic_key = key_buf;
+	int sdif = tcp_v4_sdif(skb);
+	int dif = inet_iif(skb);
+	int l3index = sdif ? dif : 0;
+	struct tcp_ao_key *key;
+	bool drop = true;
+	u32 ao_sne = 0;
+	u8 keyid;
+
+	rcu_read_lock();
+	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, reply->seq,
+				 &key, &traffic_key, &keyid, &ao_sne))
+		goto out;
+
+	reply_options[0] = htonl((TCPOPT_AO << 24) | (tcp_ao_len(key) << 16) |
+				 (aoh->rnext_keyid << 8) | keyid);
+	arg->iov[0].iov_len += round_up(tcp_ao_len(key), 4);
+	reply->doff = arg->iov[0].iov_len / 4;
+
+	if (tcp_ao_hash_hdr(AF_INET, (char *)&reply_options[1],
+			    key, traffic_key,
+			    (union tcp_ao_addr *)&ip_hdr(skb)->saddr,
+			    (union tcp_ao_addr *)&ip_hdr(skb)->daddr,
+			    reply, ao_sne))
+		goto out;
+	drop = false;
+out:
+	rcu_read_unlock();
+	return drop;
+#else
+	return true;
+#endif
+}
+
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -668,32 +711,25 @@ EXPORT_SYMBOL(tcp_v4_send_check);
  *	Exception: precedence violation. We do not implement it in any case.
  */
 
-#ifdef CONFIG_TCP_AO
-#define OPTION_BYTES MAX_TCP_OPTION_SPACE
-#elif defined(CONFIG_TCP_MD5SIG)
-#define OPTION_BYTES TCPOLEN_MD5SIG_ALIGNED
-#else
-#define OPTION_BYTES sizeof(__be32)
-#endif
-
 static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
-		__be32 opt[OPTION_BYTES / sizeof(__be32)];
+		__be32 opt[REPLY_OPTIONS_LEN];
 	} rep;
 	struct ip_reply_arg arg;
-#ifdef CONFIG_TCP_MD5SIG
-	struct tcp_md5sig_key *key = NULL;
-	const __u8 *md5_hash_location = NULL;
-	unsigned char newhash[16];
-	int genhash;
-	struct sock *sk1 = NULL;
-#endif
 	u64 transmit_time = 0;
 	struct sock *ctl_sk;
 	struct net *net;
+	const __u8 *md5_hash_location = NULL;
+	const struct tcp_ao_hdr *aoh;
+#ifdef CONFIG_TCP_MD5SIG
+	struct tcp_md5sig_key *key = NULL;
+	unsigned char newhash[16];
+	struct sock *sk1 = NULL;
+	int genhash;
+#endif
 
 	/* Never send a reset in response to a reset. */
 	if (th->rst)
@@ -725,11 +761,15 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-#ifdef CONFIG_TCP_MD5SIG
+
 	/* Invalid TCP option size or twice included auth */
-	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, NULL))
+	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
 		return;
 
+	if (aoh && tcp_v4_ao_sign_reset(sk, skb, aoh, &arg, &rep.th, rep.opt))
+		return;
+
+#ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	if (sk && sk_fullsock(sk)) {
 		const union tcp_md5_addr *addr;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0074d1f1f8a5..282603cb009c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -858,7 +858,9 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32 seq,
 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
 				 int oif, struct tcp_md5sig_key *key, int rst,
-				 u8 tclass, __be32 label, u32 priority, u32 txhash)
+				 u8 tclass, __be32 label, u32 priority, u32 txhash,
+				 struct tcp_ao_key *ao_key, char *tkey,
+				 u8 rcv_next, u32 ao_sne)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcphdr *t1;
@@ -877,6 +879,13 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (key)
 		tot_len += TCPOLEN_MD5SIG_ALIGNED;
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key)
+		tot_len += tcp_ao_len(ao_key);
+#endif
+#if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
+	WARN_ON_ONCE(key && ao_key);
+#endif
 
 #ifdef CONFIG_MPTCP
 	if (rst && !key) {
@@ -928,6 +937,17 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				    &ipv6_hdr(skb)->daddr, t1);
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key) {
+		*topt++ = htonl((TCPOPT_AO << 24) | (tcp_ao_len(ao_key) << 16) |
+				(ao_key->sndid << 8) | (rcv_next));
+
+		tcp_ao_hash_hdr(AF_INET6, (char *)topt, ao_key, tkey,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->saddr,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->daddr,
+				t1, ao_sne);
+	}
+#endif
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr = ipv6_hdr(skb)->saddr;
@@ -992,17 +1012,27 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	u32 seq = 0, ack_seq = 0;
 	struct tcp_md5sig_key *key = NULL;
-#ifdef CONFIG_TCP_MD5SIG
+	__be32 label = 0;
+	u32 priority = 0;
+	struct net *net;
+	struct tcp_ao_key *ao_key = NULL;
+	u8 rcv_next = 0;
+	u32 ao_sne = 0;
+	u32 txhash = 0;
+	int oif = 0;
 	const __u8 *md5_hash_location = NULL;
+	const struct tcp_ao_hdr *aoh;
+#ifdef CONFIG_TCP_MD5SIG
 	unsigned char newhash[16];
 	int genhash;
 	struct sock *sk1 = NULL;
 #endif
-	__be32 label = 0;
-	u32 priority = 0;
-	struct net *net;
-	u32 txhash = 0;
-	int oif = 0;
+#ifdef CONFIG_TCP_AO
+	char key_buf[TCP_AO_MAX_HASH_SIZE] __tcp_ao_key_align;
+	char *traffic_key = key_buf;
+#else
+	u8 *traffic_key = NULL;
+#endif
 
 	if (th->rst)
 		return;
@@ -1014,12 +1044,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		return;
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-#ifdef CONFIG_TCP_MD5SIG
 	/* Invalid TCP option size or twice included auth */
-	if (tcp_parse_auth_options(th, &md5_hash_location, NULL))
+	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
-
 	rcu_read_lock();
+#ifdef CONFIG_TCP_MD5SIG
 	if (sk && sk_fullsock(sk)) {
 		int l3index;
 
@@ -1068,6 +1097,17 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ack_seq = ntohl(th->seq) + th->syn + th->fin + skb->len -
 			  (th->doff << 2);
 
+#ifdef CONFIG_TCP_AO
+	if (aoh) {
+		int l3index;
+
+		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, seq, &ao_key,
+					 &traffic_key, &rcv_next, &ao_sne))
+			goto out;
+	}
+#endif
+
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
@@ -1090,12 +1130,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	}
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash);
+			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ao_key, traffic_key, rcv_next, ao_sne);
 
-#ifdef CONFIG_TCP_MD5SIG
 out:
 	rcu_read_unlock();
-#endif
 }
 
 static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
@@ -1104,7 +1143,7 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			    __be32 label, u32 priority, u32 txhash)
 {
 	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
-			     tclass, label, priority, txhash);
+			     tclass, label, priority, txhash, NULL, NULL, 0, 0);
 }
 
 static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
-- 
2.40.0

