Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04CA607009
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJUG1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJUG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:27:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CE4239235
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333660; x=1697869660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzNlDHPI/XFafd7wgVRkw0spwtN78uwxU/YxTQTL/b4=;
  b=mgkf8E9BGeAe+cNX/V+Z3WPyaUUTEilLFru3qB+OGralYqcHIdSKVIj5
   T6fswYsZjd0RAn9RGcKxfuTuFMAb9Yl3xOAXRPeejd7f1WUExDiFRnN1Z
   StTJUEL57lTu3gId6USviViabmlFvJqDdJlyOjzMgclADaUPCQUMzENuU
   6pxZZKCN+5HC0sEfFMu1z7MvTyPAEXHzA4jt2hCMISnYxYKXk5f6X01hw
   M0wf5MeydGMVfEVfwrzjB0JW94DFY0C+KqgpvPN6yX4IVC7Sp4iZY/fym
   ROu/ikLWsLiKzjnbJWl0RskokqsApb42RlCxFOOY1kN4OYmFK7NaMyX17
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286642406"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286642406"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735358035"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735358035"
Received: from d8bbc18b98c6.jf.intel.com ([10.54.241.152])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 23:27:39 -0700
From:   shaoqin.huang@intel.com
To:     mst@redhat.com, jasowang@redhat.com
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Date:   Thu, 20 Oct 2022 23:27:34 -0700
Message-Id: <20221021062734.228881-3-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021062734.228881-1-shaoqin.huang@intel.com>
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Use helper function is_power_of_2() to check if num is power of two.
Minor readability improvement.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..723c4e29e1d3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1052,7 +1052,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	dma_addr_t dma_addr;
 
 	/* We assume num is a power of 2. */
-	if (num & (num - 1)) {
+	if (!is_power_of_2(num)) {
 		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
 		return -EINVAL;
 	}
-- 
2.34.1

