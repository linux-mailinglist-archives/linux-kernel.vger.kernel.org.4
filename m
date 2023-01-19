Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE97674AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjATEgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjATEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFEBCE05
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189242; x=1705725242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9H/TKCUR8aTdpw58Up2LgmeAs0CY/BRgs131VlxrwU=;
  b=GGbLMu+GWjn+N+9hnk1fqQd0WW4trF8lu4YifSr6Ffd3EpAz8hBhjJHY
   +1gUMcYTwcFP88bLoFkH6/vZBLN5LPUlpX5yNAc1Frjdz+2wBkLZO+cJY
   A3r/htzZd4EBozfIU5Zq1uF7AZl1B17gax+KBmxmlxbuBNDmX+WsWeYq4
   rVbYvvBt1vATdxRbSv92E7P9n/u0SnwDOvi3rllAoXW48+nMry7liukkY
   PCcvyoWjMJ/oX9XLA8PT+jd3jka/Aoo13D2yIIh9oq7qfz8ZYDItmfz0L
   tE9MV7SOVTlgdb5PvIjSr9WqmWWBe3rrXkzTVkdEJ87Zn2uhEWLFkedkr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526194"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526194"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988994004"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988994004"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:19 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 6/6] virtio_ring: Prevent bounds check bypass on descriptor index
Date:   Thu, 19 Jan 2023 15:57:21 +0200
Message-Id: <20230119135721.83345-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The descriptor index in virtqueue_get_buf_ctx_split() comes from the
device/VMM.a Use array_index_nospec() to prevent the CPU from speculating
beyond the descriptor array bounds and providing a primitive for building
a side channel.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..c42d070ab68d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/kmsan.h>
@@ -819,6 +820,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u out of range\n", i);
 		return NULL;
 	}
+
+	i = array_index_nospec(i, vq->split.vring.num);
 	if (unlikely(!vq->split.desc_state[i].data)) {
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
-- 
2.39.0

