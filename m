Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4674FDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGLDbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGLDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:31:19 -0400
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B6C10D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:31:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---.TrdQGet_1689132666;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdQGet_1689132666)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:31:08 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Borislav Petkov" <bp@alien8.de>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <llvm@lists.linux.dev>, "Masahiro Yamada" <masahiroy@kernel.org>,
        "=?UTF-8?B?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?=" 
        <mhiramat@kernel.org>, "Michael Kelley" <mikelley@microsoft.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "=?UTF-8?B?UGV0ZXIgWmlqbHN0cmEgKEludGVsKQ==?=" <peterz@infradead.org>,
        "Petr Pavlu" <petr.pavlu@suse.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Tom Rix" <trix@redhat.com>,
        "Usama Arif" <usama.arif@bytedance.com>, <x86@kernel.org>,
        "Xin Li" <xin3.li@intel.com>
Subject: [PATCH RFC 0/7] x86/head/64: Build the head code as PIE
Date:   Wed, 12 Jul 2023 11:30:04 +0800
Message-Id: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
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

During the early boot stage, the head code runs at a low identity
address, which means that all absolute references would be incorrect.
However, when accessing globals, the compiler does not have to generate
PC-relative references. To work around this problem, every global
variable access must be adjusted using fixup_pointer() in
arch/x86/kernel/head64.c.
However, some global variable accesses in the current code do not use
fixup_pointer(), and they may work correctly because the compiler can
generate the right PC-relative references. But the behavior differs
between GCC and CLANG, which has caused problems before. For example,
commit c1887159eb48 ("x86/boot/64: Add missing fixup_pointer() for
next_early_pgt access") stated that CLANG would generate absolute
references for 'next_early_pgt' without fixup_pointer(), which leads to
booting failure. Moreover, the rule is not always clear. For instance,
'pgdir_shift' is a non-static global variable similar to
'next_early_pgt', but the compiler can generate the right PC-relative
reference, so fixup_pointer() is not applied to pgdir_shift when using
the PGDIR_SHIFT macro.

In addition, the code in arch/x86/mm/mem_encrypt_identity.c also runs at
identity address, but it uses inline assembly to use RIP-relative
reference for some globals instead of fixup_pointer(). However, not all
global references are changed into inline assembly.

To avoid such cases and also prepare for building the kernel as PIE, the
head code could be built as PIE to force the generation of PC-relative
references. This can eliminate the need for fixup_pointer() and inline
assembly. However, there are still a few functions that are called by
the head code but are not in head64.c and mem_encrypt_identity.c, such
as snp_init() and early_snp_set_memory_shared(). Moving them into a
separate compile unit and building them as PIE is a little complicated,
so for now, they will remain unchanged.

Note: The change in mem_encrypt_identity.c has not been tested since I
don't have the necessary environment available.

Hou Wenlong (7):
  x86/head/64: Mark startup_gdt and startup_gdt_descr as __initdata
  x86/head/64: Add missing __head annotation to startup_64_load_idt()
  x86/head/64: Move all head code from head64.c into another file
  x86/boot/compressed: Adapt sed command if head code is built as PIE
  x86/head/64: Build the head code as PIE
  x86/sme: Mark code as __head in mem_encrypt_identity.c
  x86/sme: Build the code in mem_encrypt_identity.c as PIE

 arch/x86/boot/compressed/Makefile  |   2 +-
 arch/x86/include/asm/desc.h        |  12 ++
 arch/x86/include/asm/init.h        |   2 +
 arch/x86/include/asm/mem_encrypt.h |   8 +-
 arch/x86/include/asm/setup.h       |   2 +-
 arch/x86/kernel/Makefile           |  16 +-
 arch/x86/kernel/head64.c           | 307 +----------------------------
 arch/x86/kernel/head64_identity.c  | 282 ++++++++++++++++++++++++++
 arch/x86/kernel/head_64.S          |   2 -
 arch/x86/mm/Makefile               |   3 +
 arch/x86/mm/mem_encrypt_identity.c |  58 ++----
 11 files changed, 342 insertions(+), 352 deletions(-)
 create mode 100644 arch/x86/kernel/head64_identity.c


base-commit: 1a2945f27157825a561be7840023e3664111ab2f
--
2.31.1

