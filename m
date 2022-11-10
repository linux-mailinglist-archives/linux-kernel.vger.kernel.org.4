Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9043C6242E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKJNJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKJNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:09:39 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02108DEA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:09:37 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id B2F12400CBDC;
        Thu, 10 Nov 2022 13:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B2F12400CBDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668085775;
        bh=6OlZriUDEchZQUeQ2XzXlu3cfcV0g8cSmETlWS2PYDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMMzJMwJ6/GWHOaIHVHdezI4S7X5VjnVFWu/SquSMh4+1dWK3VU5LHyM9/fOlhtYU
         9Ehq40EffgfYY16qzn6W8wxcmJLuwSzam3XjoIYfG1Rh+MGl1mKW1w2XTeF231JGY2
         gdFeXndLQRZdw1gLIeBzlD4YBoRDQ3B6X73ZIp7I=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v8 2/5] x86: Add cmdline_prepare() helper
Date:   Thu, 10 Nov 2022 16:09:30 +0300
Message-Id: <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668082601.git.baskov@ispras.ru>
References: <cover.1668082601.git.baskov@ispras.ru>
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
index 000000000000..01736d66028d
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
+#define BUILTIN_COMMAND_LINE CONFIG_CMDLINE
+#else
+#define BUILTIN_COMMAND_LINE ""
+#endif
+
+static inline void cmdline_prepare(char *dst, const char *boot_command_line)
+{
+	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
+		strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
+	} else {
+		strscpy(dst, BUILTIN_COMMAND_LINE, COMMAND_LINE_SIZE);
+		/*
+		 * Append boot loader cmdline to builtin, if it exists
+		 * and should not be overriden.
+		 */
+		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) && boot_command_line[0]) {
+			strlcat(dst, " ", COMMAND_LINE_SIZE);
+			strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
+		}
+	}
+}
+
+#endif /* _ASM_X86_SETUP_CMDLINE_H */
-- 
2.37.4

