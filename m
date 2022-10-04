Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD605F438E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJDMwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJDMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:52:02 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636E6052E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:49:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 74B5B4075264;
        Tue,  4 Oct 2022 12:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 74B5B4075264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1664887712;
        bh=GtPkfmrcMpXCGw2JfKXL9qcrACFtOrc75VWkW2MmZoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q54wn50Kjy3LMSLBmXk7dmDCOnHJRLzShtM1Jpb2v1oOvZwglHN7RP7bijk2Ravnq
         Ix+N9n8tqQnfMcf/cIYw2/mBF9BcLO5KW9GwKlZLZFw00j6NEKalM0yfCV/wro8o5N
         g1zShqa0jgCtsongPXg80FpqVy7IHtYKrcsw5l6g=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v7 2/5] x86: Add cmdline_prepare() helper
Date:   Tue,  4 Oct 2022 15:48:21 +0300
Message-Id: <603dc95beb44340aa1787328589ff2e073b251e1.1664886978.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1664886978.git.baskov@ispras.ru>
References: <cover.1664886978.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command line needs to be combined in both compressed and uncompressed
kernel from built-in and boot command line strings, which requires
non-trivial logic depending on CONFIG_CMDLINE_BOOL and
CONFIG_CMDLINE_OVERRIDE.

Add a helper function to avoid code duplication.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/include/asm/shared/cmdline.h | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/x86/include/asm/shared/cmdline.h

diff --git a/arch/x86/include/asm/shared/cmdline.h b/arch/x86/include/asm/shared/cmdline.h
new file mode 100644
index 000000000000..32d4a792a38a
--- /dev/null
+++ b/arch/x86/include/asm/shared/cmdline.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_SETUP_CMDLINE_H
+#define _ASM_X86_SETUP_CMDLINE_H
+
+#define _SETUP
+#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+#include <linux/string.h>
+
+#ifdef CONFIG_CMDLINE_BOOL
+#define COMMAND_LINE_INIT CONFIG_CMDLINE
+#else
+#define COMMAND_LINE_INIT ""
+#endif
+
+/*
+ * command_line and boot_command_line are expected to be at most
+ * COMMAND_LINE_SIZE length. command_line needs to be initialized
+ * with COMMAND_LINE_INIT.
+ */
+static inline void cmdline_prepare(char *command_line,
+				   const char *boot_command_line)
+{
+	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
+		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	} else if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		/* Append boot loader cmdline to builtin one. */
+		strlcat(command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	}
+}
+
+#endif /* _ASM_X86_SETUP_CMDLINE_H */
-- 
2.35.1

