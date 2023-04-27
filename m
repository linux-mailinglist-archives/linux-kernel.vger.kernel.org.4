Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3D6F041C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbjD0KUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243369AbjD0KUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:20:10 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85255B7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:20:05 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="94534342"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="94534342"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:18:54 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 52709D66A0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:52 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DC8F16E60
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:51 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9369C114147F;
        Thu, 27 Apr 2023 19:18:49 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     x86@kernel.org, nvdimm@lists.linux.dev, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, ruansy.fnst@fujitsu.com,
        Li Zhijian <lizhijian@fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH v2 kexec-tools] kexec: Add and mark pmem region into PT_LOADs
Date:   Thu, 27 Apr 2023 18:18:35 +0800
Message-Id: <20230427101838.12267-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--6.121700-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cNSuJfEWZSQfBmCYUYerLHrwTlc9CcHMZerwqxtE531VIpb
        wG9fIuITIqMWro5FhUiisum7bT5AftDFhoVadDNxfUkgDiuGxn/jmgMQ17h56yS30GKAkBxWCu1
        ja6drUTmG9aEScwNGm4Ay6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuUiwP+xLbq3AxYM
        d1N0VknfHRdUVXE7DT6INmePPYNPFgO21BQaodlQ==
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
1. Add pmem region into PT_LOADs of vmcore
2. Mark pmem region's p_flags as PF_DEV

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
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

