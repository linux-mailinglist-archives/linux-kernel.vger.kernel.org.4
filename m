Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A671FF54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjFBKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjFBKbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:31:02 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DF2709
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:29:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="107447910"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="107447910"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:09 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 83306CA1F0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76FE4D9A89
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A65F4E4AA6;
        Fri,  2 Jun 2023 19:27:05 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [RFC PATCH v3 3/3] kernel/kexec_file: Mark pmem region with new flag PF_DEV
Date:   Fri,  2 Jun 2023 18:26:52 +0800
Message-Id: <20230602102656.131654-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--6.493600-10.000000
X-TMASE-MatchedRID: 9KRLfRi0EIdXk4HjwySOxx1kSRHxj+Z5W+HVwTKSJIbfghYDxv+lXYyt
        cTfY0Fk5Fcbst+g5Co4SHwgOjzzIf6GGOyqBK41vEXjPIvKd74BMkOX0UoduubgbJOZ434BsXMi
        +6Pt1uebPz9CYF+mMT7BRAkACNnr7lwV2iaAfSWcURSScn+QSXhhJCIHRlO51+gtHj7OwNO0kL2
        NLniq3NW48jxF4hJknuYLQT0SIw8Y4aBTofN3FK6vjRgCarhn/
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pmem, metadata is specific to the namespace rather than the entire
pmem region. Therefore, ranges that have not yet created a namespace or
are unusable due to alignment reasons will not be associated with metadata.

When an application attempts to access regions that do not have
corresponding metadata, it will encounter an access error. With this flag,
the dumping applications are able to know this access error, and then
take special actions correspondingly.

This is kexec_file_load() specific, for the traditional kexec_load(),
kexec-tools will have a similar change.

CC: Eric Biederman <ebiederm@xmission.com>
CC: Baoquan He <bhe@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kernel/kexec_file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..0d5b516b96ee 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,8 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#define PF_DEV (1 << 4)
+
 #ifdef CONFIG_KEXEC_SIG
 static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
 
@@ -1221,6 +1223,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
+static bool is_pmem_range(u64 start, u64 size)
+{
+	return REGION_INTERSECTS == region_intersects(start, size,
+			IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -1302,6 +1310,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
+		if (is_pmem_range(mstart, mend - mstart))
+			phdr->p_flags |= PF_DEV;
 		phdr->p_offset  = mstart;
 
 		phdr->p_paddr = mstart;
-- 
2.29.2

