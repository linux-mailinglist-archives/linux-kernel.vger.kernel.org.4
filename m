Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707686654F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAKHAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAKHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:00:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31A2DDA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:00:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b17so8324418pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNcGHeECqDQtB1BPvR98d72LqRmvpgPjIP0nqQX8lsE=;
        b=ejhJ3Zj+f0SekNfLrwQnnSDuizXNOfW4s4MWkbAPLJeB2pyADBImtH8IMTDb4BB4/U
         gb7FJBRXBuo4tvALZKoV76/mAMWLTPWs2CqrR66wPJFc+pQE8N6dWkvkGjwZADJsdWBL
         g+od9HUm7lh6cTyYLFzL3C/vp+2TUZ16sYU9lnf3GpCENCS9/kA7C5v5HHF7/HcHcuS8
         0jBYivY71PRdtqaaIv8CwbLlb+ChgFevVCbfCN3l9WLYk46Br/I2Nd92beIa9swgWssT
         bHNSddtvhYtGh5i+4ksMzsdPrIPbLnZppZTNzIjZfr9PEUNn52cl9QkP78vWTD01Z9nx
         QnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNcGHeECqDQtB1BPvR98d72LqRmvpgPjIP0nqQX8lsE=;
        b=Cm8W8tIX441O2p/oTiIPm41WVqpEYsgONmX4TM65Em1r77+zcsFdhVE0XbBuYY7fp+
         hmpY1GsAoF3fktGWcOedzeqxPI/jablIoNE3l0rI+38/sRU1NGnRAXY6eiqYL4CpKOL9
         ujHLtStCL3bQZoJZg4rBvt88AsjBzYJ85IodiCrxolgtgQwpyi2MsadyOdSIubZZsxz3
         ljt0iI+9jZJEpXD1wneV1tIKhcEPKwBU5WjcFnY4u8dkhvsP+BaVLOmBeus+TjlRLUYP
         FnrZDHkVt2x0LG/F0MKpEdtPkNFHVIAwHvsaVIuGmbpH4XAOinSUvjKqYlZsO7Tu11d0
         IDSw==
X-Gm-Message-State: AFqh2krUUWro6mc2n8POsqAOfakl8iUd2nGkgeH6eZo54vQoqGE9y+Xb
        WukFdkFmqDKXPrAHYhv/PO7Kmw==
X-Google-Smtp-Source: AMrXdXumy3ecW/9eHoAvTe5Y6+o43clkz9MjRFV9H9TTK1oKsgD42Q7rksvila0shf2og10+yZTUYw==
X-Received: by 2002:a05:6a20:9589:b0:b0:2070:2ef5 with SMTP id iu9-20020a056a20958900b000b020702ef5mr87433323pzb.22.1673420416321;
        Tue, 10 Jan 2023 23:00:16 -0800 (PST)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79563000000b005769cee6735sm9211463pfq.43.2023.01.10.23.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:00:15 -0800 (PST)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kuniyu@amazon.com, xiyou.wangcong@gmail.com,
        duanxiongchun@bytedance.com, cuiyunhui@bytedance.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dust.li@linux.alibaba.com
Subject: [PATCH v6] sock: add tracepoint for send recv length
Date:   Wed, 11 Jan 2023 14:59:30 +0800
Message-Id: <20230111065930.1494-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 tracepoints to monitor the tcp/udp traffic
of per process and per cgroup.

Regarding monitoring the tcp/udp traffic of each process, there are two
existing solutions, the first one is https://www.atoptool.nl/netatop.php.
The second is via kprobe/kretprobe.

Netatop solution is implemented by registering the hook function at the
hook point provided by the netfilter framework.

These hook functions may be in the soft interrupt context and cannot
directly obtain the pid. Some data structures are added to bind packets
and processes. For example, struct taskinfobucket, struct taskinfo ...

Every time the process sends and receives packets it needs multiple
hashmaps,resulting in low performance and it has the problem fo inaccurate
tcp/udp traffic statistics(for example: multiple threads share sockets).

We can obtain the information with kretprobe, but as we know, kprobe gets
the result by trappig in an exception, which loses performance compared
to tracepoint.

We compared the performance of tracepoints with the above two methods, and
the results are as follows:

ab -n 1000000 -c 1000 -r http://127.0.0.1/index.html
without trace:
Time per request: 39.660 [ms] (mean)
Time per request: 0.040 [ms] (mean, across all concurrent requests)

netatop:
Time per request: 50.717 [ms] (mean)
Time per request: 0.051 [ms] (mean, across all concurrent requests)

kr:
Time per request: 43.168 [ms] (mean)
Time per request: 0.043 [ms] (mean, across all concurrent requests)

tracepoint:
Time per request: 41.004 [ms] (mean)
Time per request: 0.041 [ms] (mean, across all concurrent requests

It can be seen that tracepoint has better performance.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Signed-off-by: Xiongchun Duan <duanxiongchun@bytedance.com>
---
 include/trace/events/sock.h | 45 +++++++++++++++++++++++++++++++++++++
 net/socket.c                | 33 +++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 777ee6cbe933..71492e8276da 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -263,6 +263,51 @@ TRACE_EVENT(inet_sk_error_report,
 		  __entry->error)
 );
 
+/*
+ * sock send/recv msg length
+ */
+DECLARE_EVENT_CLASS(sock_msg_length,
+
+	TP_PROTO(struct sock *sk, int ret, int flags),
+
+	TP_ARGS(sk, ret, flags),
+
+	TP_STRUCT__entry(
+		__field(void *, sk)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, ret)
+		__field(int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->family = sk->sk_family;
+		__entry->protocol = sk->sk_protocol;
+		__entry->ret = ret;
+		__entry->flags = flags;
+	),
+
+	TP_printk("sk address = %p, family = %s protocol = %s, length = %d, error = %d, flags = 0x%x",
+		  __entry->sk, show_family_name(__entry->family),
+		  show_inet_protocol_name(__entry->protocol),
+		  !(__entry->flags & MSG_PEEK) ?
+		  (__entry->ret > 0 ? __entry->ret : 0) : 0,
+		  __entry->ret < 0 ? __entry->ret : 0,
+		  __entry->flags)
+);
+
+DEFINE_EVENT(sock_msg_length, sock_send_length,
+	TP_PROTO(struct sock *sk, int ret, int flags),
+
+	TP_ARGS(sk, ret, flags)
+);
+
+DEFINE_EVENT(sock_msg_length, sock_recv_length,
+	TP_PROTO(struct sock *sk, int ret, int flags),
+
+	TP_ARGS(sk, ret, flags)
+);
 #endif /* _TRACE_SOCK_H */
 
 /* This part must be outside protection */
diff --git a/net/socket.c b/net/socket.c
index 888cd618a968..77626e4d9690 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -106,6 +106,7 @@
 #include <net/busy_poll.h>
 #include <linux/errqueue.h>
 #include <linux/ptp_clock_kernel.h>
+#include <trace/events/sock.h>
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
@@ -709,12 +710,22 @@ INDIRECT_CALLABLE_DECLARE(int inet_sendmsg(struct socket *, struct msghdr *,
 					   size_t));
 INDIRECT_CALLABLE_DECLARE(int inet6_sendmsg(struct socket *, struct msghdr *,
 					    size_t));
+
+static noinline void call_trace_sock_send_length(struct sock *sk, int ret,
+						 int flags)
+{
+	trace_sock_send_length(sk, ret, 0);
+}
+
 static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 {
 	int ret = INDIRECT_CALL_INET(sock->ops->sendmsg, inet6_sendmsg,
 				     inet_sendmsg, sock, msg,
 				     msg_data_left(msg));
 	BUG_ON(ret == -EIOCBQUEUED);
+
+	if (trace_sock_send_length_enabled())
+		call_trace_sock_send_length(sock->sk, ret, 0);
 	return ret;
 }
 
@@ -989,12 +1000,21 @@ INDIRECT_CALLABLE_DECLARE(int inet_recvmsg(struct socket *, struct msghdr *,
 					   size_t, int));
 INDIRECT_CALLABLE_DECLARE(int inet6_recvmsg(struct socket *, struct msghdr *,
 					    size_t, int));
+
+static noinline void call_trace_sock_recv_length(struct sock *sk, int ret, int flags)
+{
+	trace_sock_recv_length(sk, ret, flags);
+}
+
 static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
 				     int flags)
 {
-	return INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
-				  inet_recvmsg, sock, msg, msg_data_left(msg),
-				  flags);
+	int ret = INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
+				     inet_recvmsg, sock, msg,
+				     msg_data_left(msg), flags);
+	if (trace_sock_recv_length_enabled())
+		call_trace_sock_recv_length(sock->sk, ret, flags);
+	return ret;
 }
 
 /**
@@ -1044,6 +1064,7 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
 {
 	struct socket *sock;
 	int flags;
+	int ret;
 
 	sock = file->private_data;
 
@@ -1051,7 +1072,11 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
 	/* more is a combination of MSG_MORE and MSG_SENDPAGE_NOTLAST */
 	flags |= more;
 
-	return kernel_sendpage(sock, page, offset, size, flags);
+	ret = kernel_sendpage(sock, page, offset, size, flags);
+
+	if (trace_sock_send_length_enabled())
+		call_trace_sock_send_length(sock->sk, ret, 0);
+	return ret;
 }
 
 static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
-- 
2.20.1

