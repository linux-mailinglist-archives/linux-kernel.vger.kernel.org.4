Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA8874FDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGLDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGLDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:31:25 -0400
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67663E5F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:31:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.TrdQGkX_1689132675;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdQGkX_1689132675)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:31:16 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
Subject: [PATCH RFC 2/7] x86/head/64: Add missing __head annotation to startup_64_load_idt()
Date:   Wed, 12 Jul 2023 11:30:06 +0800
Message-Id: <efcc5b5e18af880e415d884e072bf651c1fa7c34.1689130310.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is currently only used in the head code and is only called
from startup_64_setup_env(). Although it would be inlined by the
compiler, it would be better to mark it as __head too.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dd357807ffb5..5066189b00ac 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -588,7 +588,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(unsigned long physbase)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-- 
2.31.1

