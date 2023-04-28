Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E96F14AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjD1Jzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbjD1JzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:09 -0400
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB935584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:54:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.STFQGPs_1682675586;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFQGPs_1682675586)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:07 +0800
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
        "Nathan Chancellor" <nathan@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Xin Li" <xin3.li@intel.com>
Subject: [PATCH RFC 24/43] x86/boot/compressed: Adapt sed command to generate voffset.h when PIE is enabled
Date:   Fri, 28 Apr 2023 17:51:04 +0800
Message-Id: <8d6bbaf66b90cf1a8fd2c5da98f5e094b9ffcb27.1682673543.git.houwenlong.hwl@antgroup.com>
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

When PIE is enabled, all symbols would be set as hidden to reduce GOT
references. According to generic ABI, a hidden symbol contained in a
relocatable object must be either removed or converted to STB_LOCAL
binding by the link-editor when the relocatable object is included in an
executable file or shared object. Both gold and ld.lld change the
binding of a STV_HIDDEND symbol to STB_LOCAL. But For GNU ld, it will
keep global hidden.  However, sed command to generate voffset.h only
captures global symbol, then empty voffset.h would be generated when PIE
is enabled with lld. So capture local symbol too in sed command.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe607bdb..678881496c44 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -79,7 +79,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVWabcdgrstvw] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
-- 
2.31.1

