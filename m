Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6267B96A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjAYSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAYSes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:34:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F865B1;
        Wed, 25 Jan 2023 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674671687; x=1706207687;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=DLIRvXMdKH0hTEcM4b9xtXkEm+HmcMdb8x6cxdoVsZE=;
  b=iYf6/UAaBbqSqOaYgFEKzCmYUfTe13UmSd957x8mBTP/ZrJ9VI3Xiprv
   KWO0r2bCuMzfCXsk9xjJDsxEr1NPKRDBe0Yks/EsgHsLNPKUdepGtVFzR
   DmjJGWN3aCfSeiGQty9CrjnupsmImVNX3GmNeBfwEoChldH10mSoRV/Rz
   EFS1AFm0db8O1PK7VAq9vj1f7e9x7W/V0bwwIEQPEsdsOtFCw+/1Khbvs
   8gFN2bVAFhZOoTZaDGE2o2Rmv/RgNt3A3333eQ8KobIUqphHPqltlDm6G
   DSzdUPFH8kjmH7hU+UYTWo0B3tGaKYtGhsFJOc/eQo9r6Qfd1/oBvk+j7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326666759"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326666759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:34:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991364139"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="991364139"
Received: from ssgirme-mobl2.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.29.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:34:42 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 25 Jan 2023 11:34:18 -0700
Subject: [PATCH] ACPI: NFIT: fix a potential deadlock during NFIT teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-acpi_nfit_lockdep-v1-1-660be4dd10be@intel.com>
X-B4-Tracking: v=1; b=H4sIACl20WMC/x2N0QqDMAwAf0XybMF2orBfGSI1TWdYiaVVGYj/v
 rDHOzjugkqFqcKzuaDQyZU3UbBtA7h6eZPhoAyuc4/OWmc8Zp4l8j6nDT+BsnFDH8bYWxpwBO0
 WX8ksxQuuWsqRkspcKPL3P3pN9/0Dl7n4oXgAAAA=
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=DLIRvXMdKH0hTEcM4b9xtXkEm+HmcMdb8x6cxdoVsZE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkXy2yffTuc+V6KKz1C4fa1Faa1n8o2zJpZLXP+iUVD0CGH
 A53sHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZhI80OG/14hX3uXHj5xR2C3zXk5sf
 WnZTkve4hrRoR79jwS+bzokzYjQ+PrnLkVX0xWS0wxjlJUEHHv00yP5QvvK2b04Xvgyb2FFwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep reports that acpi_nfit_shutdown() may deadlock against an
opportune acpi_nfit_scrub(). acpi_nfit_scrub () is run from inside a
'work' and therefore has already acquired workqueue-internal locks. It
also acquiires acpi_desc->init_mutex. acpi_nfit_shutdown() first
acquires init_mutex, and was subsequently attempting to cancel any
pending workqueue items. This reversed locking order causes a potential
deadlock:

    ======================================================
    WARNING: possible circular locking dependency detected
    6.2.0-rc3 #116 Tainted: G           O     N
    ------------------------------------------------------
    libndctl/1958 is trying to acquire lock:
    ffff888129b461c0 ((work_completion)(&(&acpi_desc->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x43/0x450

    but task is already holding lock:
    ffff888129b460e8 (&acpi_desc->init_mutex){+.+.}-{3:3}, at: acpi_nfit_shutdown+0x87/0xd0 [nfit]

    which lock already depends on the new lock.

    ...

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&acpi_desc->init_mutex);
                                  lock((work_completion)(&(&acpi_desc->dwork)->work));
                                  lock(&acpi_desc->init_mutex);
     lock((work_completion)(&(&acpi_desc->dwork)->work));

    *** DEADLOCK ***

Since the workqueue manipulation is protected by its own internal locking,
the cancellation of pending work doesn't need to be done under
acpi_desc->init_mutex. Move cancel_delayed_work_sync() outside the
init_mutex to fix the deadlock. Any work that starts after
acpi_nfit_shutdown() drops the lock will see ARS_CANCEL, and the
cancel_delayed_work_sync() will safely flush it out.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f1cc5ec6a3b6..4e48d6db05eb 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3297,8 +3297,8 @@ void acpi_nfit_shutdown(void *data)
 
 	mutex_lock(&acpi_desc->init_mutex);
 	set_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
-	cancel_delayed_work_sync(&acpi_desc->dwork);
 	mutex_unlock(&acpi_desc->init_mutex);
+	cancel_delayed_work_sync(&acpi_desc->dwork);
 
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight

---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230112-acpi_nfit_lockdep-264d7f41e6c7

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

