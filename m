Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD26627F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjAIN7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjAIN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:58:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9879525FE;
        Mon,  9 Jan 2023 05:58:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ECC71650;
        Mon,  9 Jan 2023 05:59:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 872733F23F;
        Mon,  9 Jan 2023 05:58:41 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     catalin.marinas@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, revest@chromium.org, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH 2/8] ACPI: Don't build ACPICA with '-Os'
Date:   Mon,  9 Jan 2023 13:58:22 +0000
Message-Id: <20230109135828.879136-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109135828.879136-1-mark.rutland@arm.com>
References: <20230109135828.879136-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPICA code has been built with '-Os' since the beginning of git
history, though there's no explanatory comment as to why.

This is unfortunate as building with '-Os' overrides -falign-functions,
which prevents CONFIG_FUNCITON_ALIGNMENT and
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B from having their expected effect
on the ACPICA code. This is doubly unfortunate as in subsequent patches
arm64 will depend upon CONFIG_FUNCTION_ALIGNMENT for its ftrace
implementation.

Drop the '-Os' flag when building the ACPICA code. With this removed,
the code builds cleanly and works correctly in testing so far.

I've tested this by selecting CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
building and booting a kernel using ACPI, and looking for misaligned
text symbols:

* arm64:

  Before:
    #  grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    908
    #  grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    576

  After:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    322
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    0

* x86_64:

  Before:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    2057
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    706

  After:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    1351
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    0

With the patch applied, the remaining unaligned text labels are a
combination of static call trampolines and labels in assembly, which
will be dealt with in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/acpica/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 9e0d95d76fff7..30f3fc13c29d1 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -3,7 +3,7 @@
 # Makefile for ACPICA Core interpreter
 #
 
-ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
+ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace
-- 
2.30.2

