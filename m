Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8D062D0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiKQBj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKQBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:39:24 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8D2529C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:39:23 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-376596ae449so5350387b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+zGv9vaFR5Pk6w8irqXhv3za0LaNRRJC/xfq3ObajE=;
        b=KcE2WeaXge1v3PX1H634l/+DCU4lr6UaJt1yg2rv61+dta0Nz72nTz1mszYBBqfsME
         tF38kGGo26RzzAtS3ujs5cNMHsbwzkN6gZhBjFiHjSjz6WWWz/ZhlrlgnEueKNKlFqJ2
         GtI6Dw4DJ6tFsVEn5eQiZGMLr/qSs1r2oKBkkt/NG9IJ/Zt+ExHdhujT08YrLI0OLCdB
         5q91HrNzYsY3nICH3PRvmKjgR2+Acb0BZBA893yXGrIXt2/P1Ce4JksfNh4R3MIsPiP8
         GueHEO4ZsWo/Tv0iAaWZCnWFyyNumdcmONg/GOUzKLPWPVD3gKNUEJ7vqvilZtkhmpX3
         z7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+zGv9vaFR5Pk6w8irqXhv3za0LaNRRJC/xfq3ObajE=;
        b=YJCH6oMpM6VPVA5aOMjVKw2AZ74/fdvWDl7oZ9xjhmZYwE93UxIBF7j6sRCEZ2s8zH
         QpIRoKNPuFGr20tpN3otd6quxVuLUuQW04eq1fBSE6E69jnpHbrJm3mziseJuKnUHPKL
         jzYIovzhLwGJneAn0gaO2DiR2om8G+i0JrH46/ghJMv1Ye2Reyb62fZCO34k+BqYle6u
         /HqCqEdhTgq/KmE1iepcCPE/g6OfIjFRQmNSTLGw07U/bl9IwIdeeBvG3p7X4kiVPh3t
         uYdIUwaD9O3XJMFWMP1lxxJAfhimHVGeez+4yWfOTR3d67dJoTqhcZtA8wc+jUt+gu2c
         qG2g==
X-Gm-Message-State: ANoB5pkr+2Kt7MuVCc+GfML5Ok6rjaCQSYFYGZD2A7DcJhdW/eDtpAbu
        J0xHQRr0aCRyGpfrfe0DPH92zcxIMeCDn3X1nXrgRQ==
X-Google-Smtp-Source: AA0mqf5hwszcJje10Ni1qfeUIno07FzJfKvsq9PsVi2yjGB8A2lel1WPcRdV+av6m+aC5pj1toVSWtYf5LJKGkzBwh4=
X-Received: by 2002:a81:8302:0:b0:36a:1b76:eca8 with SMTP id
 t2-20020a818302000000b0036a1b76eca8mr94333ywf.483.1668649162897; Wed, 16 Nov
 2022 17:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com> <Y3Vd6dxNvGguCyxi@x1n>
In-Reply-To: <Y3Vd6dxNvGguCyxi@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 16 Nov 2022 17:39:12 -0800
Message-ID: <CADrL8HXY_U1Ag2BnAv11gsMw_6EccDqSg7u6hd=9ws_J3z0cyg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
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

On Wed, Nov 16, 2022 at 2:02 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:28PM +0000, James Houghton wrote:
> > +/* hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
> > + * the page table entry for @addr.
> > + *
> > + * @hpte must always be pointing at an hstate-level PTE (or deeper).
> > + *
> > + * This function will never walk further if it encounters a PTE of a size
> > + * less than or equal to @sz.
> > + *
> > + * @stop_at_none determines what we do when we encounter an empty PTE.
>
> IIUC it is not about empty PTE but swap-or-empty pte?
>
> I'm not sure whether it'll be more straightforward to have "bool alloc"
> just to show whether the caller would like to allocate pgtables when
> walking the sub-level pgtable until the level specified.

I think "bool alloc" is cleaner. I'll do that. Thanks for the suggestion.

>
> In final version of the code I also think we should drop all the "/*
> stop_at_pte */" comments in the callers. Maybe that already means the
> meaning of the bool is confusing so we always need a hint.

I did that to hopefully make things easier to read. I'll remove it.

- James

>
> --
> Peter Xu
>
