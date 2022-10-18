Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A7602F14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJRPBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJRPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:01:38 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281DB5167
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:01:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso7767316otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI7ij/O+BSLU/t/Hdd+xrpFJ0CCm9rH48Y2X7l03iy8=;
        b=W/eRXiRCD8z9KFyxp5NwSjDvAORN/Uqo67mkzrL2ojeDzzj7SQrDsrefZIL1w5EBIR
         S9ZBS5oi+0JoWJXcsX2A6jmMbx5WrqVMHNbu1r7dYdxvUgZ3J+BndBdL9JlFf2VzL2Si
         PY149hfGF5eXBv9Ntw1dXU8wa5llaJT6EYOSHhC0eVz1Grto7dghBYr/R5U/U9ahJr1L
         MBhnfZR/FNtygbC5vU7Rv4hGuzINRZhgjqETMuzzZaFgMoNSG0dS2oFyIUMPeI9cLX5/
         7Dp6h9wEEmHxlmc3HwM0LHZ1oYsWgizQABze6A1w47shY/RNbiMIzYPkXw+3ZRssedXk
         z15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI7ij/O+BSLU/t/Hdd+xrpFJ0CCm9rH48Y2X7l03iy8=;
        b=VARQJo2hqFD58WyVvBdst0yVibzqqt1fHetnqCODh9/JIXzV04JybkFpVZuQtRkdtr
         f0l5mgtCOKNAxG7FnrY6ccK58wlzOGzjlgf89YTwXfqjKthbKx3SbvgdbTuKz8Z8N9/O
         W7ZBO9dAIYuY8wnz9QZhZ8OmwfjScLr48dKKGZOxPMB9AXXew3hQ6x0shTQ0MDovAbd0
         IIE1vYdel7fvBKyWrVZH0a8mJaZ7wWYMx54TfyBVkzKh7rom7a4ehNn0QfXTPtc5k5J1
         aZFpYjyAWhCDpFArxMVjWRyqpma9SHqBOZ2429fYvxz+pOpP7nuge3yGsgJO3f5dLuZc
         3cKQ==
X-Gm-Message-State: ACrzQf2OH1UC60MoiREQ6jZJFh/nWAp/WCtcwdCSEdwdn/Yv/Akjna5p
        YlViuUTunAt9jV9oA+qL3R0=
X-Google-Smtp-Source: AMsMyM5dxqvwl2xST5anu3oixMG5EhIq4rZx1LRoGSjUdGxEjruYBC6VxddSypGolpxyRDThAvGxIw==
X-Received: by 2002:a05:6830:4120:b0:661:d839:cc63 with SMTP id w32-20020a056830412000b00661d839cc63mr1559640ott.51.1666105294679;
        Tue, 18 Oct 2022 08:01:34 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id x27-20020a056870a79b00b001372c1902afsm6224450oao.52.2022.10.18.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:01:33 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:59:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
Message-ID: <Y06/SipcWdh4uIqd@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com>
 <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de>
 <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
 <Y065nbfVQwZhwt51@yury-laptop>
 <Y067uYGTaA93Hn3z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y067uYGTaA93Hn3z@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:44:09PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 18, 2022 at 07:35:09AM -0700, Yury Norov wrote:
> > On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:
> 
> ...
> 
> > For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
> > to a value that matches to what's parsed from DT.
> > 
> > Can you please look at the draft below that disables FORCE_NR_CPUS
> > in allmodconfig? If it's OK with you, I'll send a patch. If you think
> > that there are architectures where it's not possible to set correct
> > NR_CPUS at compile time for some reason, I'll add ARCH_UNFORCE_NR_CPUS
> > option.
> 
> Instead you may simply add
> 
> 	depends on CONFIG_$ARCH/$MACHINE=n
> 
> and so on to the FORCE_NR_CPUS, no?

Yes, if there's just one machine like that. If there's many of them, the
'depends' list would be too long.

I hope there's no such a weird machines, and we don't need that at
all. Let's see what Geert will say.

