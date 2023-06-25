Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C773D1B9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFYPeU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjFYPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:34:18 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57AE47
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:34:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1153855276.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687707256; x=1690299256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em86VtDkd1foZmdIW9TVdQbVnG2xtBG9ePF3h2l9uqI=;
        b=XOGSy9Dk+QYFmHiRfcEGAzL+YFnTPf6NyOYxdgmmQYvRs60qZjQ2EgOVsufqBN0R5M
         A43QGcHlKfJytstJggPRYknclu6MiCLJdvV+O1kHFvKxopyFR5tJr0MOrHliFhEeJLh2
         1lcOS/U3GpsTQC8Vs7mrQbokE3apxnQ3KD6oRQnY3BZpUZItjS8/l8YJ5/375L2xzx4L
         5dJfCtOZzSTZDl1LsWBFy/QO0zWXoSf5+GVELhDzli2k6VB6Nw6GqtNeA/rFZ6r1kCeL
         LxmwyGOCR74jk5K97ArtGkDDUHzRGNYFb0H8OrZ8sFLmXgrsBncPr76vLzvzAYJVOURs
         4/6A==
X-Gm-Message-State: AC+VfDxqp2MGPHOPxS3G7NMkwx1rpiZf8OURIEHvzRzMOFbrh78gKzK4
        tUajwS8VzDL1VWxvE881jcyxcBFer6JhaA==
X-Google-Smtp-Source: ACHHUZ7Ddykp4N0gHuljzhkforLwAPtSgT4aQ7maXZJ7q7G4NxAPOPfp9QHNQoXgddvGEDMmRkB3eA==
X-Received: by 2002:a81:6942:0:b0:55d:8cee:96e9 with SMTP id e63-20020a816942000000b0055d8cee96e9mr29804452ywc.5.1687707255832;
        Sun, 25 Jun 2023 08:34:15 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id r185-20020a815dc2000000b0056ffca5fb01sm852447ywb.117.2023.06.25.08.34.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:34:14 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1153824276.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:34:14 -0700 (PDT)
X-Received: by 2002:a81:7c41:0:b0:576:777f:28bc with SMTP id
 x62-20020a817c41000000b00576777f28bcmr7920762ywc.21.1687707254518; Sun, 25
 Jun 2023 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
 <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain> <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
 <1059342c-f45a-4065-b088-f7a61833096e@kili.mountain> <CAMuHMdW3NO9tafYsCJGStA7YeWye8gwKm2HYb72f1PRXGfXNWg@mail.gmail.com>
 <206F3FDB-59BE-4386-82D2-6FF3CD16D053@oracle.com>
In-Reply-To: <206F3FDB-59BE-4386-82D2-6FF3CD16D053@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 17:34:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWX_fNxiPSBbWVSwSM+go_=1dccCK9jaYkR+2U14FR8pg@mail.gmail.com>
Message-ID: <CAMuHMdWX_fNxiPSBbWVSwSM+go_=1dccCK9jaYkR+2U14FR8pg@mail.gmail.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744 __alloc_pages+0x2e8/0x3a0
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

On Sun, Jun 25, 2023 at 5:17 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Jun 25, 2023, at 4:46 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, May 13, 2023 at 10:54 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >> On Fri, May 12, 2023 at 01:56:30PM +0000, Chuck Lever III wrote:
> >>>> On May 12, 2023, at 6:32 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >>>> I'm pretty sure Chuck Lever did this intentionally, but he's not on the
> >>>> CC list.  Let's add him.
> >>>>
> >>>> regards,
> >>>> dan carpenter
> >>>>
> >>>> On Fri, May 12, 2023 at 06:15:04PM +0530, Naresh Kamboju wrote:
> >>>>> Following kernel warning has been noticed on qemu-arm64 while running kunit
> >>>>> tests while booting Linux 6.4.0-rc1-next-20230512 and It was started from
> >>>>> 6.3.0-rc7-next-20230420.
> >>>>>
> >>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>>>
> >>>>> This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i386.
> >>>>> Is this expected warning as a part of kunit tests ?
> >>>
> >>> Dan's correct, this Kunit test is supposed to check the
> >>> behavior of the API when a too-large privsize is specified.
> >>>
> >>> I'm not sure how to make this work without the superfluous
> >>> warning. Would adding GFP_NOWARN to the allocation help?
> >>
> >> That would silence the splat, yes.
> >
> > But introduce a build failure, as GFP_NOWARN does not exist.
>
> This is the fix that went in:
>
> commit b21c7ba6d9a5532add3827a3b49f49cbc0cb9779
> Author:     Chuck Lever <chuck.lever@oracle.com>
> AuthorDate: Fri May 19 13:12:50 2023 -0400
> Commit:     Jakub Kicinski <kuba@kernel.org>
> CommitDate: Mon May 22 19:24:52 2023 -0700
>
>     net/handshake: Squelch allocation warning during Kunit test
>
>     The "handshake_req_alloc excessive privsize" kunit test is intended
>     to check what happens when the maximum privsize is exceeded. The
>     WARN_ON_ONCE_GFP at mm/page_alloc.c:4744 can be disabled safely for
>     this test.
>
>     Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>     Fixes: 88232ec1ec5e ("net/handshake: Add Kunit tests for the handshake consumer API")
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Link: https://lore.kernel.org/r/168451636052.47152.9600443326570457947.stgit@oracle-102.nfsv4bat.org
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> index e6adc5dec11a..6193e46ee6d9 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c
> @@ -102,7 +102,7 @@ struct handshake_req_alloc_test_param handshake_req_alloc_params[] = {
>         {
>                 .desc                   = "handshake_req_alloc excessive privsize",
>                 .proto                  = &handshake_req_alloc_proto_6,
> -               .gfp                    = GFP_KERNEL,
> +               .gfp                    = GFP_KERNEL | __GFP_NOWARN,
>                 .expect_success         = false,
>         },
>         {
>
> Is there a platform where __GPF_NOWARN is not defined?

"git grep" says all of them, as you misspelled it in your question ;-)

"__GFP_NOWARN"  is defined in include/linux/gfp_types.h,
so it should be available everywhere.

Note the use of "__GFP_NOWARN" instead of "GFP_NOWARN".
Once in a while, people do submit patches using "GFP_NOWARN"...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
