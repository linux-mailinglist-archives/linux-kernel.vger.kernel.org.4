Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40B700FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjELUYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjELUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:23:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2B658E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:23:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42b984405so34458075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1683923021; x=1686515021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWvsRLIxiB43sDAy6eApAN4jRtdnfyX6t8wa5LgFN8k=;
        b=bS2O09FjqLBfPvjsX9HIJIdTHqmnZsh49elIai1krm7urEk1pwni2SjcJQLp4oy7pf
         KE+ZjyXq7VnvuJ6Y/sCn/l2F/hnrdBUV3VOF4mN0SFRUgTIhc2X39MyuoWNBIkYVbQz6
         BTRatEULipe55eKe1UAsstSGlSHPC9R6TlmEifqCK2gGVh+yKxpmNtMKhkhCIFpMZ2i7
         snvxCkOTlpXWD2PKwVd5YC2Von0mqoK6tWuW6Wah7BLU/9K9aiq72Hn2ZAyZ7P/Lhb1S
         3KrkXyfrL6DeCnqv8Va4w3ajkgoyt8ffhqC/6lkbHF+IRNXY+/ALT28+azRTwrJqY8BE
         jHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923021; x=1686515021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWvsRLIxiB43sDAy6eApAN4jRtdnfyX6t8wa5LgFN8k=;
        b=mCMag/Ko92sjIbAU/1TNP/7ecpV61oCyQ1GeWgjf3cIs8xXxuVT5eAPEwLToJg2NnB
         Ui2cKtLFGTjVmbyKeTGZf1p7BW6ME4DdGNE0bTEdK6QaqnP+Z3wqJR9WFR3dB6O6LQnN
         COFa9ei+FeJaxakZ8S8R4naibw32fZSxJ1skwY96kJgnpS1SxJCMWAjtPCu+qfBAEEn5
         qj26yuM463uVEDdzNzPSXzdwqfGnHDYkcFSKOj9SD1175DEftlPzYMLDcGcNq0AX/nKp
         zJObUbrnEKNk7QYqfuaENvVyT51De05PJ6NHLF/SH/3Jwa3t90Oouw02T/ONVrEIiy41
         HPPA==
X-Gm-Message-State: AC+VfDxYjvZy+OjNeLo7wYrbwFxi13UqTajXAie30HFC/gchbKlK7U3x
        +1C14SYfEAulpAecrxRutNU+jIIGG7zKRRXJvqI=
X-Google-Smtp-Source: ACHHUZ6i3cfU7GyOiDffCCXIEwgFS2k5l021Y+jiELGkleBnZPbH3tSxYbo8r7cMrmPHpSej++W3QA==
X-Received: by 2002:a7b:ca43:0:b0:3f1:72dc:8bae with SMTP id m3-20020a7bca43000000b003f172dc8baemr17142995wml.21.1683923021379;
        Fri, 12 May 2023 13:23:41 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003f423508c6bsm17304527wmd.44.2023.05.12.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:23:41 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH v6 16/21] net/tcp: Ignore specific ICMPs for TCP-AO connections
Date:   Fri, 12 May 2023 21:23:06 +0100
Message-Id: <20230512202311.2845526-17-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230512202311.2845526-1-dima@arista.com>
References: <20230512202311.2845526-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Similarly to IPsec, RFC5925 prescribes:
  ">> A TCP-AO implementation MUST default to ignore incoming ICMPv4
  messages of Type 3 (destination unreachable), Codes 2-4 (protocol
  unreachable, port unreachable, and fragmentation needed -- ’hard
  errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
  (administratively prohibited) and Code 4 (port unreachable) intended
  for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
  WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs."

A selftest (later in patch series) verifies that this attack is not
possible in this TCP-AO implementation.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h      | 10 ++++++-
 include/uapi/linux/snmp.h |  1 +
 include/uapi/linux/tcp.h  |  4 ++-
 net/ipv4/proc.c           |  1 +
 net/ipv4/tcp_ao.c         | 62 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c       |  5 ++++
 net/ipv6/tcp_ipv6.c       |  4 +++
 7 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 391b8260c325..a99521b78147 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -25,6 +25,7 @@ struct tcp_ao_counters {
 	atomic64_t	pkt_bad;
 	atomic64_t	key_not_found;
 	atomic64_t	ao_required;
+	atomic64_t	dropped_icmp;
 };
 
 struct tcp_ao_key {
@@ -94,7 +95,8 @@ struct tcp_ao_info {
 	struct tcp_ao_key	*rnext_key;
 	struct tcp_ao_counters	counters;
 	u32			ao_required	:1,
-				__unused	:31;
+				accept_icmps	:1,
+				__unused	:30;
 	__be32			lisn;
 	__be32			risn;
 	u32			snd_sne;
@@ -174,6 +176,7 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 u32 tcp_ao_compute_sne(u32 sne, u32 seq, u32 new_seq);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
+bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
@@ -248,6 +251,11 @@ static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 {
 }
 
+static inline bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
+{
+	return false;
+}
+
 static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 		const struct sk_buff *skb, unsigned short int family,
 		const struct request_sock *req, const struct tcp_ao_hdr *aoh)
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 06ddf4cd295c..47a6b47da66f 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -300,6 +300,7 @@ enum
 	LINUX_MIB_TCPAOBAD,			/* TCPAOBad */
 	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
 	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
+	LINUX_MIB_TCPAODROPPEDICMPS,		/* TCPAODroppedIcmps */
 	__LINUX_MIB_MAX
 };
 
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 3fe0612ec59a..ca7ed18ce67b 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -392,7 +392,8 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
 		set_rnext	:1,	/* corresponding ::rnext */
 		ao_required	:1,	/* don't accept non-AO connects */
 		set_counters	:1,	/* set/clear ::pkt_* counters */
-		reserved	:28;	/* must be 0 */
+		accept_icmps	:1,	/* accept incoming ICMPs */
+		reserved	:27;	/* must be 0 */
 	__u16	reserved2;		/* padding, must be 0 */
 	__u8	current_key;		/* KeyID to set as Current_key */
 	__u8	rnext;			/* KeyID to set as Rnext_key */
@@ -400,6 +401,7 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
 	__u64	pkt_bad;		/* failed verification */
 	__u64	pkt_key_not_found;	/* could not find a key to verify */
 	__u64	pkt_ao_required;	/* segments missing TCP-AO sign */
+	__u64	pkt_dropped_icmp;	/* ICMPs that were ignored */
 } __attribute__((aligned(8)));
 
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 3f643cd29cfe..5d3c9c96773e 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -302,6 +302,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOBad", LINUX_MIB_TCPAOBAD),
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
+	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 2f030cd5e605..fdba3e1c80cc 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -15,6 +15,7 @@
 
 #include <net/tcp.h>
 #include <net/ipv6.h>
+#include <net/icmp.h>
 
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len)
@@ -52,6 +53,64 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 	return 1;
 }
 
+bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
+{
+	struct tcp_ao_info *ao;
+	bool ignore_icmp = false;
+
+	/* RFC5925, 7.8:
+	 * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
+	 * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
+	 * unreachable, port unreachable, and fragmentation needed -- ’hard
+	 * errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
+	 * (administratively prohibited) and Code 4 (port unreachable) intended
+	 * for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
+	 * WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs.
+	 */
+	if (sk->sk_family == AF_INET) {
+		if (type != ICMP_DEST_UNREACH)
+			return false;
+		if (code < ICMP_PROT_UNREACH || code > ICMP_FRAG_NEEDED)
+			return false;
+	} else if (sk->sk_family == AF_INET6) {
+		if (type != ICMPV6_DEST_UNREACH)
+			return false;
+		if (code != ICMPV6_ADM_PROHIBITED && code != ICMPV6_PORT_UNREACH)
+			return false;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	rcu_read_lock();
+	switch (sk->sk_state) {
+	case TCP_TIME_WAIT:
+		ao = rcu_dereference(tcp_twsk(sk)->ao_info);
+		break;
+	case TCP_SYN_SENT:
+	case TCP_SYN_RECV:
+	case TCP_LISTEN:
+	case TCP_NEW_SYN_RECV:
+		/* RFC5925 specifies to ignore ICMPs *only* on connections
+		 * in synchronized states.
+		 */
+		rcu_read_unlock();
+		return false;
+	default:
+		ao = rcu_dereference(tcp_sk(sk)->ao_info);
+	}
+
+	if (ao && !ao->accept_icmps) {
+		ignore_icmp = true;
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAODROPPEDICMPS);
+		atomic64_inc(&ao->counters.dropped_icmp);
+	}
+	rcu_read_unlock();
+
+	return ignore_icmp;
+}
+EXPORT_SYMBOL_GPL(tcp_ao_ignore_icmp);
+
 /* Optimized version of tcp_ao_do_lookup(): only for sockets for which
  * it's known that the keys in ao_info are matching peer's
  * family/address/port/VRF/etc.
@@ -938,6 +997,7 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 	new_ao->lisn = htonl(tcp_rsk(req)->snt_isn);
 	new_ao->risn = htonl(tcp_rsk(req)->rcv_isn);
 	new_ao->ao_required = ao->ao_required;
+	new_ao->accept_icmps = ao->accept_icmps;
 
 	if (family == AF_INET) {
 		addr = (union tcp_ao_addr *)&newsk->sk_daddr;
@@ -1618,9 +1678,11 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 		atomic64_set(&ao_info->counters.pkt_bad, cmd.pkt_bad);
 		atomic64_set(&ao_info->counters.key_not_found, cmd.pkt_key_not_found);
 		atomic64_set(&ao_info->counters.ao_required, cmd.pkt_ao_required);
+		atomic64_set(&ao_info->counters.dropped_icmp, cmd.pkt_dropped_icmp);
 	}
 
 	ao_info->ao_required = cmd.ao_required;
+	ao_info->accept_icmps = cmd.accept_icmps;
 	if (new_current)
 		WRITE_ONCE(ao_info->current_key, new_current);
 	if (new_rnext)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9db6d7118c28..791453dabf88 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -492,6 +492,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		return -ENOENT;
 	}
 	if (sk->sk_state == TCP_TIME_WAIT) {
+		/* To increase the counter of ignored icmps for TCP-AO */
+		tcp_ao_ignore_icmp(sk, type, code);
 		inet_twsk_put(inet_twsk(sk));
 		return 0;
 	}
@@ -506,6 +508,9 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	}
 
 	bh_lock_sock(sk);
+	if (tcp_ao_ignore_icmp(sk, type, code))
+		goto out;
+
 	/* If too many ICMPs get dropped on busy
 	 * servers this needs to be solved differently.
 	 * We do take care of PMTU discovery (RFC1191) special case :
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6918076e1552..3ed15011876b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -399,6 +399,8 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	}
 
 	if (sk->sk_state == TCP_TIME_WAIT) {
+		/* To increase the counter of ignored icmps for TCP-AO */
+		tcp_ao_ignore_icmp(sk, type, code);
 		inet_twsk_put(inet_twsk(sk));
 		return 0;
 	}
@@ -410,6 +412,8 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	}
 
 	bh_lock_sock(sk);
+	if (tcp_ao_ignore_icmp(sk, type, code))
+		goto out;
 	if (sock_owned_by_user(sk) && type != ICMPV6_PKT_TOOBIG)
 		__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
 
-- 
2.40.0

