Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDD6A9A06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCCPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCCPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:00:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6473521C2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677855557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWWXXqiDyIc6Rr6qCB3dXr2H5ZRa+ZVUM0XNMHhCm9k=;
        b=ZKuiy8qi01waGUVUrw0STRx6K9GO26ilZk9Uqfyo3aXk39i3hc6T189TmicDrvaVk1u76V
        rtbaOEAPAD5eHaycHxvjQxXjkPh5IbQGiw0wUujxCpPQMi9nK77tvqsUT4V6lgRNvUtunh
        qC9I6KvZ/E4ADLj0DGSN+ZUXsnjTT/U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-5YSxFOZUOdKBCSWPGaLg_A-1; Fri, 03 Mar 2023 09:59:17 -0500
X-MC-Unique: 5YSxFOZUOdKBCSWPGaLg_A-1
Received: by mail-qk1-f198.google.com with SMTP id d4-20020a05620a166400b00742859d0d4fso1505032qko.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677855556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWWXXqiDyIc6Rr6qCB3dXr2H5ZRa+ZVUM0XNMHhCm9k=;
        b=57fAkevcPywuC2yeCxM1Izi5Yn0ZTEm7uavO36qDTY994cODGae77yMI4agLEENKbp
         Xjxy/baPGkaIqHFcumoOh/zJVOqbsKRh9ib+oSoevNKurSz75BuGelCiE7xUG02b8wzq
         EaWq6p00CGJjmJW9zbBOMWfBYkGPgUoTqyb0XHj6HkKjv/FLsyqcvqCa7WVdWHX9lXDb
         CoP8wi4dR10uiBKhYv8WGcmTn+LfDx+OdDDVpho5m63r3w24/bD7SFk5LkZikMRr7Xy9
         1M/WgoMQzwjZyOoHgjSG9+dhle+FJzBwIM6/vhXZzsKxp3/eNgpI/xdqPWgxCzBOHbxB
         ladQ==
X-Gm-Message-State: AO0yUKWe0+wKCRPGu9hvQswqPrrtuxlA/fj/a08zOGA+7ZNkc+df2BEE
        /jN4kBhqeWOlF/suSX+Soi3c8fVXdtvSCvZ1zeh5NaU603uoXNqmXRyuAoef8ZnTuDkc+z9Qz9O
        YUZit4CZfGeFyDp9o5j14r7bQRLPUAA==
X-Received: by 2002:a0c:f251:0:b0:56e:99ea:966c with SMTP id z17-20020a0cf251000000b0056e99ea966cmr2512250qvl.4.1677855556048;
        Fri, 03 Mar 2023 06:59:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+ZeM2sghlJ2Lwmz8RHXDFH1s49AZ4Mnv5nWJG26/AZtTAFptUUX4noZn/0olp3Qqjd2BrzPw==
X-Received: by 2002:a0c:f251:0:b0:56e:99ea:966c with SMTP id z17-20020a0cf251000000b0056e99ea966cmr2512232qvl.4.1677855555777;
        Fri, 03 Mar 2023 06:59:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id q79-20020a374352000000b0073b27323c6dsm1757032qka.136.2023.03.03.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:59:15 -0800 (PST)
Date:   Fri, 3 Mar 2023 09:59:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Stevens <stevensd@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
Message-ID: <ZAILQkpi7uomSBmb@x1n>
References: <20230222195247.791227-1-peterx@redhat.com>
 <CAHbLzkp3PwpXir=YUuWmxpW5VXEba81UKb3YOyq+snKTZGjqDA@mail.gmail.com>
 <20230302232150.vvmszlrdzqm5ndjq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302232150.vvmszlrdzqm5ndjq@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:21:50PM -0800, Zach O'Keefe wrote:
> On Feb 22 14:53, Yang Shi wrote:
> > On Wed, Feb 22, 2023 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > If memory charge failed, instead of returning the hpage but with an error,
> > > allow the function to cleanup the folio properly, which is normally what a
> > > function should do in this case - either return successfully, or return
> > > with no side effect of partial runs with an indicated error.
> > >
> > > This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
> > > with either anon or shmem path (even if it's safe to do so).
> > 
> > Thanks for the cleanup. Reviewed-by: Yang Shi <shy828301@gmail.com>
> > 
> > >
> > > Cc: Yang Shi <shy828301@gmail.com>
> > > Reviewed-by: David Stevens <stevensd@chromium.org>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > v1->v2:
> > > - Enhance commit message, drop "Fixes:" and "Cc: stable" tag, add R-bs.
> > > ---
> > >  mm/khugepaged.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 8dbc39896811..941d1c7ea910 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1063,12 +1063,19 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> > >         gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
> > >                      GFP_TRANSHUGE);
> > >         int node = hpage_collapse_find_target_node(cc);
> > > +       struct folio *folio;
> > >
> > >         if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
> > >                 return SCAN_ALLOC_HUGE_PAGE_FAIL;
> > > -       if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
> > > +
> > > +       folio = page_folio(*hpage);
> > > +       if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
> > > +               folio_put(folio);
> > > +               *hpage = NULL;
> > >                 return SCAN_CGROUP_CHARGE_FAIL;
> > > +       }
> > >         count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
> > > +
> > >         return SCAN_SUCCEED;
> > >  }
> > >
> > > --
> > > 2.39.1
> > >
> > 
> 
> Thanks, Peter.
> 
> Can we also get rid of the unnecessary mem_cgroup_uncharge() calls while we're
> at it? Maybe this deserves a separate patch, but after Yang's cleanup of the
> !NUMA case (where we would preallocate a hugepage) we can depend on put_page()
> do take care of that for us.

Makes sense to me.  I can prepare a separate patch to clean it up.

> 
> Regardless, can have my
> 
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>

Thanks!

-- 
Peter Xu

