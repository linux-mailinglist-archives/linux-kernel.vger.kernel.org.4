Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD6696CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjBNSXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjBNSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:23:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E342BF04;
        Tue, 14 Feb 2023 10:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FDB6181E;
        Tue, 14 Feb 2023 18:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3376FC433EF;
        Tue, 14 Feb 2023 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676399005;
        bh=6EEHFrLsabjvymp2QY0maJnB4Ezo1N96TizvWsxliSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewo4sNIkf4SKN8X81e1VZLV0gftWY9x5Idojfu6eT2b5ZqWCugH7cdipfgrW/yItW
         dqagFjGOxb/3bL82FQa8uuxe//ztDAd9OjP7hBFIDi33dsqHZZjtip3V1HJ2oMssgq
         JOC+Yor+xpMwuL0MvLKpSDnAPlafCWbIbj+fVaPjRgLXxBLYj2+reObJ0duhgkj1On
         B/RwdybgTkIi3ajOUQ2j7ORpSeUDMZz187rZ02sRoCPqHerIGi+6Ive3pLH2MHMcC/
         Wt6l7B+BR9KKMKD4veoKROyWZ38VxJ/Bk61QLyW3eGZbXyZkY95I+3EgwPU2h+98Tw
         pND7dbVAeFWAA==
Date:   Tue, 14 Feb 2023 10:23:22 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: Re: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
Message-ID: <20230214182322.r5tyeowxzloiuh72@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
 <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:55:32AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Josh,
> 
> On 14/2/23 08:05, Josh Poimboeuf wrote:
> > cpu_die() doesn't return.  Make that more explicit with a BUG().
> > 
> > BUG() is preferable to unreachable() because BUG() is a more explicit
> > failure mode and avoids undefined behavior like falling off the edge of
> > the function into whatever code happens to be next.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >   arch/xtensa/kernel/smp.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
> > index 4dc109dd6214..7bad78495536 100644
> > --- a/arch/xtensa/kernel/smp.c
> > +++ b/arch/xtensa/kernel/smp.c
> 
> Can you update the documentation along? Currently we have:
> 
>   /*
>    * Called from the idle thread for the CPU which has been shutdown.
>    *
>    * Note that we disable IRQs here, but do not re-enable them
>    * before returning to the caller. This is also the behaviour
>    * of the other hotplug-cpu capable cores, so presumably coming
>    * out of idle fixes this.
>    */

void __ref cpu_die(void)
{
	idle_task_exit();
	local_irq_disable();
	__asm__ __volatile__(
			"	movi	a2, cpu_restart\n"
			"	jx	a2\n");

	BUG();
}

Hm, not only is the comment wrong, but it seems to be branching to
cpu_restart?  That doesn't seem right at all.

Max/Chris?

-- 
Josh
