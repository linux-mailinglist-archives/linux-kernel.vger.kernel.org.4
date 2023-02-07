Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3415268D751
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBGM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBGM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:58:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E823DBD;
        Tue,  7 Feb 2023 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675774714; x=1707310714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WDJpMcDdYBilMJ0Vr9d6MMAORMQnG9SLY+Ss5nORfsM=;
  b=mQe/nkM5y+rlGVkvTRz5QmyaIAAHZ0NAZQll6rNqHedWcrUvZPpiAMFn
   M8b34yPSUIHULV9bTRDgiNdllYKLZGSEPkzCCmG3CScgYxYXUjc4A2KNh
   KMfyMu0e/dxpo5AH5FDTwlFBZbSk0aKysxtnnKAmTWD+iSBZRJPdqTOae
   /hP9BXs37rC/aNgVHwVYCYC54UGLleJ5pGSFL5oTkV14cl3sfFSKirzwh
   IQ8kZg35D6cncJv24ZM2vS6PV7CkmvY5TDtb8ujPPfvUSfbB9M/f+bCGw
   ZzCpILeJR+KwLNxkLPJ5MReUb95aemZF5VGhf3uPS8q25f9HI8ZnIeFW0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331630962"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331630962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 04:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840752267"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="840752267"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2023 04:58:34 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org, david.e.box@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel/vsec: Use mutex for ida_alloc() and ida_free()
Date:   Tue,  7 Feb 2023 04:58:21 -0800
Message-Id: <20230207125821.3837799-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

ID alloc and free functions don't have in built protection for parallel
invocation of ida_alloc() and ida_free(). With the current flow in the
vsec driver, there is no such scenario. But add mutex protection for
potential future changes.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index b936fc5776d7..f1680b7e64f5 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -129,11 +129,16 @@ static void intel_vsec_remove_aux(void *data)
 	auxiliary_device_uninit(data);
 }
 
+static DEFINE_MUTEX(vsec_ida_lock);
+
 static void intel_vsec_dev_release(struct device *dev)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
 
+	mutex_lock(&vsec_ida_lock);
 	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
+	mutex_unlock(&vsec_ida_lock);
+
 	kfree(intel_vsec_dev->resource);
 	kfree(intel_vsec_dev);
 }
@@ -145,7 +150,9 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 	struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
 	int ret, id;
 
+	mutex_lock(&vsec_ida_lock);
 	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
+	mutex_unlock(&vsec_ida_lock);
 	if (ret < 0) {
 		kfree(intel_vsec_dev);
 		return ret;
@@ -161,7 +168,9 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 
 	ret = auxiliary_device_init(auxdev);
 	if (ret < 0) {
+		mutex_lock(&vsec_ida_lock);
 		ida_free(intel_vsec_dev->ida, auxdev->id);
+		mutex_unlock(&vsec_ida_lock);
 		kfree(intel_vsec_dev->resource);
 		kfree(intel_vsec_dev);
 		return ret;
-- 
2.39.1

