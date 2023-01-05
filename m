Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337E65E279
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjAEBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjAEBXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:23:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29623F11E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:23:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so21549843wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iT+lTm4nI7audT05NuAnB4AV4C6eHB3o7/YvWGrh+hA=;
        b=I78A5qcp7WeJPpPbuyAINFilNEdW+GYeP/LiK0lPPlAr02nSoaPMbXu/0lTPQJPdPc
         3vtZz4sEla5pQEjQUFxxxB8UH4tUnhx0Gimo/Mon0vJ3hv6AaNpIzwT0/WXz1Ik832j1
         ti++CmRF2I74vS8eW0Shuz6UQefUROY5wYOc8BO6QK9LObYHxwLMCsLNhgRQghBPPUDT
         bHa6E7ta7Yt5/MDGAYFYP+6A0C1Q7DcFghSIfKTqh/EBOrayq3JqWrP08peDM+n14Uzp
         oCow0HtpTCCFud1Ku9T/SjRiXN0LkPdOQSN65iznIapMxGAffV78lhpYUsFbGHoqqHjp
         kTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT+lTm4nI7audT05NuAnB4AV4C6eHB3o7/YvWGrh+hA=;
        b=oo3JLm6aVFD+oElLmv6tWSjQl1bzZe/8KLu7UNxrtqyHf4pxkMypUB4/oEH/s6rLsD
         2Fvz+ayUQhnfol0ooo9rw/mUvx4Ylid+6WZ0yKaIE+xt6FmeiGQYhyHYQZyOqIMQwoAL
         BucxzN+XoE2nfAjRfnzXGXsm0erdAKs5brkiqk1wXaQGbrcyMMyGZx8zrr2Qq/sZ9/Wx
         FcxNoKOkC2/hvC6Jd7Sj25goFwEZk6Ut56nP/VWxx5qP863EVCHNwVnCOlte7d+y9nUZ
         uLrbmH0R/8uLB2XXuwrErySUgAS+o980ISq8AE4KgrpupE5Mt8NRF4aBZVGCCoHMm3ns
         KhvQ==
X-Gm-Message-State: AFqh2kqh+ftuA2OXd9PsWpEXsmH0nEc+mVQf9CaR66LoIqtazhTTCDqU
        zkXLdBGBDdUsxbobkajOMYxcuxRK799pC6JA6/ewVw==
X-Google-Smtp-Source: AMrXdXuCjJh1DhnSeqZjJt2mEorQUVq6WEpzHulaujU5eZ9DJhXGbNqIdpb0w3oOAgcstdnm2/RsVQATjWwZrcuCfYc=
X-Received: by 2002:a5d:640b:0:b0:290:ef26:df02 with SMTP id
 z11-20020a5d640b000000b00290ef26df02mr957635wru.664.1672881808043; Wed, 04
 Jan 2023 17:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com> <d5760f7f-5985-1962-1c89-f32eb743985c@oracle.com>
In-Reply-To: <d5760f7f-5985-1962-1c89-f32eb743985c@oracle.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 5 Jan 2023 01:23:15 +0000
Message-ID: <CADrL8HXUo-vTL5vH7=fMVPoE0+epdmGbQT=3FXq7C2gwoPWaAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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

On Thu, Jan 5, 2023 at 12:58 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> > + * @stop_at_none determines what we do when we encounter an empty PTE. If true,
> > + * we return that PTE. If false and @sz is less than the current PTE's size,
> > + * we make that PTE point to the next level down, going until @sz is the same
> > + * as our current PTE.
> [..]
> > +int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
> > +                  struct hugetlb_pte *hpte, unsigned long addr,
> > +                  unsigned long sz, bool stop_at_none)
> > +{
> [..]
> > +     while (hugetlb_pte_size(hpte) > sz && !ret) {
> > +             pte = huge_ptep_get(hpte->ptep);
> > +             if (!pte_present(pte)) {
> > +                     if (stop_at_none)
> > +                             return 0;
> > +                     if (unlikely(!huge_pte_none(pte)))
> > +                             return -EEXIST;
>
> If 'stop_at_none' means settling down on the just encountered empty PTE,
> should the above two "if" clauses switch order?  I thought Peter has
> raised this question too, but I'm not seeing a response.

A better name for "stop_at_none" would be "dont_allocate"; it will be
changed in the next version. The idea is that "stop_at_none" would
simply do a walk, and the caller will deal with what it finds. If we
can't continue the walk for any reason, just return 0. So in this
case, if we land on a non-present, non-none PTE, we can't continue the
walk, so just return 0.

Another way to justify this order: we want to ensure that calls to
this function with stop_at_none=1 and sz=PAGE_SIZE will never fail,
and that gives us the order that you see. (This requirement is
documented in the comment above the definition of hugetlb_hgm_walk().
This guarantee makes it easier to write code that uses HGM walks.)

> Also here below, the way 'stop_at_none' is used when HGM isn't enabled
> is puzzling.  Could you elaborate please?
>
> > +       if (!hugetlb_hgm_enabled(vma)) {
> > +               if (stop_at_none)
> > +                       return 0;
> > +               return sz == huge_page_size(hstate_vma(vma)) ? 0 : -EINVAL;
> > +       }

This is for the same reason; if "stop_at_none" is provided, we need to
guarantee that this function won't fail. If "stop_at_none" is false
and sz != huge_page_size(), then the caller is attempting to use HGM
without having enabled it, hence -EINVAL.

Both of these bits will be cleaned up with the next version of this series. :)

Thanks!

- James
