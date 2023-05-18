Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564BC7085AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjERQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjERQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:10:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725DFE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:10:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so2872213276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684426251; x=1687018251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ6fEh41sGhN6IZlpmir3nTFUB9eH0sY819Rneyh7hs=;
        b=M5x2tqEeI57jIhJIrwT/dCbMeRbiRpHmvZNAWJiNpy40KrdFIp5OS9dYYy1e+D8dOn
         IfwIEE0xaaAOOfDWXqcYDcFZXnf+CRUoShJLukUdSIMfeZrbDgH7G426eyZfVMceDYIK
         b7tsc0oHq2U1GAI6umpCTWXoyWXMAn9vk4jP1zK8OrpYNxLrEtG1uT5cwT9WuPewW6ZF
         DbFVz1U3IOl899F5VkE5pzMiqYp8+AhyAgt66xAScDz//OS/crWLfMBQ2MJoiQN/4Ia0
         mIUHXz5mgHZvrKk+sstrxm5PC+9YnFIe8/y6//0SAK0knMZrMNjywfQBjn233QCCASuA
         PDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426251; x=1687018251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ6fEh41sGhN6IZlpmir3nTFUB9eH0sY819Rneyh7hs=;
        b=czFLCOKJyEWJx+1vhu/oZtEm2wK7QHmzX0zgKS1cMLFYucGggYNsz9NywHe1zC+0Fr
         d/9DYvVzK7oZ7hAVsUXJWerb2hOsg7qdeG5khXArkSXY6kcx3Z8oulKiMPuGRfGM7XwQ
         i2+KZfPJXAo4JPZt84RCudSidOUK9dRxbF99P1Azoo1mpKkHtfsLrRO2WYo919YTMnib
         Or/uiMi3mAalD/1BhGfQstRjb4j4ueqW6IoCAnHnRyGFfoA1je0R6U/T/hX1aguDJj12
         MXmecdjHGdJ3dqnwhz12QmskNwLQRtOvSLuonTC+I95tb7aJN9hOAA38w9PyKKywpv41
         s7Aw==
X-Gm-Message-State: AC+VfDyWcFkJmNkgNToZhSd2gLrPp6Nfm7EUWaxlAQT4iPHDtwVKAjoj
        6FeqfQp2ycjgLfrnbuRWiaZY5HuTDhQhjG6tFUq4Kg==
X-Google-Smtp-Source: ACHHUZ6u/qM9qzGiehyROZJRL8PBkBdsgxRiwT6kRoso8gCcRwKce5PfQyVRrORdKNSrhUc3GOAbwMek5rHdCHurX1s=
X-Received: by 2002:a25:d043:0:b0:ba8:2317:e74f with SMTP id
 h64-20020a25d043000000b00ba82317e74fmr2068931ybg.60.1684426250788; Thu, 18
 May 2023 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517233020.GA10757@monkey>
In-Reply-To: <20230517233020.GA10757@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 18 May 2023 09:10:39 -0700
Message-ID: <CACw3F51iVe7AtaFDR_y1x+hc8HH1nAqKA7ZYtL=tte6Qmb5CGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Improve hugetlbfs read on HWPOISON hugepages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 17, 2023 at 4:30=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 05/17/23 16:09, Jiaqi Yan wrote:
> > Today when hardware memory is corrupted in a hugetlb hugepage,
> > kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
> > read will suject to silent data corruption. This is implemented by
> > returning -EIO from hugetlb_read_iter immediately if the hugepage has
> > HWPOISON flag set.
> >
> > Since memory_failure already tracks the raw HWPOISON subpages in a
> > hugepage, a natural improvement is possible: if userspace only asks for
> > healthy subpages in the pagecache, kernel can return these data.
>
> Thanks for putting this together.
>
> I recall discussing this some time back, and deciding to wait and see
> how HGM would progress.  Since it may be some time before HGM goes
> upstream, it would be reasonable to consider this again.

This improvement actually does NOT depend on HGM at all. No page table
related stuff involved here. The other RFC [2] I sent earlier DOES
require HGM. This improvement was brought up by James when we were
working on [2]. In "Future Work" section of the cover letter, I
thought HGM was needed but soon when I code it up, I found I was
wrong.

>
> One quick question.
> Do you have an actual use case for this?  It certainly is an improvement
> over existing functionality.  However, I am not aware of too many (?any?)
> users actually doing read() calls on hugetlb files.

I don't have any use case. I did search on Github for around half a
hour and all the hugetlb usages are done via mmap.

> --
> Mike Kravetz
>
> > This patchset implements this improvement. It consist of three parts.
> > The 1st commit exports the functionality to tell if a subpage inside a
> > hugetlb hugepage is a raw HWPOISON page. The 2nd commit teaches
> > hugetlbfs_read_iter to return as many healthy bytes as possible.
> > The 3rd commit properly tests this new feature.
> >
> > [1] commit 8625147cafaa ("hugetlbfs: don't delete error page from pagec=
ache")

[2] https://lore.kernel.org/linux-mm/20230428004139.2899856-6-jiaqiyan@goog=
le.com/T/#m97c6edef8ad0cc9b064e1fd9369b8521dcfa43de

> >
> > Jiaqi Yan (3):
> >   mm/hwpoison: find subpage in hugetlb HWPOISON list
> >   hugetlbfs: improve read HWPOISON hugepage
> >   selftests/mm: add tests for HWPOISON hugetlbfs read
> >
> >  fs/hugetlbfs/inode.c                          |  62 +++-
> >  include/linux/mm.h                            |  23 ++
> >  mm/memory-failure.c                           |  26 +-
> >  tools/testing/selftests/mm/.gitignore         |   1 +
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
> >  6 files changed, 419 insertions(+), 16 deletions(-)
> >  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> >
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >

(Sorry if you received twice, was sent in a wrong way a while ago)
