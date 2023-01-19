Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999F6740B0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjASSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjASSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:16:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444108EFEB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674152165; x=1705688165;
  h=resent-from:resent-date:resent-message-id:resent-to:from:
   to:cc:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=l9H/TKCUR8aTdpw58Up2LgmeAs0CY/BRgs131VlxrwU=;
  b=VhXjebDFhDVXTpFDZynfznYZ1FP/S/FcDFWTpDtTjy43NsIdaaoM1bqc
   dF0AZFFTT9JYf+6igzfjqfQBpv4wgxx6oBFrX5StKEqcxjL8FgYkQGKQh
   tn6MKxh4C1JNNJNsQ/jQBQvBNEr3uTvwb8ajTnYBgxu9u5tHY0MbpPo6T
   UpaI/E2b1/BA97Cou5YCrseBeM94kKzEWctRWSJ3YqQ7k59aGD5EV3mPv
   bBfYR8UEQjF60Ta1XbbNV6sNZDqQnlDeT//v5uxytCgf0MshTPwiYrKSO
   rqV9zzJqqnsx5oH0YGQHL4QWtRmkL2Wlf2am9CH0oT9+QAqbE2x4vLp0G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305045434"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305045434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:16:04 -0800
X-ExtLoopCount2: 2 from 10.237.72.184
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610158893"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610158893"
Received: from ubik.fi.intel.com (HELO ubik) ([10.237.72.184])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 10:16:04 -0800
Received: from ash by ubik with local (Exim 4.96)
        (envelope-from <alexander.shishkin@intel.com>)
        id 1pIZRw-00EPLa-2Z
        for linux-kernel@vger.kernel.org;
        Thu, 19 Jan 2023 20:15:44 +0200
X-Original-To: alexander.shishkin@linux.intel.com
Received: from linux.intel.com [10.54.29.200]
        by ubik.fi.intel.com with IMAP (fetchmail-6.4.29)
        for <ash@localhost> (single-drop); Thu, 19 Jan 2023 15:59:08 +0200 (EET)
Received: from fmsmga005.fm.intel.com (fmsmga005.fm.intel.com [10.253.24.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6A51B580AE0;
        Thu, 19 Jan 2023 05:57:21 -0800 (PST)
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

