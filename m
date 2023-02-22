Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F369FEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBVWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:54:20 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AF10CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:54:18 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id d20so4330021vsf.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677106458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vwXFOqgMuy52mReBM7YJtW0wWXswYMcjcxrkPg4Wbpk=;
        b=C4u1m+qj59yTXcFhECr+gLA8EE3O3Y42cUVexpZHT2IK/W9JYY+qiTKdFl70rnDcPc
         8AEX1VXCVpnKRyQIaGQsEbxUPn9aa0bRoCVyrQEEEy5s53/MfVT4hiIggvzQclHrmBOB
         eMsjTVOv6nynaOFNalhqbHEfCXA+58L5VfCIzErJ/0Hag9SCfG/No3lrSna2RZXuc7Ks
         rkZA93dqgkUMZBFWkP2elM3P+cUkve2qeUgdbhjneXL3FLxkU3w7As4INVYIfWYGD1WV
         3nLn/EEbSDb0f3hlM4V4unI1tqTHwLN07lS1kZVzyxNhMD2Pcvb3kfRv+gmNQ5nEcMw9
         EBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677106458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwXFOqgMuy52mReBM7YJtW0wWXswYMcjcxrkPg4Wbpk=;
        b=C0lSBQLaZI+fPJAQW8N0CArnX1mwJA+4XqJ5ZhJNdf6pJ9/wyXbsgUMyhMjTuhNcwr
         feSZa1hUDm9UnU8kyRePiqm6h0QFKN1rA+SPbM8SuxnW/MaOxLOJl53E8tiuVb3wCMka
         KzL9qzwdZNharZEgk3m+2NMJxfJNMUbXf7rU5aRTITBz3E9lZPQESEloZmr29oZoxfjp
         PpR6t94iVh2cvpDaLocyASS0qJVHwmTTkLltkk5pO1KRVKCMV0Gs3npJBhwrvVAYxwfV
         IuzUWUD/Lo449eknQqLHig7x+JgT2sjSPcv1lysivjv19aGNXdRi4OdUpFvtnqekuUiL
         w8bw==
X-Gm-Message-State: AO0yUKUlfjkrEePYOe4Py8/hcRhOZ0TJdiNE2c5QhZpx1Q14I51O79j6
        OyCNxYeaIEph082iY2Z1IY9GkmkQK71hhQbtjsTpKQ==
X-Google-Smtp-Source: AK7set8/28U69HPGUVsZOSqq2mG7uy8Ii3ibCWRXbJfiC/xiMdhOy1uOz48V38C7m+VeqUXgLFLiGCesuq9On+Q0RGk=
X-Received: by 2002:a05:6122:1692:b0:401:42f3:fe4d with SMTP id
 18-20020a056122169200b0040142f3fe4dmr1971940vkl.42.1677106457981; Wed, 22 Feb
 2023 14:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-16-jthoughton@google.com> <CAHS8izPAcFSn-TyZyGr0C3b7Q-0t3GUUjHdB2Q=Z79F8USa5RA@mail.gmail.com>
In-Reply-To: <CAHS8izPAcFSn-TyZyGr0C3b7Q-0t3GUUjHdB2Q=Z79F8USa5RA@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 22 Feb 2023 14:53:42 -0800
Message-ID: <CADrL8HWJW-QYe9RnsLCH_0zqo3Wn4sHvDaoBdf4WeA11AnMgbQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/46] hugetlb: add make_huge_pte_with_shift
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

On Wed, Feb 22, 2023 at 1:15 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wrote:
> >
> > This allows us to make huge PTEs at shifts other than the hstate shift,
> > which will be necessary for high-granularity mappings.
> >
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thank you :)

>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f74183acc521..ed1d806020de 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5110,11 +5110,11 @@ const struct vm_operations_struct hugetlb_vm_ops = {
> >         .pagesize = hugetlb_vm_op_pagesize,
> >  };
> >
> > -static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> > -                               int writable)
> > +static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
> > +                                     struct page *page, int writable,
> > +                                     int shift)
>
> Nit: can this be 'unsigned int shift'. Because you're actually passing
> it an unsigned int below and there is an implicit cast there. Yes it
> will never matter, I know...

Yes I think it should be unsigned int. Thanks for the catch.

>
> >  {
> >         pte_t entry;
> > -       unsigned int shift = huge_page_shift(hstate_vma(vma));
> >
> >         if (writable) {
> >                 entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
> > @@ -5128,6 +5128,14 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> >         return entry;
> >  }
> >
> > +static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> > +                          int writable)
> > +{
> > +       unsigned int shift = huge_page_shift(hstate_vma(vma));
> > +
> > +       return make_huge_pte_with_shift(vma, page, writable, shift);
> > +}
> > +
> >  static void set_huge_ptep_writable(struct vm_area_struct *vma,
> >                                    unsigned long address, pte_t *ptep)
> >  {
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
