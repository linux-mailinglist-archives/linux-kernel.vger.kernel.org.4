Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED961F00B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKGKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiKGKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:13:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6285B2BC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:13:00 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5Rm0032PzpW35;
        Mon,  7 Nov 2022 18:09:19 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:12:57 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <hw.huiwang@huawei.com>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] x86: use HW_BREAKPOINT_RW where possible
Date:   Tue, 8 Nov 2022 10:12:52 +0800
Message-ID: <20221108021252.605986-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use enum HW_BREAKPOINT_RW where possible instead of individual
(HW_BREAKPOINT_R | HW_BREAKPOINT_W).

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 arch/x86/kernel/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 668a4a6533d9..cccfb446ce80 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -213,7 +213,7 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 		*gen_type = HW_BREAKPOINT_W;
 		break;
 	case X86_BREAKPOINT_RW:
-		*gen_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
+		*gen_type = HW_BREAKPOINT_RW;
 		break;
 	default:
 		return -EINVAL;
@@ -347,7 +347,7 @@ static int arch_build_bp_info(struct perf_event *bp,
 	case HW_BREAKPOINT_W:
 		hw->type = X86_BREAKPOINT_WRITE;
 		break;
-	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+	case HW_BREAKPOINT_RW:
 		hw->type = X86_BREAKPOINT_RW;
 		break;
 	case HW_BREAKPOINT_X:
-- 
2.25.1

