Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C1603961
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJSFvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:51:38 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087B1FF89
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:51:37 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id a66so7898948vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFGd93jrtvQiqJNlNhKuSpttJ7R1kimxCliY9JMGiO8=;
        b=rJov42dEZxyrkHBKooMuGFtyzEjE4ZBDyIxL72lQMhBaeYY6i92BmHDEPO0B0wqlwm
         aHK68k7QphWmEUwpaLnaps9i4e3xGcwIIfdVeqpqI4bwpxCvaJ6jyRCjyxHdJj23NVqh
         kk3/vJ/JyO2IT5LGQcCJVw4BXWRWy1cVROSxF1Xx+u/d83nJLOT6iVZVMttVgUQdV/NM
         dCxMC78eZgziUDScLpEiAcir1junGES6X7m/KrNQaxvtB0F9K7ZcETXi6YtMinZhkTTk
         3XHZ9UpInXF+eLXMQU8g3z4I165lKqAAsi+inDQCuy6iOSF5zZ2fq/E3OttwUDjXVOR3
         vFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFGd93jrtvQiqJNlNhKuSpttJ7R1kimxCliY9JMGiO8=;
        b=X0QeVlpeNfnz9BOttZ/UgcCtViQa1wSmfVwtCx4rAkC5689SHZsg+im0Ix+HTkdUtv
         +lfKOaIKMXp+Z+IXwnNE/BGBPq24rSWgrLzPStXEEbmOYJy+pIbTFQJd9701Jr6H7QDt
         B/ewk/DDo6Wl4D0zRBqPhy71HEbgZDgkoZuJqKroJPUAqEvLe6o05mRDL7etjOpndPj6
         /Bv5wWkJOGNXh/LHuY/G8samainEgvvryzcZHGJxK01WfErAQGczH99jexoiNVZW0aTX
         EMXV+yjBky6pRU1d2MJLNVATGygvdrt/l9huoi6Ub1hQo70iwwXhevkDM2phee73i5Xz
         58DA==
X-Gm-Message-State: ACrzQf2+Y877e69FcUg1LQv1iz+C2iXVNpiNJqBLUvBQg67kFY/PAW4w
        yPzevssg7bR7daRuM3SQelHtmIKdSNA8ndVqT1wNjw==
X-Google-Smtp-Source: AMsMyM4guPNgQoa7KlximIDZAmk9KlZ4Y4bJcH4mqoVFcaNoTZPJTr8XAHHByaU++HZ+c2XUuSu3ELrJpZlkGkFLxYw=
X-Received: by 2002:a1f:988c:0:b0:3aa:cf0a:e0f7 with SMTP id
 a134-20020a1f988c000000b003aacf0ae0f7mr3164429vke.24.1666158696774; Tue, 18
 Oct 2022 22:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 18 Oct 2022 23:51:00 -0600
Message-ID: <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 9:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 01:13:27AM -0600, Yu Zhao wrote:
> > +     for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
> > +             pmd_t val = pmd_read_atomic(pmd + i);
> > +
> > +             /* for pmd_read_atomic() */
> > +             barrier();
>
> Please clarify the above. This is an entirely inadequate ordering
> comment.

If it's acceptable, I'll copy what we have in
pmd_none_or_clear_bad_unless_trans_huge():

        pmd_t pmdval = pmd_read_atomic(pmd);

       /* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
        barrier();
#endif

        if (pmd_none(pmdval))
                return 1;

pmd_read_atomic() should have a built-in READ_ONCE() in the first
place. If we have to use pmd_read_atomic(), it means we are not under
PMD PTL. So we can also race with pte_alloc(), regardless of THP
split. In this case, compiler reordering probably won't cause any real
damage, but technically not having barrier() is still a bug and will
trigger KCSAN warnings, I think.
