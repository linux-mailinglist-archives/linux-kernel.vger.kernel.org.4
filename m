Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A5627CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiKNLpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiKNLoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053B1D655
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34A71B80E6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE33AC433D6;
        Mon, 14 Nov 2022 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426265;
        bh=mZy59RfMp+d1UJJbf+o4C0WWNhptP9zLv0Zp8nxmYqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPYVlpz368y2BvR4VAyLp0saq8tF6P5Cp+4m0jbJhjQgB9H7x7DfN3vURZR+wYkC/
         GBWAYSbKB6NYboPLqd1Rnnwtv6/IoJ4+ARtKrns+0fztif2QW7WsCr5Iw1NFJjmKup
         y8grnvSS2m/5cppYeNVgrNJETBDHGJSdNjFhE4s0j/dLKVfjdkkTgo7Tqi+pEQfsyf
         5In4dDX+Pf1RaDEjZMXsT5w/J3HQBXMZfEWDzorQ8r2uDq8J84W6ev0qhlT9a3whu+
         nW1oGTYQdFMtRHOhzEVCWZbJtpOLOTved+3Xr9wXJXB0xL7BBCqPCGFkmylbq6s2f/
         D6ZFfLFn8tJyw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/46] x86/preempt, lto: Mark preempt_schedule_*thunk() as __visible
Date:   Mon, 14 Nov 2022 12:43:11 +0100
Message-Id: <20221114114344.18650-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark preempt_schedule_thunk() and preempt_schedule_notrace_thunk() as
__visible.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 5f6daea1ee24..c76ec881b23c 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -106,13 +106,13 @@ static __always_inline bool should_resched(int preempt_offset)
 #ifdef CONFIG_PREEMPTION
 
 extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_thunk(void);
+extern __visible asmlinkage void preempt_schedule_thunk(void);
 
 #define preempt_schedule_dynamic_enabled	preempt_schedule_thunk
 #define preempt_schedule_dynamic_disabled	NULL
 
 extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
+extern __visible asmlinkage void preempt_schedule_notrace_thunk(void);
 
 #define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
 #define preempt_schedule_notrace_dynamic_disabled	NULL
-- 
2.38.1

