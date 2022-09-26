Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83505EB123
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIZTRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIZTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:17:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692059C2CA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:17:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b23so4715153qtr.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=q8munikSll6ds8QrY3EUs90jbennWh1xIHh3UwOd5AQ=;
        b=ONi7B1LnHiDZrjcx5A0IBTCb+/6oA/NowgJzWt+cYqiqiAkSQSXZFL/pc4A3lOqvcP
         ONcmazaoqHIJtHKeRB1z9tqA+KAXXF2G1ZIn6gqIz2yV3/pM1K4VMIPwKXylyUvyXIvt
         lzluvb0LXb3tsn6OUIWc5T5NBO/AICNetiJhw/8FHFlyFYAwcwxlf+LuRZAEIGPBcFb8
         K/dvK8Gn3hzRVwwH2sXIPMv8lw+op9ccXj3Qs2qfP6HCY0o5ppY9wvIv+iSDPQVXQvhU
         diITqP8+2MEY2rDdP0OKxK256jpsJMY7OC7LhHjy1+LHEc590G7ntDpwpMlWEYKcnP/o
         wj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q8munikSll6ds8QrY3EUs90jbennWh1xIHh3UwOd5AQ=;
        b=O+RLSyiQ9/EQzbZdtvHj5ifTGUOKj9WJvyEzZrwN7q4l/KvHAnnv3RAwdd6OIaUr5C
         uAapETuVR39YZeyK7u0h+ic50rRePrEXKLH6pPpjYuLIbCmARWlZmUSNGxY+oQxb1eyR
         /5zTdSL+R6rDzZdE2QUhGKhHkNJeOQFfdHR9PtLeKcV6YKLQ9dkkXgWnCW8dSC+hA5xu
         nmVDG58c5efZE3ahXHkcDWv+1N8pY2U6cGbKb9HqSSh0E5e6KCylHKmG4/pVAP7x+RwR
         4ACTmNEy5ZOg3qthWk3UUlm6gVtM05beYqjHcfbVxuS8zizzHGXUgUfPQCV9lZpszZsW
         9aMw==
X-Gm-Message-State: ACrzQf0NzCvzgn0Tovbr617X1nT6XefKSRZ9/iH6V/gkgcSU5iuxuL1x
        1Iebd844TjNyEKTtVbd7+Qju9tzV4b8=
X-Google-Smtp-Source: AMsMyM5sD1YyCz5Y8EahH0Ps4TaReW+3qYg8pQ1ks1fWqhZy1h++Ixg5G1z53K4fSJRbOjX2QyOILg==
X-Received: by 2002:a05:622a:2c5:b0:35d:4ade:e0c3 with SMTP id a5-20020a05622a02c500b0035d4adee0c3mr275127qtx.414.1664219839171;
        Mon, 26 Sep 2022 12:17:19 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:155c:f237:bceb:6273])
        by smtp.gmail.com with ESMTPSA id ay43-20020a05620a17ab00b006ce76811a07sm11954756qkb.75.2022.09.26.12.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:17:18 -0700 (PDT)
Date:   Mon, 26 Sep 2022 12:17:17 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/5] lib/find: add find_nth_bit()
Message-ID: <YzH6vWKGzx8jJtta@yury-laptop>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
 <Yy3cYtJCRiFvFV2e@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3cYtJCRiFvFV2e@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, take in bitmap-for-next.

On Fri, Sep 23, 2022 at 09:18:44AM -0700, Yury Norov wrote:
> Ping?
> 
> On Sat, Sep 17, 2022 at 08:07:10PM -0700, Yury Norov wrote:
> > Kernel lacks for a function that searches for Nth bit in a bitmap.
> > Usually people do it like this:
> >   for_each_set_bit(bit, mask, size)
> >           if (n-- == 0)
> >                   return bit;
> > 
> > Which is not so elegant and very slow.
> > 
> > This series adds fast routines for this task, and applies them where
> > appropriate.
> > 
> > v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
> > v2: https://lore.kernel.org/lkml/CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com/T/
> > v3:
> >  - add bitmap_weight_and() and use it in cpumask_local_spread();
> >  - rework find_nth_bit() family: similarly to [1], introduce
> >    FIND_NTH_BIT(), and optimize the function to return earlier when
> >    it's known that the rest of bitmap can't meet the requirement.
> >  - patch "lib/nodemask: inline next_node_in() and node_random()" has
> >    been merged, so drop it from this series.
> > 
> > On top of:
> > [1] https://lore.kernel.org/lkml/20220915020730.852234-1-yury.norov@gmail.com/T/
> > 
> > Yury Norov (6):
> >   lib/bitmap: don't call __bitmap_weight() in kernel code
> >   lib/bitmap: add bitmap_weight_and()
> >   lib: add find_nth(,and,andnot)_bit()
> >   lib/bitmap: add tests for find_nth_bit()
> >   lib/bitmap: remove bitmap_ord_to_pos
> >   cpumask: add cpumask_nth_{,and,andnot}
> > 
> >  fs/ntfs3/bitmap.c        |  4 +-
> >  include/linux/bitmap.h   | 13 +++++-
> >  include/linux/bitops.h   | 19 +++++++++
> >  include/linux/cpumask.h  | 55 +++++++++++++++++++++++++
> >  include/linux/find.h     | 86 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/nodemask.h |  3 +-
> >  lib/bitmap.c             | 68 ++++++++++++-------------------
> >  lib/cpumask.c            | 28 ++++++-------
> >  lib/find_bit.c           | 44 ++++++++++++++++++++
> >  lib/find_bit_benchmark.c | 18 +++++++++
> >  lib/test_bitmap.c        | 47 +++++++++++++++++++++-
> >  11 files changed, 320 insertions(+), 65 deletions(-)
> > 
> > -- 
> > 2.34.1
