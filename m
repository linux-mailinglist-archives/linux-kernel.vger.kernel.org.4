Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE960E426
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiJZPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiJZPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:08:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931912347E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666796932; x=1698332932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/VJ/zZxV+j4zvTylkKvQJvW+/QH7d4xZGt7+Trkcoo=;
  b=C6s9+Njiw4Iseaahok1QTFaCimIdHyeutV3JInD/G+kpqG1OxX77hQ46
   E1TBU2+XkEjjf6R9mpfPuS1StS7E/w21yMf5Bym5y+Dz3vFIp7H4BOS+N
   yexsGMeaIyE08HyxRyPcBiV+7kq1NfiK4iOqCFVuxqqNH7qwCS5+sgDqr
   n6NAgioDy9asP6c7qZLYrz4NbKsoaOsHOC7QcOnuVMlhZRUMN6gOw8gq9
   b6i59F4YSwqEN9zHvuiuBaJjUoQLP/axWs4Gj+lwLUNXfftty7zHPzQIl
   EcJ7Wl5ln9o0ql3RPbgy3BArRKp+XweDIWll7CDNoxSLPW0+hwIj8GKVD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="370035946"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="370035946"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961252435"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961252435"
Received: from briansim-mobl.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.29.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:49 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v5 1/4] vdpa: Add resume operation
Date:   Wed, 26 Oct 2022 17:08:35 +0200
Message-Id: <2c10a3b3a52081fc467868e6f2c2b4bdc12584f1.1666796792.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666796792.git.sebastien.boeuf@intel.com>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

