Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9E744740
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGAGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGAGjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:39:47 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594A423E;
        Fri, 30 Jun 2023 23:39:37 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7B077120009;
        Sat,  1 Jul 2023 09:28:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7B077120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688192922;
        bh=m9zois+QCrFB15Af+wiZukpNNaD+yGxiy2VOPPrcIAU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=qIJ/oIgjgGzGAhCK4Y+6JfmvwJN8ZZ+c1tti3+FFyEa/pJcJWYNUDr8+zFd0gyTrL
         nXt1suiH31AwYeD657OyY537AaMdDe+TNebr0ZZVprazRlZrAFgqXbBA4WVi5jIyXf
         2yAD/VDAyq1lCpPceP+pOyfx3tumQUi88xiAY+mWTkB2qPnjEIp+VfYeB/muyHXwp8
         9/LpsOC35wYKuIlfDQ/Hfqvf0owqlgIVQ+L+Q5q0/QhX9Lvq3Uc2w8Re0U2eNVvG6c
         WteAJbkaMB7/wEnOo2u8GCDvU8wySMjtc76B0vZGv1ZJI3Epm6iYeGq8XCe9zhw2Lu
         NP3LmolXeNG5g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat,  1 Jul 2023 09:28:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 1 Jul 2023 09:28:19 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
        <avkrasnov@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: [RFC PATCH v5 05/17] vsock/virtio: MSG_ZEROCOPY flag support
Date:   Sat, 1 Jul 2023 09:22:58 +0300
Message-ID: <20230701062310.3397129-6-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230701062310.3397129-1-AVKrasnov@sberdevices.ru>
References: <20230701062310.3397129-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178380 [Jun 30 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/01 00:58:00 #21597365
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds handling of MSG_ZEROCOPY flag on transmission path: if this
flag is set and zerocopy transmission is possible, then non-linear skb
will be created and filled with the pages of user's buffer. Pages of
user's buffer are locked in memory by 'get_user_pages()'. Second thing
that this patch does is replace type of skb owning: instead of calling
'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
of socket, so to decrease this field correctly proper skb destructor is
needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 Changelog:
 v4 -> v5:
  * Remove unused 'vsk' arg from 'virtio_transport_fill_linear_skb()'.
  * Remove old comment 'Returns a new packet on success...'.
  * Commit message update by adding details why this patch uses
    'skb_set_owner_w()' instead of previous 'skb_set_owner_sk_safe()'.
  * 'hdr' variable declaration and assignment in a single line.
  * Rename 'max_skb_cap' to 'max_skb_len'.
  * Use 'info->msg->msg_flags' to check MSG_ZEROCOPY flag  instead of
    field 'flags' of struct 'virtio_vsock_pkt_info'. This was a bug.

 net/vmw_vsock/virtio_transport_common.c | 262 ++++++++++++++++++------
 1 file changed, 200 insertions(+), 62 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dfc48b56d0a2..2269530ea737 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -37,27 +37,99 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
 	return container_of(t, struct virtio_transport, transport);
 }
 
-/* Returns a new packet on success, otherwise returns NULL.
- *
- * If NULL is returned, errp is set to a negative errno.
- */
-static struct sk_buff *
-virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
-			   size_t len,
-			   u32 src_cid,
-			   u32 src_port,
-			   u32 dst_cid,
-			   u32 dst_port)
-{
-	const size_t skb_len = VIRTIO_VSOCK_SKB_HEADROOM + len;
-	struct virtio_vsock_hdr *hdr;
-	struct sk_buff *skb;
+static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *info,
+				       size_t max_to_send)
+{
+	struct iov_iter *iov_iter;
+
+	if (!info->msg)
+		return false;
+
+	iov_iter = &info->msg->msg_iter;
+
+	/* Data is simple buffer. */
+	if (iter_is_ubuf(iov_iter))
+		return true;
+
+	if (!iter_is_iovec(iov_iter))
+		return false;
+
+	if (iov_iter->iov_offset)
+		return false;
+
+	/* We can't send whole iov. */
+	if (iov_iter->count > max_to_send)
+		return false;
+
+	return true;
+}
+
+static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
+					   struct sk_buff *skb,
+					   struct msghdr *msg,
+					   bool zerocopy)
+{
+	struct ubuf_info *uarg;
+
+	if (msg->msg_ubuf) {
+		uarg = msg->msg_ubuf;
+		net_zcopy_get(uarg);
+	} else {
+		struct iov_iter *iter = &msg->msg_iter;
+		struct ubuf_info_msgzc *uarg_zc;
+		int len;
+
+		/* Only ITER_IOVEC or ITER_UBUF are allowed and
+		 * checked before.
+		 */
+		if (iter_is_iovec(iter))
+			len = iov_length(iter->__iov, iter->nr_segs);
+		else
+			len = iter->count;
+
+		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
+					    len,
+					    NULL);
+
+		if (!uarg)
+			return -1;
+
+		uarg_zc = uarg_to_msgzc(uarg);
+		uarg_zc->zerocopy = zerocopy ? 1 : 0;
+	}
+
+	skb_zcopy_init(skb, uarg);
+
+	return 0;
+}
+
+static int virtio_transport_fill_linear_skb(struct sk_buff *skb,
+					    struct virtio_vsock_pkt_info *info,
+					    size_t len)
+{
 	void *payload;
 	int err;
 
-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
+	payload = skb_put(skb, len);
+	err = memcpy_from_msg(payload, info->msg, len);
+	if (err)
+		return -1;
+
+	if (msg_data_left(info->msg))
+		return 0;
+
+	return 0;
+}
+
+static void virtio_transport_init_hdr(struct sk_buff *skb,
+				      struct virtio_vsock_pkt_info *info,
+				      u32 src_cid,
+				      u32 src_port,
+				      u32 dst_cid,
+				      u32 dst_port,
+				      size_t len)
+{
+	struct virtio_vsock_hdr *hdr;
 
 	hdr = virtio_vsock_hdr(skb);
 	hdr->type	= cpu_to_le16(info->type);
@@ -68,42 +140,6 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 	hdr->dst_port	= cpu_to_le32(dst_port);
 	hdr->flags	= cpu_to_le32(info->flags);
 	hdr->len	= cpu_to_le32(len);
-
-	if (info->msg && len > 0) {
-		payload = skb_put(skb, len);
-		err = memcpy_from_msg(payload, info->msg, len);
-		if (err)
-			goto out;
-
-		if (msg_data_left(info->msg) == 0 &&
-		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
-			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
-
-			if (info->msg->msg_flags & MSG_EOR)
-				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
-		}
-	}
-
-	if (info->reply)
-		virtio_vsock_skb_set_reply(skb);
-
-	trace_virtio_transport_alloc_pkt(src_cid, src_port,
-					 dst_cid, dst_port,
-					 len,
-					 info->type,
-					 info->op,
-					 info->flags);
-
-	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
-		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
-		goto out;
-	}
-
-	return skb;
-
-out:
-	kfree_skb(skb);
-	return NULL;
 }
 
 static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
@@ -214,6 +250,79 @@ static u16 virtio_transport_get_type(struct sock *sk)
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
 }
 
+static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
+						  struct virtio_vsock_pkt_info *info,
+						  size_t payload_len,
+						  bool zcopy,
+						  u32 dst_cid,
+						  u32 dst_port,
+						  u32 src_cid,
+						  u32 src_port)
+{
+	struct sk_buff *skb;
+	size_t skb_len;
+
+	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
+
+	if (!zcopy)
+		skb_len += payload_len;
+
+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	virtio_transport_init_hdr(skb, info, src_cid, src_port,
+				  dst_cid, dst_port,
+				  payload_len);
+
+	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
+	 * owner of skb without check to update 'sk_wmem_alloc'.
+	 */
+	if (vsk)
+		skb_set_owner_w(skb, sk_vsock(vsk));
+
+	if (info->msg && payload_len > 0) {
+		int err;
+
+		if (zcopy) {
+			err = __zerocopy_sg_from_iter(info->msg, NULL, skb,
+						      &info->msg->msg_iter,
+						      payload_len);
+		} else {
+			err = virtio_transport_fill_linear_skb(skb, info, payload_len);
+		}
+
+		if (err)
+			goto out;
+
+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off = 0;
+
+		if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
+			struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+
+			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
+
+			if (info->msg->msg_flags & MSG_EOR)
+				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
+		}
+	}
+
+	if (info->reply)
+		virtio_vsock_skb_set_reply(skb);
+
+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
+					 dst_cid, dst_port,
+					 payload_len,
+					 info->type,
+					 info->op,
+					 info->flags);
+
+	return skb;
+out:
+	kfree_skb(skb);
+	return NULL;
+}
+
 /* This function can only be used on connecting/connected sockets,
  * since a socket assigned to a transport is required.
  *
@@ -226,6 +335,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
 	u32 pkt_len = info->pkt_len;
+	bool can_zcopy = false;
+	u32 max_skb_len;
 	u32 rest_len;
 	int ret;
 
@@ -254,22 +365,49 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
 		return pkt_len;
 
+	/* If zerocopy is not enabled by 'setsockopt()', we behave as
+	 * there is no MSG_ZEROCOPY flag set.
+	 */
+	if (info->msg && !sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
+		info->msg->msg_flags &= ~MSG_ZEROCOPY;
+
+	if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY)
+		can_zcopy = virtio_transport_can_zcopy(info, pkt_len);
+
+	if (can_zcopy)
+		max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
+				    (MAX_SKB_FRAGS * PAGE_SIZE));
+	else
+		max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
+
 	rest_len = pkt_len;
 
 	do {
 		struct sk_buff *skb;
 		size_t skb_len;
 
-		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
+		skb_len = min(max_skb_len, rest_len);
 
-		skb = virtio_transport_alloc_skb(info, skb_len,
-						 src_cid, src_port,
-						 dst_cid, dst_port);
+		skb = virtio_transport_alloc_skb(vsk, info, skb_len, can_zcopy,
+						 dst_cid, dst_port,
+						 src_cid, src_port);
 		if (!skb) {
 			ret = -ENOMEM;
 			break;
 		}
 
+		/* This is last skb to send this portion of data. */
+		if (skb_len == rest_len && info->msg &&
+		    info->msg->msg_flags & MSG_ZEROCOPY &&
+		    info->op == VIRTIO_VSOCK_OP_RW) {
+			if (virtio_transport_init_zcopy_skb(vsk, skb,
+							    info->msg,
+							    can_zcopy)) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
+
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb);
@@ -939,11 +1077,11 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!t)
 		return -ENOTCONN;
 
-	reply = virtio_transport_alloc_skb(&info, 0,
-					   le64_to_cpu(hdr->dst_cid),
-					   le32_to_cpu(hdr->dst_port),
+	reply = virtio_transport_alloc_skb(NULL, &info, 0, false,
 					   le64_to_cpu(hdr->src_cid),
-					   le32_to_cpu(hdr->src_port));
+					   le32_to_cpu(hdr->src_port),
+					   le64_to_cpu(hdr->dst_cid),
+					   le32_to_cpu(hdr->dst_port));
 	if (!reply)
 		return -ENOMEM;
 
-- 
2.25.1

