Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238256F4671
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjEBOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEBOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:55:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE094
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:55:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a516fb6523so38453925ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683039338; x=1685631338;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEBqqVr8f6T0ZxjZz/v0fKyuttupB/BYEkIsIsUCLrY=;
        b=uFKV8JEP/0goAOcNDaRNn3xMCtbO6Fvs/yUtnl4o0OVvSB/7YlPui935jiwSUJikgE
         z3Q66AbJ+O1V+Htiegpz1BPuQTl5hNKil4dK7TbPLopppeT1N0ZN3ZVpeZXvL4bAsIDy
         2zCLAuN4tB5swf1VKOs7KmYzHoZ9nCffD48diIdl7XT4ZmniofcOXGZJV+ZD1HGseMmr
         VrkPIlZ2Uo0s3yuIrEnrLqFuD/D7DQ6DQLHEbAHIqFtT6zEc/1YoZUmCC5AaP6jzR2kp
         V4DAGUaioLJyvK2XfHKVUn9UT5CuVDZJg8I6CBFm/2ERAYrQdDlFV0oLSAhtDkciIwaD
         Zo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039338; x=1685631338;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEBqqVr8f6T0ZxjZz/v0fKyuttupB/BYEkIsIsUCLrY=;
        b=LlaCWKAKuldi/7y7nCOXHI0Dz53Dpnr/A3ZvzCB2bc47/BGxXJ5Vh6nh76NE+8nBX8
         fvTvEJ9mmdMNG8B1Hkb/NRD7T0QbWbZmlIEOsXLPh88+hXfXOZLz3aENYaoIwQxH2063
         z0D7mXL5VaREmCzUdLQu4ARIBNh/jCHe9IHEnhUD/tDfVVqrv7YQ1CV2/d27yQ/YtIFJ
         aREdYM+xtxxL+J4Oofzzc0mnRiLpdGB8EAslgk6NB0GLzRARXsAZNZWG/ZQEOltC0BQy
         Hzl43k95lUaOPxwv14nKWzSWwtuK6tsmBv2AwKBR75NNxu4ImGhUN1GSwFtxrCNYwGNB
         f6zA==
X-Gm-Message-State: AC+VfDxPRkDQ0xKH3BNLfqj6vI1YEpN3IRlS+IlSgzQT5k1kw5cKkF6f
        gbgWNfDt3HiJvXelY1e+O948L7IKyPjiu3Rbat2gRg==
X-Google-Smtp-Source: ACHHUZ6Q7O2+wVIuCv8rcE/aGBSd24ZYTbW2cO608oSQ7i7M8QNBhmNxHCaSR7w2/N5i7+G/648U+g==
X-Received: by 2002:a17:902:e805:b0:1aa:f6c3:ba24 with SMTP id u5-20020a170902e80500b001aaf6c3ba24mr8921721plg.4.1683039337662;
        Tue, 02 May 2023 07:55:37 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a96e24e487sm15620976plr.163.2023.05.02.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:55:35 -0700 (PDT)
Date:   Tue, 02 May 2023 07:55:35 -0700 (PDT)
X-Google-Original-Date: Tue, 02 May 2023 07:55:33 PDT (-0700)
Subject:     Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
In-Reply-To: <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com>
CC:     jrtc27@jrtc27.com, bjorn@kernel.org, heiko@sntech.de,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     philipp.tomsich@vrull.eu
Message-ID: <mhng-12185417-4256-4106-9bf5-2d14f66612db@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2023 00:03:59 PDT (-0700), philipp.tomsich@vrull.eu wrote:
> On Mon, 1 May 2023 at 22:08, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>
>> On 1 May 2023, at 20:55, Björn Töpel <bjorn@kernel.org> wrote:
>> >
>> > Heiko Stuebner <heiko@sntech.de> writes:
>> >
>> >> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>> >>
>> >> The hwprobing infrastructure was merged recently [0] and contains a
>> >> mechanism to probe both extensions but also microarchitecural features
>> >> on a per-core level of detail.
>> >>
>> >> While discussing the solution internally we identified some possible issues,
>> >> tried to understand the underlying issue and come up with a solution for it.
>> >> All these deliberations overlapped with hwprobing being merged, but that
>> >> shouldn't really be an issue, as both have their usability - see below.
>> >> Also please see the "Things to consider" at the bottom!
>> >>
>> >>
>> >> Possible issues:
>> >> - very much limited to Linux
>> >> - schedulers run processes on all cores by default, so will need
>> >>  the common set of extensions in most cases
>> >
>> > ...which hwprobe has support for via the CPU mask. no?
>> >
>> >> - each new extensions requires an uapi change, requiring at least
>> >>  two pieces of software to be changed
>> >> - adding another extension requires a review process (only known
>> >>  extensions can be exposed to user-space)
>> >> - vendor extensions have special needs and therefore possibly
>> >>  don’t fit well
>> >>
>> >>
>> >> Limited to Linux:
>> >> -----------------
>> >>
>> >> The syscall and its uapi is Linux-specific and other OSes probably
>> >> will not defer to our review process and requirements just to get
>> >> new bits in. Instead most likely they'll build their own systems,
>> >> leading to fragmentation.
>> >
>> > There are a number of examples where multiple OSs have followed what
>> > Linux does, and vice versa. I'd say the opposite -- today system
>> > builders do not do their own solution, but review what's out there and
>> > mimics existing ones.
>>
>> Where they can. But if the interface is “make architecture-dependent
>> syscall X” that’s not going to fly on other OSes where syscalls are not
>> architecture-dependent. Similarly if it’s “go read auxarg Y” where Y is
>> architecture-dependent and the OS in question has
>> architecture-independent auxargs. Or the system doesn’t even have
>> auxargs. Now, at the end of the day, I couldn’t care less what Linux
>> does to communicate the information to userspace, what matters is what
>> the userspace interface is that random IFUNCs are going to make use of.
>> Something which seems to be woefully lacking from this discussion. Is
>> the interface going to just be syscall(2)? Or is there going to be some
>> higher-level interface that other OSes *do* have a hope of being able
>> to implement?
>>
>> > Personally I think this argument is moot, and will not matter much for
>> > fragmentation.
>> >
>> >> Feature on all cores:
>> >> ---------------------
>> >>
>> >> Arnd previously ([1]) commented in the discussion, that there
>> >> should not be a need for optimization towards hardware with an
>> >> asymmetric set of features. We believe so as well, especially
>> >> when talking about an interface that helps processes to identify
>> >> the optimized routines they can execute.
>> >>
>> >> Of course seeing it with this finality might not take into account
>> >> the somewhat special nature of RISC-V, but nevertheless it describes
>> >> the common case for programs very well.
>> >>
>> >> For starters the scheduler in its default behaviour, will try to use any
>> >> available core, so the standard program behaviour will always need the
>> >> intersection of available extensions over all cores.
>> >>
>> >>
>> >> Limiting program execution to specific cores will likely always be a
>> >> special use case and already requires Linux-specific syscalls to
>> >> select the set of cores.
>> >>
>> >> So while it can come in handy to get per-core information down the road
>> >> via the hwprobing interface, most programs will just want to know if
>> >> they can use a extension on just any core.
>> >>
>> >>
>> >> Review process:
>> >> ---------------
>> >>
>> >> There are so many (multi-letter-)extensions already with even more in
>> >> the pipeline. To expose all of them, each will require a review process
>> >> and uapi change that will make defining all of them slow as the
>> >> kernel needs patching after which userspace needs to sync in the new
>> >> api header.
>> >>
>> >>
>> >> Vendor-extensions:
>> >> ------------------
>> >>
>> >> Vendor extensions are special in their own right.
>> >> Userspace probably will want to know about them, but we as the kernel
>> >> don't want to care about them too much (except as errata), as they're
>> >> not part of the official RISC-V ISA spec.
>> >>
>> >> Getting vendor extensions from the dt to userspace via hwprobe would
>> >> require coordination efforts and as vendors have the tendency to invent
>> >> things during their development process before trying to submit changes
>> >> upstream this likely would result in conflicts with assigned ids down
>> >> the road. Which in turn then may create compatibility-issues with
>> >> userspace builds built on top of the mainline kernel or a pre-
>> >> existing vendor kernel.
>> >>
>> >> The special case also is that vendor A could in theory implement an
>> >> extension from vendor B. So this would require to actually assign
>> >> separate hwprobe keys to vendors (key for xthead extensions, key for
>> >> xventana extensions, etc). This in turn would require vendors to
>> >> come to the mainline kernel to get assigned a key (which in reality
>> >> probably won't happen), which would then make the kernel community
>> >> sort of an id authority.
>> >>
>> >>
>> >>
>> >>
>> >> To address these, the attached patch series adds a second interface
>> >> for the common case and "just" exposes the isa-string via the
>> >> AT_BASE_PLATFORM aux vector.
>> >
>> > *A second interface* introduced the second hwprobe landed. Really?
>> > Start a discussion on how to extend hwprobe instead.
>>
>> I’ve been trying to push for something other than this for months, but
>> RVI took no interest in dealing with it until it got closer to these
>> landing, at which point finally some action was taken. But even then,
>> heels were dragged, and it took hwprobe being landed to force them to
>> finally publish things. But of course too late, so now the ecosystem is
>> forever screwed thanks to their inaction.
>
> I am similarly frustrated as I had been asking for a universally
> acceptable solution since August 2021 (and Kito gave a presentation on
> the issue at LPC21) that was meant to avoid system calls; however, the
> design of hwprobe has happened outside of RVI and without getting RVI
> involved to drive coordination between members.

Linux development happens on LKML, not at RVI.  If you want to 
participate you need to do so on the mailing lists.  We have been 
through this many times over the years.

> The bottleneck (in cases like this one) at RVI is that it is
> volunteer-driven and dependent on the buy-in of its membership: there
> are no technical resources except for us company delegates.  If

Though apparently you have resources to start a pointless flame war 
after everyone else has agreed on a solution.

> members decide to work a gap without involving RVI, then the chances
> of fragmentation are high.  Nothing we can do about that, as RVI is
> not a traffic cop.

This isn't the first time you've complained you have no resources to do 
the work, but then gotten mad when someone else does.  That's not 
constructive behavior, please stop.

>> All I wanted was some simple extension string -> version number function
>> as a standardised userspace interface... because at the end of the day
>> people just want to know “can I use extension Y?”, possibly with a
>> minimum version. But maybe there’s some hope that Linux libcs will
>> translate such queries into poking at this hwprobe thing. Though god
>> knows what they’re going to do about vendor extensions, especially if
>> those vendor extensions only get supported in vendor forks of the
>> kernel (who’s allocating their encodings? Xvendorfoo exists to
>> namespace them and give vendors control...).
>
> The support for vendor extensions without a central registry remains
> the strongest reason for a different interface, as RISC-V has the
> flexibility to add vendor extensions as one of its strongest selling
> points.
>
> It is a pity that the current interface was designed without involving
> RVI (and that I had to ask my team to put together a patch set for

We talked about this at Plumbers, you and Mark (the RISC-V CTO) were both 
there.  Additionally this has been discussion on the mailing list for 
the better part of a year, including proposals similar to this one.  
Pretending nobody from RVI was involved is just blatantly false.

This isn't the first time we've had the RVI leadership making false 
statements in order to drum up controversy on the mailing lists.  Please 
stop, we have real work to do and this just gets in everyone's way.

> further discussion, given that none of the other major vendors in RVI
> stepped forward).  I guarantee that plenty of reviewers would have
> highlighted that a central registry (even if it is just a kernel
> header) should be avoided.

This has been reviewed by engineers from multiple vendors on LKML, 
including Hekio who sent this patch set.

> So what is the best way to support vendor-defined/vendor-specific
> extensions without a central registry?

Stop with the pointless flame wars.
