Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0073CF76
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFYIqj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFYIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:46:37 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BF1B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:46:36 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bff4f1e93caso2215611276.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687682795; x=1690274795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHlgsInQ4EQ73iyaQZEOHgbhLEPbwxie4IAHuCK4X/s=;
        b=dJQYWCS+mR3pkVl/o7AOjdbZ5fQ2KLY77/EaDU5AOdIOjmYclrLaAzEgHpWKOQkZlN
         I1gq5269D8p6rAvL1UVCA69g5619FGvmCQhpxvZLUg6+OWZtqyoO6ydanKyoqhNgsgjl
         1BrGgBlhLjMgBqIF4jCj9lUeBi3kJLvKbozt9FiBBZ90OiBQmnHieP6yujnTmKkvyysi
         BgvC5TMLONKjalz0KIevB1QUxrX3vNIY94wT4740VSbUeGQbuVppFqPMz+Uwj8HJAsxf
         P/DbU4Tlw9oMdEowMUoAcsqz8lfILFywXA5iHGNRYgO+9xFyqSzsPZeZQo0Xk8O3IUDa
         vang==
X-Gm-Message-State: AC+VfDxxfNVpD8HD9Jfn91tGkfu4jCk/yPQ3G9o1qztAoKR0RujUubFN
        +8aMy4sn1nPxJRZXHJUpbl2pSo1JcK2Zlw==
X-Google-Smtp-Source: ACHHUZ6YBEC79/25DEzG2wOVD8na53izJFxNpoVtAchLZexr4HFG8jEq+3VkTL3VegAH/bTPCv8Z4w==
X-Received: by 2002:a25:ba8d:0:b0:c11:3daf:7c47 with SMTP id s13-20020a25ba8d000000b00c113daf7c47mr3359793ybg.63.1687682795047;
        Sun, 25 Jun 2023 01:46:35 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id s128-20020a0dd086000000b005732811678dsm723266ywd.64.2023.06.25.01.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:46:34 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bf5f41a87ceso2215212276.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:46:34 -0700 (PDT)
X-Received: by 2002:a25:d791:0:b0:bc4:78ac:9216 with SMTP id
 o139-20020a25d791000000b00bc478ac9216mr22897394ybg.61.1687682794370; Sun, 25
 Jun 2023 01:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
 <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain> <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
 <1059342c-f45a-4065-b088-f7a61833096e@kili.mountain>
In-Reply-To: <1059342c-f45a-4065-b088-f7a61833096e@kili.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 10:46:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3NO9tafYsCJGStA7YeWye8gwKm2HYb72f1PRXGfXNWg@mail.gmail.com>
Message-ID: <CAMuHMdW3NO9tafYsCJGStA7YeWye8gwKm2HYb72f1PRXGfXNWg@mail.gmail.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744 __alloc_pages+0x2e8/0x3a0
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
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

On Sat, May 13, 2023 at 10:54 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> On Fri, May 12, 2023 at 01:56:30PM +0000, Chuck Lever III wrote:
> > > On May 12, 2023, at 6:32 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > I'm pretty sure Chuck Lever did this intentionally, but he's not on the
> > > CC list.  Let's add him.
> > >
> > > regards,
> > > dan carpenter
> > >
> > > On Fri, May 12, 2023 at 06:15:04PM +0530, Naresh Kamboju wrote:
> > >> Following kernel warning has been noticed on qemu-arm64 while running kunit
> > >> tests while booting Linux 6.4.0-rc1-next-20230512 and It was started from
> > >> 6.3.0-rc7-next-20230420.
> > >>
> > >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >>
> > >> This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i386.
> > >> Is this expected warning as a part of kunit tests ?
> >
> > Dan's correct, this Kunit test is supposed to check the
> > behavior of the API when a too-large privsize is specified.
> >
> > I'm not sure how to make this work without the superfluous
> > warning. Would adding GFP_NOWARN to the allocation help?
>
> That would silence the splat, yes.

But introduce a build failure, as GFP_NOWARN does not exist.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
