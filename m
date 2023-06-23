Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDC73C461
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjFWW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjFWW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A103272D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687560943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+/sbivnn4SSL91vpgGdKmYtGhKmLadJeuepui2ZFTU=;
        b=f2r1Qvw3q3oZm88gMz200soN+8EyRgKdgTbBHdw2PEf7wLV1rsluzrQIKj6PTAHpyKNQr8
        1DUAPmZ760u0MF6W4QVxqs3aOxMpirR6CMmmJfq4AuM27rhMTmlsqbn31zoFhiMi8mizSn
        1Spq5+yRyA9IIU34Zuvies3axLVXFAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-lshSpaI8Mri8O6LpAzQ_CA-1; Fri, 23 Jun 2023 18:55:38 -0400
X-MC-Unique: lshSpaI8Mri8O6LpAzQ_CA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B008809F8F;
        Fri, 23 Jun 2023 22:55:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF64940C2063;
        Fri, 23 Jun 2023 22:55:34 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Subject: [PATCH net-next v5 07/16] nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date:   Fri, 23 Jun 2023 23:55:04 +0100
Message-ID: <20230623225513.2732256-8-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transmitting data, call down into TCP using a sendmsg with
MSG_SPLICE_PAGES instead of sendpage.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
Acked-by: Willem de Bruijn <willemb@google.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@fb.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Chaitanya Kulkarni <kch@nvidia.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-nvme@lists.infradead.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #4)
     - Cancel MSG_SPLICE_PAGES if the page being sent fails sendpage_ok().
    
    ver #3)
     - Split nvme/host from nvme/target changes.
    
    ver #2)
     - Wrap lines at 80.

 drivers/nvme/host/tcp.c | 49 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..47ae17f16c05 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -997,25 +997,28 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 	u32 h2cdata_left = req->h2cdata_left;
 
 	while (true) {
+		struct bio_vec bvec;
+		struct msghdr msg = {
+			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+		};
 		struct page *page = nvme_tcp_req_cur_page(req);
 		size_t offset = nvme_tcp_req_cur_offset(req);
 		size_t len = nvme_tcp_req_cur_length(req);
 		bool last = nvme_tcp_pdu_last_send(req, len);
 		int req_data_sent = req->data_sent;
-		int ret, flags = MSG_DONTWAIT;
+		int ret;
 
 		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
-			flags |= MSG_EOR;
+			msg.msg_flags |= MSG_EOR;
 		else
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags |= MSG_MORE;
 
-		if (sendpage_ok(page)) {
-			ret = kernel_sendpage(queue->sock, page, offset, len,
-					flags);
-		} else {
-			ret = sock_no_sendpage(queue->sock, page, offset, len,
-					flags);
-		}
+		if (!sendpage_ok(page))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES,
+
+		bvec_set_page(&bvec, page, len, offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+		ret = sock_sendmsg(queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
@@ -1054,22 +1057,24 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE;
 	else
-		flags |= MSG_EOR;
+		msg.msg_flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1093,6 +1098,8 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_MORE, };
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
@@ -1101,13 +1108,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
 	if (!req->h2cdata_left)
-		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
-	else
-		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE);
+		msg.msg_flags |= MSG_SPLICE_PAGES;
+
+	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
 

