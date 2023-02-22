Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF169FEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjBVWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:53:08 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFFA8A5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:52:55 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id j14so11969077vse.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677106374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t1YrXJq3WaEAkWelELqkrlZlV6sQWbkUh+zymDC/FcM=;
        b=rEKc7nSXJ3OCotja2EJ8iZ0vwqpwYZFE1hganHW1XfmrR17hL8FI5+sThMcWr9rtky
         YThFCVTiz0NM0ILLp4nenJvTzFcJ170nbuB1mm8ht2JGg84dRARUCCamwoVxn1J6pOJ9
         g9v7VracNz4uONU+W6BMJgXZKZJ/ZJnlUEkBQLYOEJpTK6tue32FD+KtpJkWuH65VxDh
         +lcSuIF6qmWEXqw7uQwc7lHJekp27CXvzIn9BFmLMnObC4M2TNk0IeoOn+kZ4Jfk4SQu
         dftK5GV+jQdzTV7LWe6jHjwyqrr3M3a0+PZij+d9eT8BtOgNzjsdIHPH1w2Ha9uWgrPZ
         W+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677106374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1YrXJq3WaEAkWelELqkrlZlV6sQWbkUh+zymDC/FcM=;
        b=FfGNNjReLlwNKUamKEJ1T9sbkAywNFCqSISljJ0Snwt67kYFrgUs4pl2RQcydCIjX6
         0P0m4HMxcisFNiIs+IIydkSuTv1APd6Eqx9pXrySzIMyaY26hL3uglqYKnoi1ZfsCZFC
         aZKLbIv6PWhZzOWt10ebefw9fCD7QV/kxOgP2J2EPXg+8Aohzcd4GAPiPEK44EKyXW+H
         El+3PUgqFN7f9P+19s/Wx1Uj4xB3novnEvGta2Bkxn65BsNSuTJw9IGhP9akohBTiMxj
         C3WSiSED2r2Kc9ST+o6pEUxTpl0xKIze1K9msOc2VYGS92HDBqM0Me6l957QKA4q6Q0/
         yk+g==
X-Gm-Message-State: AO0yUKXmXbWwAcsKqFJ9Edkw0K1MqkxL91p/Mk7Peg66XD7AbOg8nBLK
        IwR0Js7Qv+NNIkF8+NlpPPwzipRkxl1vICTNs4cvIw==
X-Google-Smtp-Source: AK7set+Hvog1Dx2Cs4T4pz7KjICWNdmS6cbnN633KiEmXHg1e025OzJfDxDqB4MO/d6LR8IOFvFj7jmzOUlY3F+U+Lc=
X-Received: by 2002:a67:e081:0:b0:41e:910f:10ed with SMTP id
 f1-20020a67e081000000b0041e910f10edmr1840052vsl.11.1677106374191; Wed, 22 Feb
 2023 14:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-17-jthoughton@google.com> <CAHS8izP9qVOV4ZvDT4vRS0-xvJ2yiQu9Uze-TSJO1f0Oec95hA@mail.gmail.com>
In-Reply-To: <CAHS8izP9qVOV4ZvDT4vRS0-xvJ2yiQu9Uze-TSJO1f0Oec95hA@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 22 Feb 2023 14:52:18 -0800
Message-ID: <CADrL8HUhD2aHsXw06chQCcCxnJyw7HnD_rE7kK=5X3qzQrVL8Q@mail.gmail.com>
Subject: Re: [PATCH v2 16/46] hugetlb: make default arch_make_huge_pte
 understand small mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Wed, Feb 22, 2023 at 1:18 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wrote:
> >
> > This is a simple change: don't create a "huge" PTE if we are making a
> > regular, PAGE_SIZE PTE. All architectures that want to implement HGM
> > likely need to be changed in a similar way if they implement their own
> > version of arch_make_huge_pte.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 726d581158b1..b767b6889dea 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -899,7 +899,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
> >  static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
> >                                        vm_flags_t flags)
> >  {
> > -       return pte_mkhuge(entry);
> > +       return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
> >  }
> >  #endif
> >
>
> How are contig_pte's handled here? Will shift show that it's actually
> a contig_pte and not just PAGE_SHIFT? Or is that arm64 specific so it
> exists only in the arm64 version of this function? Do we need to worry
> about it here?

arm64 implements its own version of arch_make_huge_pte, and 'shift'
does indeed indicate (to arm64) if the PTE is contiguous or not (like
it will be CONT_PTE_SHIFT, for example).
