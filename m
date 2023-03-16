Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8757E6BD646
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCPQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCPQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:50:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E71B1EFF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:50:23 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E29D1EC069C;
        Thu, 16 Mar 2023 17:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678985422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pvZfB3xEnFcv+kVn5Kmi9T4R22mO6xRhrZ8tN35T6bI=;
        b=c6WU9pCFsaHPMrROvxfoSDtYYbTTdTt+tEDbv37vsvdKXCfFvyrLk8l9rUjm93Hi9CJk4U
        JXe1OfjoIhYKtJaBPE6FKs0bL+3+wYRyY2MOVZGXZQ4fzci2yYKrtUFNsbce26+jqi+b6H
        GquPvLw+ksxPAyeddaaOabOcNvDasp4=
Date:   Thu, 16 Mar 2023 17:50:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230316165017.GAZBNIyTYanBKqe0ip@fat_crate.local>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:
> All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
> functions, as those functions calls are hidden from gcc. In case the
> kernel is compiled with "-fzero-call-used-regs" the compiler will
> clobber caller-saved registers at the end of C functions, which will
> result in unexpectedly zeroed registers at the call site of the
> related paravirt functions.
> 
> Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
> the same instructions as the related paravirt calls in the
> PVOP_ALT_[V]CALLEE*() macros.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt_types.h |  8 +++++++-
>  arch/x86/kernel/paravirt.c            | 27 ++++++---------------------
>  2 files changed, 13 insertions(+), 22 deletions(-)

objtool's not happy with this for whatever reason. I'll look later as to
why. .config is allmodconfig with this patch ontop of tip:x86/paravirt:

vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: default_idle+0x1e: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: mwait_idle+0x5d: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x94: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: intel_idle_irq+0xab: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: acpi_safe_halt+0x2a: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: poll_idle+0x86: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_double_fault+0x3b: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_nmi+0x188: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: __sev_put_ghcb+0x11: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: __sev_get_ghcb+0x13: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_page_fault+0x1e: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: lockdep_hardirqs_on+0xd0: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: lockdep_hardirqs_off+0xe7: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: look_up_lock_class+0x52: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[32]: pv_native_irq_enable
vmlinux.o: warning: objtool: lock_is_held_type+0x143: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: ct_kernel_enter.constprop.0+0x37: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[32]: pv_native_irq_enable
vmlinux.o: warning: objtool: ct_idle_exit+0x51: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: ct_idle_enter+0xe: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: check_preemption_disabled+0x4c: call to {dynamic}() leaves .noinstr.text section

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
