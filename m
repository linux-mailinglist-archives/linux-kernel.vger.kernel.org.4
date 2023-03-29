Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6766CD06D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjC2DAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjC2C76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:59:58 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD201BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 19:59:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VeuzKk5_1680058783;
Received: from L-PF27918B-1352.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VeuzKk5_1680058783)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 10:59:52 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        kirill.shutemov@linux.intel.com, wutu.xq2@linux.alibaba.com
Subject: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Date:   Wed, 29 Mar 2023 10:59:37 +0800
Message-Id: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems MOVSXD which opcode is 0x63 is not handled, support
to decode it in insn_decode_mmio().

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 arch/x86/lib/insn-eval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605929db..db6f93bad219 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1607,6 +1607,10 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 		return INSN_MMIO_DECODE_FAILED;
 
 	switch (insn->opcode.bytes[0]) {
+	case 0x63: /* MOVSXD r64, m32 */
+		*bytes = 4;
+		type = INSN_MMIO_READ_SIGN_EXTEND;
+		break;
 	case 0x88: /* MOV m8,r8 */
 		*bytes = 1;
 		fallthrough;
-- 
2.34.3

