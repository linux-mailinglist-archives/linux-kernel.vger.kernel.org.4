Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40B72A74B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjFJBAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjFJA7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:59:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E83AA1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 17:58:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6260b578097so17633466d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686358728; x=1688950728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1vY4qAtc5xUmwIOF/wXuc4xbGrdjFfiVCQ6YVrfe4Y=;
        b=CPB0lHtHpC0VvuE1XUOxtVINK+5k1qVb8FsGYnJckM3/Ks1XlEQoUKE0zegBrEfALJ
         SQtz8S9XlQZroBiFXFi1poXrMRfUi5nVCFE73lzpfTqxv3q0x7QsUrbJuK9Nny8gYyAD
         19dh4c+sYmGEPptwgm8/cvTOs0wSxgv9ggqwYzBIoWNGXG+O27QYrc9w3fQC9rSW17t0
         22UT2Dbl0MOtDJ24lCo1j3rNJCZl+3E5gXrAZHZT5lyu4A7wO6Pw3+U9OYfzGgQ16sy7
         rsQxset4dICcVxssuHh7XsXqhabkT2/Pu2T5IhTDeaIomYFPHbPfdcmIEfEWQg4wfR9/
         D+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358728; x=1688950728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1vY4qAtc5xUmwIOF/wXuc4xbGrdjFfiVCQ6YVrfe4Y=;
        b=g5kuZjv3wOqdhdDH/KSAoR0IhQGTY3p29SjdPOjbRAS8MmtNVy5UzgCDb/z5nGpvLJ
         76YR37qaoZvDFvY7igl3MOTlpq6hhnTwV5yav/X96TbhV7HnnQKM6weLXcl3OCBahLHO
         +UBfKDKBJgQTlSTGT2wJ3GzchPPlfYiapEw3TvW449E/24e6ZlHBIMF+TfIF7I0dKMKd
         Ii0wn+VHDipsw3BFWXmhl5TBsZ3yIb7ELhGtTr761lCZFAIV97UABgsq/HmikkucqAqo
         Nb6PEFC6Gj7b3yguiFAkuUhfVvQJLNYfe/8REt+IlBWTb9U9m2YzXGwUmXhfambSB/6T
         AuDQ==
X-Gm-Message-State: AC+VfDyhAefGi4iGErwtI2Kv+eTWmMcAD/G1AZn7YUnsSWVGM42a06u2
        UFxuAmYSIY3P2cICCil6yG2fyw==
X-Google-Smtp-Source: ACHHUZ7TFSxbJy+liBH3dNJpH+AuvL8DZMKGs4Lwqi6QxHI9rtYXs7508N3ZLZJa9kuqpp+iUlVSGg==
X-Received: by 2002:a05:6214:250e:b0:62b:4e7e:8aba with SMTP id gf14-20020a056214250e00b0062b4e7e8abamr4016793qvb.60.1686358728054;
        Fri, 09 Jun 2023 17:58:48 -0700 (PDT)
Received: from [172.17.0.4] ([130.44.212.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a0ce251000000b00606750abaf9sm1504075qvl.136.2023.06.09.17.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 17:58:47 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Sat, 10 Jun 2023 00:58:31 +0000
Subject: [PATCH RFC net-next v4 4/8] vsock: make vsock bind reusable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the bind table management functions in vsock usable
for different bind tables. For use by datagrams in a future patch.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ef86765f3765..7a3ca4270446 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
+					    struct list_head *bind_table)
 {
 	struct vsock_sock *vsk;
 
-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
+	list_for_each_entry(vsk, bind_table, bound_table) {
 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
 			return sk_vsock(vsk);
 
@@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 	return NULL;
 }
 
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
+}
+
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
 						  struct sockaddr_vm *dst)
 {
@@ -646,12 +652,17 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+static int vsock_bind_common(struct vsock_sock *vsk,
+			     struct sockaddr_vm *addr,
+			     struct list_head *bind_table,
+			     size_t table_size)
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
+	if (table_size < VSOCK_HASH_SIZE)
+		return -1;
+
 	if (!port)
 		port = get_random_u32_above(LAST_RESERVED_PORT);
 
@@ -667,7 +678,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!vsock_find_bound_socket_common(&new_addr,
+							    &bind_table[VSOCK_HASH(addr)])) {
 				found = true;
 				break;
 			}
@@ -684,7 +696,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (vsock_find_bound_socket_common(&new_addr,
+						   &bind_table[VSOCK_HASH(addr)]))
 			return -EADDRINUSE;
 	}
 
@@ -696,11 +709,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	 * by AF_UNIX.
 	 */
 	__vsock_remove_bound(vsk);
-	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
+	__vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
 
 	return 0;
 }
 
+static int __vsock_bind_connectible(struct vsock_sock *vsk,
+				    struct sockaddr_vm *addr)
+{
+	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
+}
+
 static int __vsock_bind_dgram(struct vsock_sock *vsk,
 			      struct sockaddr_vm *addr)
 {

-- 
2.30.2

