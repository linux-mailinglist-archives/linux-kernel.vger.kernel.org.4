Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F96984A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBOTpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBOTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:45:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04233BD8F;
        Wed, 15 Feb 2023 11:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E36461D23;
        Wed, 15 Feb 2023 19:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43254C433EF;
        Wed, 15 Feb 2023 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676490341;
        bh=jEHEKJREN3+faSwa9KQfDCZrIk1boGFeW1CEIEtwaE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nR0NlH9Idu9r6K5BB6SiskW/nN4Duv8oUu4t8oAsMW/BA2jHnn50sUmTtFA09snEM
         MM4Q1KeVxIEK0CQ3heZ6KGEcJDJrmingPvv4ff3yLJnpeg2zJ4He1vCJjQd4s9mOGJ
         HhE0qrDT5xUO3xGvs5zweCTvugYIA2adLOusrfvLPAxv6b4Cny+j0eHRlRanyAeAV0
         ysxu48fte0a0SA7XcnPw1U31MXQzSfjcPpTrp4Qgi04O07kA/LeXjWVthIX5CMIF30
         JAfOEJGYLSGZoEytWeIGwTCLRlwIMdQ5V+BaoKw5Pr+bw7iEZ2yNGIfGT3LJDZnQTo
         qDwCO7AGpVLow==
Date:   Wed, 15 Feb 2023 11:45:38 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        x86@kernel.org, jiaxun.yang@flygoat.com,
        linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com,
        guoren@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        kernel@xen0n.name, will@kernel.org, vschneid@redhat.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        ysato@users.sourceforge.jp, chenhuacai@kernel.org,
        linux@armlinux.org.uk, linux-csky@vger.kernel.org,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de,
        mattst88@gmail.com, linux-xtensa@linux-xtensa.org,
        paulmck@kernel.org, richard.henderson@linaro.org,
        npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org,
        loongarch@lists.linux.dev, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, jgross@suse.com,
        chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [PATCH v2 04/24] arm64/cpu: Mark cpu_die() __noreturn
Message-ID: <20230215194538.aiiris3uabnuvkkg@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
 <14274f04-2991-95bd-c29b-07e86e8755c1@linaro.org>
 <Y+zZgZIP7RPIgyQf@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+zZgZIP7RPIgyQf@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:09:21PM +0000, Mark Rutland wrote:
> On Tue, Feb 14, 2023 at 09:13:08AM +0100, Philippe Mathieu-Daudé wrote:
> > On 14/2/23 08:05, Josh Poimboeuf wrote:
> > > cpu_die() doesn't return.  Annotate it as such.  By extension this also
> > > makes arch_cpu_idle_dead() noreturn.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >   arch/arm64/include/asm/smp.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> > > index fc55f5a57a06..5733a31bab08 100644
> > > --- a/arch/arm64/include/asm/smp.h
> > > +++ b/arch/arm64/include/asm/smp.h
> > > @@ -100,7 +100,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> > >   extern int __cpu_disable(void);
> > >   extern void __cpu_die(unsigned int cpu);
> > > -extern void cpu_die(void);
> > > +extern void __noreturn cpu_die(void);
> > >   extern void cpu_die_early(void);
> > 
> > Shouldn't cpu_operations::cpu_die() be declared noreturn first?
> 
> The cpu_die() function ends with a BUG(), and so does not return, even if a
> cpu_operations::cpu_die() function that it calls erroneously returned.
> 
> We *could* mark cpu_operations::cpu_die() as noreturn, but I'd prefer that we
> did not so that the compiler doesn't optimize away the BUG() which is there to
> catch such erroneous returns.
> 
> That said, could we please add __noreturn to the implementation of cpu_die() in
> arch/arm64/kernel/smp.c? i.e. the fixup below.

Done.

> With that fixup:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-- 
Josh
