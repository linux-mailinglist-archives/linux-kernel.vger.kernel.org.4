Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264E7671D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjARNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjARNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:15:08 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16C4740A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:38:41 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z194so4531938iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ne1ZZ8g0CKjtUM0flXLQwaKYgCBQx784VijV19d+6xc=;
        b=rheJ1RUUcAkj+1owhrmAToGN1JKqVwS5uNfucsbLgdY6jiwLnv20ZvMr/zG5UmC3MR
         r6w4F2M4P+L39RFGiPrp7Pc4YsCSMo2eypVoYy7uAZH0skF0cb9KGqSqKmQtTROWTdZw
         Y4onbS8Bh9xurv/ecxH2l9+6u4n2k+Du7eEvZ+3bilOaoZOJlQlDDMN5a0ev1/1AkMIv
         6hGk1h8D1872yYIqM9YnRK4SbQiqQUWcQ1xmAUvd1tSMlevfjfCKbIpNjzx92FXNNtTK
         eamrPPtqzoYNgbP3fcy329YWOqfU15+ST4GR/7gu/oa+wU+FfArYkk5BOsi4UvDxXYDv
         dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne1ZZ8g0CKjtUM0flXLQwaKYgCBQx784VijV19d+6xc=;
        b=daJJlPddh3G3ld7NBmk8eVVlt5wu/DINT/X3SCBhlWO1wPTazzGT/wrfxYNhKexBKn
         pxPk6MK9c41uRd4Aj8SsgMy8rbrn39onUgMUPURyuhc8bzkEUGkFiDY7cuW0xICqf9Dx
         bNNg5mttgWVf8hSrVnDI6svP3UUegAs/8wNjBy2vvNagYbRYchqY9KL6WAiX5N5poqsZ
         2k3Lz3dx9d1B4ZVoL7aCvw47+gIc4vtHs+zjgGTr/VofNn2QJ9aUR4sQzLx6AHL8ZeYY
         ZwWcEWqWE915dF2EZji0EWTWYrwAzs0mL6oJc7XOXHJPpWriK9YWZeoROiX3ia8ZMow3
         nskQ==
X-Gm-Message-State: AFqh2kr3f/WU+SUhX5pKCfF8Y9wjPf6tb/dTxV1kfT/e/LS9TBzzRGQH
        Drgzb1CMak/5g4dBoIg7CmpA2fvr/lobjdQZRhsg2A==
X-Google-Smtp-Source: AMrXdXtdPpTPNrN7OiYOv16BmNfqKkmp2Nm/DssJpSsitfPp+gX8QsWWZQOd27RnCdytJ0z4l4VIPkrlODp7fq/3+OE=
X-Received: by 2002:a02:cb45:0:b0:39e:6dd8:6c96 with SMTP id
 k5-20020a02cb45000000b0039e6dd86c96mr543739jap.246.1674045520432; Wed, 18 Jan
 2023 04:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-19-surenb@google.com>
 <Y8a9+ywh65fmuKvv@dhcp22.suse.cz> <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
 <Y8e+efbJ4rw9goF0@dhcp22.suse.cz>
In-Reply-To: <Y8e+efbJ4rw9goF0@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 Jan 2023 13:38:03 +0100
Message-ID: <CAG48ez0Hmr6wF4sSC1oSL1Q8N8mREARU4itwQ0TbRF3y+oMYFg@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 10:40 AM Michal Hocko <mhocko@suse.com> wrote:
> On Tue 17-01-23 21:28:06, Jann Horn wrote:
> > On Tue, Jan 17, 2023 at 4:25 PM Michal Hocko <mhocko@suse.com> wrote:
> > > On Mon 09-01-23 12:53:13, Suren Baghdasaryan wrote:
> > > > Protect VMA from concurrent page fault handler while collapsing a huge
> > > > page. Page fault handler needs a stable PMD to use PTL and relies on
> > > > per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
> > > > set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
> > > > not be detected by a page fault handler without proper locking.
> > >
> > > I am struggling with this changelog. Maybe because my recollection of
> > > the THP collapsing subtleties is weak. But aren't you just trying to say
> > > that the current #PF handling and THP collapsing need to be mutually
> > > exclusive currently so in order to keep that assumption you have mark
> > > the vma write locked?
> > >
> > > Also it is not really clear to me how that handles other vmas which can
> > > share the same thp?
> >
> > It's not about the hugepage itself, it's about how the THP collapse
> > operation frees page tables.
> >
> > Before this series, page tables can be walked under any one of the
> > mmap lock, the mapping lock, and the anon_vma lock; so when khugepaged
> > unlinks and frees page tables, it must ensure that all of those either
> > are locked or don't exist. This series adds a fourth lock under which
> > page tables can be traversed, and so khugepaged must also lock out that one.
> >
> > There is a codepath in khugepaged that iterates through all mappings
> > of a file to zap page tables (retract_page_tables()), which locks each
> > visited mm with mmap_write_trylock() and now also does
> > vma_write_lock().
>
> OK, I see. This would be a great addendum to the changelog.
>
> > I think one aspect of this patch that might cause trouble later on, if
> > support for non-anonymous VMAs is added, is that retract_page_tables()
> > now does vma_write_lock() while holding the mapping lock; the page
> > fault handling path would probably take the locks the other way
> > around, leading to a deadlock? So the vma_write_lock() in
> > retract_page_tables() might have to become a trylock later on.
>
> This, right?
> #PF                     retract_page_tables
> vma_read_lock
>                         i_mmap_lock_write
> i_mmap_lock_read
>                         vma_write_lock
>
>
> I might be missing something but I have only found huge_pmd_share to be
> called from the #PF path. That one should be safe as it cannot be a
> target for THP. Not that it would matter much because such a dependency
> chain would be really subtle.

Oops, yeah. Now that I'm looking closer I also don't see a path from
the #PF path to i_mmap_lock_read. Sorry for sending you on a wild
goose chase.
