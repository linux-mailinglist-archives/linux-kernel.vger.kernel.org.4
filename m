Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E72729600
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjFIJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbjFIJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:55:11 -0400
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF97EC5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:46:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TPYicTQ_1686303990;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TPYicTQ_1686303990)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 17:46:31 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Nadav Amit" <namit@vmware.com>, "Juergen Gross" <jgross@suse.com>,
        "Ajay Kaher" <akaher@vmware.com>,
        "Alexey Makhalov" <amakhalov@vmware.com>,
        "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site packed
Date:   Fri, 09 Jun 2023 17:45:32 +0800
Message-Id: <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
References: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to struct alt_instr, make the struct paravirt_patch_site packed
and get rid of all the .align directives. This could save 2 bytes for
one entry on X86_64.

Suggested-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/paravirt.h       | 2 --
 arch/x86/include/asm/paravirt_types.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2350ceb43db0..3e5ccacb3893 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -747,11 +747,9 @@ extern void default_banner(void);
 	ops;					\
 772:;						\
 	.pushsection .parainstructions,"a";	\
-	 .align	4;				\
 	 .long 771b-.;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 .align 4;				\
 	.popsection
 
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 982a234f5a06..da0547bcd068 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -8,7 +8,7 @@ struct paravirt_patch_site {
 	s32 instr_offset;	/* original instructions */
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
-};
+} __packed;
 
 /* Lazy mode for batching updates / context switch */
 enum paravirt_lazy_mode {
@@ -270,11 +270,9 @@ extern struct paravirt_patch_template pv_ops;
 #define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
-	"  .align 4\n"					\
 	"  .long 771b-.\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	"  .align 4\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
-- 
2.31.1

