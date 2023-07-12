Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33974FDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGLDcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGLDbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:31:48 -0400
Received: from out0-194.mail.aliyun.com (out0-194.mail.aliyun.com [140.205.0.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F610EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:31:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TrdHwxy_1689132693;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdHwxy_1689132693)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:31:34 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Petr Pavlu" <petr.pavlu@suse.com>, "Xin Li" <xin3.li@intel.com>
Subject: [PATCH RFC 4/7] x86/boot/compressed: Adapt sed command if head code is built as PIE
Date:   Wed, 12 Jul 2023 11:30:08 +0800
Message-Id: <0856eaae3439581fdcb7143389ee4cc00859cc9d.1689130310.git.houwenlong.hwl@antgroup.com>
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

When x86/head64_identity.c is built as PIE, all symbols would be set as
hidden to omit GOT references. According to the generic ABI, a hidden
symbol contained in a relocatable object must be either removed or
converted to STB_LOCAL binding by the link-editor when the relocatable
object is included in an executable file or shared object. Both gold and
ld.lld change the binding of a STV_HIDDEND symbol to STB_LOCAL. However,
for GNU ld, it will keep the global hidden. The sed command to generate
voffset.h only captures global symbols, so an empty voffset.h would be
generated with ld.lld. Therefore, local symbols should also be captured
in the sed command.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 40d2ff503079..ca57ad0d2d22 100644
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

