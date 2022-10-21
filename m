Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5F607FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJUUki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJUUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB54B4AA;
        Fri, 21 Oct 2022 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384796; x=1697920796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxRC+gbPUdUp3j7hZeJ/DbMqthGvlXHYc4JmKqG4KW8=;
  b=g3tjWPgFJxeEwtg7fFAHFp3hPgiTVRVYQ6JRHK6hdLFtk4ooJ4IHJk0C
   hsOTcX1pV/nYXwTvauNYBlr1Zh/f+btTqc5jS4YpzipkWogCCWDWEd7TX
   0K0RdY0g6jgR+isiwvr+tYj1C8C5KdwkSilIKih2M1cRh7rAf/5bz/DmJ
   Lw2YJEX1QorMkEkfrMra/8qmsoUK16v4sD3OcmNH/GSKWe/tZBpKFkBpx
   w/oars13ZcOXnqyNp1Z7vaMaEl67foG93S65uzQ7nla5x7TDtUkJSyvqy
   0qcYmzFjK8aLgDBYlaQZoqSBBX5Asm67GOIU9Z7Tublssy6LEB0BeHtO6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161181"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701017"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701017"
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
Subject: [PATCH 07/14] x86/microcode/intel: Expose microcode_sanity_check()
Date:   Fri, 21 Oct 2022 13:34:06 -0700
Message-Id: <20221021203413.1220137-8-jithu.joseph@intel.com>
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

IFS test image carries the same microcode header as regular Intel
microcode blobs. Microcode blobs  use header version of 1,
whereas IFS test images will use header version of 2.

microcode_sanity_check() can be used by IFS driver to perform
sanity check of the IFS test images too.

Refactor header version as a parameter and expose this function.
Qualify the function name with intel.

No functional change intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/microcode_intel.h |  3 +++
 arch/x86/kernel/cpu/microcode/intel.c  | 14 +++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 33db2a62ed34..27eba991c6b6 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -75,6 +75,7 @@ extern void show_ucode_info_early(void);
 extern int __init save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
 int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
+int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver);
 #else
 static inline __init void load_ucode_intel_bsp(void) {}
 static inline void load_ucode_intel_ap(void) {}
@@ -83,6 +84,8 @@ static inline int __init save_microcode_in_initrd_intel(void) { return -EINVAL;
 static inline void reload_ucode_intel(void) {}
 static inline int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 	{ return 0; }
+static inline int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
+	{ return -EINVAL; }
 #endif
 
 #endif /* _ASM_X86_MICROCODE_INTEL_H */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5473b094baee..bc3f33a25d7a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -37,6 +37,8 @@
 #include <asm/setup.h>
 #include <asm/msr.h>
 
+#define MICROCODE_HEADER_VER 1
+
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
@@ -164,7 +166,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, bool print_err)
+int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
@@ -181,9 +183,10 @@ static int microcode_sanity_check(void *mc, bool print_err)
 		return -EINVAL;
 	}
 
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_ver) {
 		if (print_err)
-			pr_err("Error: invalid/unknown microcode update format.\n");
+			pr_err("Error: invalid/unknown microcode update format. Header version %d\n",
+			       mc_header->hdrver);
 		return -EINVAL;
 	}
 
@@ -261,6 +264,7 @@ static int microcode_sanity_check(void *mc, bool print_err)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(microcode_intel_sanity_check);
 
 /*
  * Get microcode matching with BSP's model. Only CPUs with the same model as
@@ -282,7 +286,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, false) < 0)
+		    microcode_intel_sanity_check(data, false, MICROCODE_HEADER_VER) < 0)
 			break;
 
 		size -= mc_size;
@@ -821,7 +825,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, true) < 0) {
+		    microcode_intel_sanity_check(mc, true, MICROCODE_HEADER_VER) < 0) {
 			break;
 		}
 
-- 
2.25.1

