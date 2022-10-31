Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7F16134BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJaLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJaLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:43:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D232203
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:43:43 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N1B4L1Rqyz15MHL;
        Mon, 31 Oct 2022 19:38:42 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 19:43:41 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <tony.luck@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <pbonzini@redhat.com>, <chenyi.qiang@intel.com>,
        <jithu.joseph@intel.com>, <alexs@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: fix undefined behavior in bit shift for intel_detect_tlb
Date:   Mon, 31 Oct 2022 19:43:40 +0800
Message-ID: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/intel.c:948:21
left shift of 1 by 31 places cannot be represented in type 'int'
Call Trace:
 <TASK>
 dump_stack_lvl+0x7d/0xa5
 dump_stack+0x15/0x1b
 ubsan_epilogue+0xe/0x4e
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
 intel_detect_tlb+0x114/0xbd0
 identify_boot_cpu+0x29/0x9e
 check_bugs+0x2f/0x15a5
 start_kernel+0xc3f/0xc78
 x86_64_start_reservations+0x24/0x2a
 x86_64_start_kernel+0xed/0xf8
 secondary_startup_64_no_verify+0xe5/0xeb
 </TASK>

Fixes: e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..121c1c38162a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -945,7 +945,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 
 		/* If bit 31 is set, this is an unknown format */
 		for (j = 0 ; j < 3 ; j++)
-			if (regs[j] & (1 << 31))
+			if (regs[j] & (1U << 31))
 				regs[j] = 0;
 
 		/* Byte 0 is level count, not a descriptor */
-- 
2.25.1

