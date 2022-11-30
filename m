Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23E63E56F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiK3X3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiK3X24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:28:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28CA957A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:19:27 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i131so23521138ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1CvzEDs24QW86WHYCJO7ldmgZffPCDkhf+BewAnOM8=;
        b=AlEZeIvgPBlg/GfJx3mG29SiBWRv7VIS/2hc+XrXCtCh+r8GoBIH9+a5eX0iIjzhZO
         O87KHkPzejAUJBhQtHeGUeFrthQWjcFYy/3cmVrf9NjPxbRELzc8H7fgYKNgosox5sqX
         M3/F1fTkt1R7gLR1tPSp2Tcurw5brT6yzQ1CgR59+Qk7ccfgtoJET45gMUQZPhCaQBH8
         T93fNOqzbt3hjrRrDpWUKWo08dtrJqF9nVwneM/KSa5+dqRWDK7120PEGsthwKV2WYLg
         +X2W5Ygldc0dxwyF2LH6zc2wSF3WP2CBBH6D5RcpfRz3Ydjh2kxZfO2oW1kDe+KHhhC+
         kjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1CvzEDs24QW86WHYCJO7ldmgZffPCDkhf+BewAnOM8=;
        b=hkaBZ0LhR5EYOcb6nbXvvQHG4uOEkfj4i/wQoNUrypaD+cblrh0K60agub1YEGXoAy
         TCdFAIol4KEz9cUoJGBQiBqTyCK109v9CCaIDjPluXQnDnhqQVj5DwOWAa80SGHnIRdD
         0WP8pETc/JwkhxwwtFH6lzMAs6zpodwE2KG9/RcRHPA4srnzvexRK35E5aa7hmPpGY0T
         8Ju/wMl7552zni9cUZFFPmB5zUkIA5ksqN0EHc76xpjaPa4UuUtHH6wbY1lTjf5z8E/P
         O2pqGt97C8NiWuk66qkGGcG4pY7hnXO/OopBjdESDNrOOzHQ5IBfM1uJhJn65t1z79Rl
         u25g==
X-Gm-Message-State: ANoB5pmm3XJwVOiZBnuYvdfDlceQyBqQmX5ATbk2GtnzfljVVtIvvBoT
        hlCvkYL5prNBTWTVu+pAmzLrzuB7fCS5hdNMP/4Kjw==
X-Google-Smtp-Source: AA0mqf76NMMyoniYOh90z5CA0a5taAqe2MmVdbR3KHFfgjw/3MArj6SFyCuV7tbeAC+RCwIuSBZHqZb3zdR2DCa608k=
X-Received: by 2002:a25:ac8:0:b0:6fa:678a:7623 with SMTP id
 191-20020a250ac8000000b006fa678a7623mr4513898ybk.577.1669850333794; Wed, 30
 Nov 2022 15:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-26-jthoughton@google.com> <Y4fL1SjtFif4/REe@x1n>
In-Reply-To: <Y4fL1SjtFif4/REe@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 30 Nov 2022 18:18:43 -0500
Message-ID: <CADrL8HV6CLTZM9Pw_UQGbBDFikmOFhr1kbk3Y3QgQc5QdX8fgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 25/47] hugetlb: add HGM support for copy_hugetlb_page_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 30, 2022 at 4:32 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:41PM +0000, James Houghton wrote:
> > This allows fork() to work with high-granularity mappings. The page
> > table structure is copied such that partially mapped regions will remain
> > partially mapped in the same way for the new process.
> >
> > A page's reference count is incremented for *each* portion of it that is
> > mapped in the page table. For example, if you have a PMD-mapped 1G page,
> > the reference count and mapcount will be incremented by 512.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> I have a feeling that this path is not triggered.  See:
>
> bcd51a3c679d ("hugetlb: lazy page table copies in fork()", 2022-07-17)
>
> It might be helpful to have it when exploring private mapping support of
> hgm on page poison in the future.  But the thing is if we want this to be
> accepted we still need a way to test it. I just don't see how to test this
> without the private support being there..

We can trigger this behavior by registering the VMA with
uffd-writeprotect. I didn't include any self-tests for this though;
I'll make sure to actually test this path in v1.

- James

>
> --
> Peter Xu
>
