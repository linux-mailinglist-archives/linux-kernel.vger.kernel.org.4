Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005CC62D212
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiKQECh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiKQEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:01:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2965825C4F;
        Wed, 16 Nov 2022 20:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668657660; x=1700193660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bJNZRB1a44pHjOnEv3/4PjZugHE4Knh67eBC+s5ZKfM=;
  b=SsMNQtPkQZabXqBPGTpJAnQa2jtUFp1mzJbv6RrWqQU9itASEbGjnrkh
   Fi36wlnYYS1LoPha2cuIBCwIrVz7xqcqjhdR/elvTXpZjyh5EBh8k2hzr
   dXk3WomQpAraWFFS5Wg6l7tOfUth6No9rbZkcm7y/vY2+fn5CAiOhNz27
   SmiPBa6L8NzwPGx+CeaKE9UsjySM2p8yqEnjNVvxLNHRm8RuHs69NehLc
   A820udfxGyrh/+KFnAjsQGHP4fA0LUVeNH2fyTPTC7HmoXfiG0glAcUQr
   lKctQwBh3MIE0l+w4lR3Yrk8UaPQ6dZK4ghC05gUAK91Uff07mQ7LrJIj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292455978"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292455978"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590462712"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590462712"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:59 -0800
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
Subject: [PATCH v3 12/16] platform/x86/intel/ifs: Add metadata validation
Date:   Wed, 16 Nov 2022 19:59:31 -0800
Message-Id: <20221117035935.4136738-13-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-1-jithu.joseph@intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data portion of IFS test image file contains a metadata
region containing possibly multiple metadata structures in
addition to test data and hashes.

    IFS Metadata layout
   +----------------------+  0
   |META_TYPE_IFS (=1)    |
   +----------------------+
   |meta_size             |
   +----------------------+
   |test type             |
   +----------------------+
   |fusa info             |
   +----------------------+
   |total images          |
   +----------------------+
   |current image#        |
   +----------------------+
   |total chunks          |
   +----------------------+
   |starting chunk        |
   +----------------------+
   |size per chunk        |
   +----------------------+
   |chunks per stride     |
   +----------------------+
   |Reserved[54]          |
   +----------------------+ 256
   |                      |
   |                      |
   |                      |
   |                      |
   |Test Data/Chunks      |
   |                      |
   |                      |
   |                      |
   |                      |
   +----------------------+  meta_size
   |   META_TYPE_END (=0) |
   +----------------------+  meta_size + 4
   |   size of end (=8)   |
   |                      |
   +----------------------+  meta_size + 8

Introduce the layout of this meta_data structure and validate
the sanity of certain fields of the new image before loading.

Tweak references to IFS test image chunks to reflect the updated
layout of the test image.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  2 +
 drivers/platform/x86/intel/ifs/load.c | 57 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 3a051890d9e7..e3e8210ebd57 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -196,6 +196,7 @@ union ifs_status {
  * @valid_chunks: number of chunks which could be validated.
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
+ * @cur_batch: number indicating the currently loaded test file
  */
 struct ifs_data {
 	int	integrity_cap_bit;
@@ -205,6 +206,7 @@ struct ifs_data {
 	int	valid_chunks;
 	int	status;
 	u64	scan_details;
+	u32	cur_batch;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 6caa98cc6cac..3f1de9d4cf4b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -7,7 +7,25 @@
 
 #include "ifs.h"
 
+#define IFS_CHUNK_ALIGNMENT	256
+union meta_data {
+	struct {
+		u32 meta_type;		// metadata type
+		u32 meta_size;		// size of this entire struct including hdrs.
+		u32 test_type;		// IFS test type
+		u32 fusa_info;		// Fusa info
+		u32 total_images;	// Total number of images
+		u32 current_image;	// Current Image #
+		u32 total_chunks;	// Total number of chunks in this image
+		u32 starting_chunk;	// Starting chunk number in this image
+		u32 size_per_chunk;	// size of each chunk
+		u32 chunks_per_stride;	// number of chunks in a stride
+	};
+	u8 padding[IFS_CHUNK_ALIGNMENT];
+};
+
 #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
+#define META_TYPE_IFS	1
 static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
@@ -128,6 +146,41 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	complete(&ifs_done);
 }
 
+static int validate_ifs_metadata(struct device *dev)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	union meta_data *ifs_meta;
+	char test_file[64];
+	int ret = -EINVAL;
+
+	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
+		 boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
+
+	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
+	if (!ifs_meta) {
+		dev_err(dev, "IFS Metadata missing in file %s\n", test_file);
+		return ret;
+	}
+
+	ifs_test_image_ptr = (u64)ifs_meta + sizeof(union meta_data);
+
+	/* Scan chunk start must be 256 byte aligned */
+	if (!IS_ALIGNED(ifs_test_image_ptr, IFS_CHUNK_ALIGNMENT)) {
+		dev_err(dev, "Scan pattern is not aligned on %d bytes aligned in %s\n",
+			IFS_CHUNK_ALIGNMENT, test_file);
+		return ret;
+	}
+
+	if (ifs_meta->current_image != ifsd->cur_batch) {
+		dev_warn(dev, "Mismatch between filename %s and batch metadata 0x%02x\n",
+			 test_file, ifs_meta->current_image);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * IFS requires scan chunks authenticated per each socket in the platform.
  * Once the test chunk is authenticated, it is automatically copied to secured memory
@@ -140,6 +193,10 @@ static int scan_chunks_sanity_check(struct device *dev)
 	int curr_pkg, cpu, ret;
 
 	memset(ifs_pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
+	ret = validate_ifs_metadata(dev);
+	if (ret)
+		return ret;
+
 	ifsd->loading_error = false;
 	ifsd->loaded_version = ifs_header_ptr->rev;
 
-- 
2.25.1

