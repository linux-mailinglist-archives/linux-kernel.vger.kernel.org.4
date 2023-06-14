Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB572B747
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjFLFZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjFLFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:25:04 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09573DF;
        Sun, 11 Jun 2023 22:25:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VkrnYGX_1686547497;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VkrnYGX_1686547497)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 13:24:58 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/2] perf/core: Bail out early if the request AUX area is out of bound
Date:   Mon, 12 Jun 2023 13:24:51 +0800
Message-Id: <20230612052452.53425-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf-record with a large AUX area, e.g 4GB, it fails with:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

and it reveals a WARNING with __alloc_pages:

[   66.595604] ------------[ cut here ]------------
[   66.600206] WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
[   66.608375] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) aes_ce_blk(E) vfat(E) fat(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
[   66.657719] CPU: 44 PID: 17573 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #58
[   66.666749] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
[   66.674650] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   66.681597] pc : __alloc_pages+0x1ec/0x248
[   66.685680] lr : __kmalloc_large_node+0xc0/0x1f8
[   66.690285] sp : ffff800020523980
[   66.693585] pmr_save: 000000e0
[   66.696624] x29: ffff800020523980 x28: ffff000832975800 x27: 0000000000000000
[   66.703746] x26: 0000000000100000 x25: 0000000000100000 x24: ffff8000083615d0
[   66.710866] x23: 0000000000040dc0 x22: ffff000823d6d140 x21: 000000000000000b
[   66.717987] x20: 000000000000000b x19: 0000000000000000 x18: 0000000000000030
[   66.725108] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff000823d6d6d0
[   66.732229] x14: 0000000000000000 x13: 343373656761705f x12: 726e202c30206574
[   66.739350] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff8000083af570
[   66.746471] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
[   66.753592] x5 : 0000000000000000 x4 : ffff000823d6d8d8 x3 : 0000000000000000
[   66.760713] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
[   66.767834] Call trace:
[   66.770267]  __alloc_pages+0x1ec/0x248
[   66.774003]  __kmalloc_large_node+0xc0/0x1f8
[   66.778259]  __kmalloc_node+0x134/0x1e8
[   66.782081]  rb_alloc_aux+0xe0/0x298
[   66.785643]  perf_mmap+0x440/0x660
[   66.789031]  mmap_region+0x308/0x8a8
[   66.792593]  do_mmap+0x3c0/0x528
[   66.795807]  vm_mmap_pgoff+0xf4/0x1b8
[   66.799456]  ksys_mmap_pgoff+0x18c/0x218
[   66.803365]  __arm64_sys_mmap+0x38/0x58
[   66.807187]  invoke_syscall+0x50/0x128
[   66.810922]  el0_svc_common.constprop.0+0x58/0x188
[   66.815698]  do_el0_svc+0x34/0x50
[   66.818999]  el0_svc+0x34/0x108
[   66.822127]  el0t_64_sync_handler+0xb8/0xc0
[   66.826296]  el0t_64_sync+0x1a4/0x1a8
[   66.829946] ---[ end trace 0000000000000000 ]---

The pages for AUX area are organized as rb->aux_pages[] which alloced by
kcalloc_node() later. The kcalloc() family guarantees the pages are
physically contiguous (and virtually contiguous) with an order of
MAX_ORDER - 1 at maximum.

So bail out early with -EINVAL if the request AUX area is out of bound,
e.g.:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 22 (Invalid argument)

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 kernel/events/core.c                     | 10 ++++++++++
 tools/perf/Documentation/perf-record.txt |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d..83d4e29 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6404,6 +6404,16 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		/*
+		 * The pages for AUX area are organized as rb->aux_pages[]
+		 * which alloced by kcalloc_node() later. The kcalloc() family
+		 * guarantees the pages are physically contiguous (and
+		 * virtually contiguous) with an order of MAX_ORDER - 1 at
+		 * maximum MAX_ORDER. So bail out early if the request AUX area
+		 * is out of bound.
+		 */
+		if (get_order(nr_pages * sizeof(void *)) >= MAX_ORDER)
+			return -EINVAL;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ff815c2..a50a426 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -236,7 +236,8 @@ OPTIONS
 	specification with appended unit character - B/K/M/G. The
 	size is rounded up to have nearest pages power of two value.
 	Also, by adding a comma, the number of mmap pages for AUX
-	area tracing can be specified.
+	area tracing can be specified. With MAX_ORDER set as 11, the
+	maximum AUX area is limit to 2GB.
 
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
-- 
1.8.3.1

