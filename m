Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D26674E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjALOPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjALOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:14:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D05CF8B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:07:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k8so3692495wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VeQspTnffiwI58L9LycVhK0E5SPBlYLIUK7B8t+8/6A=;
        b=MFX2NB5TMIFbOLH7I+9IQK889rOdZYfEhXxTxxThTb7W6cM+VdBHV99ld0Ek5raHWr
         0QnGbZIaX/Uf3A7hezWUNwA5C+b1hltdMG7EfCPJQ99LDymNeyRB7MgnAU1usmV3lM0y
         BC7yCwUq3QusphxYA631uWFAVnnrsEHjVK4TbADR1U52gNzYeWEFQAx6hjabwqyHocE/
         OKeATcA6Jc8tMpVpGkSp2kpiY8QGuu+PBNqBQCCpllEplmsQWbtqoXU4y/GizjSSJedC
         tW60ojiQS9r1lIjQbqQkoKN/uXhchTXy41RvYULJcTc07CYd75K6mhZl84pmq+rkcJs+
         wdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeQspTnffiwI58L9LycVhK0E5SPBlYLIUK7B8t+8/6A=;
        b=KtUR/1kO16VssNf7ZDusUH+tWKifPZBXCkf+A19cC7IfhU3Kx464b5KFehaEuSAF5h
         rYQb0+2q1f0ReIMPGkbV6vOKYq4vukrtW2alGD27M+60ByET+nrI17Utybu62wFfq41E
         hWgmAtcz5vyA6uYDL9TnrtiHSgzX/VvZbHNQVjV58SaSyLpv6K5ekTlomWgXsESCidD9
         zvbrtCpyaXCsB6Q9iJgfZQLRLRZKSZfjYLXUCBUatvwm/8BehEXw1vo929Ig7yHO5dG2
         uwqtOM9HQi1lkK/e8IYlZAdgRE8aocFUFyhQHkztJ2Zb02FWQ9DtKd1+ktnZ47oUuv2W
         YYRw==
X-Gm-Message-State: AFqh2koU0w3mBt9Sz+5RjfWtplvqw/MeD9Z6w9rsBsiziAPF4AqAZsUD
        hK3ILWPUEZuVKmeu87phG5+4btWs1UCo3HIcAe65dg==
X-Google-Smtp-Source: AMrXdXucJQn/K8isV2eY+/IdgIcNJyHlG81hYcnf/Bltvh3vgEDQRkW1xtnnHbhEt01DnGFPaMDQMysKTtjyleC3axk=
X-Received: by 2002:a5d:6b51:0:b0:2b7:74c3:560d with SMTP id
 x17-20020a5d6b51000000b002b774c3560dmr1430049wrw.39.1673532419131; Thu, 12
 Jan 2023 06:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
In-Reply-To: <Y78+/wleTEC3gyqu@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 09:06:48 -0500
Message-ID: <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
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

On Wed, Jan 11, 2023 at 5:58 PM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> > @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> >               int mapcount = page_mapcount(page);
> >
> >               if (mapcount >= 2)
> > -                     mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> > +                     mss->shared_hugetlb += hugetlb_pte_size(hpte);
> >               else
> > -                     mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> > +                     mss->private_hugetlb += hugetlb_pte_size(hpte);
> >       }
> >       return 0;
>
> One thing interesting I found with hgm right now is mostly everything will
> be counted as "shared" here, I think it's because mapcount is accounted
> always to the huge page even if mapped in smaller sizes, so page_mapcount()
> to a small page should be huge too because the head page mapcount should be
> huge.  I'm curious the reasons behind the mapcount decision.
>
> For example, would that risk overflow with head_compound_mapcount?  One 1G
> page mapping all 4K takes 0.25M counts, while the limit should be 2G for
> atomic_t.  Looks like it's possible.

The original mapcount approach was "if the hstate-level PTE is
present, increment the compound_mapcount by 1" (basically "if any of
the hugepage is mapped, increment the compound_mapcount by 1"), but
this was painful to implement, so I changed it to what it is now (each
new PT mapping increments the compound_mapcount by 1). I think you're
right, there is absolutely an overflow risk. :( I'm not sure what the
best solution is. I could just go back to the old approach.

Regarding when things are accounted in private_hugetlb vs.
shared_hugetlb, HGM shouldn't change that, because it only applies to
shared mappings (right now anyway). It seems like "private_hugetlb"
can include cases where the page is shared but has only one mapping,
in which case HGM will change it from "private" to "shared".

>
> Btw, are the small page* pointers still needed in the latest HGM design?
> Is there code taking care of disabling of hugetlb vmemmap optimization for
> HGM?  Or maybe it's not needed anymore for the current design?

The hugetlb vmemmap optimization can still be used with HGM, so there
is no code to disable it. We don't need small page* pointers either,
except for when we're dealing with mapping subpages, like in
hugetlb_no_page. Everything else can handle the hugetlb page as a
folio.

I hope we can keep compatibility with the vmemmap optimization while
solving the mapcount overflow risk.

Thanks Peter.
- James
