Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5F5B5CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiILO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiILO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:58:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C061582B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:58:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-345528ceb87so104068737b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=e79vEofZ9N/t1Dt7lOD1eiAAOpYQXB8oOUTFmaudJBM=;
        b=lvYsOFuatcWlJlG4i5qGjRIb71C8BQ8EpDowfMruzhqCvf7ifF5tLenQVQvNYuxufI
         uDn+t/B0S2oujl27GUOeGfqbqzzHJHKoUrWV/GF5H9Z0WhbKaQA/VmU1QSDll6q6bqKS
         30xxyntO7ldDcWDciH3CtfNwdOnM2oHapKd30MLn3ee6HYjq/KSHNJQZq7+1BkMg4EkJ
         fee7E3i0HtApNkO5OZHEisn9txCn4kAb9MhqsZqo/r+1eKT3OXc1nrdRddJKpG1cIKi3
         Ko67m9q4l9+ln44bYsBNy3ow791ab7K9Duvq8fd76ejIbHEPV12bjn17dPJ0ejr+1QUU
         cSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=e79vEofZ9N/t1Dt7lOD1eiAAOpYQXB8oOUTFmaudJBM=;
        b=T/MCiEDU1o2HPGrBv1ZwXS3V8g++iqjqwy3mix9VYV4MLxyfV9AYVICv3BRdQVdtwF
         /qj9AD3IX/RMTqXZQfwEmRiOkuXZzVfPuN4li/DlQIZdL600jgdMW+xQmzC12nD8GL1c
         BvkwbT84iShwhsTYkUf+oosdDIUuLbivOAexA4Lk1D/o7tqKmSWCqoP21wEezDkNF0/o
         WiQeJ6q+DSVfhVCTiXawOkkFZr1Yt+Wjnf6hsisnM0cn1dLT+gmA8asqnFphccVCGnPu
         XROM88oBGr+eva81NH7uBsa63S2IQ+96GWbu4NNslbvN1WcGyZI4+wCDccgTSTilYvRg
         8zTA==
X-Gm-Message-State: ACgBeo0/KvzG7Y9NM6Bf9rdtk3gda7iqiD2Nx49JQ5v4FnFMMHNZBFbm
        4e2fTwkLo01gV7KcvbWWPSiwPJYq25ThzzMCiheQOHnRRWw=
X-Google-Smtp-Source: AA6agR7VyYhulbHt8mYulK7Jpgrv1T3Y+ll1VEkVzwAq76KYaxRXPf9PCzn7yb/IREE0WHfoM6te/gsnAP9a3TPna5k=
X-Received: by 2002:a81:6c4e:0:b0:345:3877:9ed7 with SMTP id
 h75-20020a816c4e000000b0034538779ed7mr22074247ywc.515.1662994713961; Mon, 12
 Sep 2022 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220912053755.156704-1-senozhatsky@chromium.org>
 <CADyq12yWFMyTRCQmmGoLg7epvXRWu-XqKMS4N2vEomvvuWNpBA@mail.gmail.com>
 <Yx9EMhwLXnDYlQwd@google.com> <Yx9HfpsJ3JJZLJJ9@google.com>
In-Reply-To: <Yx9HfpsJ3JJZLJJ9@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 12 Sep 2022 10:57:38 -0400
Message-ID: <CADyq12yK98A3Gn8qA+PiYFsT+Oj7nJKROSenW-kse_LLf4ziyQ@mail.gmail.com>
Subject: Re: [PATCH] zram: do not waste zram_table_entry flags bits
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:51 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/12 23:37), Sergey Senozhatsky wrote:
> > > > -#define ZRAM_FLAG_SHIFT 24
> > > > +#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
> > >
> > > Why not just hard code 16 with an explanation that it cannot be
> > > increased further using the analysis you did in the other thread? It's
> > > going to be tricky to reason about how many free flag bits actually
> > > remain with PAGE_SHIFT across all architectures, especially given we
> > > have no architecture specific flags.
> >
> > Well, zram should not make any assumptions on arch code. How do
> > we know that PAGE_SHIFT 16 is the max value we will ever have?
> > Some arch can come around someday and use PAGE_SHIFT say, 18,
> > and we won't be aware of it (using hardcoded value of 16) until
> > someone hits a really hard to debug problem in zram.
>
> And I'd probably also add something like this, to keep us alert should
> we run out of bits in the future:
>
> ---
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index f3948abce2f7..07913bcdb5c2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2449,6 +2449,8 @@ static int __init zram_init(void)
>  {
>         int ret;
>
> +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
> +

Thanks Sergey, yes, with the BUILD_BUG_ON I think using PAGE_SHIFT is
fine, my concern was primarily that a flag could overwrite a bit of
the size field, a BUILD_BUG_ON addresses that.

>         ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
>                                       zcomp_cpu_up_prepare, zcomp_cpu_dead);
>         if (ret < 0)

Thanks,
Brian
