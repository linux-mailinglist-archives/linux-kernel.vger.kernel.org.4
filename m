Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87EE677CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjAWNqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjAWNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:46:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BB8426586;
        Mon, 23 Jan 2023 05:46:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C92BE1655;
        Mon, 23 Jan 2023 05:47:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35B5A3F64C;
        Mon, 23 Jan 2023 05:46:23 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH v3 5/8] arm64: insn: Add helpers for BTI
Date:   Mon, 23 Jan 2023 13:46:00 +0000
Message-Id: <20230123134603.1064407-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches we'd like to check whether an instruction is a
BTI. In preparation for this, add basic instruction helpers for BTI
instructions.

Per ARM DDI 0487H.a section C6.2.41, BTI is encoded in binary as
follows, MSB to LSB:

  1101 0101 000 0011 0010 0100 xx01 1111

Where the `xx` bits encode J/C/JC:

  00 : (omitted)
  01 : C
  10 : J
  11 : JC

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/insn.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index aaf1f52fbf3e..139a88e4e852 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -420,6 +420,7 @@ __AARCH64_INSN_FUNCS(sb,	0xFFFFFFFF, 0xD50330FF)
 __AARCH64_INSN_FUNCS(clrex,	0xFFFFF0FF, 0xD503305F)
 __AARCH64_INSN_FUNCS(ssbb,	0xFFFFFFFF, 0xD503309F)
 __AARCH64_INSN_FUNCS(pssbb,	0xFFFFFFFF, 0xD503349F)
+__AARCH64_INSN_FUNCS(bti,	0xFFFFFF3F, 0xD503241f)
 
 #undef	__AARCH64_INSN_FUNCS
 
-- 
2.30.2

