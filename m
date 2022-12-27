Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF0656D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiL0RDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiL0RDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:03:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F104A19A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:03:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y8so12882838wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuZBQ+L+0/ZqHqWlgeQLK5JnjyvDB5tbr4vfEmfM+Fw=;
        b=evI4PAAF6tj+QUQqNK4wWdSLrvtCi2JscjdLHeZNcQM/+rdxH8ykhmtxECH30THm5V
         iGs7Il9f2Od7bZaLRGOhVmedf7XOcTDGFKE9rX8N7Mw5OFNdie0O62s1OCHrzaL8tUr7
         pYUhTyL8ELxE4SKdfZK+enSOeL4Bi/MnPpAUjhKYaXExptSK9RzgI8jjNf21XN/0mjTg
         ThzJqUNBdmuqLhVwYJqU+CElUnTmALKONofsJ9xp8PT3OvSIedX6lj6ZnBpUzHrLo0BD
         H8Aw9m8lheLUwObVzD/k2yhJu0S9WIBQAeKTeFdjLVTnlXYmu8BlNpRD9vTJEbZqcUJy
         RDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuZBQ+L+0/ZqHqWlgeQLK5JnjyvDB5tbr4vfEmfM+Fw=;
        b=3PlSj/oTtGlnBKQxrVOmmtROrZdO4rZHs2xEU8Xt4EZiXxdnfWF0mOsAunvFluYRUU
         f6DnkELmdm9oaBP3WJyQmi90tR260ZKOt2zBxfFHRuFkRvjhOvX1s3iRinF7cVSUObyS
         lDwhuHX0LpxC+jc/Idy3riEcyv7nVcfk0LGorY9Um54TI3h1SGOBuGWip8lkN3mdS2/e
         mRYXeFX+I93EHbc/os16ty1GplGlmUL3ZHAs1hrKM3xVvQU7Zpx7CcXxvX+G1D0wjLU4
         By9GlAiJDK0QgjF5EfCExs72hrIyBOfVJ5oUUoIwrKqeDZ4SmoDzC8AXqb/X3F8ttYxz
         Fkxw==
X-Gm-Message-State: AFqh2kqMpUNLYWPC5qPNY6YbKSjx6j2/GZFtPUOrAHGz+VJgHZA17RA1
        xn5y54g0ViOKWFhNwbHw3X9K2xCaDKAwegUCdhqAwg==
X-Google-Smtp-Source: AMrXdXtv3Kx/hsnH8qHZ4/5Xn9yjb93rEM31ac4LuAYi7aA2bkw3tBFW/HzoekpyPwqH1rPr706bfAMUSAXaxaS+4rs=
X-Received: by 2002:a5d:6148:0:b0:280:91ea:29b7 with SMTP id
 y8-20020a5d6148000000b0028091ea29b7mr167070wrt.98.1672160584923; Tue, 27 Dec
 2022 09:03:04 -0800 (PST)
MIME-Version: 1.0
References: <Y3VkIdVKRuq+fO0N@x1n> <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n> <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey> <Y6OEQB3dLSa083F6@x1n> <Y6OJUtVkvdptEgW7@monkey>
 <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
 <Y6Om/dvlt1Wl2uZw@monkey> <CADrL8HU_4ymb4XMBpujyFECwONKpWP0fgZgy7odb+M23QUx6pQ@mail.gmail.com>
 <Y6RqAbGOFEKFUeQr@x1n>
In-Reply-To: <Y6RqAbGOFEKFUeQr@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 27 Dec 2022 12:02:52 -0500
Message-ID: <CADrL8HWt0s_Ev+QRCVQqdkLbe_jX0X95A=UNYn1Ej8qpr=38ng@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 9:30 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Dec 21, 2022 at 08:24:45PM -0500, James Houghton wrote:
> > Not sure what the best name for this flag is either. MADV_ENABLE_HGM
> > sounds ok. MADV_HUGETLB_HGM or MADV_HUGETLB_SMALL_PAGES could work
> > too. No need to figure it out now.
>
> One more option to consider is MADV_SPLIT (hopefully to be more generic).
>
> We already decided to reuse thp MADV_COLLAPSE, we can also introduce
> MADV_SPLIT and leave thp for later if it can be anything helpful (I
> remember we used to discuss this for thp split).
>
> For hugetlb one SPLIT should enable hgm advise bit on the vma forever.

MADV_SPLIT sounds okay to me -- we'll see how it turns out when I send
v1. However, there's an interesting API question regarding what
address userfaultfd provides. We previously required
UFFD_FEATURE_EXACT_ADDRESS when you specified
UFFD_FEATURE_MINOR_HUGETLBFS_HGM so that there was no ambiguity. Now,
we can do:

1. When MADV_SPLIT is given, userfaultfd will now round addresses to
PAGE_SIZE instead of huge_page_size(hstate), and
UFFD_FEATURE_EXACT_ADDRESS is not needed.
2. Don't change anything. A user must know to provide
UFFD_FEATURE_EXACT_ADDRESS to get the real address, otherwise they get
an (unusable) hugepage-aligned address.

I think #1 sounds fine; let me know if you disagree.

Thanks!
- James
