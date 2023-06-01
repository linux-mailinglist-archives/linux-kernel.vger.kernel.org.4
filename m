Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81FB71F520
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjFAVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFAVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:54:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0A180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:54:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77489b6f68cso15701139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685656448; x=1688248448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLtvBlY/v8HYwh0Fbm6omkkXXBfFwuezcGJpiAwvtOM=;
        b=j7aB1DETV9ClYkDuraayoeUypuEpA4IJvV8z1+Up9Xc1Q3tDZuosP9opBNW2+SMANA
         Hndu5oCJgmuP4JsweLCxV6atsFrNJ/qtrg944xRV2i6QiMw0zAtL3dylwuBnUmmgSZu6
         EIzRmC7IP8jxCxaX/ZsJf94s3yWxyqzjvkz1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656448; x=1688248448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLtvBlY/v8HYwh0Fbm6omkkXXBfFwuezcGJpiAwvtOM=;
        b=A+/Z9Mg/qb3inWY6CzU1akLx5Ev9HC3eHuVCxMzd7+gIsq14m9kTa6inQk/1Emauhb
         Ba7cZLsuem41UXFloaufM2es7bSXqKxLyyTirIxEE62YifJB5rO8w1Rgheiou3CREdXX
         62lGUSS5rhkjq85rqwzWVIho38uX+66lilkviRtOwNdIUn61jDZAlJsCIJ7GcTagu1FN
         AthEMimIJYwpn0hr1AgJxIKn/cykbo7fUvHFAAvYUmBWXozxl5SPsYbHeFKTtnoVx9Xe
         eCJPa/SjqRMrXEsYPIuBF1AFLEyUxmKdQEVnxq2rQR4PC1GC8YdIQ68FEMb/4GS0y3tu
         PRCQ==
X-Gm-Message-State: AC+VfDwjcXw8NQtE5Lriy33/cwrvufP1DEqLT6S3GlEm4s+9BYhTI1cr
        giMDuEvkZk+YQ5Ta8owPnYBvUWXHOV4Ye5hXZuQ=
X-Google-Smtp-Source: ACHHUZ5NY+yQnGcICNiPzqUszMaZZMbmLzW2fKTDZb2x/WORUdiL9P8OseddOHIbiLOhzxbYD7HPmg==
X-Received: by 2002:a5e:a802:0:b0:774:94e1:3aee with SMTP id c2-20020a5ea802000000b0077494e13aeemr610007ioa.6.1685656448449;
        Thu, 01 Jun 2023 14:54:08 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id m24-20020a026d18000000b0041ac9dd35f0sm2390994jac.132.2023.06.01.14.54.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 14:54:08 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so12305ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:54:07 -0700 (PDT)
X-Received: by 2002:a05:6e02:17c7:b0:33b:7a45:a950 with SMTP id
 z7-20020a056e0217c700b0033b7a45a950mr70308ilu.18.1685656003076; Thu, 01 Jun
 2023 14:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
 <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
In-Reply-To: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Jun 2023 14:46:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx=64ZYqNvOBRHu-+yFWtxkzCyjAxZED2xEFqoMKvAqQ@mail.gmail.com>
Message-ID: <CAD=FV=Vx=64ZYqNvOBRHu-+yFWtxkzCyjAxZED2xEFqoMKvAqQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 9:42=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, May 10, 2023 at 9:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> > > Hi,
> >
> > Hi Doug,
> >
> > > On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > > This is an attempt to resurrect Sumit's old patch series [1] that
> > > > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs an=
d
> > > > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > > > could find was v7, so I called this series v8. I haven't copied all=
 of
> > > > his old changelongs here, but you can find them from the link.
> > > >
> > > > Since v7, I have:
> > > > * Addressed the small amount of feedback that was there for v7.
> > > > * Rebased.
> > > > * Added a new patch that prevents us from spamming the logs with id=
le
> > > >   tasks.
> > > > * Added an extra patch to gracefully fall back to regular IPIs if
> > > >   pseudo-NMIs aren't there.
> > > >
> > > > Since there appear to be a few different patches series related to
> > > > being able to use NMIs to get stack traces of crashed systems, let =
me
> > > > try to organize them to the best of my understanding:
> > > >
> > > > a) This series. On its own, a) will (among other things) enable sta=
ck
> > > >    traces of all running processes with the soft lockup detector if
> > > >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace".=
 On
> > > >    its own, a) doesn't give a hard lockup detector.
> > > >
> > > > b) A different recently-posted series [2] that adds a hard lockup
> > > >    detector based on perf. On its own, b) gives a stack crawl of th=
e
> > > >    locked up CPU but no stack crawls of other CPUs (even if they're
> > > >    locked too). Together with a) + b) we get everything (full locku=
p
> > > >    detect, full ability to get stack crawls).
> > > >
> > > > c) The old Android "buddy" hard lockup detector [3] that I'm
> > > >    considering trying to upstream. If b) lands then I believe c) wo=
uld
> > > >    be redundant (at least for arm64). c) on its own is really only
> > > >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> > > >    (see [4]). a) + c) is roughly as good as a) + b).
> >
> > > It's been 3 weeks and I haven't heard a peep on this series. That
> > > means nobody has any objections and it's all good to land, right?
> > > Right? :-P
> >
> > FWIW, there are still longstanding soundness issues in the arm64 pseudo=
-NMI
> > support (and fixing that requires an overhaul of our DAIF / IRQ flag
> > management, which I've been chipping away at for a number of releases),=
 so I
> > hadn't looked at this in detail yet because the foundations are still s=
omewhat
> > dodgy.
> >
> > I appreciate that this has been around for a while, and it's on my queu=
e to
> > look at.
>
> Ah, thanks for the heads up! We've been thinking about turning this on
> in production in ChromeOS because it will help us track down a whole
> class of field-generated crash reports that are otherwise opaque to
> us. It sounds as if maybe that's not a good idea quite yet? Do you
> have any idea of how much farther along this needs to go?

I'm still very interested in this topic. Do you have anything concrete
that is broken? Your reply gives me the vibe that there have been a
bunch of bugs found recently and, while there are no known issues,
you're worried that there might be something lingering still. Is that
correct, or do you have something concrete that's broken? Is this
anything others could help with? I could make an attempt, or we might
be able to rope some of the others interested in this topic and more
GIC-knowledgeable to help?

I still have a goal for turning this on for production but obviously
don't want to make the device crashier because of it.

Also: if this really has known bugs, should we put a big WARN_ON splat
if anyone tries to turn on pseudo NMIs? Without that, it feels like
it's a bit of a footgun.


> ...of
> course, we've also run into issues with Mediatek devices because they
> don't save/restore GICR registers properly [1]. In theory, we might be
> able to work around that in the kernel.

To followup with this, we've formulated a plan for dealing with
Mediatek Chromebooks. I doubt anyone is truly interested, but if
anyone is the details are in the public Google bug tracker [1]. None
of that should block lading the NMI backtrace series.


> In any case, even if there are bugs that would prevent turning this on
> for production, it still seems like we could still land this series.
> It simply wouldn't do anything until someone turned on pseudo NMIs,
> which wouldn't happen till the kinks are worked out.
>
> ...actually, I guess I should say that if all the patches of the
> current series do land then it actually _would_ still do something,
> even without pseudo-NMI. Assuming the last patch looks OK, it would at
> least start falling back to using regular IPIs to do backtraces. That
> wouldn't get backtraces on hard locked up CPUs but it would be better
> than what we have today where we don't get any backtraces. This would
> get arm64 on par with arm32...

The more I thought about it, the more I liked the idea of going full
hog on the idea in patch #10. I've posted v9 [2] where I've really
embraced the idea of falling back to a regular IPI if NMI isn't
available. Hopefully it looks keen.

[1] https://issuetracker.google.com/281831288
[2] https://lore.kernel.org/r/20230601213440.2488667-1-dianders@chromium.or=
g

-Doug
