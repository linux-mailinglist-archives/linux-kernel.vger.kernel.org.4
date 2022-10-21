Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A4607FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJUUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJUUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:40:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75458E8F;
        Fri, 21 Oct 2022 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384798; x=1697920798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwUTiUljjWI+BCYf4fGdJwTrdeBzp7WcJvxyFXiS2vo=;
  b=cp4UL0woWU6nXX+mzfrvBhTNegmAXVZ8USV+3mNcigxadOqGRDWAJ5Gb
   /J/vRiFFMrAdTRqv/PwmSG7ES0yQ18t4Gt+S7jKsBb3z9uJwi68ELjh2S
   B66NvBJ1HtK9Kdz0Onp7j0AkjIlrGDCGpV4by5muAtVic+6nx86vPYwBE
   mkQ/lTrVRmh9xmRmYQxD0pftb/P4fHNkdrmJNNOSml0r4Y5ecKDXgB89S
   hXiVF2y+PJOjjOGGUKsoMBo9l6Yn3kaDzysowaN9GWYr3YokHdp/4HnsE
   IQEBijAMvNa6iW96B3buxJpk1Fo9v10VxZCqWtUpeqs/N270jzKGQaM2B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161183"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161183"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701025"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701025"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:35 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 09/14] platform/x86/intel/ifs: Use generic microcode headers and functions
Date:   Fri, 21 Oct 2022 13:34:08 -0700
Message-Id: <20221021203413.1220137-10-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing implementation (broken) of IFS used a header format (for IFS
test images) which was very similar to microcode format, but didn’t
accommodate extended signatures. This meant same IFS test image had to
be duplicated for different steppings and the validation code in the
driver was only looking at the primary header parameters. Going forward
IFS test image headers has been tweaked to become fully compatible with
microcode format.

Newer IFS test image headers will use  microcode_header_intel->hdrver = 2,
so as to distinguish it from microcode images and older IFS test images.

In light of the above, use struct microcode_header_intel directly in
IFS driver instead of duplicating into a separate ifs_header structure.
Further use existing microcode_sanity_check() and find_matching_signature()
directly instead of implementing separate ones within the driver.

More IFS specific checks will be added subsequently.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 102 +++++---------------------
 1 file changed, 19 insertions(+), 83 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index b88db0765311..3cb13a7aa74b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -8,22 +8,9 @@
 
 #include "ifs.h"
 
-struct ifs_header {
-	u32 header_ver;
-	u32 blob_revision;
-	u32 date;
-	u32 processor_sig;
-	u32 check_sum;
-	u32 loader_rev;
-	u32 processor_flags;
-	u32 metadata_size;
-	u32 total_size;
-	u32 fusa_info;
-	u64 reserved;
-};
-
-#define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
-static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header */
+#define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
+#define IFS_HEADER_VER	2
+static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
 static DECLARE_COMPLETION(ifs_done);
@@ -118,33 +105,18 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
  */
 static int scan_chunks_sanity_check(struct device *dev)
 {
-	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
 	struct ifs_data *ifsd = ifs_get_data(dev);
+	int curr_pkg, cpu, ret = -ENOMEM;
 	bool *package_authenticated;
 	struct ifs_work local_work;
-	char *test_ptr;
 
 	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
 	if (!package_authenticated)
 		return ret;
 
-	metadata_size = ifs_header_ptr->metadata_size;
 
-	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
-	if (metadata_size == 0)
-		metadata_size = 2000;
-
-	/* Scan chunk start must be 256 byte aligned */
-	if ((metadata_size + IFS_HEADER_SIZE) % 256) {
-		dev_err(dev, "Scan pattern offset within the binary is not 256 byte aligned\n");
-		return -EINVAL;
-	}
-
-	test_ptr = (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
 	ifsd->loading_error = false;
-
-	ifs_test_image_ptr = (u64)test_ptr;
-	ifsd->loaded_version = ifs_header_ptr->blob_revision;
+	ifsd->loaded_version = ifs_header_ptr->rev;
 
 	/* copy the scan hash and authenticate per package */
 	cpus_read_lock();
@@ -171,67 +143,32 @@ static int scan_chunks_sanity_check(struct device *dev)
 	return ret;
 }
 
-static int ifs_sanity_check(struct device *dev,
-			    const struct microcode_header_intel *mc_header)
+static int ifs_image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
 {
-	unsigned long total_size, data_size;
-	u32 sum, *mc;
-
-	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
+	struct ucode_cpu_info uci;
 
-	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
-		dev_err(dev, "bad ifs data file size.\n");
+	if (data->hdrver != IFS_HEADER_VER) {
+		dev_err(dev, "Header version %d not supported\n", data->hdrver);
 		return -EINVAL;
 	}
 
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
-		dev_err(dev, "invalid/unknown ifs update format.\n");
+	if (microcode_intel_sanity_check((void *)data, true, IFS_HEADER_VER)) {
+		dev_err(dev, "sanity check failed\n");
 		return -EINVAL;
 	}
 
-	mc = (u32 *)mc_header;
-	sum = 0;
-	for (int i = 0; i < total_size / sizeof(u32); i++)
-		sum += mc[i];
+	intel_cpu_collect_info(&uci);
 
-	if (sum) {
-		dev_err(dev, "bad ifs data checksum, aborting.\n");
+	if (!microcode_intel_find_matching_signature((void *)data,
+						     uci.cpu_sig.sig,
+						     uci.cpu_sig.pf)) {
+		dev_err(dev, "cpu signature, pf not matching\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static bool find_ifs_matching_signature(struct device *dev, struct ucode_cpu_info *uci,
-					const struct microcode_header_intel *shdr)
-{
-	unsigned int mc_size;
-
-	mc_size = get_totalsize(shdr);
-
-	if (!mc_size || ifs_sanity_check(dev, shdr) < 0) {
-		dev_err(dev, "ifs sanity check failure\n");
-		return false;
-	}
-
-	if (!intel_cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->sig, shdr->pf)) {
-		dev_err(dev, "ifs signature, pf not matching\n");
-		return false;
-	}
-
-	return true;
-}
-
-static bool ifs_image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
-{
-	struct ucode_cpu_info uci;
-
-	intel_cpu_collect_info(&uci);
-
-	return find_ifs_matching_signature(dev, &uci, data);
-}
-
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
  * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
@@ -252,12 +189,11 @@ int ifs_load_firmware(struct device *dev)
 		goto done;
 	}
 
-	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
-		dev_err(dev, "ifs header sanity check failed\n");
+	ret = ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
+	if (ret)
 		goto release;
-	}
 
-	ifs_header_ptr = (struct ifs_header *)fw->data;
+	ifs_header_ptr = (struct microcode_header_intel *)fw->data;
 	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
 
 	ret = scan_chunks_sanity_check(dev);
-- 
2.25.1

