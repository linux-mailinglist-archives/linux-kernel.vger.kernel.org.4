Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8C70B6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjEVHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjEVHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:44:50 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA6FBA;
        Mon, 22 May 2023 00:44:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0FE255FD4E;
        Mon, 22 May 2023 10:44:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684741487;
        bh=/6zO4rnanljCV+CBu4mY/gA1rEcq0GgFnSOnSBQFx3Y=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=feEniHce4Om9Ei6HXjghozSZC7A3xW+F+AhRgv6vqjaUo2bUt7aN0tWg1pSfZan+x
         BA+LjObo40sGONjfv1rQgkKf/+MfbQdiQPRdU2CaCXnpdE5lDrTzhSL3EUEUsVrqae
         GrITdhSS6rT/1UQNXZUoAmX2Y7OkiRuW+M0AH7aB96G/0z8U5rZiGkD1sNh4pP8sLw
         CbcrQDSkg2ZuEdkzJgLElb11Kw5tUlT0SntdeRG3zVtHdtscfDblI3O0favOnllrJW
         etYbyox+FnaxwzOK/GdgNVrbujCWir5uuCk9tM/+r2hdsR/k4oTePAe2pjT/N9TmYw
         QKligwAcJ/cag==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 May 2023 10:44:47 +0300 (MSK)
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
Subject: [RFC PATCH v3 04/17] vsock/virtio: non-linear skb handling for tap
Date:   Mon, 22 May 2023 10:39:37 +0300
Message-ID: <20230522073950.3574171-5-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230522073950.3574171-1-AVKrasnov@sberdevices.ru>
References: <20230522073950.3574171-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/22 04:49:00 #21364689
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For tap device new skb is created and data from the current skb is
copied to it. This adds copying data from non-linear skb to new
the skb.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 16effa8d55d2..9854f48a0544 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 	return NULL;
 }
 
+static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,
+						void *dst,
+						size_t len)
+{
+	struct iov_iter iov_iter = { 0 };
+	struct iovec iovec;
+	size_t to_copy;
+
+	iovec.iov_base = dst;
+	iovec.iov_len = len;
+
+	iov_iter.iter_type = ITER_IOVEC;
+	iov_iter.__iov = &iovec;
+	iov_iter.nr_segs = 1;
+
+	to_copy = min_t(size_t, len, skb->len);
+
+	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
+			       &iov_iter, to_copy);
+}
+
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
@@ -114,7 +135,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	struct af_vsockmon_hdr *hdr;
 	struct sk_buff *skb;
 	size_t payload_len;
-	void *payload_buf;
 
 	/* A packet could be split to fit the RX buffer, so we can retrieve
 	 * the payload length from the header and the buffer pointer taking
@@ -122,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
 	payload_len = pkt->len;
-	payload_buf = pkt->data;
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
@@ -165,7 +184,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
-		skb_put_data(skb, payload_buf, payload_len);
+		if (skb_is_nonlinear(pkt)) {
+			void *data = skb_put(skb, payload_len);
+
+			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
+		} else {
+			skb_put_data(skb, pkt->data, payload_len);
+		}
 	}
 
 	return skb;
-- 
2.25.1

