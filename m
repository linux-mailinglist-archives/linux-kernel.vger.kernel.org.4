Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0D6378B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKXMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKXMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:16:47 -0500
Received: from out0-129.mail.aliyun.com (out0-129.mail.aliyun.com [140.205.0.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCEA28B8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:16:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.QFudH94_1669292202;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.QFudH94_1669292202)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 20:16:43 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH] x86/tools: Explicitly include autoconf.h for hostprogs
Date:   Thu, 24 Nov 2022 20:14:10 +0800
Message-Id: <f327f8f8b1521c55f5f4eaeb332d6620dbef3a49.1669292031.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relocs tool needs access to the CONFIG_* symbols found in
include/generated/autoconf.h. However, the header file is not included,
so the #if CONFIG_FW_LOADER code in arch/x86/tool/relocs.c is never
compiled.

Fixes: c8dcf655ec81 ("x86/build: Tuck away built-in firmware under FW_LOADER")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/tools/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index bddfc9a46645..941b24431696 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -38,7 +38,9 @@ $(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tool
 
 $(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
-HOST_EXTRACFLAGS += -I$(srctree)/tools/include
+HOST_EXTRACFLAGS += -I$(srctree)/tools/include \
+		    -include include/generated/autoconf.h
+
 hostprogs	+= relocs
 relocs-objs     := relocs_32.o relocs_64.o relocs_common.o
 PHONY += relocs
-- 
2.31.1

