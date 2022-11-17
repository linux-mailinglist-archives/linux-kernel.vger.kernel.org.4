Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C162E8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiKQWwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbiKQWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:52:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673317209B;
        Thu, 17 Nov 2022 14:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668725516; x=1700261516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mVyduCExykA+2bwSdGSvpAIft8UkWR80/PgyQPChDY=;
  b=mFGiq0Nrn57mtv/V3yaLiMMohtRdnoXepwU0JCLrNLBk+bjZdMIjThFk
   as/ZTRtiYKsbaUVNpXoxNcqEQ5A25/qy9OlGxynjMLnfeNmVUVO+3yQRM
   7wBBjVVDweRhm+MVZXXBdyMIOWatmUmc1YqxCPmx985Z2T8zwOZpXDCJX
   N5k8Sj0s5uRd03loggE92TWSIoV2K9/NSwjbFnBljt9J7Pq3OBuCaRrpb
   MikqXiQx72XFLmnqg9tzolMmNK9rqb5rUc5ywkzXIVKwK7DiOE+n0BnHQ
   jA/14kOUrlPmLqhiBwN1efnRLrqc6FrOQ6SVjJTGPpwQfFXP29NzoTF51
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313008549"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="313008549"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 14:51:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="969056528"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="969056528"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 14:51:56 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v3 11/16] platform/x86/intel/ifs: Use generic microcode headers and functions
Date:   Thu, 17 Nov 2022 14:50:39 -0800
Message-Id: <20221117225039.30166-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-12-jithu.joseph@intel.com>
References: <20221117035935.4136738-12-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

In light of the above, reuse struct microcode_header_intel directly in
IFS driver and reuse microcode functions for validation and sanity
checking.

More IFS specific checks will be added subsequently.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
  - Rebased to apply alongside the updated 4/16 patch

 arch/x86/include/asm/microcode_intel.h |   1 +
 drivers/platform/x86/intel/ifs/load.c  | 104 +++++--------------------
 2 files changed, 21 insertions(+), 84 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 6af1e703cb2e..f1fa979e05bf 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -43,6 +43,7 @@ struct extended_sigtable {
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
 #define MC_HEADER_TYPE_MICROCODE	1
+#define MC_HEADER_TYPE_IFS		2
 
 #define get_totalsize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 9228da560736..83434160bc4c 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -7,22 +7,8 @@
 
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
+static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
 static DECLARE_COMPLETION(ifs_done);
@@ -149,29 +135,14 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
  */
 static int scan_chunks_sanity_check(struct device *dev)
 {
-	int metadata_size, curr_pkg, cpu, ret;
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	struct ifs_work local_work;
-	char *test_ptr;
-
-	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
-	metadata_size = ifs_header_ptr->metadata_size;
+	int curr_pkg, cpu, ret;
 
-	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
-	if (metadata_size == 0)
-		metadata_size = 2000;
 
-	/* Scan chunk start must be 256 byte aligned */
-	if ((metadata_size + IFS_HEADER_SIZE) % 256) {
-		dev_err(dev, "Scan pattern offset within the binary is not 256 byte aligned\n");
-		return -EINVAL;
-	}
-
-	test_ptr = (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
+	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
 	ifsd->loading_error = false;
-
-	ifs_test_image_ptr = (u64)test_ptr;
-	ifsd->loaded_version = ifs_header_ptr->blob_revision;
+	ifsd->loaded_version = ifs_header_ptr->rev;
 
 	/* copy the scan hash and authenticate per package */
 	cpus_read_lock();
@@ -197,67 +168,33 @@ static int scan_chunks_sanity_check(struct device *dev)
 	return ret;
 }
 
-static int ifs_sanity_check(struct device *dev,
-			    const struct microcode_header_intel *mc_header)
+static int image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
 {
-	unsigned long total_size, data_size;
-	u32 sum, *mc;
-
-	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
+	struct ucode_cpu_info uci;
 
-	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
-		dev_err(dev, "bad ifs data file size.\n");
+	/* Provide a specific error message when loading an older/unsupported image */
+	if (data->hdrver != MC_HEADER_TYPE_IFS) {
+		dev_err(dev, "Header version %d not supported\n", data->hdrver);
 		return -EINVAL;
 	}
 
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
-		dev_err(dev, "invalid/unknown ifs update format.\n");
+	if (intel_microcode_sanity_check((void *)data, true, MC_HEADER_TYPE_IFS)) {
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
+	if (!intel_find_matching_signature((void *)data,
+					   uci.cpu_sig.sig,
+					   uci.cpu_sig.pf)) {
+		dev_err(dev, "cpu signature, processor flags not matching\n");
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
@@ -278,12 +215,11 @@ void ifs_load_firmware(struct device *dev)
 		goto done;
 	}
 
-	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
-		dev_err(dev, "ifs header sanity check failed\n");
+	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
+	if (ret)
 		goto release;
-	}
 
-	ifs_header_ptr = (struct ifs_header *)fw->data;
+	ifs_header_ptr = (struct microcode_header_intel *)fw->data;
 	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
 
 	ret = scan_chunks_sanity_check(dev);
-- 
2.25.1

