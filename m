Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5F73B6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFWLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFWLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3026B7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687520729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQVg0pnXVfTxPUpA8yd29SmocczyZN6S+xS0BIA8ljI=;
        b=VdG8ckHvYVwC2JEh+I5lL61ZpOyYQ8bfsuZouP5H5UQViHN/l/5PZaCzXBpAvtHyeRarU8
        H83PjEcKOGlU/MZTmDncsR7xb5/s1O8Xsg3Ob7+A+CWztyd/Woqd298rNqZF5Y/Y/xzjWH
        pa2+tu3tp5VYxh7rKMTp3xaVpu2tfG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-Fm_QQgf9PJ2p0L6RUxDWNA-1; Fri, 23 Jun 2023 07:45:26 -0400
X-MC-Unique: Fm_QQgf9PJ2p0L6RUxDWNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0D988E44EF;
        Fri, 23 Jun 2023 11:45:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48F094087C6D;
        Fri, 23 Jun 2023 11:45:21 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        dccp@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-x25@vger.kernel.org,
        mptcp@lists.linux.dev, rds-devel@oss.oracle.com,
        tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux-foundation.org
Subject: [PATCH net-next v4 15/15] net: Kill MSG_SENDPAGE_NOTLAST
Date:   Fri, 23 Jun 2023 12:44:25 +0100
Message-ID: <20230623114425.2150536-16-dhowells@redhat.com>
In-Reply-To: <20230623114425.2150536-1-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ->sendpage() has been removed, MSG_SENDPAGE_NOTLAST can be cleaned
up.  Things were converted to use MSG_MORE instead, but the protocol
sendpage stubs still convert MSG_SENDPAGE_NOTLAST to MSG_MORE, which is now
unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: bpf@vger.kernel.org
cc: dccp@vger.kernel.org
cc: linux-afs@lists.infradead.org
cc: linux-arm-msm@vger.kernel.org
cc: linux-can@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: linux-doc@vger.kernel.org
cc: linux-hams@vger.kernel.org
cc: linux-perf-users@vger.kernel.org
cc: linux-rdma@vger.kernel.org
cc: linux-sctp@vger.kernel.org
cc: linux-wpan@vger.kernel.org
cc: linux-x25@vger.kernel.org
cc: mptcp@lists.linux.dev
cc: netdev@vger.kernel.org
cc: rds-devel@oss.oracle.com
cc: tipc-discussion@lists.sourceforge.net
cc: virtualization@lists.linux-foundation.org
---

Notes:
    ver #3)
     - tcp_bpf is now handled by an earlier patch.

 include/linux/socket.h                         | 4 +---
 net/tls/tls_device.c                           | 3 +--
 net/tls/tls_main.c                             | 2 +-
 net/tls/tls_sw.c                               | 2 +-
 tools/perf/trace/beauty/include/linux/socket.h | 1 -
 tools/perf/trace/beauty/msg_flags.c            | 5 +----
 6 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 58204700018a..39b74d83c7c4 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -319,7 +319,6 @@ struct ucred {
 #define MSG_MORE	0x8000	/* Sender will send more */
 #define MSG_WAITFORONE	0x10000	/* recvmmsg(): block until 1+ packets avail */
 #define MSG_SENDPAGE_NOPOLICY 0x10000 /* sendpage() internal : do no apply policy */
-#define MSG_SENDPAGE_NOTLAST 0x20000 /* sendpage() internal : not the last page */
 #define MSG_BATCH	0x40000 /* sendmmsg(): more messages coming */
 #define MSG_EOF         MSG_FIN
 #define MSG_NO_SHARED_FRAGS 0x80000 /* sendpage() internal : page frags are not shared */
@@ -341,8 +340,7 @@ struct ucred {
 
 /* Flags to be cleared on entry by sendmsg and sendmmsg syscalls */
 #define MSG_INTERNAL_SENDMSG_FLAGS \
-	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_NOTLAST | \
-	 MSG_SENDPAGE_DECRYPTED)
+	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED)
 
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 840ee06f1708..2021fe557e50 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -441,8 +441,7 @@ static int tls_push_data(struct sock *sk,
 	long timeo;
 
 	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
-	      MSG_SPLICE_PAGES))
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SPLICE_PAGES))
 		return -EOPNOTSUPP;
 
 	if (unlikely(sk->sk_err))
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index d5ed4d47b16e..b6896126bb92 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -127,7 +127,7 @@ int tls_push_sg(struct sock *sk,
 {
 	struct bio_vec bvec;
 	struct msghdr msg = {
-		.msg_flags = MSG_SENDPAGE_NOTLAST | MSG_SPLICE_PAGES | flags,
+		.msg_flags = MSG_SPLICE_PAGES | flags,
 	};
 	int ret = 0;
 	struct page *p;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9b3aa89a4292..53f944e6d8ef 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1194,7 +1194,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			       MSG_CMSG_COMPAT | MSG_SPLICE_PAGES |
-			       MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
+			       MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
 	ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 13c3a237b9c9..3bef212a24d7 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -318,7 +318,6 @@ struct ucred {
 #define MSG_MORE	0x8000	/* Sender will send more */
 #define MSG_WAITFORONE	0x10000	/* recvmmsg(): block until 1+ packets avail */
 #define MSG_SENDPAGE_NOPOLICY 0x10000 /* sendpage() internal : do no apply policy */
-#define MSG_SENDPAGE_NOTLAST 0x20000 /* sendpage() internal : not the last page */
 #define MSG_BATCH	0x40000 /* sendmmsg(): more messages coming */
 #define MSG_EOF         MSG_FIN
 #define MSG_NO_SHARED_FRAGS 0x80000 /* sendpage() internal : page frags are not shared */
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index ea68db08b8e7..5cdebd7ece7e 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -8,9 +8,6 @@
 #ifndef MSG_WAITFORONE
 #define MSG_WAITFORONE		   0x10000
 #endif
-#ifndef MSG_SENDPAGE_NOTLAST
-#define MSG_SENDPAGE_NOTLAST	   0x20000
-#endif
 #ifndef MSG_FASTOPEN
 #define MSG_FASTOPEN		0x20000000
 #endif
@@ -50,7 +47,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 	P_MSG_FLAG(NOSIGNAL);
 	P_MSG_FLAG(MORE);
 	P_MSG_FLAG(WAITFORONE);
-	P_MSG_FLAG(SENDPAGE_NOTLAST);
+	P_MSG_FLAG(SPLICE_PAGES);
 	P_MSG_FLAG(FASTOPEN);
 	P_MSG_FLAG(CMSG_CLOEXEC);
 #undef P_MSG_FLAG

