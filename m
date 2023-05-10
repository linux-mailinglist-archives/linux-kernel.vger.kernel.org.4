Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C86FE282
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEJQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:30:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFF24207;
        Wed, 10 May 2023 09:30:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA5212FC;
        Wed, 10 May 2023 09:31:27 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700EB3F67D;
        Wed, 10 May 2023 09:30:35 -0700 (PDT)
Date:   Wed, 10 May 2023 17:30:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
Message-ID: <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com>
References: <20230419225604.21204-1-dianders@chromium.org>
 <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> Hi,

Hi Doug,

> On Wed, Apr 19, 2023 at 3:57 PM Douglas Anderson <dianders@chromium.org> wrote:
> > This is an attempt to resurrect Sumit's old patch series [1] that
> > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > could find was v7, so I called this series v8. I haven't copied all of
> > his old changelongs here, but you can find them from the link.
> >
> > Since v7, I have:
> > * Addressed the small amount of feedback that was there for v7.
> > * Rebased.
> > * Added a new patch that prevents us from spamming the logs with idle
> >   tasks.
> > * Added an extra patch to gracefully fall back to regular IPIs if
> >   pseudo-NMIs aren't there.
> >
> > Since there appear to be a few different patches series related to
> > being able to use NMIs to get stack traces of crashed systems, let me
> > try to organize them to the best of my understanding:
> >
> > a) This series. On its own, a) will (among other things) enable stack
> >    traces of all running processes with the soft lockup detector if
> >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace". On
> >    its own, a) doesn't give a hard lockup detector.
> >
> > b) A different recently-posted series [2] that adds a hard lockup
> >    detector based on perf. On its own, b) gives a stack crawl of the
> >    locked up CPU but no stack crawls of other CPUs (even if they're
> >    locked too). Together with a) + b) we get everything (full lockup
> >    detect, full ability to get stack crawls).
> >
> > c) The old Android "buddy" hard lockup detector [3] that I'm
> >    considering trying to upstream. If b) lands then I believe c) would
> >    be redundant (at least for arm64). c) on its own is really only
> >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> >    (see [4]). a) + c) is roughly as good as a) + b).

> It's been 3 weeks and I haven't heard a peep on this series. That
> means nobody has any objections and it's all good to land, right?
> Right? :-P

FWIW, there are still longstanding soundness issues in the arm64 pseudo-NMI
support (and fixing that requires an overhaul of our DAIF / IRQ flag
management, which I've been chipping away at for a number of releases), so I
hadn't looked at this in detail yet because the foundations are still somewhat
dodgy.

I appreciate that this has been around for a while, and it's on my queue to
look at.

Thanks,
Mark.
