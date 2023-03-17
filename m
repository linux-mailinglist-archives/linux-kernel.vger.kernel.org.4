Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8626BF28A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCQU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCQU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF6C8319
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMNmNTOdx390ioTe9XNiCAi1NYjBrn3x8X89rBxIitg=;
        b=WazmDTzj2Z3HfpEHD5v0sK5b0QPNEDvzdtjXO2bGsUwSgKcYRdUKjMtylzQfhMI1o79ZyC
        gNcCFKCjHHb8m044X1OeecEAet79kS9WE+qX65bTk7eNFuDAyqlDxpsPs3SG2WS8GDqHj8
        b5DxF0nqugOCzssnvdpQoKtKb/bnkjg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-Mxwocp_hMcOEN5qt7QZfpw-1; Fri, 17 Mar 2023 16:27:58 -0400
X-MC-Unique: Mxwocp_hMcOEN5qt7QZfpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7602999B21;
        Fri, 17 Mar 2023 20:27:57 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E243B492B00;
        Fri, 17 Mar 2023 20:27:56 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] block nbd: use req.cookie instead of req.handle
Date:   Fri, 17 Mar 2023 15:27:48 -0500
Message-Id: <20230317202749.419094-5-eblake@redhat.com>
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A good optimizing compiler should not compile this any differently,
but it is nicer to work directly with integers instead of memcpy().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Fix kernel test robot complaint about wrong endianness on loongarch:
https://lore.kernel.org/oe-kbuild-all/202303121323.Jd35Q1Au-lkp@intel.com/
---
 drivers/block/nbd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8a9487e79f1c..94ae85400b46 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -560,7 +560,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
 	u64 handle;
-	__be64 tmp;
 	u32 type;
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
@@ -607,8 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		request.len = htonl(size);
 	}
 	handle = nbd_cmd_handle(cmd);
-	tmp = cpu_to_be64(handle);
-	memcpy(request.handle, &tmp, sizeof(tmp));
+	request.cookie = cpu_to_be64(handle);

 	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

@@ -729,14 +727,12 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	int result;
 	struct nbd_cmd *cmd;
 	struct request *req = NULL;
-	__be64 tmp;
 	u64 handle;
 	u16 hwq;
 	u32 tag;
 	int ret = 0;

-	memcpy(&tmp, reply->handle, sizeof(tmp));
-	handle = be64_to_cpu(tmp);
+	handle = be64_to_cpu(reply->cookie);
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-- 
2.39.2

