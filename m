Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC873FB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjF0LXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjF0LXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2D10C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3lZgYf4GUx7yLsElB4csYTB1LQXvieCj0NGb4r43Kk=;
        b=GiXBeepRTYsfWFbuS5trU21wnCCJXsIQ9BnCXxzxYCNZ9tDJ+a+rA62gelwjD7l9qKC8hq
        ypmK6ZFU8LJho+9VJ/FS8B/7WdIqM29Gu3n8gfQdjVlgygW1TsYbeKuubOb6mdBf27JktH
        s8lJI9XWWi9YGN2c+OiW03+7npj7uwE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-SGCc500YMA6d6vSpb4530Q-1; Tue, 27 Jun 2023 07:22:36 -0400
X-MC-Unique: SGCc500YMA6d6vSpb4530Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4EBE1C07588;
        Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5588200A3AD;
        Tue, 27 Jun 2023 11:22:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 4/5] virtio-mem: set the timeout for offline_and_remove_memory() to 10 seconds
Date:   Tue, 27 Jun 2023 13:22:19 +0200
Message-Id: <20230627112220.229240-5-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use the default (30 seconds), let's reduce it to 10
seconds. In BBM, we barely deal with blocks larger than 1/2 GiB, and
after 10 seconds it's most probably best to give up on that memory block
and try another one (or retry this one later).

In the common fake-offline case where we effectively fake-offline memory
using alloc_contig_range() first (SBM or BBM with bbm_safe_unplug=on),
we expect offline_and_remove_memory() to be blazingly fast and never take
anywhere close to 10seconds -- so this should only affect BBM with
bbm_safe_unplug=off.

While at it, update the parameter description and the relationship to
unmovable pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f8792223f1db..7468b4a907e3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(bbm_block_size,
 static bool bbm_safe_unplug = true;
 module_param(bbm_safe_unplug, bool, 0444);
 MODULE_PARM_DESC(bbm_safe_unplug,
-	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
+	     "Use a safe/fast unplug mechanism in BBM, failing faster on unmovable pages");
 
 /*
  * virtio-mem currently supports the following modes of operation:
@@ -738,7 +738,7 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
-	rc = offline_and_remove_memory(addr, size, 0);
+	rc = offline_and_remove_memory(addr, size, 10 * MSEC_PER_SEC);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
 		/*
-- 
2.40.1

