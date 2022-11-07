Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B661FE84
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKGTZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:25:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B5286D8;
        Mon,  7 Nov 2022 11:25:18 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45DA01EC0567;
        Mon,  7 Nov 2022 20:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667849117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pcjC4gsDaAQb9wj37T7o2+NsO6eLZXW3GUgwox1LxPQ=;
        b=BM8GaX3rOv+jHHETXBX9E8P+zhHlYgi0574Y/GBHtedB3N0PSJKicx7PP+t4FHe/u+S7Gu
        yq382MXQySKBA42Ty9USgymXnP2bYlFN7ivz6wE/imTQAGQM77QNdVhJW66iVZYSl0b0fj
        7C82jcgDeBRASyPB8sWiZ/VOXv0OB0Q=
Date:   Mon, 7 Nov 2022 20:25:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 00/16] x86: make PAT and MTRR independent from each
 other
Message-ID: <Y2lbmYRWQvXn0nPe@zn.tnic>
References: <20221102074713.21493-1-jgross@suse.com>
 <Y2KxSGWllUPTikJv@zn.tnic>
 <a9c1ba97-340e-ed7b-ccdc-44a1aaff6d6d@suse.com>
 <Y2PpOGaiapd4twQR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2PpOGaiapd4twQR@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:15:52PM +0100, Borislav Petkov wrote:
> Lemme try to find a smaller box which shows that too - that one is a
> pain to bisect on.

Ok, couldn't find a smaller one (or maybe it had to be a big one to
tickle this out).

So I think it is the parallel setup thing:

x86/mtrr: Do MTRR/PAT setup on all secondary CPUs in parallel

Note that before it, it would do the configuration sequentially on each
CPU:

[    0.759239] MTRR: prepare_set: CPU83, MSR_MTRRdefType: 0x0, read: (0xc00:0)
[    0.759239] MTRR: set_mtrr_state: CPU83, mtrr_deftype_lo: 0xc00, mtrr_state.def_type: 0, mtrr_state.enabled: 3
[    0.760794] MTRR: post_set: CPU83, MSR_MTRRdefType will write: (0xc00:0)
[    0.761151] MTRR: prepare_set: CPU70, MSR_MTRRdefType: 0x0, read: (0xc00:0)
[    0.761151] MTRR: set_mtrr_state: CPU70, mtrr_deftype_lo: 0xc00, mtrr_state.def_type: 0, mtrr_state.enabled: 3
[    0.761151] MTRR: post_set: CPU70, MSR_MTRRdefType will write: (0xc00:0)
...

and so on.

Now, it would do it all in parallel:

[    0.762006] MTRR: mtrr_disable: CPU70, MSR_MTRRdefType: 0x0, read: (0xc00:0)
[    0.761916] MTRR: mtrr_disable: CPU18, MSR_MTRRdefType: 0x0, read: (0xc00:0)
[    0.761808] MTRR: mtrr_disable: CPU82, MSR_MTRRdefType: 0x0, read: (0xc00:0)
[    0.762593] MTRR: mtrr_disable: CPU6, MSR_MTRRdefType: 0x0, read: (0x0:0)
								      ^^^^^^

Note that last thing. That comes from (with debug output added):

void mtrr_disable(struct cache_state *state)
{
        unsigned int cpu = smp_processor_id();
        u64 msrval;

        /* Save MTRR state */
        rdmsr(MSR_MTRRdefType, state->mtrr_deftype_lo, state->mtrr_deftype_hi);

        /* Disable MTRRs, and set the default type to uncached */
        mtrr_wrmsr(MSR_MTRRdefType, state->mtrr_deftype_lo & ~0xcff,
                   state->mtrr_deftype_hi);

        rdmsrl(MSR_MTRRdefType, msrval);

        pr_info("%s: CPU%d, MSR_MTRRdefType: 0x%llx, read: (0x%x:%x)\n",
                __func__, cpu, msrval, state->mtrr_deftype_lo, state->mtrr_deftype_hi);
}

The "read: (0x0:0)" basically says that

	state->mtrr_deftype_lo, state->mtrr_deftype_hi

are both 0 already. BUT(!), they should NOT be. The low piece is 0xc00 on most
cores except a handful and it means that MTRRs and Fixed Range are
enabled. In total, they're these cores here:

[    0.762593] MTRR: mtrr_disable: CPU6, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762247] MTRR: mtrr_disable: CPU26, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762685] MTRR: mtrr_disable: CPU68, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762725] MTRR: mtrr_disable: CPU17, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762685] MTRR: mtrr_disable: CPU69, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762800] MTRR: mtrr_disable: CPU1, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762734] MTRR: mtrr_disable: CPU13, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762720] MTRR: mtrr_disable: CPU24, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762696] MTRR: mtrr_disable: CPU66, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762716] MTRR: mtrr_disable: CPU48, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762693] MTRR: mtrr_disable: CPU57, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762519] MTRR: mtrr_disable: CPU87, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762532] MTRR: mtrr_disable: CPU58, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762755] MTRR: mtrr_disable: CPU32, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762693] MTRR: mtrr_disable: CPU52, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762861] MTRR: mtrr_disable: CPU0, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762724] MTRR: mtrr_disable: CPU21, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762640] MTRR: mtrr_disable: CPU15, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762615] MTRR: mtrr_disable: CPU50, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762741] MTRR: mtrr_disable: CPU40, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762738] MTRR: mtrr_disable: CPU37, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762716] MTRR: mtrr_disable: CPU25, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762512] MTRR: mtrr_disable: CPU59, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762721] MTRR: mtrr_disable: CPU45, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762682] MTRR: mtrr_disable: CPU56, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762583] MTRR: mtrr_disable: CPU124, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762751] MTRR: mtrr_disable: CPU12, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762741] MTRR: mtrr_disable: CPU9, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762575] MTRR: mtrr_disable: CPU51, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762632] MTRR: mtrr_disable: CPU100, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762688] MTRR: mtrr_disable: CPU61, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762610] MTRR: mtrr_disable: CPU105, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762721] MTRR: mtrr_disable: CPU20, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.762583] MTRR: mtrr_disable: CPU47, MSR_MTRRdefType: 0x0, read: (0x0:0)

Now, if I add MFENCEs around those RDMSRs:

void mtrr_disable(struct cache_state *state)
{
        unsigned int cpu = smp_processor_id();
        u64 msrval;

        /* Save MTRR state */
        rdmsr(MSR_MTRRdefType, state->mtrr_deftype_lo, state->mtrr_deftype_hi);

        __mb();

        /* Disable MTRRs, and set the default type to uncached */
        mtrr_wrmsr(MSR_MTRRdefType, state->mtrr_deftype_lo & ~0xcff,
                   state->mtrr_deftype_hi);

        __mb();

        rdmsrl(MSR_MTRRdefType, msrval);

        pr_info("%s: CPU%d, MSR_MTRRdefType: 0x%llx, read: (0x%x:%x)\n",
                __func__, cpu, msrval, state->mtrr_deftype_lo, state->mtrr_deftype_hi);

        __mb();
}

the amount of cores becomes less:

[    0.765260] MTRR: mtrr_disable: CPU6, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765462] MTRR: mtrr_disable: CPU5, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765242] MTRR: mtrr_disable: CPU22, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765522] MTRR: mtrr_disable: CPU0, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765474] MTRR: mtrr_disable: CPU1, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765207] MTRR: mtrr_disable: CPU54, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765225] MTRR: mtrr_disable: CPU8, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765282] MTRR: mtrr_disable: CPU88, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765150] MTRR: mtrr_disable: CPU119, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765370] MTRR: mtrr_disable: CPU49, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765395] MTRR: mtrr_disable: CPU16, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765348] MTRR: mtrr_disable: CPU52, MSR_MTRRdefType: 0x0, read: (0x0:0)
[    0.765270] MTRR: mtrr_disable: CPU58, MSR_MTRRdefType: 0x0, read: (0x0:0)

which basically hints at some speculative fun where we end up reading
the MSR *after* the write to it has already happened. After this thing:

        /* Disable MTRRs, and set the default type to uncached */
        mtrr_wrmsr(MSR_MTRRdefType, state->mtrr_deftype_lo & ~0xcff,
                   state->mtrr_deftype_hi);

and thus when we read it, we already read the disabled state. But this
is only a conjecture because I still have no clear idea how TF would
that even happen?!?

Needless to say, this fixes it, ofc:

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3805a6d32d37..4a685898caf3 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1116,12 +1116,14 @@ void cache_enable(struct cache_state *state)
                __write_cr4(state->cr4);
 }
 
+static DEFINE_RAW_SPINLOCK(set_atomicity_lock);
+
 static void cache_cpu_init(void)
 {
        unsigned long flags;
        struct cache_state state = { };
 
-       local_irq_save(flags);
+       raw_spin_lock_irqsave(&set_atomicity_lock, flags);
        cache_disable(&state);
 
        if (memory_caching_control & CACHE_MTRR)
@@ -1131,7 +1133,7 @@ static void cache_cpu_init(void)
                pat_cpu_init();
 
        cache_enable(&state);
-       local_irq_restore(flags);
+       raw_spin_unlock_irqrestore(&set_atomicity_lock, flags);
 }
 
 static bool cache_aps_delayed_init = true;

---

and frankly, considering how we have bigger fish to fry, I'd say we do
it the old way and leave that can'o'worms half-opened.

Unless you wanna continue poking at it. I can give you access to that
box at work...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
