Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842873FB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjF0LXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjF0LXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E219BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aSs18Pv+ZzmA9Rj2C8nVvP+WDMPcyKRh1O4HH29Hbc=;
        b=UxMLV7NXxKfMBIB8ihBPl41p2B78V9brNMBlt9O88KEvSPZiX4hruIpfF+YjAkTUeztWNP
        w2hAfmnOWT9EuktczMQEJFH8pNceobzXiuDlJh3pDKDbLY4H8c9rySH2hBAdVEQNcnbu7V
        VKBvkBZ7wAGq2Ps9DdQY9kuCNcYXenU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-y_sQWVhBPMapPH_5wxp9qg-1; Tue, 27 Jun 2023 07:22:32 -0400
X-MC-Unique: y_sQWVhBPMapPH_5wxp9qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5553814947;
        Tue, 27 Jun 2023 11:22:31 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30867200A3AD;
        Tue, 27 Jun 2023 11:22:30 +0000 (UTC)
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
Subject: [PATCH v1 2/5] virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
Date:   Tue, 27 Jun 2023 13:22:17 +0200
Message-Id: <20230627112220.229240-3-david@redhat.com>
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

Let's prepare for offline_and_remove_memory() to return other error
codes that effectively translate to -EBUSY, such as -ETIMEDOUT.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb66..cb8bc6f6aa90 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -750,7 +750,15 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		dev_dbg(&vm->vdev->dev,
 			"offlining and removing memory failed: %d\n", rc);
 	}
-	return rc;
+
+	switch (rc) {
+	case 0:
+	case -ENOMEM:
+	case -EINVAL:
+		return rc;
+	default:
+		return -EBUSY;
+	}
 }
 
 /*
-- 
2.40.1

