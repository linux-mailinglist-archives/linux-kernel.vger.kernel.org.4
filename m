Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E485F8A28
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJIIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:36:57 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9281B7FE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 01:36:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VRhMqeJ_1665304608;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VRhMqeJ_1665304608)
          by smtp.aliyun-inc.com;
          Sun, 09 Oct 2022 16:36:52 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jamie@nuviainc.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/resctrl: Clear the stale staged config after the configuration is completed
Date:   Sun,  9 Oct 2022 16:36:48 +0800
Message-Id: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a temporary storage, array staged_config in struct rdt_domain is not
cleared after it has been used. The stale value in staged_config could
cause a MSR access error.

If resctrl is mounted with CDP enabled and then remounted with CDP
disabled, the value of staged_config in domainX via mkdir changes as
follows:

CDP enabled:
mkdir <resource control group>
    domainX.staged_config[CDP_NONE].have_new_ctrl = false
    domainX.staged_config[CDP_NONE].new_ctrl = 0
    domainX.staged_config[CDP_CODE].have_new_ctrl = true
    domainX.staged_config[CDP_CODE].new_ctrl = <default mask>
    domainX.staged_config[CDP_DATA].have_new_ctrl = true
    domainX.staged_config[CDP_CODE].new_ctrl = <default mask>

unmount/remount resctrl (CDP disabled):
mkdir <resource control group>
    domainX.staged_config[CDP_NONE].have_new_ctrl = true
    domainX.staged_config[CDP_NONE].new_ctrl = <default mask>
    domainX.staged_config[CDP_CODE].have_new_ctrl = true      /* stale */
    domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */
    domainX.staged_config[CDP_DATA].have_new_ctrl = true      /* stale */
    domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */

When creating a new resource control group, hardware will be configured by
resctrl_arch_update_domains():
rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()

Since resctrl_arch_update_domains() iterates and updates all
resctrl_conf_type whose have_new_ctrl is true, it will continue to update
the stale CDP_CODE and CDP_DATA configurations when CDP is disabled.

Based on the above analysis, an error can be reproduced on a system with
16 usable CLOSIDs for a 15-way L3 Cache (MBA should be disabled if the
number of CLOSIDs for MB is less than 16.) :
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

As Reinette Chatre explained:
https://lore.kernel.org/all/2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com/
"
 The value of interest here is the register it tries to write to ... 0xca0.
 On a system with 16 CLOSIDs the range of registers available to set the
 CBM would be 0xc90 to 0xc9f that corresponds to CLOSID 0 to CLOSID 15.
 The error is an attempt to write to an unsupported register - there
 appears to have been an attempt to configure non-existent CLOSID 16.

 Above becomes an issue when the resource group being created is for a
 CLOSID # that is more than half of the CLOSIDs supported. In the
 reproducer the issue was encountered when creating resource group for
 CLOSID 8 on a system that supports 16 CLOSIDs.

 In this case get_config_index() called from resctrl_arch_update_domains()
 will return 16 and 17 when processing this resource group and that
 translated to an invalid register - 0xca0 in this scenario.
"

Fix this issue by clearing the staged configs when the configuration is
completed.

Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Suggested-by: Xin Hao <xhao@linux.alibaba.com>
---
Changes since v1:
- Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
- Update the commit message suggested by Reiniette Chatre.
- Add stable tag suggested by James Morse.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1dafbdc5ac31..2c719da5544f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				msr_param.high = max(msr_param.high, idx + 1);
 			}
 		}
+		/* Clear the stale staged config */
+		memset(d->staged_config, 0, sizeof(d->staged_config));
 	}
 
 	if (cpumask_empty(cpu_mask))
-- 
2.27.0

