Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83395EF9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiI2QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiI2QID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:08:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31271D1E10;
        Thu, 29 Sep 2022 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664467677; x=1696003677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jHn9z+1lv3tK2fXTdGlOlF2iLuZnN9z+U8BA37mZtzw=;
  b=OEl3SdZ0izF//pm2JZVcgRDg6NPD+GutRRvqF7hznjLjrleq1QH8tI23
   Bv4k3KA6+MHdV2Oku2Wcvo1MWIDvj8B9S7fvsc+jUcH/Q+mYvLIcVJljQ
   Acc92czUn7Rz2a0Bvvou1DT5WIDMaMgj2ouCh+FivVrfeVSS45eEMwBT0
   MCY3AKv7PQJDwMBa8MppHqGE3F9qtfeVpI+qAFXD/Wu0LXPvuLWMBwveP
   /sxjgbO+LHOK0T8Bl+JDy39cXj20m4WhdcSz+QRQJX8jY21BaIp9E8/Oe
   dwfGSqXNJz5NRaSbzt1Bqszh24DZg6eATpYTtOeRzdsZVdCnTkelg2OPo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="363786503"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="363786503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:06:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="684897729"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="684897729"
Received: from andyjuye-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.209.4.224])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:06:56 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     ira.weiny@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Date:   Thu, 29 Sep 2022 09:06:46 -0700
Message-Id: <20220929160647.362798-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to disable page faults or preemption when
using kmap calls, so replace kmap_atomic() and kunmap_atomic()
calls with more the more appropriate kmap_local_page() and
kunmap_local() calls.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
 arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f40d64206ded..63dd92bd3288 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 		return ret;
 
 	pginfo.addr = encl_page->desc & PAGE_MASK;
-	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
-	pcmd_page = kmap_atomic(b.pcmd);
+	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
+	pcmd_page = kmap_local_page(b.pcmd);
 	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
 
 	if (secs_page)
@@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	 */
 	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
 
-	kunmap_atomic(pcmd_page);
-	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+	kunmap_local(pcmd_page);
+	kunmap_local((void *)(unsigned long)pginfo.contents);
 
 	get_page(b.pcmd);
 	sgx_encl_put_backing(&b);
@@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 
 	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
 		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
-		pcmd_page = kmap_atomic(b.pcmd);
+		pcmd_page = kmap_local_page(b.pcmd);
 		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
 			pr_warn("PCMD page not empty after truncate.\n");
-		kunmap_atomic(pcmd_page);
+		kunmap_local(pcmd_page);
 	}
 
 	put_page(b.pcmd);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index ebe79d60619f..f2f918b8b9b1 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
 	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
 	pginfo.addr = encl_page->desc & PAGE_MASK;
 	pginfo.metadata = (unsigned long)secinfo;
-	pginfo.contents = (unsigned long)kmap_atomic(src_page);
+	pginfo.contents = (unsigned long)kmap_local_page(src_page);
 
 	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
 
-	kunmap_atomic((void *)pginfo.contents);
+	kunmap_local((void *)pginfo.contents);
 	put_page(src_page);
 
 	return ret ? -EIO : 0;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..4efda5e8cadf 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -159,17 +159,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	pginfo.addr = 0;
 	pginfo.secs = 0;
 
-	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
-	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
+	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
+	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
 			  backing->pcmd_offset;
 
 	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
 	set_page_dirty(backing->pcmd);
 	set_page_dirty(backing->contents);
 
-	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
+	kunmap_local((void *)(unsigned long)(pginfo.metadata -
 					      backing->pcmd_offset));
-	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+	kunmap_local((void *)(unsigned long)pginfo.contents);
 
 	return ret;
 }
-- 
2.37.3

