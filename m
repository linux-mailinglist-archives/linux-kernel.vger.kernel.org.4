Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA371FF5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjFBKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjFBKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:31:04 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 03:29:22 PDT
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0B2710
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:29:22 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119282617"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="119282617"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:11 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 860F3CA1EB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE6A1D9A89
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CC25FE4ABD;
        Fri,  2 Jun 2023 19:27:07 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH makedumpfile v3 2/3] makedumpfile.c: Exclude all pmem pages
Date:   Fri,  2 Jun 2023 18:26:55 +0800
Message-Id: <20230602102656.131654-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--6.321800-10.000000
X-TMASE-MatchedRID: CCHfsHgEWa2BgK4uB6zi2wI0yP/uoH+D2+EDPw+8xrdJEjJjpEhCnwFV
        KntB9/BKIvrftAIhWmLy9zcRSkKatUAhvNB5B6uKzfqlpbtmcWgAPNCUrAcH+yS30GKAkBxW58T
        g0a5Ro0fiJKINn1ydSUNghIQqhUBNP7A6mmzUskCp3Btb1bH20NY3ddD/vCxPkHPVkBTu31P8bd
        qAerXT9wzx9NgblERANGy+MoqzZ01DQYe+1GQPNbrbxxduc6FPfS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTtH/zyL+gBqiwKmTdg1dVt31KQTaEXmx8EEvFiRzb4CfQizqc5rHUqnQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, the pmem is too large to suitable to be dumped. Further, only
the namespace of the pmem is dumpable, but actually currently we have no
idea the excatly layout of the namespace in pmem. So we exclude all of
them temporarily. And later, we will try to support including/excluding
metadata by specific parameter.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 makedumpfile.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cadc59662bef..f304f752b0ec 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -100,6 +100,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_pmem_userdata;
 mdf_pfn_t pfn_elf_excluded;
 
 mdf_pfn_t num_dumped;
@@ -6389,6 +6390,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	unsigned int is_pmem;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6443,6 +6445,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 				continue;
 		}
 
+		is_pmem = is_pmem_pt_load_range(pfn << PAGESHIFT(), (pfn + 1) << PAGESHIFT());
+		if (is_pmem) {
+			pfn_pmem_userdata++;
+			clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle);
+			continue;
+		}
+
 		index_pg = pfn % PGMM_CACHED;
 		pcache  = page_cache + (index_pg * SIZE(page));
 
@@ -8122,7 +8131,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9460,7 +9469,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10408,7 +10417,7 @@ print_report(void)
 	 */
 	pfn_original = info->max_mapnr - pfn_memhole;
 
-	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
 	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 
 	REPORT_MSG("\n");
@@ -10425,6 +10434,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    pmem userdata pages     : 0x%016llx\n", pfn_pmem_userdata);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10464,7 +10474,7 @@ print_mem_usage(void)
 	*/
 	pfn_original = info->max_mapnr - pfn_memhole;
 
-	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
 	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
-- 
2.29.2

