Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852B618349
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiKCPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKCPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51165DD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667490617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Kf9rvim63yuVg7xQXPf25qL1fvNeKXI/1pKoooV9l0=;
        b=EXFY43vz/vEWBS02r7l6eTcOTdBAwSKi2r+6CeogwLUbrmycz/RcA0JbLSNpREQxtGRC3U
        rvcm+mdtPZRyDs/vjGFPpxEZUrZ5ZmEOGzVINLXUvq3tij1AlgF4G/aCQLib9uAbCPdDLz
        qn8noheYzMJW42z5HGO4kBWogwFtaxw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-p1Q8BnhWM1uiTtMT09h0qg-1; Thu, 03 Nov 2022 11:50:15 -0400
X-MC-Unique: p1Q8BnhWM1uiTtMT09h0qg-1
Received: by mail-qv1-f71.google.com with SMTP id g12-20020a0cfdcc000000b004ad431ceee0so1544524qvs.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Kf9rvim63yuVg7xQXPf25qL1fvNeKXI/1pKoooV9l0=;
        b=p8ybsm14jAlqjjgXLC4p/gjsRSg3UHpNPLkV5sU7kKwbQhpizkCMFIEfXujkBqkbdc
         RFO91TROJpnQWIah4GanNMkftHpDFSIHgWwHDC2YejprKlLeFbRX7KQZiaD8BvS7mIUE
         epqCycc0wwiBGtPkBD64waPeqp4KRXZMMStrmAaIv5CsKMo/u7dLlRhcZPCJOhCs7hfX
         y825Cte8s6sXWq3xOOw7rgGdHqYEBLD+lSljIUXiSOwA55cbkvW7iLPQysyhfhF5cdJ3
         wQ8S+d1evNorVhuY1Y2KqtjdbJkbfZMti8HahSwLdt8Kj+xVtYtILpzHY1uvUfsossIt
         EVIw==
X-Gm-Message-State: ACrzQf2gwGoRUbTQzm+/pJkCId8BsSzeKeDWWQ0clDRaKiwJAXHF6VoT
        v7w1L/jvD8jsbgV+sFaeLmcpmGuzQ3YaibhlNkrnqlSCx1yGtHjJn1ApBU0UP8u4qLkQjTsXfFK
        HLIDfklm9toiLgKT2SKk84NqG
X-Received: by 2002:a05:6214:238e:b0:4b4:3392:ced6 with SMTP id fw14-20020a056214238e00b004b43392ced6mr26580275qvb.38.1667490608516;
        Thu, 03 Nov 2022 08:50:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4/UckPGDZ8wo2iosYYoH1J3/hz8LOZ3kGO84B6ybEZcp6AooCtTlIRzEq1qK9gh1+opKmHbA==
X-Received: by 2002:a05:6214:238e:b0:4b4:3392:ced6 with SMTP id fw14-20020a056214238e00b004b43392ced6mr26580247qvb.38.1667490608300;
        Thu, 03 Nov 2022 08:50:08 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id f21-20020ac87f15000000b003a5430ee366sm732000qtk.60.2022.11.03.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:50:07 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:50:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 07/10] mm/hugetlb: Make hugetlb_follow_page_mask()
 RCU-safe
Message-ID: <Y2PjLlJaBVWDd2bn@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-8-peterx@redhat.com>
 <CADrL8HUJZMGaWtyVCcXUfmU3neTO4Q6e=3Fi5=osiEVH9jRZ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUJZMGaWtyVCcXUfmU3neTO4Q6e=3Fi5=osiEVH9jRZ=w@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:24:57AM -0700, James Houghton wrote:
> On Sun, Oct 30, 2022 at 2:29 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > RCU makes sure the pte_t* won't go away from under us.  Please refer to the
> > comment above huge_pte_offset() for more information.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 9869c12e6460..85214095fb85 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6229,10 +6229,12 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >         if (WARN_ON_ONCE(flags & FOLL_PIN))
> >                 return NULL;
> >
> > +       /* For huge_pte_offset() */
> > +       rcu_read_lock();
> >  retry:
> >         pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> >         if (!pte)
> > -               return NULL;
> > +               goto out_rcu;
> >
> >         ptl = huge_pte_lock(h, mm, pte);
> 
> Just to make sure -- this huge_pte_lock doesn't count as "blocking"
> (for the purposes of what is allowed in an RCU read-side critical
> section), right? If so, great!

Yeah I think spinlock should be fine, iiuc it'll be fine as long as we
don't proactively yield with any form of sleeping locks.

For RT sleepable spinlock should also be fine in this case, as explicitly
mentioned in the RCU docs:

b.	What about the -rt patchset?  If readers would need to block
	in an non-rt kernel, you need SRCU.  If readers would block
	in a -rt kernel, but not in a non-rt kernel, SRCU is not
	necessary.  (The -rt patchset turns spinlocks into sleeplocks,
	hence this distinction.)

> But I think we need to call `rcu_read_unlock` before entering
> `__migration_entry_wait_huge`, as that function really can block.

Right, let me revisit this after I figure out how to do with the
hugetlb_fault() path first, as you commented in the other patch.

Actually here I really think we should just remove the migration chunk and
return with page==NULL, since I really don't think follow_page_mask should
block at all.. then for !sleep cases (FOLL_NOWAIT) or follow_page we'll
return the NULL upwards early, while for generic GUP (__get_user_pages)
we'll just wait in the upcoming faultin_page().  That's afaict what we do
with non-hugetlb memories too (after the recent removal of FOLL_MIGRATE in
4a0499782a).

-- 
Peter Xu

