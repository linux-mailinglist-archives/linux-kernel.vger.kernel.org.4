Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C69D6DCA71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDJSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjDJSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECE2712
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681149982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oA7vC3IC/UfWw/nU7DhHbrgbZ80ejmkeIuMD8WFpxCo=;
        b=fbTea1tvJAl2GOFhdu41ukmwW+eBtEm3GRIPI8gghvEBEGIYB8AdRG/GnZW2xohgtdNLH2
        00LZslQkqYzS1QMiEKBpHY4p5xy/xZw1/iexbrRSs8ims+RTvwJGkLxuhjemXez4xGwmNo
        tTNMUla7+czVS0XIFk6RZbJOWJaPbdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-S3Uh7-YpMo2AMJpLLugL-A-1; Mon, 10 Apr 2023 14:06:18 -0400
X-MC-Unique: S3Uh7-YpMo2AMJpLLugL-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3822985A5B1;
        Mon, 10 Apr 2023 18:06:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA0C492C13;
        Mon, 10 Apr 2023 18:06:17 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] block nbd: use req.cookie instead of req.handle
Date:   Mon, 10 Apr 2023 13:06:10 -0500
Message-Id: <20230410180611.1051618-4-eblake@redhat.com>
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
References: <20230410180611.1051618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NBD spec was recently changed [1] to refer to the opaque client
identifier as a 'cookie' rather than a 'handle', but has for a much
longer time listed it as a 64-bit value, and declares that all values
in the NBD protocol are sent in network byte order (big-endian).

Because the value is opaque to the server, it doesn't usually matter
what endianness we send as the client - as long as we are consistent
that either we byte-swap on both write and read, or on neither, then
we can match server replies back to our requests.  That said, our
internal use of the cookie is as a 64-bit number (well, as two 32-bit
numbers concatenated together), rather than as 8 individual bytes; so
prior to this commit, we ARE leaking the native endianness of our
internals as a client out to the server.  We don't know of any server
that will actually inspect the opaque value and behave differently
depending on whether a little-endian or big-endian client is sending
requests, but since we DO log the cookie value, a wireshark capture of
the network traffic is easier to correlate back to the kernel traffic
of a big-endian host (where the u64 and char[8] representations are
the same) than of a little-endian host (where if wireshark honors the
NBD spec and displays a u64 in network byte order, it is byte-swapped
from what the kernel logged).

The fix in this patch is thus two-part: it now consistently uses
network byte order for the opaque value (no difference to a big-endian
machine, but an extra byteswap on a little-endian machine; probably in
the noise compared to the overhead of network traffic in general), and
now uses a 64-bit integer instead of char[8] as its preferred access
to the opaque value (direct assignment instead of memcpy()).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>

---

v3: squash original 2/5 and 4/5 into one patch, to avoid intermediate
duplication through a tmp variable [Ming].  Josef's R-b added, since
the final outcome of the squash is unchanged.
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..94ae85400b46 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -606,7 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		request.len = htonl(size);
 	}
 	handle = nbd_cmd_handle(cmd);
-	memcpy(request.handle, &handle, sizeof(handle));
+	request.cookie = cpu_to_be64(handle);

 	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

@@ -618,7 +618,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	trace_nbd_header_sent(req, handle);
 	if (result < 0) {
 		if (was_interrupted(result)) {
-			/* If we havne't sent anything we can just return BUSY,
+			/* If we haven't sent anything we can just return BUSY,
 			 * however if we have sent something we need to make
 			 * sure we only allow this req to be sent until we are
 			 * completely done.
@@ -732,7 +732,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	u32 tag;
 	int ret = 0;

-	memcpy(&handle, reply->handle, sizeof(handle));
+	handle = be64_to_cpu(reply->cookie);
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-- 
2.39.2

