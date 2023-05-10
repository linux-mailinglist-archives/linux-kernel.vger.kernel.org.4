Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099FF6FE2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjEJQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjEJQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:49:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4F30F7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:49:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64384274895so5366602b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683737387; x=1686329387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4AcAs1XOdI4uJxnLDu55ay7WUOLwtVEGo1buGajIlI=;
        b=MrJLpejK8Oe/atyhDSAiyLpo6iNlXF8EqfYqvL7f4dvCDO56seTeGM3h0aTG17TAHM
         EfJki5mrgQ4lvEW1H6nHwRd5bqWvsNklT0Fz04nwjCbzvqV58BOSDTz+wE1AEuWaGEeZ
         aF8GQzFFPryFBZLr/Dm1W1On2sH0gVlfwk5WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683737387; x=1686329387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4AcAs1XOdI4uJxnLDu55ay7WUOLwtVEGo1buGajIlI=;
        b=k378OVDhWWjLM1iHoRn1szCm/r32HydW4etsLfBVvfQJLAOkwePcndZx+DoCopNbBy
         49WNwo/V8A88cAOvQ9w7gVi3Q0w0xSy0KgPu5u5Wy9UxO20wxTQBfrEwkACMFExAOUva
         KMgGjUdrmxdpdGXnbauc8xD2JFvEA4vAhH2NGyF8qM561D8d8g9nhMPHo7URPgMChDse
         2isPOTddMhaQdayFuru6oWoENUl6L5ME7C4pQObVByIUS+21Qieb+v+HjjXHBYTrBCk/
         Tsc41mGSE7AF5V5fhGoR604hQ1MWp4Gf/6jX5VTzBhRDTtwi41DDmR6uc0vENaNKk3n9
         OjOw==
X-Gm-Message-State: AC+VfDyavFzUasOHw02k24D085c295IkLUb33/WdU8oT2FHfePcNoR2N
        G6VoT8zHQZPtJ6qTdAm5HsuzvfCYxiFKw2O4XCCTeA==
X-Google-Smtp-Source: ACHHUZ5QajkZkHEC6cXb7dzcCJuutm99bWe9fxKa6BKfvJg4rrXh6DtNRY0bb+waNkEWMGdlf8Y2Qw==
X-Received: by 2002:a05:6a20:6a0e:b0:ff:f746:1044 with SMTP id p14-20020a056a206a0e00b000fff7461044mr17251609pzk.53.1683737387358;
        Wed, 10 May 2023 09:49:47 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id z14-20020aa785ce000000b0062a56e51fd7sm3731812pfn.188.2023.05.10.09.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:49:47 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1aae90f5ebcso234705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:49:46 -0700 (PDT)
X-Received: by 2002:ac8:5792:0:b0:3ee:d8fe:6f5c with SMTP id
 v18-20020ac85792000000b003eed8fe6f5cmr329937qta.1.1683736943923; Wed, 10 May
 2023 09:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
 <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 May 2023 09:42:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
Message-ID: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
To:     Mark Rutland <mark.rutland@arm.com>
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
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 9:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> > Hi,
>
> Hi Doug,
>
> > On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > > This is an attempt to resurrect Sumit's old patch series [1] that
> > > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> > > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > > could find was v7, so I called this series v8. I haven't copied all o=
f
> > > his old changelongs here, but you can find them from the link.
> > >
> > > Since v7, I have:
> > > * Addressed the small amount of feedback that was there for v7.
> > > * Rebased.
> > > * Added a new patch that prevents us from spamming the logs with idle
> > >   tasks.
> > > * Added an extra patch to gracefully fall back to regular IPIs if
> > >   pseudo-NMIs aren't there.
> > >
> > > Since there appear to be a few different patches series related to
> > > being able to use NMIs to get stack traces of crashed systems, let me
> > > try to organize them to the best of my understanding:
> > >
> > > a) This series. On its own, a) will (among other things) enable stack
> > >    traces of all running processes with the soft lockup detector if
> > >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace". O=
n
> > >    its own, a) doesn't give a hard lockup detector.
> > >
> > > b) A different recently-posted series [2] that adds a hard lockup
> > >    detector based on perf. On its own, b) gives a stack crawl of the
> > >    locked up CPU but no stack crawls of other CPUs (even if they're
> > >    locked too). Together with a) + b) we get everything (full lockup
> > >    detect, full ability to get stack crawls).
> > >
> > > c) The old Android "buddy" hard lockup detector [3] that I'm
> > >    considering trying to upstream. If b) lands then I believe c) woul=
d
> > >    be redundant (at least for arm64). c) on its own is really only
> > >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> > >    (see [4]). a) + c) is roughly as good as a) + b).
>
> > It's been 3 weeks and I haven't heard a peep on this series. That
> > means nobody has any objections and it's all good to land, right?
> > Right? :-P
>
> FWIW, there are still longstanding soundness issues in the arm64 pseudo-N=
MI
> support (and fixing that requires an overhaul of our DAIF / IRQ flag
> management, which I've been chipping away at for a number of releases), s=
o I
> hadn't looked at this in detail yet because the foundations are still som=
ewhat
> dodgy.
>
> I appreciate that this has been around for a while, and it's on my queue =
to
> look at.

Ah, thanks for the heads up! We've been thinking about turning this on
in production in ChromeOS because it will help us track down a whole
class of field-generated crash reports that are otherwise opaque to
us. It sounds as if maybe that's not a good idea quite yet? Do you
have any idea of how much farther along this needs to go? ...of
course, we've also run into issues with Mediatek devices because they
don't save/restore GICR registers properly [1]. In theory, we might be
able to work around that in the kernel.

In any case, even if there are bugs that would prevent turning this on
for production, it still seems like we could still land this series.
It simply wouldn't do anything until someone turned on pseudo NMIs,
which wouldn't happen till the kinks are worked out.

...actually, I guess I should say that if all the patches of the
current series do land then it actually _would_ still do something,
even without pseudo-NMI. Assuming the last patch looks OK, it would at
least start falling back to using regular IPIs to do backtraces. That
wouldn't get backtraces on hard locked up CPUs but it would be better
than what we have today where we don't get any backtraces. This would
get arm64 on par with arm32...

[1] https://issuetracker.google.com/281831288
