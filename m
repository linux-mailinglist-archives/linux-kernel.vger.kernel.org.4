Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5476BF27F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCQU2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCQU2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F53B878
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwZBg+6O/Oe6TP7FO/stIooN++Hb7G11H2vCfhbvtbY=;
        b=AzbKMxuDmvfzBsdtIK8H5k2DWW5JoJOlTEQ6bXOs3XAzSR/u9z4Qxz54aTT3GF7gLgVK7K
        3AgIoTEsbiKmeY98mJsmvj1RtlaMxRh1BTHFRm4gPt+nkeRcV1RMIepugB0zCzGSbB7oto
        WM5Pu0wblDmr++1LnRtewRCJcUpqs3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-Noqphx4HOairI2HF7qQiGg-1; Fri, 17 Mar 2023 16:27:56 -0400
X-MC-Unique: Noqphx4HOairI2HF7qQiGg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E901F85A5A3;
        Fri, 17 Mar 2023 20:27:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371E3492B00;
        Fri, 17 Mar 2023 20:27:55 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] block nbd: send handle in network order
Date:   Fri, 17 Mar 2023 15:27:46 -0500
Message-Id: <20230317202749.419094-3-eblake@redhat.com>
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NBD spec says the client handle (or cookie) is opaque on the
server, and therefore it really doesn't matter what endianness we use;
to date, the use of memcpy() between u64 and a char[8] has exposed
native endianness when treating the handle as a 64-bit number.
However, since NBD protocol documents that everything else is in
network order, and tools like Wireshark will dump even the contents of
the handle as seen over the network, it's worth using a consistent
ordering regardless of the native endianness.

Plus, using a consistent endianness now allows an upcoming patch to
simplify this to directly use integer assignment instead of memcpy().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch
---
 drivers/block/nbd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..8a9487e79f1c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -560,6 +560,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
 	u64 handle;
+	__be64 tmp;
 	u32 type;
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
@@ -606,7 +607,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		request.len = htonl(size);
 	}
 	handle = nbd_cmd_handle(cmd);
-	memcpy(request.handle, &handle, sizeof(handle));
+	tmp = cpu_to_be64(handle);
+	memcpy(request.handle, &tmp, sizeof(tmp));

 	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

@@ -618,7 +620,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	trace_nbd_header_sent(req, handle);
 	if (result < 0) {
 		if (was_interrupted(result)) {
-			/* If we havne't sent anything we can just return BUSY,
+			/* If we haven't sent anything we can just return BUSY,
 			 * however if we have sent something we need to make
 			 * sure we only allow this req to be sent until we are
 			 * completely done.
@@ -727,12 +729,14 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	int result;
 	struct nbd_cmd *cmd;
 	struct request *req = NULL;
+	__be64 tmp;
 	u64 handle;
 	u16 hwq;
 	u32 tag;
 	int ret = 0;

-	memcpy(&handle, reply->handle, sizeof(handle));
+	memcpy(&tmp, reply->handle, sizeof(tmp));
+	handle = be64_to_cpu(tmp);
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-- 
2.39.2

