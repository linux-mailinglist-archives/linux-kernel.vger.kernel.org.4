Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D161FD53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiKGSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiKGSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:20:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC918341
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:20:46 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t62so13009788oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mjd3cGRCLj/jP/pf/MBxRxarevBpDlFo2GaY3XrL44Y=;
        b=m3fvib6JZDZhhDUKCvsaORXMcowcN6j41cz/f2/osZzCc5YPSAmEyyR05mK2h+47vm
         3jP53WAyvmQKsnt3/GuWVxvujL/z8Zl1gYxtORtrJMsZ6HMoIKCmFyNoe4jNGua2/K57
         Xl8aj2zehauWC9IZitf7gALe3/XKaraDfhDFATp4CVNyGgPDajMBxRCfDNFlQvbn/e32
         FC1YX89sFsQHTzBJbODv3Lggg46hp7HOXLJFPjXmgsCqFT0WQq8DzIjncsUS0C84FOY5
         319QSwhP6VWwDWAuhRc5+FmV7wuo3iS2Qi4x9nsq6sZlJ423d4sfXvZtMR7T/po1XT+9
         PQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mjd3cGRCLj/jP/pf/MBxRxarevBpDlFo2GaY3XrL44Y=;
        b=jy3K6u3vT2rIIGha7BGTKDuHHX34TtBW6Sj59R2i8JBBqDEqXHxYhqGySlRIVAWY7I
         +qVgcSbVyDVXUg12Ku5+RuT8OBQfEBVopkVoMBS3c5tizoTi2/mD/FEPO4c9ni+sOmSN
         vOc5s+WwiddbWhe4XvG/I5cNgRpIw8VWby8PYAgYqMN1OzMxxHpjI+B9p/QDPTyc1jIU
         7QlbC7ywkuaCJ+XMMT0xMy+QwLId8aQmgJvcj8vsqbPl/5MSz0Y82lkkMML2UtEqNrjW
         uqPNHuNDAug12l+VCj9Cv51ynHnc8HNFVtYJyNjB2RVbbIuWTQKn5jfUtGo4YpYhIWoI
         Acdw==
X-Gm-Message-State: ACrzQf2alH/TJFKHxZZbobgl7NcFT1e7mUVJmIfbjrumNkBseYxtN04Y
        +0B22KGD6JkOnlK9wsIwiTM=
X-Google-Smtp-Source: AMsMyM5GL4aj762jB/qq3OA83sP9lnkR9nKnmncHvBSPZp3NuO0+i/snHcm1vnNpaZ3SADCYmIxx0w==
X-Received: by 2002:a05:6808:1b0c:b0:35a:eb4:3619 with SMTP id bx12-20020a0568081b0c00b0035a0eb43619mr24180748oib.116.1667845245290;
        Mon, 07 Nov 2022 10:20:45 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id s16-20020a4adb90000000b0047f72b6988fsm2408289oou.45.2022.11.07.10.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:20:44 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:20:43 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
Message-ID: <Y2lMe/1sIKvxvuKf@yury-laptop>
References: <20221019225939.1646349-1-yury.norov@gmail.com>
 <xhsmhtu3evcme.mognet@vschneid.remote.csb>
 <Y2WT5qVi+YU2VEXU@yury-laptop>
 <xhsmhzgd3lyqx.mognet@vschneid.remote.csb>
 <CAHk-=wjSVUpjh0UZW+w0C633gQo=-JhGH9ja8kUmRW0TUcSMpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSVUpjh0UZW+w0C633gQo=-JhGH9ja8kUmRW0TUcSMpw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:55:34AM -0800, Linus Torvalds wrote:
> On Mon, Nov 7, 2022 at 4:45 AM Valentin Schneider <vschneid@redhat.com> wrote:
> >
> > True, this would have been neater as a single config, but AIUI it's a
> > required "trick" for allyesconfig. I would have expected other configs to
> > have hit similar issues in the past, but didn't find any.
> 
> Actually, the standard trick for allmodconfig and allyesconfig is to
> use the "COMPILE_TEST" config variable.
> 
> It's basically a variable for "I'm not going to *run* the result, but
> I want to make sure to get build coverage".
> 
> And both allmodconfig and allyesconfig set that config option.
> 
> In most cases, the "COMPILE_TEST" config variable is used to enable
> things that wouldn't make sense on the chosen hardware platform, so
> you have things like
> 
>         depends on ARCH_DAVINCI || COMPILE_TEST
> 
> because some driver only makes sense on ARCH_DAVINCI, but people still
> want the build coverage.
> 
> But sometimes it's used the other way around, so fro example on x86 we have
> 
>      config X86_DECODER_SELFTEST
> 
> which explicitly depends on COMPILE_TEST *not* being set, because it's
> a test that takes forever to run (particularly for huge kernels), and
> so it's actually disabled for the  common all{yes,mod}config cases.
> 
> Same goes for things like LTO_CLANG_FULL. It's just expensive for big
> build tests, plus causes too many issues for now.
> 
> End result: if some option actually *reduces* test coverage, or has
> some other reason why it makes no sense for build tests, use that
> 
>         depends on !COMPILE_TEST
> 
> to not have allmodconfig and allyesconfig pick it.

Thanks, I'll send v3 than.

Thanks,
Yury
