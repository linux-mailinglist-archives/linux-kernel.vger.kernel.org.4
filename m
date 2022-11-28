Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADE63A3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiK1I6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiK1I6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:58:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D05FA8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:58:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b8so14444171edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRo5DYRndKCx9sGSXzsZxPr88K/zqtuLTLl1O32mcFE=;
        b=XOKEpyQaMH8DtU4ghoeum5LLPSyZKKSeL9ukREYJEhE5Pet4ng53VcgxrNVIVOiN3z
         qM9BvX69vBwubqV7gI66eEPgV5zFoyHzRXj6Y/c3o1k6BVytkDV23dS8hW9lN3urO8Q7
         YycsWj1XAMOHph6L7v2J+A4VSfKO7i7WBHunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRo5DYRndKCx9sGSXzsZxPr88K/zqtuLTLl1O32mcFE=;
        b=3rrNxfZZIr/4ivzzbVMww71Q/PEmnu8kVRlzhc7QnUIEZpg3Pl1wJmn7QFukcXRpOS
         PK+Z4EUOclHKhMPP4kcd1e8zXawnopnLKwE4v6JX/WXMV/98F5NjdiQcbPkMdknQDbNj
         r3iC4JEfrif89MsKjeaxbdwEMn9VTntAPC1eC/Ixm3TJ/Ao/O36PHuJpoYPMaiQUrn5+
         f+ij+JDP8a0C60Rq4DMW9hsAEfZGoFCZzgpQkK803bcE5JAcaCr/L6V5PONhIZaWUDtI
         chnRRefka/IwjDyIChHSP7JfW6HiUlIxO9dpmEjZoY9rJq+k2mLGRvAlLIFCRrJ/my8R
         my3Q==
X-Gm-Message-State: ANoB5plNkXp1uTeWq4rHbY9lyVreh/8a2b8wO1hDy6+eQnNowvqsQUVg
        +PuFdUzxdjTyB9wRzV3sLnu0MbHhO4DGpw==
X-Google-Smtp-Source: AA0mqf5R75hHjRr7YKR/NxI8MYPDV9btp5BiZYA+Hk5lBM4l+ZGjyFLjvzSnBRghbctx9l96S50okA==
X-Received: by 2002:a05:6402:528d:b0:468:dc9:ec08 with SMTP id en13-20020a056402528d00b004680dc9ec08mr31444929edb.17.1669625885162;
        Mon, 28 Nov 2022 00:58:05 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0046b1d63cfc1sm1497395edu.88.2022.11.28.00.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:58:04 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id s5so14426456edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:58:04 -0800 (PST)
X-Received: by 2002:aa7:db98:0:b0:46a:d57:d9d0 with SMTP id
 u24-20020aa7db98000000b0046a0d57d9d0mr25216647edt.113.1669625884043; Mon, 28
 Nov 2022 00:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20221116102659.70287-1-david@redhat.com> <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com> <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
In-Reply-To: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 28 Nov 2022 17:57:51 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BQBsBiY48o3FxmQT7H4063=dvDDwSB4S=AyLxXbXuJeA@mail.gmail.com>
Message-ID: <CAAFQd5BQBsBiY48o3FxmQT7H4063=dvDDwSB4S=AyLxXbXuJeA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE usage
To:     David Hildenbrand <david@redhat.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 28.11.22 09:17, Hans Verkuil wrote:
> > Hi David,
> >
> > On 27/11/2022 11:35, David Hildenbrand wrote:
> >> On 16.11.22 11:26, David Hildenbrand wrote:
> >>> FOLL_FORCE is really only for ptrace access. According to commit
> >>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
> >>> writable"), get_vaddr_frames() currently pins all pages writable as a
> >>> workaround for issues with read-only buffers.
> >>>
> >>> FOLL_FORCE, however, seems to be a legacy leftover as it predates
> >>> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
> >>> always writable"). Let's just remove it.
> >>>
> >>> Once the read-only buffer issue has been resolved, FOLL_WRITE could
> >>> again be set depending on the DMA direction.
> >>>
> >>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> >>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Cc: Tomasz Figa <tfiga@chromium.org>
> >>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>    drivers/media/common/videobuf2/frame_vector.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> >>> index 542dde9d2609..062e98148c53 100644
> >>> --- a/drivers/media/common/videobuf2/frame_vector.c
> >>> +++ b/drivers/media/common/videobuf2/frame_vector.c
> >>> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
> >>>        start = untagged_addr(start);
> >>>          ret = pin_user_pages_fast(start, nr_frames,
> >>> -                  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> >>> +                  FOLL_WRITE | FOLL_LONGTERM,
> >>>                      (struct page **)(vec->ptrs));
> >>>        if (ret > 0) {
> >>>            vec->got_ref = true;
> >>
> >>
> >> Hi Andrew,
> >>
> >> see the discussion at [1] regarding a conflict and how to proceed with
> >> upstreaming. The conflict would be easy to resolve, however, also
> >> the patch description doesn't make sense anymore with [1].
> >
> > Might it be easier and less confusing if you post a v2 of this series
> > with my patch first? That way it is clear that 1) my patch has to come
> > first, and 2) that it is part of a single series and should be merged
> > by the mm subsystem.
> >
> > Less chances of things going wrong that way.
> >
> > Just mention in the v2 cover letter that the first patch was added to
> > make it easy to backport that fix without being hampered by merge
> > conflicts if it was added after your frame_vector.c patch.
>
> Yes, that's the way I would naturally do, it, however, Andrew prefers
> delta updates for minor changes.
>
> @Andrew, whatever you prefer!
>
> Thanks!
>

However you folks proceed with taking this patch, feel free to add my
Acked-by. Thanks!

Best regards,
Tomasz

> --
> Thanks,
>
> David / dhildenb
>
