Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904462B663
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKPJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiKPJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:22:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859D29C89
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668590560; x=1700126560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GTSmWM4/773jpiMFtu9dyGEa5/KxzthxxjZk9qHNbF0=;
  b=c13AzyHPAXzFm4TqW504kPfXGLTzDuNzj0QKXveMWxPasMAdvlSP3vkf
   fUcJdWCXlIfdkSMaE46jmjyy87IWpbs35U3Q/I9o3Hl3W+zSLgQnl4dvh
   +qYpLNqrni8JPD6FKgd2pNSrENdyUaQfqr4wgV23bTF2wrNhaWyeq9Odi
   dtwodWcMwATEqiR/ej1WzblNUO6Ke7IocmEdrEYTbDyhst853MEKZGiHY
   YuHsSL9y+8/j5nwx2Bc/FhITSHoBMjqQOolu3V5A/LGuK9Q9U8PHBnBz2
   16fmQSrWTcSM/AsGpUDh5VFiz1TDVi1oFMUGUw8cN0UU3aNPXWNUfW7f4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314310528"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314310528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 01:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728297924"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728297924"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 01:22:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3BD92F3; Wed, 16 Nov 2022 11:23:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Date:   Wed, 16 Nov 2022 11:22:54 +0200
Message-Id: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
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

After the commits for userspace (see Link tags below) the uuid field is
not being used in the ACRN code. Update kernel to reflect these changes.
I.e. we do the following:
- adding a comment explaining that it's not used anymore
- replacing the specific type by a raw buffer
- updating the example code accordingly

The advertised field confused users and actually never been used. So
the wrong part here is that kernel puts something which userspace never
used and hence this may confuse a reader of this code.

Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
v4: added tag (Rafael), Cc'ed to Greg (missing in the previous version
    by some reason)
v3: converted to Link tags (Rafael), explained what was wrong (Rafael)
v2: added tag (Fei)

 include/uapi/linux/acrn.h | 5 ++---
 samples/acrn/vm-sample.c  | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index ccf47ed92500..04fa83647ae5 100644
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
+ * @uuid:		Reserved (used to be UUID of the VM)
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

