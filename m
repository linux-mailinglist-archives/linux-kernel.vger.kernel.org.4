Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7352562C4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKPQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiKPQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:36:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD88318
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668616176; x=1700152176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nlGqMO/TJSaUCPyTe7kOZmjCa0oFZuyekXsISdQy8Zg=;
  b=h1niWlkFQrmIOArQHXPC8s4KcN7BvBA4nS+pub1AKjAcpaY63jbemU6q
   Nep/16GqxIRUzgbiYcx7za2KEr2eUEYB9XVVvsLD5yOA2WZ52oP6oDCqr
   fXr0Ae0dO6lfvRJftXkt+R0eUX1Af3eeIJTkTrsvIcTOiDynHBUV92qT5
   rR4CO8CEBLR1LJFTvs9oM5M/xVJjB1geMgWud36KVJnEG+m5HW1u8mtp0
   EY1LxYPByY5JIJauh0hveTjS+l0KxnII+gdCpNN/LR36youZUgUAlNnKh
   rniI5B2X8crlraOOHDzsxJNeEKnv3RR6t7TO4RnqtdD6mb+5pGnzUyvcJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292981807"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292981807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728429834"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="728429834"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 08:29:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE8EE2B7; Wed, 16 Nov 2022 18:29:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 1/1] virt: acrn: Mark the uuid field as unused
Date:   Wed, 16 Nov 2022 18:29:56 +0200
Message-Id: <20221116162956.72658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commits for userspace (see Link tags below) the uuid field
is not being used in the ACRN code. Update kernel to reflect these
changes, i.e. do the following:
- adding a comment explaining that it's not used anymore
- replacing the specific type by a raw buffer
- updating the example code accordingly

The advertised field confused users and actually never been used.
So the wrong part here is that kernel puts something which userspace
never used and hence this may confuse a reader of this code.

Note, that there is only a single tool that had been prepared a year
ago for these forthcoming changes in the kernel.

Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
v5: removed Fixes tags (Greg), updated field description (Greg),
    update commit message to show that no tool will be broken (Greg)
v4: added tag (Rafael), Cc'ed to Greg (missing in the previous version                                           
    by some reason)                                                                                              
v3: converted to Link tags (Rafael), explained what was wrong (Rafael)                                           
v2: added tag (Fei)                                                                                              

 include/uapi/linux/acrn.h | 5 ++---
 samples/acrn/vm-sample.c  | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index ccf47ed92500..7b714c1902eb 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -12,7 +12,6 @@
 #define _UAPI_ACRN_H
 
 #include <linux/types.h>
-#include <linux/uuid.h>
 
 #define ACRN_IO_REQUEST_MAX		16
 
@@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
  * @reserved0:		Reserved and must be 0
  * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
  * @reserved1:		Reserved and must be 0
- * @uuid:		UUID of the VM. Pass to hypervisor directly.
+ * @uuid:		Empty space never to be used again (used to be UUID of the VM)
  * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
  * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
  *			hypervisor directly.
@@ -198,7 +197,7 @@ struct acrn_vm_creation {
 	__u16	reserved0;
 	__u16	vcpu_num;
 	__u16	reserved1;
-	guid_t	uuid;
+	__u8	uuid[16];
 	__u64	vm_flag;
 	__u64	ioreq_buf;
 	__u64	cpu_affinity;
diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index b2dad47a77a0..7abd68b20153 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -29,8 +29,6 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
 
 __u16 vcpu_num;
 __u16 vmid;
-/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
-guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
 
 int hsm_fd;
 int is_running = 1;
@@ -63,7 +61,6 @@ int main(int argc, char **argv)
 	}
 	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
 
-	memcpy(&create_vm.uuid, &vm_uuid, 16);
 	create_vm.ioreq_buf = (__u64)io_req_buf;
 	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
 	printf("Created VM! [%d]\n", ret);
-- 
2.35.1

