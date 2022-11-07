Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0426202BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiKGWzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiKGWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C941571D;
        Mon,  7 Nov 2022 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861688; x=1699397688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WqEb7bkqzB9awU+zIFi5Shc5FWp2eKID0NmWlt0sCJQ=;
  b=PbwsfgymAIVonXFszJxQ2sEZmMInoSMtQugjnXwJaYqcRhjFY6cA2fAd
   MBoM/YYySfXsstmGy9doGRGByne+N2325rzGZ85F7IS0WbYkNDHs6XdDq
   GRaCpqYVQcq1wm/E5tbMJvbImXMEnUMOfXOUF4IPA9305vIYgBMsQOyDV
   EihQq3zfafeti/NXz+ZZZgoYstgEjTsVbO8evxtPDFQlpm1x1GnB6aIIy
   xc1lUnFIeg23oYdQNBM9n0Q1I+ap6pUd5QzDwgjKlepHVJ8pytB6Uzz5a
   fG7/m15TgSzeK2cw/W37Cgo7vavS3LfyPbJ8wOjSFpo4GwvXYMFZg2up/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911836"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012988"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012988"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:47 -0800
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
Subject: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Date:   Mon,  7 Nov 2022 14:53:19 -0800
Message-Id: <20221107225323.2733518-11-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data portion of IFS test image file contains a metadata
region containing possibly multiple metadata structures in
addition to test data and hashes.

Introduce the layout of this meta_data structure and validate
the sanity of certain fields of the new image before loading.

Tweak references to IFS test image chunks to reflect the updated
layout of the test image.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  2 +
 drivers/platform/x86/intel/ifs/load.c | 53 +++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 3ff1d9aaeaa9..98ca91bdd5ca 100644
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
+	int	cur_batch;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 7c0d8602817b..f361fd42a320 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -8,7 +8,23 @@
 
 #include "ifs.h"
 
+struct meta_data {
+	unsigned int meta_type;		// metadata type
+	unsigned int meta_size;		// size of this entire struct including hdrs.
+	unsigned int test_type;		// IFS test type
+	unsigned int fusa_info;		// Fusa info
+	unsigned int total_images;	// Total number of images
+	unsigned int current_image;	// Current Image #
+	unsigned int total_chunks;	// Total number of chunks in this image
+	unsigned int starting_chunk;	// Starting chunk number in this image
+	unsigned int size_per_chunk;	// size of each chunk
+	unsigned int chunks_per_stride;	// number of chunks in a stride
+	unsigned int reserved[54];	// Align to 256 bytes for chunk alignment.
+};
+
 #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
+#define META_TYPE_IFS	1
+#define IFS_CHUNK_ALIGNMENT	256
 static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
@@ -129,6 +145,40 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	complete(&ifs_done);
 }
 
+static int validate_ifs_metadata(struct device *dev)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct meta_data *ifs_meta;
+	char test_file[64];
+	int ret = -EINVAL;
+
+	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
+		 boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
+
+	ifs_meta = (struct meta_data *)ifs_find_meta_data(ifs_header_ptr, META_TYPE_IFS);
+	if (!ifs_meta) {
+		dev_err(dev, "IFS Metadata missing in file %s\n", test_file);
+		return ret;
+	}
+
+	ifs_test_image_ptr = (u64)ifs_meta + sizeof(struct meta_data);
+
+	/* Scan chunk start must be 256 byte aligned */
+	if (!IS_ALIGNED(ifs_test_image_ptr, IFS_CHUNK_ALIGNMENT)) {
+		dev_err(dev, "Scan pattern offset is not 256 byte aligned in %s\n", test_file);
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
@@ -145,6 +195,9 @@ static int scan_chunks_sanity_check(struct device *dev)
 	if (!package_authenticated)
 		return ret;
 
+	ret = validate_ifs_metadata(dev);
+	if (ret)
+		return ret;
 
 	ifsd->loading_error = false;
 	ifsd->loaded_version = ifs_header_ptr->rev;
-- 
2.25.1

