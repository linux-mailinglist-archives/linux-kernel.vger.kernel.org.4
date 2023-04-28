Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD46F14A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbjD1JzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbjD1JzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:05 -0400
Received: from out0-203.mail.aliyun.com (out0-203.mail.aliyun.com [140.205.0.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2EE59F9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:54:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.STDfs7d_1682675593;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STDfs7d_1682675593)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:13 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Brian Gerst" <brgerst@gmail.com>
Subject: [PATCH RFC 26/43] x86/pie: Add .data.rel.* sections into link script
Date:   Fri, 28 Apr 2023 17:51:06 +0800
Message-Id: <d32ccd92c2042e6b7abc4f7519d47a1d92383026.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .data.rel.local and .data.rel.ro.local sections are generated when
PIE is enabled, merge them into .data section, since no dynamic loader
is used.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index fa4c6582663f..71e0769d2b52 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -177,6 +177,10 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+#ifdef CONFIG_X86_PIE
+		*(.data.rel)
+		*(.data.rel.*)
+#endif
 		/* End of data section */
 		_edata = .;
 	} :data
-- 
2.31.1

