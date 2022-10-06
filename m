Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6695F6E38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiJFT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJFT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB31727B4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665084521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wwtCkg9brQ3dbfSvGkTv+uYwYqKS+oibTQyuGU5eVE=;
        b=aSra8tYQSpbdgA4m3WPi118tbzXX1oqYemkOM9AXQDDSbh0O1MC9cFypU56dEzP97Ze8l8
        Ds7aOYiGWycaUGyVWiQDamWmcM94IOCBjKhPrVYSpx0zejfv2PI/sZLz3Rz3j3VmphhVqY
        5R3xb2OFpcXjEYQ4ja2FuO09lQ0H/8c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-46-iMOjbi03PL6H_CbFZqwtTw-1; Thu, 06 Oct 2022 15:28:40 -0400
X-MC-Unique: iMOjbi03PL6H_CbFZqwtTw-1
Received: by mail-qk1-f197.google.com with SMTP id de16-20020a05620a371000b006ceb92bc740so2230018qkb.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wwtCkg9brQ3dbfSvGkTv+uYwYqKS+oibTQyuGU5eVE=;
        b=o6qgq3Vf6e34zDTJuzKQOEjiKGxNq7uhbb4QYhH/eIH0um6bv936eKbmuYvaDrN6cF
         PGhGQuv3RC77n29Y1ZPugfV5k8w3+rEIIV9StiSf0nhIeE7i2d2P/aF2P9QATn5wDKYm
         8ExveD0BPW+Q1SG0muAGCQ7vAaxxRDs9bXpRJd5QQC6K7iXnVsXR5bXnlhJuQfAyOkUU
         6pKX6WdHFWRyZTJU0LR+A1mBVVBvgeKXfdFHgw7QGpPk33QxYEi3eqE/XTCc2cTbaCLY
         o3wa8UgQ3NDuD+le2v/hQTgAjDKny5H8Dg+kCIMFvgxguF+cXGNRW/32POxqWdj0tetW
         aVcQ==
X-Gm-Message-State: ACrzQf0SROVbS988bQaE5GL9N2qOeAMMth6Ju9S1m5Q8niH7kpzXUoV0
        1bEczHSl/wVGtNFiHRHM1tq0vsS9wNLv9GayE37VgdA7YiT/K6V2qQwY25F52CZ1boKlE0/l8bC
        Tvv2zBSNzpka6Z6rtDvnnTE3j
X-Received: by 2002:a05:620a:2989:b0:6ce:1913:83ce with SMTP id r9-20020a05620a298900b006ce191383cemr1404399qkp.49.1665084520145;
        Thu, 06 Oct 2022 12:28:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5O0opIAgOKkQpMkYtzkmV6L2RfyYpkvzkuo1iBKAjxfLrtcmURtP29Z5SsTjxfFNHsMZ/MfQ==
X-Received: by 2002:a05:620a:2989:b0:6ce:1913:83ce with SMTP id r9-20020a05620a298900b006ce191383cemr1404378qkp.49.1665084519888;
        Thu, 06 Oct 2022 12:28:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a0d5200b006ce407b996asm19445857qkl.69.2022.10.06.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:28:39 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:28:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use
 walk_page_range_vma()
Message-ID: <Yz8sZROC7rpPwmgY@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-7-david@redhat.com>
 <Yz3wcDZPFvKBmnet@x1n>
 <9a84440f-1462-2193-7dd6-c84e8bb22232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a84440f-1462-2193-7dd6-c84e8bb22232@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:20:42AM +0200, David Hildenbrand wrote:
> > > +int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
> > > +			struct mm_walk *walk)
> > > +{
> > > +	/* We only care about page tables to walk to a single base page. */
> > > +	if (pud_leaf(*pud) || !pud_present(*pud))
> > > +		return 1;
> > > +	return 0;
> > > +}
> > 
> > Is this needed?  I thought the pgtable walker handlers this already.
> > 
> > [...]
> > 
> 
> Most probably yes. I was trying to avoid about PUD splits, but I guess we
> simply should not care in VMAs that are considered by KSM (MERGABLE). Most
> probably never ever happens.

I was surprised the split is the default approach; didn't really notice
that before. Yeah maybe better to keep it.

> 
> > >   static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
> > >   {
> > > -	struct page *page;
> > >   	vm_fault_t ret = 0;
> > > +	if (WARN_ON_ONCE(!IS_ALIGNED(addr, PAGE_SIZE)))
> > > +		return -EINVAL;
> > > +
> > >   	do {
> > >   		bool ksm_page = false;
> > >   		cond_resched();
> > > -		page = follow_page(vma, addr,
> > > -				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> > > -		if (IS_ERR_OR_NULL(page))
> > > -			break;
> > > -		if (PageKsm(page))
> > > -			ksm_page = true;
> > > -		put_page(page);
> > > +		ret = walk_page_range_vma(vma, addr, addr + PAGE_SIZE,
> > > +					  &break_ksm_ops, &ksm_page);
> > > +		if (WARN_ON_ONCE(ret < 0))
> > > +			return ret;
> > 
> > I'm not sure this would be worth it, especially with a 4% degrade.  The
> > next patch will be able to bring 50- LOC, but this patch does 60+ anyway,
> > based on another new helper just introduced...
> > 
> > I just don't see whether there's strong enough reason to do so to drop
> > FOLL_MIGRATE.  It's different to the previous VM_FAULT_WRITE refactor
> > because of the unshare approach was much of a good reasoning to me.
> > 
> > Perhaps I missed something?
> 
> My main motivation is to remove most of that GUP hackery here, which is
> 1) Getting a reference on a page and waiting for migration to finish
>    even though both is unnecessary.
> 2) As we don't have sufficient control, we added FOLL_MIGRATION hacks to
>    MM core to work around limitations in the GUP-based approacj.

I saw one thing of adding FOLL_MIGRATION from Hugh was to have a hint for
follow page users:

  I'd have preferred to avoid another flag, and do it every time, in case
  someone else makes the same easy mistake..

Though..

> 3) We rely on legacy follow_page() interface that we should really get
>    rid of in the long term.

..this is part of effort to remove follow_page()?  More context will be
helpful in that case.

> 
> All we want to do is walk the page tables and make a decision if something
> we care about is mapped. Instead of leaking these details via hacks into GUP
> code and making that code harder to grasp/maintain, this patch moves that
> logic to the actual user, while reusing generic page walking code.

Indeed there's only one ksm user, at least proving that the flag was not
widely used.

> 
> Yes, we have to extend page walking code, but it's just the natural,
> non-hacky way of doing it.
> 
> Regarding the 4% performance degradation (if I wouldn't have added the
> benchmarks, nobody would know and probably care ;) ), I am not quite sure
> why that is the case. We're just walking page tables after all in both
> cases. Maybe the callback-based implementation of pagewalk code is less
> efficient, but we might be able to improve that implementation if we really
> care about performance here. Maybe removing break_ksm_pud_entry() already
> improves the numbers slightly.

Yeah it could be the walker is just slower.  And for !ksm walking your code
should be faster when hit migration entries, but that should really be rare
anyway.

-- 
Peter Xu

