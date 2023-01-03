Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5067A65BE73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjACKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbjACKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD0DF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672743092; x=1704279092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zukvlO7ayucX1PyDrSkH1p1yDhKXLf7pZ9ViBv268Sg=;
  b=Zfx7MmkXB6gpkVmIK0PPGoas+8IDi5c5KLumkTL15In6DhDp1zjNISWW
   w2CTV/CbL5mjgMnlgEHDoSxCQita9fcfuLDoZDLJ5X1g8r/8TtB7Mx/Km
   9yKwiuiAccEYcBXW4L8KSo5IjHlegswPC/xAM1B361wRuy323i/1gMDHX
   mwlGjaGSnBAqxj5/w5ImVRmYybvUOvy0b6RPod3dTHpDsGGVlNY8RjKUH
   j+muTGxsEmm26BZiLFF7H+L+dMEEouenc/Ch2PncspqeW5hRcN0Qf+U84
   g/6iajpHY0xdZ3cFv5xoEDRdIW32mmFodu97PrdI8oWF3ZSMOl4gNCkMn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301318433"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="301318433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604772656"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="604772656"
Received: from isobansk-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.24.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:29 -0800
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 1/4] vdpa: Add resume operation
Date:   Tue,  3 Jan 2023 11:51:05 +0100
Message-Id: <6e05c4b31b47f3e29cb2bd7ebd56c81f84b8f48a.1672742878.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1672742878.git.sebastien.boeuf@intel.com>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
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
2.37.2

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

