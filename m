Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE1607FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJUUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJUUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:40:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64258E8B;
        Fri, 21 Oct 2022 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384798; x=1697920798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4GA/zUmUAfO1cKUlriGt7rRQ7snnRf1VH62DtYVeQqU=;
  b=F5YEumW103h9PwFevZ8bDQVi2jMiBxPuk74jCeq0YBGAYJQ5bTsRiYGq
   O9cgXw+RnLuIvC2jfB28g9mZ5x0rW1xWUekjAYjjjiPn3UWXOJ5kn+KN4
   cXjevD4wfTKug4ZepdFcTsM8+a5GXg+ZmyeVA0zjlbVaBXzOVpZ8yCw6g
   R5awvpSaHl6gsM2M752pFJ3MpgQqi0k2Ji9Wjns+PQj09nf6Wjy7x5UuN
   UuHfntvcJzhq2HWCCPKsUDMbqsRkNLZa27VreBtPUnH7lXHZdxqmr6Anj
   SETlw0b2M5A/0mJtBzXGps5+prjdLJMBsyutSVHdtOvx0sTdqeIU1lN+b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161184"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701029"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701029"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 10/14] platform/x86/intel/ifs: Add metadata validation
Date:   Fri, 21 Oct 2022 13:34:09 -0700
Message-Id: <20221021203413.1220137-11-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
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

The data portion of IFS test image file contains a meta-data
structure in addition to test data and hashes.

Introduce the layout of this meta_data structure and validate
the sanity of certain fields of the new-image before loading.

Tweak references to IFS test image chunks to reflect the updated
layout of the test image.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  2 +
 drivers/platform/x86/intel/ifs/load.c | 54 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index be37512535f2..bb43fd65d2d2 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -196,6 +196,7 @@ union ifs_status {
  * @valid_chunks: number of chunks which could be validated.
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
+ * @cur_batch: suffix indicating the currently loaded test file
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
index 3cb13a7aa74b..d300cf3ce5bd 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -8,8 +8,24 @@
 
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
 #define IFS_HEADER_VER	2
+#define META_TYPE_IFS	1
+#define IFS_CHUNK_ALIGNMENT	256
 static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
@@ -98,6 +114,41 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
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
+	ifs_meta = (struct meta_data *)microcode_intel_find_meta_data(ifs_header_ptr,
+								      META_TYPE_IFS);
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
+		dev_warn(dev, "Suffix metadata is not matching with filename %s(0x%02x)\n",
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
@@ -114,6 +165,9 @@ static int scan_chunks_sanity_check(struct device *dev)
 	if (!package_authenticated)
 		return ret;
 
+	ret = validate_ifs_metadata(dev);
+	if (ret)
+		return ret;
 
 	ifsd->loading_error = false;
 	ifsd->loaded_version = ifs_header_ptr->rev;
-- 
2.25.1

