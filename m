Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C102C632C26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKUSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKUSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:33:59 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC422C9026
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:33:56 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 7so14574477ybp.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qg+e2O0H9WsioRdDgWCYzvTng7LFE6we2RznhTrz2ws=;
        b=BgcAbTBkUmbQyhNx3mRxuxNPych+Rkwd57U7c2CWZjgUTwsFkbwOTlnfj8SFjEK+Z5
         XKKwkbnMdNN9i+PWrALNhZ4n1abMXnd8sYi8o7E+mWPrakYoJDzRy0yfL9RQy0cJW6Hb
         KXLguPyXXnGE/QshUwiBmN+AtC2kMzQZUJ6q3iWZr3/Mf93lTBqsJDMyNPlxYSZqdsoO
         nkocPx9qu6DEnC0c+Ckio5j+YNvna/M+t8fWB9erqvOyv/MFk647s7fvJ6QDGp3MIZj+
         IL553LR4C6yl7wUx3v/sDQqm3VmkDMJ1Vp1uNJk+vLRtOEyW1vbQWS1XNgNEJO/+kVFd
         6q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg+e2O0H9WsioRdDgWCYzvTng7LFE6we2RznhTrz2ws=;
        b=0H82MAAj02oNMbu3SyV09ceUQJFgMvl+TTaJkscdJGQ/NeD6ao2qMTaPytUOz37+vA
         8zUpLtQzZN+jLp+/7n13I8k+Rt6Atw7fuK8aTdGtVvIR4Xx2IKt3m3+Hk+mQJ0mJ1jW9
         yyctsYfBRdnBUoS+JaI99OWHIjxuMsCP6jG6FDza4f3bPmMWzx06rW7VJorPDA0slVYa
         qBWi69tjW6gPQprBymhrpAlZZXDI05cxFGYWAq7ZFCncSvOYdhf3wC4/7VBxtFh8ldAw
         gRCeMXCUlJUN1b58Ufpt9VWiqmD9OWh0EWpQRzw1mdXlRg9MO21Elhtzj5HQ3WKc7eWM
         UTEA==
X-Gm-Message-State: ANoB5pk8vQyH34AfK5Wkh0TeYPwzrlCbBtrWBfqmmRk5WTgHUhbF/ivh
        CrHYMy6/OBQF93jpbVUUe+XZ5WdRG+fj5KVFB2zrXg==
X-Google-Smtp-Source: AA0mqf6ZkhjZlk4W86OQFInQl+DM7rAm+6NRbPKEEIy3bftzt5PgeqFzOPhZQMqJohaGtGCO1jXtfRTlmVzw9uHZOGY=
X-Received: by 2002:a5b:505:0:b0:6cf:e605:7707 with SMTP id
 o5-20020a5b0505000000b006cfe6057707mr117675ybp.638.1669055635817; Mon, 21 Nov
 2022 10:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-2-jthoughton@google.com> <Y3UQCmlnQXfKhbyE@x1n>
In-Reply-To: <Y3UQCmlnQXfKhbyE@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 21 Nov 2022 10:33:45 -0800
Message-ID: <CADrL8HXXT+7BBMj3kgR8g=z4RZv0q-AF5ykkg1vXF9aYCWg9MA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/47] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
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

On Wed, Nov 16, 2022 at 8:30 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:17PM +0000, James Houghton wrote:
> > This is how it should have been to begin with. It would be very bad if
> > we actually set PageUptodate with a UFFDIO_CONTINUE, as UFFDIO_CONTINUE
> > doesn't actually set/update the contents of the page, so we would be
> > exposing a non-zeroed page to the user.
> >
> > The reason this change is being made now is because UFFDIO_CONTINUEs on
> > subpages definitely shouldn't set this page flag on the head page.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1a7dc7b2e16c..650761cdd2f6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6097,7 +6097,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >        * preceding stores to the page contents become visible before
> >        * the set_pte_at() write.
> >        */
> > -     __SetPageUptodate(page);
> > +     if (!is_continue)
> > +             __SetPageUptodate(page);
> > +     else
> > +             VM_WARN_ON_ONCE_PAGE(!PageUptodate(page), page);
>
> Yeah the old code looks wrong, I'm just wondering whether we can 100%
> guarantee this for hugetlb.  E.g. for shmem that won't hold when we
> uffd-continue on a not used page (e.g. by an over-sized fallocate()).
>
> Another safer approach is simply fail the ioctl if !uptodate, but if you're
> certain then WARN_ON_ONCE sounds all good too.  At least I did have a quick
> look on hugetlb fallocate() and pages will be uptodate immediately.

Failing the ioctl sounds better than only WARNing. I'll do that and
drop the WARN_ON_ONCE for v1. Thanks!

- James

>
> >
> >       /* Add shared, newly allocated pages to the page cache. */
> >       if (vm_shared && !is_continue) {
> > --
> > 2.38.0.135.g90850a2211-goog
> >
> >
>
> --
> Peter Xu
>
