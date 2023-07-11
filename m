Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654A74E5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKEfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGKEf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:35:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196EE73
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:35:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b5d1498670so4379338a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689050124; x=1691642124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4d6TzlfjJWrdOGjW/NEKdoSNLBqa20i4S1TfSLDQrw=;
        b=xW5EjQ2tpBl4JvgMTw68zXoGETIEeH48G9EfbS7yTmQEdr2kaZjO8SDz74qk6jT41X
         0ceJiEgAh9YOb37ysPyF+uWUxNmvfWqLyxEzXaV4FptHfNK3MIktGtwdXPHi9UhOB05U
         vwl9F/luKu4oQLCteLviw+B0NDaCuuZHulGRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050124; x=1691642124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4d6TzlfjJWrdOGjW/NEKdoSNLBqa20i4S1TfSLDQrw=;
        b=dLFejDq1fGrK9xxdzXnMpU4EOVZJgh4hImi/EdOYS0gIvKdeOu8RxYfrSfoiuVWiq/
         C946mEcW+wOqEYyXGyy2dRC3YLdAktTXfu1il+kDth1OI2yvbbdrJvqi3s9FzoudUURy
         7XQIJNFUIoeYwIWPdtwAyeyBFolUlMMAasDNpJHCaXzJg6U0p3CjNkPJywfWUTe7Hezb
         5X+p7L4cDCJU8/cFfoBl2GSJ9NB58Rre3p9EFC3ZwHnb9fEl0hsx71nHCEKZwM2gp/jH
         FK7XwuYJrjZ3UUeV5Q8nNusThiBaToIG3wmaMTPevU9zalt+ztSSS+c0VUMQaf5EALgW
         LBow==
X-Gm-Message-State: ABy/qLZKZUZG7XbH7D4vv28Opn13WDWpML9dL/9TQkSec00ULQS77b8e
        2Bi5wSK9CSidrtTLKh7IQjrrgw==
X-Google-Smtp-Source: APBJJlFvkqRJ9X/SbxNLy/CEgfUzlF08N0/VlUhQr5n9Fpv8Ztz53HAbYfGDQv379rQ5VV6MsKQRJw==
X-Received: by 2002:a05:6870:c1d3:b0:199:f985:7129 with SMTP id i19-20020a056870c1d300b00199f9857129mr13611073oad.39.1689050124314;
        Mon, 10 Jul 2023 21:35:24 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:60e1:d34a:f5f6:64b5])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b6674b6140sm714976pld.290.2023.07.10.21.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:35:23 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
Date:   Mon, 10 Jul 2023 21:34:52 -0700
Message-ID: <20230711043453.64095-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's already a way to count the overall numbers of queue overflows:

    $ sudo netstat -s | grep 'listen queue'
    4 times the listen queue of a socket overflowed

However, it's too coarse for monitoring and alerting when a user wants to
track errors per socket and route alerts to people responsible for those
sockets directly. For UDP there's udp_fail_queue_rcv_skb, which fills
a similar need for UDP sockets. This patch adds a TCP equivalent.

--

The goal is to use this new tracepoint with ebpf_exporter:

* https://github.com/cloudflare/ebpf_exporter

There's an example configuration for UDP drops there that we use:

* https://github.com/cloudflare/ebpf_exporter/blob/master/examples/udp-drops.bpf.c
* https://github.com/cloudflare/ebpf_exporter/blob/master/examples/udp-drops.yaml

Paolo Abeni asked whether we need the UDP tracepoint given that kfree_skb
and MIB counters already exist, and I covered that part in my reply here:

* https://lore.kernel.org/netdev/CABWYdi3DVex0wq2kM72QTZkhNzkh_Vjb4+T8mj8U7t06Na=5kA@mail.gmail.com/

I added a TCP example utilizing this patch here:

* https://github.com/cloudflare/ebpf_exporter/pull/221

Not so long ago we hit a bug in one of our services that broke its accept
loop, which in resulted in the listen queue overflow. With this new
tracepoint we can have a metric for this and alert the service owners
directly, cutting the middleman SRE and improving the alert fidelity.

We don't really need a tracepoint for this, just a place to hook a kprobe
or an fprobe to. The existing tcp_listendrop is great for this, except
it's a short inlined function, so there's no way to attach a probe to it.

There are a few ways to approach this:

* Un-inline tcp_listendrop to allow probe attachment
* Un-inline tcp_listendrop and add a stable tracepoint
* Keep tcp_listendrop inlined, but add a tracepoint wrapper to call into

There is no option to keep tcp_listendrop inlined and call into tracepoint
directly from it (it does not compile and it wouldn't be nice if it did):

* https://docs.kernel.org/trace/tracepoints.html

Therefore I went with the third option, which this patch implements.

Example output from perf:

    $ sudo perf trace -a -e tcp:tcp_listen_queue_drop
    0.000 sockfull/5459 tcp:tcp_listen_queue_drop(skaddr: 0xffffff90d7a25580, sport: 12345, saddr: 0x7faa1aed26, saddr_v6: 0x7faa1aed2a, sk_max_ack_backlog: 128, sk_ack_backlog: 129)

Example extracting the local port with bpftrace:

    $ sudo ~/projects/bpftrace/src/bpftrace -e 'rawtracepoint:tcp_listen_queue_drop { $sk = (struct sock *) arg0; $lport = $sk->__sk_common.skc_num; printf("drop on lport = %d\n", $lport); }'
    Attaching 1 probe...
    drop on lport = 12345

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 include/net/tcp.h          |  7 ++++++
 include/trace/events/tcp.h | 46 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c             |  7 ++++++
 3 files changed, 60 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 226bce6d1e8c..810ad606641f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -46,6 +46,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/siphash.h>
 #include <linux/net_mm.h>
+#include <linux/tracepoint-defs.h>
 
 extern struct inet_hashinfo tcp_hashinfo;
 
@@ -2259,6 +2260,10 @@ static inline void tcp_segs_in(struct tcp_sock *tp, const struct sk_buff *skb)
 		WRITE_ONCE(tp->data_segs_in, tp->data_segs_in + segs_in);
 }
 
+DECLARE_TRACEPOINT(tcp_listen_queue_drop);
+
+void do_trace_tcp_listen_queue_drop_wrapper(const struct sock *sk);
+
 /*
  * TCP listen path runs lockless.
  * We forced "struct sock" to be const qualified to make sure
@@ -2270,6 +2275,8 @@ static inline void tcp_listendrop(const struct sock *sk)
 {
 	atomic_inc(&((struct sock *)sk)->sk_drops);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
+	if (tracepoint_enabled(tcp_listen_queue_drop))
+		do_trace_tcp_listen_queue_drop_wrapper(sk);
 }
 
 enum hrtimer_restart tcp_pace_kick(struct hrtimer *timer);
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index bf06db8d2046..646ad0bbd378 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -416,6 +416,52 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+TRACE_EVENT(tcp_listen_queue_drop,
+
+	TP_PROTO(const struct sock *sk),
+
+	TP_ARGS(sk),
+
+	TP_STRUCT__entry(
+		__field(const void *, skaddr)
+		__field(__u16, sport)
+		__array(__u8, saddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__field(__u32, sk_max_ack_backlog)
+		__field(__u32, sk_ack_backlog)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+		struct in6_addr *pin6;
+		__be32 *p32;
+
+		__entry->skaddr = sk;
+
+		__entry->sport = ntohs(inet->inet_sport);
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		pin6 = (struct in6_addr *)__entry->saddr_v6;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			*pin6 = sk->sk_v6_rcv_saddr;
+		else
+			ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
+#else
+		ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
+#endif
+
+		__entry->sk_max_ack_backlog = READ_ONCE(sk->sk_max_ack_backlog);
+		__entry->sk_ack_backlog = READ_ONCE(sk->sk_ack_backlog);
+	),
+
+	TP_printk("sport=%hu saddr=%pI4 saddrv6=%pI6c sk_max_ack_backlog=%d sk_ack_backlog=%d",
+		__entry->sport, __entry->saddr, __entry->saddr_v6,
+		__entry->sk_max_ack_backlog, __entry->sk_ack_backlog)
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03e08745308..29ecbc5248c3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -276,6 +276,8 @@
 #include <net/ip.h>
 #include <net/sock.h>
 
+#include <trace/events/tcp.h>
+
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
@@ -1697,6 +1699,11 @@ int tcp_peek_len(struct socket *sock)
 }
 EXPORT_SYMBOL(tcp_peek_len);
 
+void do_trace_tcp_listen_queue_drop_wrapper(const struct sock *sk)
+{
+	trace_tcp_listen_queue_drop(sk);
+}
+
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
 {
-- 
2.41.0

