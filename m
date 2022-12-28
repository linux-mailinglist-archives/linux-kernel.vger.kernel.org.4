Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F66571E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiL1Byu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiL1ByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:54:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B21005
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:54:20 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NhZMG5rM2z501Qc;
        Wed, 28 Dec 2022 09:54:18 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 2BS1sBhk035276;
        Wed, 28 Dec 2022 09:54:11 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Wed, 28 Dec 2022 09:54:12 +0800 (CST)
Date:   Wed, 28 Dec 2022 09:54:12 +0800 (CST)
X-Zmail-TransId: 2afb63aba1c4fffffffffae57a6b
X-Mailer: Zmail v1.0
Message-ID: <202212280954121197626@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <will@kernel.org>
Cc:     <catalin.marinas@arm.com>, <lkp@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huang.junhua@zte.com.cn>,
        <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBhcm02NC91cHJvYmVzOiBjaGFuZ2UgdGhlIHVwcm9iZV9vcGNvZGVfdCB0eXBlZGVmIHRvIGZpeCB0aGUgc3BhcnNlIHdhcm5pbmc=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BS1sBhk035276
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63ABA1CA.001 by FangMail milter!
X-FangMail-Envelope: 1672192458/4NhZMG5rM2z501Qc/63ABA1CA.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ABA1CA.001/4NhZMG5rM2z501Qc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: junhua huang <huang.junhua@zte.com.cn>

After we fixed the uprobe inst endian in aarch_be, the sparse check report
the following warning info:

sparse warnings: (new ones prefixed by >>)
>> kernel/events/uprobes.c:223:25: sparse: sparse: restricted __le32 degrades to integer
>> kernel/events/uprobes.c:574:56: sparse: sparse: incorrect type in argument 4 (different base types)
@@     expected unsigned int [addressable] [usertype] opcode @@     got restricted __le32 [usertype] @@
   kernel/events/uprobes.c:574:56: sparse:     expected unsigned int [addressable] [usertype] opcode
   kernel/events/uprobes.c:574:56: sparse:     got restricted __le32 [usertype]
>> kernel/events/uprobes.c:1483:32: sparse: sparse: incorrect type in initializer (different base types)
@@     expected unsigned int [usertype] insn @@     got restricted __le32 [usertype] @@
   kernel/events/uprobes.c:1483:32: sparse:     expected unsigned int [usertype] insn
   kernel/events/uprobes.c:1483:32: sparse:     got restricted __le32 [usertype]

use the __le32 to u32 for uprobe_opcode_t, to keep the same.

Fixes: 60f07e22a73d ("arm64:uprobe fix the uprobe SWBP_INSN in big-endian")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: junhua huang <huang.junhua@zte.com.cn>
---
 arch/arm64/include/asm/uprobes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
index ba4bff5ca674..2b09495499c6 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -16,7 +16,7 @@
 #define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
 #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES

-typedef u32 uprobe_opcode_t;
+typedef __le32 uprobe_opcode_t;

 struct arch_uprobe_task {
 };
-- 
2.15.2
