Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775B69851A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBOUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:00:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4C86B9;
        Wed, 15 Feb 2023 12:00:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i18so12956689pli.3;
        Wed, 15 Feb 2023 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFrWO0f7yzYN0JfWwtvFw3Ysd86ppP1HxQirWGWfkGU=;
        b=p55ohjy+62umt3tJQxO+jZD1wSAGGC1zVE4GCTWFu2joi/QjhhkDv0s3/fCrg5VFN5
         QcxAg7oipjf+NRNLaE0ob2xPdq7t/4ipZRNYr95kx6JjeiwHOuSYEaN66tJ8OZ0I7klY
         S9qoBUcQdsFD/5/xuXph/R3/A5uKfqPT2bcztxpFvXK75E2jaIiwKhPpliPm7eHaZDVh
         XfvZ9jD6/9Y9RhnhdQM6HrnYkuVU76OGSjg7fJGuICBujK70clz6WPPmDgSaTefGwhI3
         jB8R5jGN5+hfmvFgpzL+M0BDt1UxQkavMgXP5PWx0d45nwMjKRrOYPML9EHc7NlLj5Bm
         0srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFrWO0f7yzYN0JfWwtvFw3Ysd86ppP1HxQirWGWfkGU=;
        b=dyK2t1rjpJydq+A2vv6QeAi/g48VwpvbYN81Ts9bnQJr39C+FT9eeV9KYMJjvdU6VY
         SYSQiBGeBnPfMqJdD0NBMAKoGW/gBPSEGRelg/TWVmhZnkilFigC2Uo5Vr9A8kZfbbyM
         Mp5okP54XUq/dUiRGDpTDy7M6RvQKdxzTSdEH5THxVBx+Hu3ekEREDBrxNQxdvjeabkp
         EsptNQnysD5f419tm1snA7CQAyh6STWVGd3M2jiOgs+IzV8Q8OMMiRyEYsYhTGanxU3z
         b0vPQ5v9Ck2QL5f2vBLPU6+IizNmri3LXxANFWdsoKRkZHDe7+4p5P9IwzsemOH/PXiY
         9OYw==
X-Gm-Message-State: AO0yUKVpFxc7D67ojXq+XnWoYuOjZYb6GI8dpQ1I+bC3bWIonQWc5sxO
        u9HoWwfsnntouDUAi8Xbu1n0SUy6oqjlEdW9SN8=
X-Google-Smtp-Source: AK7set9bs5Zg8Yirc4qUbLHYhiamHtAx2jf0H+f1/8yBTmxsP26MbB8uiOOGpaGbls5Iz91VFs683r7GA3VbOXJNbLQ=
X-Received: by 2002:a17:90b:1e4c:b0:230:b973:a726 with SMTP id
 pi12-20020a17090b1e4c00b00230b973a726mr138046pjb.23.1676491221040; Wed, 15
 Feb 2023 12:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20230214190221.1156876-1-shy828301@gmail.com> <alpine.LRH.2.21.2302150716120.5940@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.21.2302150716120.5940@file01.intranet.prod.int.rdu2.redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Feb 2023 12:00:09 -0800
Message-ID: <CAHbLzkr4RrKpR1pGZxs7JdB=R539SiNgO2+Fr7X-rVKcBh5tQQ@mail.gmail.com>
Subject: Re: [dm-devel] [v2 PATCH 0/5] Introduce mempool pages bulk allocator
 and use it in dm-crypt
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 4:23 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 14 Feb 2023, Yang Shi wrote:
>
> >
> > Changelog:
> > RFC -> v2:
> >   * Added callback variant for page bulk allocator and mempool bulk allocator
> >     per Mel Gorman.
> >   * Used the callback version in dm-crypt driver.
> >   * Some code cleanup and refactor to reduce duplicate code.
> >
> > rfc: https://lore.kernel.org/linux-mm/20221005180341.1738796-1-shy828301@gmail.com/
>
> Hi
>
> This seems like unneeded complication to me. We have alloc_pages(), it can
> allocate multiple pages efficiently, so why not use it?

The alloc_pages() allocates *contiguous* pages, but dm-crypt doesn't
need contiguous pages at all. This may incur unnecessary compaction
overhead to the dm-crypt layer when memory is fragmented. The bulk
allocator is a good fit to this usecase, which allocates multiple
order-0 pages.

In addition, filesystem writeback doesn't guarantee power-of-2 pages
every time IIUC. But alloc_pages() just can allocate power-of-2 pages.

>
> I suggest to modify crypt_alloc_buffer() to use alloc_pages() and if
> alloc_pages() fails (either because the system is low on memory or because
> memory is too fragmented), fall back to the existing code that does
> mempool_alloc().

My PoC patches just did this way, but called bulk allocator. There may
be other potential mepool users as I listed in this cover letter,
which may get benefits from bulk allocator. So introducing a new bulk
mempool API seems better for long run although we just have one user
for now. And it makes other uses easier to gain the benefit by just
calling the new API.

>
> Mikulas
>
