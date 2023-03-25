Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0B6C8F76
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCYQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCYQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:33:37 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6387D26B7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:33:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o44so3737738qvo.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679762004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+IGcq5whZ5cIGpFrj3EMqmDdJU1miHHxTnqhKHWiYM=;
        b=LmxnjU8yJBNlf2YBqtna34dmEJA0ILPFrF6R6g4031+0eswNuQ2DJ3Xy2kXJTfJ339
         JIODLbtiSEyzOf+Zn+RcdIpdPahLRSzGK5IEwDIXKS4ooUZC2zPhUcIUaQNORZJYhHfK
         SpaUoJ7VV6nrkXRyu8VMcGmqPfiy9YSjG8upg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679762004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+IGcq5whZ5cIGpFrj3EMqmDdJU1miHHxTnqhKHWiYM=;
        b=EXJVxwWWi2RjPFfRmHBUUp4xzt2xhPMSrq2/vnUpIQii1jY2XSkN1k8jF0hgWDUloS
         BRidfxAoGha+km9qDvh4E7DKNWFislbCyuasrvGb7dQo9M8s7wbDYSMx9RtnFzz+g1ZG
         DnMfVLO9nCzctDVBCpVS1onCLfmRC1hVAaqgRKdWDym0bTRGzDPECuhQa9diu8tWmbPj
         +csKotrWgV6Pd22G/4cVXZFQ1kChLT6SJWJQ/MxVYTExCyeoVybFzWrZg2VzbYdAxocf
         tyXw5t54DfM5H2RrC43JBWbiGzPKpB8l/ZRwLRCiL7qdkBysiLD9JejStIanPv0Dm60c
         S9Yw==
X-Gm-Message-State: AAQBX9fZQhLwKtgbuOJ6AxvdCEdsvPflRdWncKH02g9ybeMXclS8TeiQ
        AJoKauZFcqe2rvudhuLtLv7U4A==
X-Google-Smtp-Source: AKy350bgIokcJSqtEpxPRvLjwT5rK/qhjYoPwIA2RTUAyMR6SXuHmSeZThiEHWx3c5UnGOVNVYB5nQ==
X-Received: by 2002:a05:6214:d84:b0:5a6:9028:7b89 with SMTP id e4-20020a0562140d8400b005a690287b89mr10319487qve.35.1679762004470;
        Sat, 25 Mar 2023 09:33:24 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id eh13-20020a056214186d00b005dd8b9345fasm1551290qvb.146.2023.03.25.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 09:33:23 -0700 (PDT)
Date:   Sat, 25 Mar 2023 16:33:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON in move_normal_pmd
Message-ID: <20230325163323.GA3088525@google.com>
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
 <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 24, 2023 at 04:38:03PM -0700, Linus Torvalds wrote:
> On Fri, Mar 24, 2023 at 6:43 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Wouldn't it be better to instead fix it from the caller side? Like
> > making it non-overlapping.
> 
> I wonder if we could just do something like this in mremap() instead
> 
>  - if old/new are mutually PMD_ALIGNED
> 
>  - *and* there is no vma below new within the same PMD
> 
>  - then just expand the mremap to be PMD-aligned downwards
> 
> IOW, the problem with the exec stack moving case isn't really that
> it's overlapping: that part is fine. We're moving downwards, and we
> start from the bottom, so the moving part works fine.
> 
> No, the problem is that we *start* by moving individual pages, and
> then by the time we've a few pages down by a whole PMD, we finish the
> source PMD (and we've cleared all the contents of it), but it still
> exists.
> 
> And at *that* point, when we go and start copying the next page, we're
> suddenly fully PMD-aligned, and now we try to copy a whole PMD, and
> then that code is unhappy about the fact that the old (empty) PMD is
> there in the target.
> 

You are very right. I am able to also trigger the warning with a synthetic
program that just mremaps a range and moves it in the same way that triggers
this issue, however I had to hack the kernel to prevent mremap from erroring
out if ranges overlap (unlike exec, mremap does some initial checks for
that). Also had to do other hacks but I did reproduce it consistently.

The issue is that even though the PMD is empty, it is allocated. So
pmd_none() is kind of a lie in some sense, it is pointing to empty PTEs when
the range is really empty.

How about we replace the warning with something like the following?

+       if (unlikely(!pmd_none(*new_pmd))) {
+               // Check if any ptes in the pmd are non-empty. Doing this here
+               // is ok since this is not a fast path.
+               bool pmd_empty = true;
+               unsigned long tmp_addr = new_addr;
+               pte_t* check_pte = pte_offset_map(new_pmd, new_addr);
+
+               new_ptl = pte_lockptr(mm, new_pmd);
+               spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+               for (; tmp_addr < old_addr + PMD_SIZE; check_pte++, tmp_addr += PAGE_SIZE) {
+                       if (!pte_none(*check_pte)) {
+                               pmd_empty = false;
+                               break;
+                       }
+               }

+               WARN_ON_ONCE(!pmd_empty);
+               spin_unlock(new_ptl);
+       }
+

> And for all of this to happen, we need to move things by an exact
> multiple of PMD size, because otherwise we'd never get to that aligned
> situation at all, and we'd always do all the movement in individual
> pages, and everything would be just fine.
> 
> And more importantly, if we had just *started* with moving a whole
> PMD, this also wouldn't have happened. But we didn't. We started
> moving individual pages.
> 
> So you could see the warning not as a "this range overlaps" warning
> (it's fine, and happens all the time, and we do individual pages that
> way quite happily), but really as a "hey, this was very inefficient -
> you shouldn't have done those individual pages as several small
> independent invidual pages in the first place" warning.
> 

Exactly.

> So some kind of
> 
>         /* Is the movement mutually PMD-aligned? */
>         if ((old_addr ^ new_addr) & ~PMD_MASK == 0) {
>                 .. try to extend the move_vma() down to the *aligned*
> PMD case ..
>         }
> 

I actually didn't follow what you meant by "mutually PMD-aligned". Could you
provide some example address numbers to explain?

AFAIK, only 2MB aligned memory addresses can be directly addressed by a PMD.
Otherwise how will you index the bytes in the 2MB page? You need bits in the
address for that.

> logic in move_page_tables() would get rid of the warning, and would
> make the move more efficient since you'd skip the "move individual
> pages and allocate a new PMD" case entirely.
> 
> This is all fairly com,plicated, and the "try to extend the move
> range" would also have to depend on CONFIG_HAVE_MOVE_PMD etc, so I'm
> not saying it's trivial.
> 
> But it would seem to be a really nice optimization, in addition to
> getting rid of the warning.
> 
> It could even help real world cases outside of this odd stack
> remapping case if users ever end up moving vma's by multiples of
> PMD_SIZE, and there aren't other vma's around the source/target that
> disable the optimization.
> 
> Hmm? Anybody want to look into that? It looks hairy enough that I
> think that "you could test this with mutually aligned mremap()
> source/targets in some test program" would be a good thing. Because
> the pure execve() case is rare enough that using *that* as a test-case
> seems like a fool's errand.
> 

Just to mention, mremap errors out if you try to move overlapping ranges
because this in  mremap_to():

       /* Ensure the old/new locations do not overlap
        if (addr + old_len > new_addr && new_addr + new_len > addr) {
                pr_err("%s: (%s) (%d)", __func__, __FILE__, __LINE__);
                goto out;
        }

Or is there an mremap trick I might be missing which actually allows
overlapping range moves?

thanks,

 - Joel


