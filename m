Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A1602723
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJRIiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJRIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:38:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C19F740
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082294; x=1697618294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/VJ/zZxV+j4zvTylkKvQJvW+/QH7d4xZGt7+Trkcoo=;
  b=l96uS4EmYUO3BLTGwChexAWk0zVXAtKM5sy2kKK3J1ondbDbPmPqQmB5
   I6PqKoafoNslnU+PjJzpJnrsLr4ZGVz1J6i6KlpcotYH+AczQlgYlPhTp
   aOoKVBw+fOC98r/CbXZS/RSOhrBHgG0Lp0RjHIiBDiwEgXhQXm/kE0vph
   vGDH0B1juUIRBYG9EkUctUxBrtcSPhZXdcb1mzpoxmkAEgPFPS6AZIEPd
   /ePZo56ybq4+cDNwFtlPLsh1cccf/VcOf2q+VkrcHqF20NLkOb3gFa+1Q
   qcwpm3OnU2vQ+Mek0PLfBifh7lyFYO3DigCgrm0kedOURf+Tl7fGDSsc9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307125502"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307125502"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:37:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753951033"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="753951033"
Received: from aboyhan-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.26.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:37:55 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v4 1/4] vdpa: Add resume operation
Date:   Tue, 18 Oct 2022 10:37:24 +0200
Message-Id: <17c8f9fba6c8533cce013f7613247a527d4eed42.1666082013.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666082013.git.sebastien.boeuf@intel.com>
References: <cover.1666082013.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Add a new operation to allow a vDPA device to be resumed after it has
been suspended. Trying to resume a device that wasn't suspended will
result in a no-op.

This operation is optional. If it's not implemented, the associated
backend feature bit will not be exposed. And if the feature bit is not
exposed, invoking this operation will return an error.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 include/linux/vdpa.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..96d308cbf97b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -219,7 +219,10 @@ struct vdpa_map_file {
  * @reset:			Reset device
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
- * @suspend:			Suspend or resume the device (optional)
+ * @suspend:			Suspend the device (optional)
+ *				@vdev: vdpa device
+ *				Returns integer: success (0) or error (< 0)
+ * @resume:			Resume the device (optional)
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
  * @get_config_size:		Get the size of the configuration space includes
@@ -324,6 +327,7 @@ struct vdpa_config_ops {
 	void (*set_status)(struct vdpa_device *vdev, u8 status);
 	int (*reset)(struct vdpa_device *vdev);
 	int (*suspend)(struct vdpa_device *vdev);
+	int (*resume)(struct vdpa_device *vdev);
 	size_t (*get_config_size)(struct vdpa_device *vdev);
 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
 			   void *buf, unsigned int len);
-- 
2.34.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 5 208 026.16 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

