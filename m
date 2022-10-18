Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE76030A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJRQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJRQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:19:00 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EBCB7F78
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:59 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1321a1e94b3so17417673fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYZUlYSc4gqOFVsv65NI7ueFvWbNl7EItsPw2lHJXQw=;
        b=Y3/2lP+Avek2tukwyTqj0uIy/k7FtQYKk4gtgtZ6T7mQnIutVxW7DJL/HnLchhsfZJ
         eH9y+63dZ7JkujYGZrB5FmbyTX9T1X6sBR9pxHnn47l7ieY7ECGfiLzyQquF+H73uYSh
         g4AeCz8XeiTMn+fDRwwTAmFkvMNta8CsxD4DKszYPmC0gEbGSxlJskmlg8akTeLbu7qZ
         oQBDFzb31Qjms5s6XltPR51zOBG/17DZ4NhkusmHwo+WDg2SMf+9DM04FmhwzaZSBQ17
         lLdzil5PdBA6LO4edNQWOLSKz9Jg4TGD/7coimHXXkw1MOu6xti/VsgvHXpsRVFKDYxr
         v9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYZUlYSc4gqOFVsv65NI7ueFvWbNl7EItsPw2lHJXQw=;
        b=sSMCoV9O9CXwRl8Zyb8X/rix1bXIhWw7O8NKqzgXfFk70RKZSpDnp3IH81z/oAGbuj
         olBIcmOTPGOC0T6V869H5pPeJ6SazKyV4y3SYMpni4ysRdu2ADENrGPVEKc+A5gi8kIM
         xHB2kSdFdQVMja8Ly1P4XJww99GW0CuefSQpUoEVfZkbgodrhq4bgNBRf26FJbFtJj1H
         GG2FbWVKVy4CR8MVaKQlra3qh0NAVuRa+n354jOnZ5UnXpwE2HJ4PWLtN6N2BH/onpso
         14RZe70S6VFZuunyMRhHovyC0W932gFs52kOvQ7Tq+dA7RafNMV6mezyXtnmJdId5BfM
         EOVA==
X-Gm-Message-State: ACrzQf1t0p5DB73OrlX5latyUVVHF+fSiKfLmRFLEknEjYLRVhkXqF/m
        jRBQfGQnGIvkeKmRB/xI2EI=
X-Google-Smtp-Source: AMsMyM5lJjgYUQFrRHJqWw43YYndHirFZjvWBIiuqwHjhwDGAD3TjW7vuvznUnWaUTkcDIbEXP1CiQ==
X-Received: by 2002:a05:6870:b528:b0:134:75d:c87d with SMTP id v40-20020a056870b52800b00134075dc87dmr19011221oap.22.1666109938897;
        Tue, 18 Oct 2022 09:18:58 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w13-20020a056870430d00b0012d939eb0bfsm6250920oah.34.2022.10.18.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:18:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 09:16:48 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <Y07RcE3fgoGLpNZz@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com>
 <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de>
 <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
 <Y065nbfVQwZhwt51@yury-laptop>
 <Y067uYGTaA93Hn3z@smile.fi.intel.com>
 <Y06/SipcWdh4uIqd@yury-laptop>
 <CAMuHMdVjViT8-VMPuKZz2O1sudy5ogHpzVYM_P+isjRRUNgirw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVjViT8-VMPuKZz2O1sudy5ogHpzVYM_P+isjRRUNgirw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:15:41PM +0200, Geert Uytterhoeven wrote:
> Hi Yuri,
> 
> On Tue, Oct 18, 2022 at 5:01 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Tue, Oct 18, 2022 at 05:44:09PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 18, 2022 at 07:35:09AM -0700, Yury Norov wrote:
> > > > On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:
> > >
> > > ...
> > >
> > > > For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
> > > > to a value that matches to what's parsed from DT.

...

> I haven't tried the patch from your other email yet, but I did try
> CONFIG_NR_CPUS=4 and CONFIG_FORCE_NR_CPUS=y on
> Icicle earlier today.
> 
> There was no warning, as the number of CPUs did match, but the
> fourth CPU (cpu@4, i.e. the fifth core in DT) failed to come online:
> 
>     CPU3: failed to come online
>     smp: Brought up 1 node, 3 CPUs
> 
> BTW, it behaves the same with CONFIG_FORCE_NR_CPUS=n.
> Increasing CONFIG_NR_CPUS (before I used 8) makes the fourth
> CPU core come online again.

The problem is seemingly unrelated to CONFIG_FORCE_NR_CPUS...
If so, we don't need ARCH_UNFORCE_NR_CPUS. Is that right?

This all looks weird. RISCV hasn't an arch code to setup nr_cpu_ids,
and therefore should use generic setup_nr_cpu_ids(), which is:

  void __init setup_nr_cpu_ids(void)
  {
          set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
  }

Where:

  static inline void set_nr_cpu_ids(unsigned int nr)
  {
  #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
          WARN_ON(nr != nr_cpu_ids);
  #else
          nr_cpu_ids = nr;
  #endif
  }


As you can see, at this point cpu_possible_mask is initialized based
on DT, and even if arch has non-dense cpu_possible_mask, the logic
should still be correct.

Wish I could tell more, if I had an access to the hardware...

Thanks,
Yury
