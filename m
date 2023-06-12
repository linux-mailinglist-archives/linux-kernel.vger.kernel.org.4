Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA72272B749
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjFLFZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjFLFZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:25:06 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417AAE1;
        Sun, 11 Jun 2023 22:25:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VkrnYHA_1686547498;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VkrnYHA_1686547498)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 13:25:00 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 2/2] perf/ring_buffer: Fix high-order allocations for AUX space with correct MAX_ORDER limit
Date:   Mon, 12 Jun 2023 13:24:52 +0800
Message-Id: <20230612052452.53425-3-xueshuai@linux.alibaba.com>
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

When perf-record with a large AUX area, e.g 2GB:

    #perf record -C 0 -m ,2G -e arm_spe_0// -- sleep 1

it reveals a WARNING with __alloc_pages:

[   48.888553] ------------[ cut here ]------------
[   48.888559] WARNING: CPU: 39 PID: 17438 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
[   48.888569] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) vfat(E) fat(E) aes_ce_blk(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
[   48.888610] CPU: 39 PID: 17438 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #56
[   48.888613] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
[   48.888614] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   48.888616] pc : __alloc_pages+0x1ec/0x248
[   48.888619] lr : rb_alloc_aux_page+0x78/0xe0
[   48.888622] sp : ffff800037c5b9e0
[   48.888623] pmr_save: 000000e0
[   48.888624] x29: ffff800037c5b9e0 x28: ffff00082743b800 x27: 0000000000000000
[   48.888627] x26: 0000000000080000 x25: ffff000000000000 x24: ffff000860b21380
[   48.888629] x23: ffff8000093fd3c0 x22: ffff00081a4a2080 x21: 000000000000000b
[   48.888631] x20: 0000000000000000 x19: 000000000000000b x18: 0000000000000020
[   48.888634] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff00081a4a2610
[   48.888636] x14: 0000000000000000 x13: 323173656761705f x12: ffff00477fffeb90
[   48.888638] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000083608a0
[   48.888641] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000040
[   48.888643] x5 : 000000000007f400 x4 : 0000000000000000 x3 : 0000000000000000
[   48.888645] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000012dc0
[   48.888648] Call trace:
[   48.888650]  __alloc_pages+0x1ec/0x248
[   48.888653]  rb_alloc_aux_page+0x78/0xe0
[   48.888654]  rb_alloc_aux+0x13c/0x298
[   48.888656]  perf_mmap+0x468/0x688
[   48.888659]  mmap_region+0x308/0x8a8
[   48.888662]  do_mmap+0x3c0/0x528
[   48.888664]  vm_mmap_pgoff+0xf4/0x1b8
[   48.888666]  ksys_mmap_pgoff+0x18c/0x218
[   48.888668]  __arm64_sys_mmap+0x38/0x58
[   48.888671]  invoke_syscall+0x50/0x128
[   48.888673]  el0_svc_common.constprop.0+0x58/0x188
[   48.888674]  do_el0_svc+0x34/0x50
[   48.888676]  el0_svc+0x34/0x108
[   48.888679]  el0t_64_sync_handler+0xb8/0xc0
[   48.888681]  el0t_64_sync+0x1a4/0x1a8
[   48.888686] ---[ end trace 0000000000000000 ]---

The problem is that the high-order pages for AUX area is allocated with
an order of MAX_ORDER. Obviously, this is a bogus.

Fix it with an order of MAX_ORDER - 1 at maximum.

Fixes: 0a4e38e64f5e ("perf: Support high-order allocations for AUX space")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 kernel/events/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 273a0fe..d6bbdb7 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, int order)
 {
 	struct page *page;
 
-	if (order > MAX_ORDER)
-		order = MAX_ORDER;
+	if (order >= MAX_ORDER)
+		order = MAX_ORDER - 1;
 
 	do {
 		page = alloc_pages_node(node, PERF_AUX_GFP, order);
-- 
1.8.3.1

