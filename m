Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7973FB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjF0LXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF0LXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2F26AE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+JMX7PmWMV8slSmifeWswXiVAWwIFJBeTLnY9EmnBs=;
        b=bGSWd6LFKSE7dSoY8M4wGHs+aNMASw0bNTE9sYGGFOcBXiYzrwQVJHrLSBLlbatMlM+mxc
        kA1JOpoFBd2flbG6+l2oeQ/UanIh5RgtmWObqoeoLPbAF/+2Hir2GLxWlvpFjtVsqkcsBo
        ic6AgMp1JJQ34wWae6BvJg+ebjGIGcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-_3hHQO3VOiqe86__7AxxGg-1; Tue, 27 Jun 2023 07:22:38 -0400
X-MC-Unique: _3hHQO3VOiqe86__7AxxGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE10B858290;
        Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37C0200A3AD;
        Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
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
Subject: [PATCH v1 5/5] virtio-mem: check if the config changed before (fake) offlining memory
Date:   Tue, 27 Jun 2023 13:22:20 +0200
Message-Id: <20230627112220.229240-6-david@redhat.com>
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

If we repeatedly fail to (fake) offline memory, we won't be sending
any unplug requests to the device. However, we only check if the config
changed when sending such (un)plug requests.

So we could end up trying for a long time to offline memory, even though
the config changed already and we're not supposed to unplug memory
anymore.

Let's optimize for that case, identified while testing the
offline_and_remove() memory timeout and simulating it repeatedly running
into the timeout.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 7468b4a907e3..247fb3e0ce61 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1922,6 +1922,10 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	unsigned long start_pfn;
 	int rc;
 
+	/* Stop fake offlining attempts if the config changed. */
+	if (atomic_read(&vm->config_changed))
+		return -EAGAIN;
+
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
@@ -2233,6 +2237,10 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
 			cond_resched();
 
+			/* Stop (fake) offlining attempts if the config changed. */
+			if (atomic_read(&vm->config_changed))
+				return -EAGAIN;
+
 			/*
 			 * As we're holding no locks, these checks are racy,
 			 * but we don't care.
-- 
2.40.1

