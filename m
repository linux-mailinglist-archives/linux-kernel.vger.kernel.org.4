Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2F5EB803
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiI0C7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiI0C6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:58:14 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4210FCB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:54:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VQpkEBa_1664247269;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VQpkEBa_1664247269)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 10:54:34 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: Clear the staged configs when destroying schemata list
Date:   Tue, 27 Sep 2022 10:54:29 +0800
Message-Id: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array staged_config in struct rdt_domain still maintains the original value when
resctrl is unmounted. If resctrl is mounted with cdp option and then remounted
without cdp option, field have_new_ctrl in staged_config[CDP_CODE] and
staged_config[CDP_DATA] will still be true. Since resctrl_arch_update_domains()
traverses all resctrl_conf_type, it will continue to update CDP_CODE and
CDP_DATA configurations, which can cause overflow problem.

The problem can be reproduced by the following commands:
    # A system with 16 usable closids and mba disabled
    mount -t resctrl resctrl -o cdp /sys/fs/resctrl
    mkdir /sys/fs/resctrl/p{1..7}
    umount /sys/fs/resctrl/
    mount -t resctrl resctrl /sys/fs/resctrl
    mkdir /sys/fs/resctrl/p{1..8}

dmesg will generate the following error:
    [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
    0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
    [ 6180.951983] Call Trace:
    [ 6180.954516]  <IRQ>
    [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
    [ 6180.962028]  __sysvec_call_function+0x24/0xd0
    [ 6180.966485]  sysvec_call_function+0x89/0xc0
    [ 6180.970760]  </IRQ>
    [ 6180.972947]  <TASK>
    [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
    [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
    [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
    ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
    f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
    [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
    [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
    [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
    [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
    [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
    [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
    [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
    [ 6181.049678]  cpuidle_enter+0x24/0x40
    [ 6181.053370]  do_idle+0x1dd/0x260
    [ 6181.056713]  cpu_startup_entry+0x14/0x20
    [ 6181.060753]  rest_init+0xbb/0xc0
    [ 6181.064097]  arch_call_rest_init+0x5/0xa
    [ 6181.068137]  start_kernel+0x668/0x691
    [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
    [ 6181.077086]  </TASK>

We fix this issue by clearing the staged configs when destroying schemata list.

Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Suggested-by: Xin Hao <xhao@linux.alibaba.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f276aff521e8..b4a817ae83ab 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2127,8 +2127,15 @@ static int schemata_list_create(void)
 static void schemata_list_destroy(void)
 {
 	struct resctrl_schema *s, *tmp;
+	struct rdt_domain *dom;
 
 	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
+		/*
+		 * Clear staged_config on each domain before schemata list is
+		 * destroyed.
+		 */
+		list_for_each_entry(dom, &s->res->domains, list)
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 		list_del(&s->list);
 		kfree(s);
 	}
-- 
2.27.0

