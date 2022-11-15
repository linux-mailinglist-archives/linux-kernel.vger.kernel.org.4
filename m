Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DDA62A1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKOTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKOTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:00:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E765DECC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:00:08 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7da329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7da:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAC0A1EC02F2;
        Tue, 15 Nov 2022 20:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668538806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HSd7B0C/1r6LoPcQxs45AWhIvb4BRbERI8/PYi7FChw=;
        b=hzXj/2zHiDxkb//OsVVPFC3wX74g7y/VNLRG1fssiutPnu0UweKvKWCTxTnPyVGSzTxn2E
        Jzid69ed3H5L9/pRuqiCQFobRBJBugJ4I+xMC0RbvVIzCKTDNKHpS6Gz48F3ycNX6NVeKa
        WibIkxpnbt0LMqSdw3JZ5Xuv+YgUXUg=
Date:   Tue, 15 Nov 2022 20:00:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 2/2] x86/boot: Use cmdline_prepare() in the compressed stage
Message-ID: <Y3PhtjKjt/G2kqAF@zn.tnic>
References: <cover.1668082601.git.baskov@ispras.ru>
 <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
 <Y3JQpxi6XDkPViBr@zn.tnic>
 <Y3PhYRx9aAYsdvMQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PhYRx9aAYsdvMQ@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Date: Tue, 15 Nov 2022 19:30:09 +0100

Use cmdline_prepare() in the compressed stage so that builtin
command line (CONFIG_CMDLINE_BOOL) and overridden command line
(CONFIG_CMDLINE_OVERRIDE) strings are visible in the compressed kernel
too.

Use case being, supplying earlyprintk via a compile-time option for
booting on systems with broken UEFI command line arguments via EFISTUB.

Reported-by: Evgeniy Baskov <baskov@ispras.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/boot/compressed/misc.c       |  7 +++++++
 arch/x86/include/asm/shared/cmdline.h | 20 ++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cf690d8712f4..b1077b2fdba6 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -18,6 +18,9 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/shared/cmdline.h>
+
+extern unsigned long get_cmd_line_ptr(void);
 
 /*
  * WARNING!!
@@ -355,6 +358,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	char *cmdline = (char *)get_cmd_line_ptr();
 	unsigned long needed_size;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
@@ -365,6 +369,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	sanitize_boot_params(boot_params);
 
+	/* Destination and boot command line are the same */
+	cmdline_prepare(cmdline, BUILTIN_CMDLINE, cmdline);
+
 	if (boot_params->screen_info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
diff --git a/arch/x86/include/asm/shared/cmdline.h b/arch/x86/include/asm/shared/cmdline.h
index e09c06338567..8a7d8f579575 100644
--- a/arch/x86/include/asm/shared/cmdline.h
+++ b/arch/x86/include/asm/shared/cmdline.h
@@ -8,6 +8,15 @@
 #define BUILTIN_CMDLINE ""
 #endif
 
+#define _SETUP
+#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+/*
+ * Add @boot_command_line to @dst only if it is not in @dst already. The compressed kernel
+ * has the command line pointer in setup_header.cmd_line_ptr which is set by the boot
+ * loader so @boot_command_line == @dst there, see the call in compressed/misc.c
+ */
 static inline void cmdline_prepare(char *dst,
                                    const char *builtin_cmdline,
                                    char *boot_command_line)
@@ -20,15 +29,18 @@ static inline void cmdline_prepare(char *dst,
 			/* Add builtin cmdline */
 			strlcat(dst, builtin_cmdline, COMMAND_LINE_SIZE);
 			strlcat(dst, " ", COMMAND_LINE_SIZE);
-			/* Add boot cmdline */
-			strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
+
+			if (dst != boot_command_line)
+				strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
 		}
 	} else {
-		strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
+		if (dst != boot_command_line)
+			strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
 	}
 
 	/* Copy back into boot command line, see setup_command_line() */
-	strscpy(boot_command_line, dst, COMMAND_LINE_SIZE);
+	if (dst != boot_command_line)
+		strscpy(boot_command_line, dst, COMMAND_LINE_SIZE);
 }
 
 #endif /* _ASM_X86_SHARED_CMDLINE_H */
-- 
2.35.1



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
