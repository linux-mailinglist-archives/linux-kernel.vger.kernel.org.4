Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79E670B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjAQWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjAQWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:05:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533D5C0D9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:28:43 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p66so15472222iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6lBLtQcwXXW0D4MwnkLaJbFSlKXy17eV5mc4KZgrNg=;
        b=aJ1tuCqCEyVYlKQ3YOYO3zSRB48viA6UM19LIAhgZpv4eGDtYMK/hPPo5lfXgu+gTS
         M+n1QCd/7KOhkd/YvSx5PKyIGahYeRaRSV3luKpLj+YUzBh1z1C4rdBug3i5gt6VJHD1
         39PJ1/Yodm39kmb9guNck1iq5XvL2xrPhssLwKDLzrKFQnQ1xeFi+kC4I4GZpNT/eBpb
         abGCyD4BAVT7vVVXEJdAV9lOIkQSg8qUbJc6A1EUb6vTmPXnnOMDcovrH9fQo2UpnH0l
         cKSBU2d7t0U9wiJWBcBPmqXGrs0e92f8O5N9QZo7wxujcaSt0nmgoUC4wJTaq7OBQpsv
         F8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6lBLtQcwXXW0D4MwnkLaJbFSlKXy17eV5mc4KZgrNg=;
        b=F2l4XF+5F1Cp+61/C980b6L5MAv6aNCxUf26zMzwUMeSaU9siHQw6y0ecqat3F6DLW
         hPsV5yIf4UACLF20DPsedAEVPti4AUo35gyJLx4DublPmttJnqcZJDsuQx1CEuyduewD
         IdDpg6tjrdrorO1tMRvX4H7OorO1Hvn8NVPXOdwevu2UhuArrwq/bzf8VfiENFqQnFaQ
         unkT59K0jpYlLLCCv6FraSNVCYHrA2o+f0nkwHcpFfB/8mX8oyPldR0ln7SghJWQ1Ly0
         skgSn8IJv4MVb2Bvw4MfH9SKULNgQCM1pfSNKBjA6jM7+CbAIrttVfwRyYYGLeOOTgEL
         hdZQ==
X-Gm-Message-State: AFqh2kowV5Jlxv5MD2Nuv/gW2e/IE7byFXwLTiSjqpb2h9dm1TiXMaDH
        7+GXdyXE4Qa3zCxlfpYC2wTpGAEOXU7Bqts5SYIDZw==
X-Google-Smtp-Source: AMrXdXsdfz3ZSkVOQq7xodxuPXlHOjr2OrBoiOuZE3Eq2JZpQR9esxUP0A6G43/Zbr959H9oSQiEOLhkS8jLPG4mH0c=
X-Received: by 2002:a02:c884:0:b0:39e:9d33:a47 with SMTP id
 m4-20020a02c884000000b0039e9d330a47mr309615jao.58.1673987322674; Tue, 17 Jan
 2023 12:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-19-surenb@google.com>
 <Y8a9+ywh65fmuKvv@dhcp22.suse.cz>
In-Reply-To: <Y8a9+ywh65fmuKvv@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 21:28:06 +0100
Message-ID: <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
Subject: Re: [PATCH 18/41] mm/khugepaged: write-lock VMA while collapsing a
 huge page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Tue, Jan 17, 2023 at 4:25 PM Michal Hocko <mhocko@suse.com> wrote:
> On Mon 09-01-23 12:53:13, Suren Baghdasaryan wrote:
> > Protect VMA from concurrent page fault handler while collapsing a huge
> > page. Page fault handler needs a stable PMD to use PTL and relies on
> > per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
> > set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
> > not be detected by a page fault handler without proper locking.
>
> I am struggling with this changelog. Maybe because my recollection of
> the THP collapsing subtleties is weak. But aren't you just trying to say
> that the current #PF handling and THP collapsing need to be mutually
> exclusive currently so in order to keep that assumption you have mark
> the vma write locked?
>
> Also it is not really clear to me how that handles other vmas which can
> share the same thp?

It's not about the hugepage itself, it's about how the THP collapse
operation frees page tables.

Before this series, page tables can be walked under any one of the
mmap lock, the mapping lock, and the anon_vma lock; so when khugepaged
unlinks and frees page tables, it must ensure that all of those either
are locked or don't exist. This series adds a fourth lock under which
page tables can be traversed, and so khugepaged must also lock out that one.

There is a codepath in khugepaged that iterates through all mappings
of a file to zap page tables (retract_page_tables()), which locks each
visited mm with mmap_write_trylock() and now also does
vma_write_lock().


I think one aspect of this patch that might cause trouble later on, if
support for non-anonymous VMAs is added, is that retract_page_tables()
now does vma_write_lock() while holding the mapping lock; the page
fault handling path would probably take the locks the other way
around, leading to a deadlock? So the vma_write_lock() in
retract_page_tables() might have to become a trylock later on.

Related: Please add the new VMA lock to the big lock ordering comments
at the top of mm/rmap.c. (And maybe later mm/filemap.c, if/when you
add file VMA support.)
