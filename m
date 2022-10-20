Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327DA60685B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJTSmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJTSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:42:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468A1208809
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:42:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so149351plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiLFWWbEtdCDuURuAcgBAS+IDqShPLESUc/digwUyOQ=;
        b=is+dxxAdd4jXbGomGgpqBlglzFuIhZBN+mY22McB5iz1ijkjv+BOtTkj7PHH7jR4w+
         vWEf+Njo+LaPuFFiSjL3qGSpn9IMgegQr4ayfAi9LSJY330Mdg65huw6G/+2QWT7JB0l
         EfXLfofcVi43z9wEOwUm6BZuCO5InhFjCF0FSy7VT3uBkbIhZ/l++dJmv1aDxm7aheJw
         jKfZRNM3zxR2uIVrMmPR/7yWQA6XYzXF8JfJprgTguhr4dDSSc/NpKW6eymDIRs6Nuc/
         /QS2HSwvHLZKW0aeS7OMu/sH2PvqTgBZ9wVY6+N6wY5jWM7X7YUgjBhQ27/noQ7Ih22l
         CiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiLFWWbEtdCDuURuAcgBAS+IDqShPLESUc/digwUyOQ=;
        b=wB2cPyoj2MQQ16D3PlJ75f8wyzy8dMaWq34dD7Bjen3vAsAH5pKFk9VugPMBHldcs4
         o+2xYS/oU7dKC9GeMELoX+cUCPcai+vx1VO+pMqU5jgenmiPQHSOAXGQXkN79ERPebmB
         OUtOtdujF90Ic9KcSqWNDmCVSbtPTDL3r+h8SG5GbFTJ7OHygJY6OeHLynq3PI1z4dJz
         UbjxZuNmAZzJ/FIqKzRzTMVzeOEFR6cA2Z0hSBuc1L/YvWhroyKJ0NP2LgEQHCIXuRK6
         RqM0G012y0s1xhVV9ZRPHL/ZRP2i4mbn2xH77PqGn7batEARH4F46HdejXokVVv/1XO+
         bB1g==
X-Gm-Message-State: ACrzQf3afpG7eWOFE2xGYAp/K8EJT2QeMKGRSxe+AsruBUFsqhefqx9O
        3yma23YoMqt6UeM9AKnkJWivftQt0Levh/Y8GrI=
X-Google-Smtp-Source: AMsMyM6UhYzjmEGu+p0gK8975yIVhbSs0Cg4B50yT+TQ3UmVYiKa78m9OHOBciwIIqBzUSJ5kno8pCZNuZrQ9fnQ+6Y=
X-Received: by 2002:a17:903:41cf:b0:183:5a22:c63e with SMTP id
 u15-20020a17090341cf00b001835a22c63emr14905540ple.61.1666291368493; Thu, 20
 Oct 2022 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221018200125.848471-1-jthoughton@google.com>
 <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com> <Y1BIHxIbVIc18zBj@monkey>
In-Reply-To: <Y1BIHxIbVIc18zBj@monkey>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Oct 2022 11:42:36 -0700
Message-ID: <CAHbLzkrQsg8NVio+uLz6vbgY1q4LdK3DVH1ET2kj32caqPxyBw@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:55 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/19/22 11:31, Yang Shi wrote:
> > On Tue, Oct 18, 2022 at 1:01 PM James Houghton <jthoughton@google.com> wrote:
> > >
> > > This change is very similar to the change that was made for shmem [1],
> > > and it solves the same problem but for HugeTLBFS instead.
> > >
> > > Currently, when poison is found in a HugeTLB page, the page is removed
> > > from the page cache. That means that attempting to map or read that
> > > hugepage in the future will result in a new hugepage being allocated
> > > instead of notifying the user that the page was poisoned. As [1] states,
> > > this is effectively memory corruption.
> > >
> > > The fix is to leave the page in the page cache. If the user attempts to
> > > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > > EIO, the same error code that shmem uses. For attempts to map the page,
> > > the thread will get a BUS_MCEERR_AR SIGBUS.
> > >
> > > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > Thanks for the patch. Yes, we should do the same thing for hugetlbfs.
> > When I was working on shmem I did look into hugetlbfs too. But the
> > problem is we actually make the whole hugetlb page unavailable even
> > though just one 4K sub page is hwpoisoned. It may be fine to 2M
> > hugetlb page, but a lot of memory may be a huge waste for 1G hugetlb
> > page, particular for the page fault path.
>
> One thing that complicated this a bit is the vmemmap optimizations for
> hugetlb.  However, I believe Naoya may have addressed this recently.
>
> > So I discussed this with Mike offline last year, and I was told Google
> > was working on PTE mapped hugetlb page. That should be able to solve
> > the problem. And we'd like to have the high-granularity hugetlb
> > mapping support as the predecessor.
>
> Yes, I went back in my notes and noticed it had been one year.  No offense
> intended to James and his great work on HGM.  However, in hindsight we should
> have fixed this in some way without waiting for a HGM based.
>
> > There were some other details, but I can't remember all of them, I
> > have to refresh my memory by rereading the email discussions...
>
> I think the complicating factor was vmemmap optimization.  As mentioned
> above, this may have already been addressed by Naoya in patches to
> indicate which sub-page(s) had the actual error.
>
> As Yang Shi notes, this patch makes the entire hugetlb page inaccessible.
> With some work, we could allow reads to everything but the sub-page with
> error.  However, this should be much easier with HGM.  And, we could
> potentially even do page faults everywhere but the sub-page with error.
>
> I still think it may be better to wait for HGM instead of trying to do
> read access to all but sub-page with error now.  But, entirely open to
> other opinions.

I have no strong preference about which goes first.


>
> I plan to do a review of this patch a little later.
> --
> Mike Kravetz
