Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630D747D54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGEGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGEGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:47:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34701701;
        Tue,  4 Jul 2023 23:47:43 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwqrp5zQdzMq8t;
        Wed,  5 Jul 2023 14:44:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:47:40 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <stable@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mhiramat@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <sashal@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <xukuohai@huawei.com>, <natechancellor@gmail.com>,
        <ndesaulniers@google.com>, <rostedt@goodmis.org>,
        <weiyongjun1@huawei.com>, <gustavoars@kernel.org>,
        <namit@vmware.com>, <laijs@linux.alibaba.com>,
        <clang-built-linux@googlegroups.com>, <lihuafei1@huawei.com>
Subject: [PATCH 5.10 1/9] kprobes/x86: Fix fall-through warnings for Clang
Date:   Wed, 5 Jul 2023 14:46:45 +0800
Message-ID: <20230705064653.226811-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705064653.226811-1-lihuafei1@huawei.com>
References: <20230705064653.226811-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit e689b300c99ca2dd80d3f662e19499bba27cda09 ]

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 5de757099186..ed9a4fb87168 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -880,6 +880,7 @@ static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 			p->ainsn.boostable = true;
 			goto no_change;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

