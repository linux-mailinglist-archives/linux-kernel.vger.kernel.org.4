Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635EA65C9B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjACWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjACWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:34:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A2387
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672785267; x=1704321267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gz1Bsl2VXdVsmjjQsG0xEXDmVpr2BN/Ua1eTj70vVD0=;
  b=Ugz7/Tf3kEW8V5m+5PkljJbCRbcwXbKelsmKZZiNWxMr5gRuxeFOZuYC
   ixKD3F4rj72wejZ+aINGK6/8uENHonCgTBsoB172ipxrXOkrdAboT2I5d
   JwA9HHchvtTPeEK1vMuACaO33nzXgxLsP2grcrQHozcNnk5+GNE/I3A6/
   OKGpSmw3i8+X1apmuwPAeBWrGA/n1XT/PplIDgUNOQjD6n0AYFApb8lK7
   KFo6ISs27ti4hCcdyvcxDgqHo7Yt2ARY3/z2YPe5phVMFxyHvlsinEcYs
   dt/gQuHOPa4k3NUnArZlJG1/T+PxNVua+sy/gRRkJoOqbcBUtz5sp3B0F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302148148"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302148148"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 14:34:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779002611"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="779002611"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 14:34:27 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fan Du <fan.du@intel.com>
Subject: [PATCH] x86/mce: Mask out non-address bits from machine check bank
Date:   Tue,  3 Jan 2023 14:34:16 -0800
Message-Id: <20230103223416.310026-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems that support various memory encryption schemes (MKTME, TDX, SEV)
use high order physical address bits to indicate which key should be
used for a specific memory location.

When a memory error is reported, some systems may report those key
bits in the IA32_MCi_ADDR machine check MSR. This is legitimate because
the Intel SDM has a footnote for the contents of the address register
that says: "Useful bits in this field depend on the address methodology
in use when the register state is saved."

Note: I don't know if any AMD systems include key bits in the reported
address, if they do, they also need this fix. If not, it is harmless.

Add a new #define MCI_ADDR_PHYSADDR for the mask of valid physical
address bits within the machine check bank address register. Use this
mask for recoverable machine check handling and in the EDAC driver to
ignore any key bits that may be present.

[Credit: fix is based on those proposed by Fan Du and Isaku Yamahata]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reported-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reported-by: Fan Du <fan.du@intel.com>
---
 arch/x86/include/asm/mce.h     |  3 +++
 arch/x86/kernel/cpu/mce/core.c | 14 +++++++++-----
 drivers/edac/skx_common.c      |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6e986088817d..a8eef87fb12a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -88,6 +88,9 @@
 #define  MCI_MISC_ADDR_MEM	3	/* memory address */
 #define  MCI_MISC_ADDR_GENERIC	7	/* generic */
 
+/* MCi_ADDR register defines */
+#define MCI_ADDR_PHYSADDR	GENMASK(boot_cpu_data.x86_phys_bits - 1, 0)
+
 /* CTL2 register defines */
 #define MCI_CTL2_CMCI_EN		BIT_ULL(30)
 #define MCI_CTL2_CMCI_THRESHOLD_MASK	0x7fffULL
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..949705bdb2f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -579,7 +579,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 	    mce->severity != MCE_DEFERRED_SEVERITY)
 		return NOTIFY_DONE;
 
-	pfn = mce->addr >> PAGE_SHIFT;
+	pfn = (mce->addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
 		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
@@ -1308,6 +1308,7 @@ static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
+	unsigned long pfn;
 	int ret;
 
 	p->mce_count = 0;
@@ -1316,9 +1317,10 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
+	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
+	ret = memory_failure(pfn, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		set_mce_nospec(pfn);
 		sync_core();
 		return;
 	}
@@ -1340,11 +1342,13 @@ static void kill_me_maybe(struct callback_head *cb)
 static void kill_me_never(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	unsigned long pfn;
 
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
+	if (!memory_failure(pfn, 0))
+		set_mce_nospec(pfn);
 }
 
 static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index f0f8e98f6efb..806986f03177 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -657,7 +657,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
-	res.addr = mce->addr;
+	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
 
 	/* Try driver decoder first */
 	if (!(driver_decode && driver_decode(&res))) {
-- 
2.38.1

