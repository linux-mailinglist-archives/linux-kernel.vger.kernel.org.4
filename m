Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889D653788
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiLUUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:21:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFBC211
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:21:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so16075413wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9MEqlNzDIbf7HSYYn7yaUunAAdmpHInWdycxJre5qk=;
        b=otzkbme8DQ+YN964XlRmVnqW9zpdM68YOuEVyYAvOV3n6/r7TBBMTAVYcuLoi5KCAL
         wDojGD4JKGxWvxPTDcn3ZOLDPg41o5qpT4/ebINHDWMxRlDFVwHfvl2j+6L2zIV25qYi
         lI09xG+7uZjlRFxgvDU6TfrszMcGvHSWcMcX442zhLzmEoTx91ZgasQ/8JjNahoyAulg
         EPwlcXOFhn1pU7f2zH4NDa2VcjDTv/g/h2J4sufGAYujhfdu0cmiBAE1jHoIiESkYe1r
         Rt86IBZ84WrOV7emqxm+ffVz5AKNvx3VilzV+ySh49KVOBoSdXBr84DSst7XMLfDS47J
         /flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9MEqlNzDIbf7HSYYn7yaUunAAdmpHInWdycxJre5qk=;
        b=cctz0m44Yg5vFMWMWWv578Q3CoEs1wzjeg/q9u7ra+OgVPbszJm6ka6ber6+hyktQJ
         fO04DPbjs7S/LHc53VyVO8GyRLSpHcF2tbCM8gh9Caqv3p6ichLmRo9geiWCkd/Gw/+S
         Mi6RWdojm3e+imvt1CBj2/ZR1MnT7ZvAsLj5WayVbnzxstDw49G4yTyE928yukTAKlsW
         f+PnV30oxaP6QwaiKztoyB6V8u9gti8LaIN3GqwAXZ+s9UIy9gJOJSDWU2RkirKWigQe
         hIjpMymUMD8dZxkoMwOLd2f9w8oj0E/aFWexq6Q2Pxv5cTsgrg+aNCKUlwo0YWJFratI
         3+ig==
X-Gm-Message-State: AFqh2kqYnVRF3kIMPaYf0ZZh3LVJoWoMqctam5bCgAOkV5iIQshRiFk0
        y15Akn7tM4T6f6F3gqIWFkS5b2KYdBoq7xaa/pUypQ==
X-Google-Smtp-Source: AMrXdXvrzynoRDjhQO3b3GLd3Sb5RrV43m+9J5OVY29ww6nZSTFmLj2RMV9xVhjVhKZnGgvq6fP1rJmbYPgoCQeYgUw=
X-Received: by 2002:adf:8b93:0:b0:26b:361a:52f1 with SMTP id
 o19-20020adf8b93000000b0026b361a52f1mr153484wra.655.1671654090127; Wed, 21
 Dec 2022 12:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com> <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com> <Y6NdN2ADVCcK70ym@x1n>
In-Reply-To: <Y6NdN2ADVCcK70ym@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 21 Dec 2022 15:21:18 -0500
Message-ID: <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
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

On Wed, Dec 21, 2022 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Wed, Nov 16, 2022 at 03:30:00PM -0800, James Houghton wrote:
> > On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > > > Userspace must provide this new feature when it calls UFFDIO_API to
> > > > enable HGM. Userspace can check if the feature exists in
> > > > uffdio_api.features, and if it does not exist, the kernel does not
> > > > support and therefore did not enable HGM.
> > > >
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > >
> > > It's still slightly a pity that this can only be enabled by an uffd context
> > > plus a minor fault, so generic hugetlb users cannot directly leverage this.
> >
> > The idea here is that, for applications that can conceivably benefit
> > from HGM, we have a mechanism for enabling it for that application. So
> > this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
> > prefer this approach over something more general like MADV_ENABLE_HGM
> > or something.
>
> Sorry to get back to this very late - I know this has been discussed since
> the very early stage of the feature, but is there any reasoning behind?
>
> When I start to think seriously on applying this to process snapshot with
> uffd-wp I found that the minor mode trick won't easily play - normally
> that's a case where all the pages were there mapped huge, but when the app
> wants UFFDIO_WRITEPROTECT it may want to remap the huge pages into smaller
> pages, probably some size that the user can specify.  It'll be non-trivial
> to enable HGM during that phase using MINOR mode because in that case the
> pages are all mapped.
>
> For the long term, I am just still worried the current interface is still
> not as flexible.

Thanks for bringing this up, Peter. I think the main reason was:
having separate UFFD_FEATUREs clearly indicates to userspace what is
and is not supported.

For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
allowed as of this patch series, but it could be allowed in the
future. To add support in the same way as this series, we would add
another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
having to add another feature isn't great; is this what you're
concerned about?

Considering MADV_ENABLE_HUGETLB...
1. If a user provides this, then the contract becomes: "the kernel may
allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
high-granularities, provided the support exists", but it becomes
unclear to userspace to know what's supported and what isn't.
2. We would then need to keep track if a user explicitly enabled it,
or if it got enabled automatically in response to memory poison, for
example. Not a big problem, just a complication. (Otherwise, if HGM
got enabled for poison, suddenly userspace would be allowed to do
things it wasn't allowed to do before.)
3. This API makes sense for enabling HGM for something outside of
userfaultfd, like MADV_DONTNEED.

Maybe (1) is solvable if we provide a bit field that describes what's
supported, or maybe (1) isn't even a problem.

Another possibility is to have a feature like
UFFD_FEATURE_HUGETLB_HGM, which will enable the possibility of HGM for
all relevant userfaultfd ioctls, but we have the same problem where
it's unclear what's supported and what isn't.

I'm happy to change the API to whatever you think makes the most sense.

Thanks!
- James

>
> --
> Peter Xu
>
