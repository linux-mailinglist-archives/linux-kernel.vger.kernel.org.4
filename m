Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4711271FF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjFBKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbjFBKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:31:24 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F102D41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:29:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119282616"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="119282616"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:10 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 06211D3EA3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CDCFD67D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 43003E4AAF;
        Fri,  2 Jun 2023 19:27:06 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH kexec-tools v3 1/1] kexec: Add and mark pmem region into PT_LOADs
Date:   Fri,  2 Jun 2023 18:26:53 +0800
Message-Id: <20230602102656.131654-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--7.038100-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2tSuJfEWZSQfA0QY5VnQyANm0H2L3kjQgpOmq2IYpeEBtfG
        u/3wXym7PHFWBoH6D4ycFX6mBx5z38fdkIlEiI2kRcGHEV0WBxCycrvYxo9Kp742hLbi424DvwU
        evDt+uW5/XjpbSJS7a86BcTqviA1zfbpIB/11M574Zi3x/9WFO9DEMPvvoocvo/gdx29vvKfIU7
        MLOn2QZlafBRDsN6GPgFK2nmPCAnkfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPC2A5+imUXo05G7e
        yF+PNMDxJCK7NkLnfyBYhxJ1cjIzsdLFNEgDIsW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does:
1. Add pmem region into PT_LOADs of vmcore so that pmem region is
   dumpable
Only the region described by PT_LOADs of /proc/vmcore are dumpable/readble
by dumping applications. Previously, on x86/x86_64 only system ram resources
will be injected into PT_LOADs.
So in order to make the entire pmem resource is dumpable/readable, we need
to add pmem region into the PT_LOADs of /proc/vmcore.

2. Mark pmem region's p_flags as PF_DEV so that we are able to ignore
   the specific pages
For pmem, metadata is specific to the namespace rather than the entire
pmem region. Therefore, ranges that have not yet created a namespace or
are unusable due to alignment reasons will not be associated with metadata.

When an application attempts to access regions that do not have
corresponding metadata, it will encounter an access error. With this flag,
the dumping applications are able to know this access error, and then
take special actions correspondingly.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kexec/crashdump-elf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index b8bb686a17ca..ab257e825187 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -25,6 +25,8 @@ do {									\
 } while(0)
 #endif
 
+#define PF_DEV (1 << 4)
+
 /* Prepares the crash memory headers and stores in supplied buffer. */
 int FUNC(struct kexec_info *info,
 	 struct crash_elf_info *elf_info,
@@ -199,7 +201,7 @@ int FUNC(struct kexec_info *info,
 	 * A seprate program header for Backup Region*/
 	for (i = 0; i < ranges; i++, range++) {
 		unsigned long long mstart, mend;
-		if (range->type != RANGE_RAM)
+		if (range->type != RANGE_RAM && range->type != RANGE_PMEM)
 			continue;
 		mstart = range->start;
 		mend = range->end;
@@ -209,6 +211,8 @@ int FUNC(struct kexec_info *info,
 		bufp += sizeof(PHDR);
 		phdr->p_type	= PT_LOAD;
 		phdr->p_flags	= PF_R|PF_W|PF_X;
+		if (range->type == RANGE_PMEM)
+			phdr->p_flags |= PF_DEV;
 		phdr->p_offset	= mstart;
 
 		if (mstart == info->backup_src_start
-- 
2.29.2

