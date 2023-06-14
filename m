Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5416730313
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbjFNPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbjFNPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA11FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686755469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVZChglvS+O5VeulYeKIgpHYT7pfIMFY3lkOqv9HePk=;
        b=d5XYwUNj7W0KXnlU8f1h/xuoLrM4pQ8Rz5Dpb1cLuNPgZicLb+yXypQxrMzmOePybeTm8s
        aAIiRRCZ8o/xtx6DAySS9y4+53CJxpYkNUjkGi4rs8Gcixd5lE7L00QsXJzr4w3iSklB93
        Ebk5nUEtfYO/i6Lq+pVZgJUxLbqMQ4w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-lC4WygcxOgyTtqk-_H4C4A-1; Wed, 14 Jun 2023 11:11:06 -0400
X-MC-Unique: lC4WygcxOgyTtqk-_H4C4A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75eb82ada06so154476885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755466; x=1689347466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVZChglvS+O5VeulYeKIgpHYT7pfIMFY3lkOqv9HePk=;
        b=TezRz1Bo9tqmdlCmCIetsJvD+5iHTD/YHCifOmpQpNL7e80P5EqYUOutX8k20pjuHy
         sB6wdG0/Rk03bjDy3ZPVAJEy6UqlQO+pQ5r1GaLhvMPAKQRYv0Nuxb2fQ2RsoD5nYbDs
         lsaUC/jGP/bAXD9dkPTeQCOPrFrwloSTtBQrfMlw0EmRMb+1giM4u9ALW5UqWTY7GVRV
         cMMHSZuUtCT/+ZMOqOnRNBI5+X2mMvHsbhxxHQVyEjZR9GaWettp0UEv8ffJqXDNSQuH
         feWxSRu4TkneNDQdTqJmnQsNlq9pvN916mzghbwCszuXd6CWFFPcx1C57RdYyBAx1VHQ
         k9zg==
X-Gm-Message-State: AC+VfDycUOYnGJrTOI0ZkFlQSt2EcMCZxjCxgd54HC4qTO/079oDOlW0
        8va9Lk06VJ88zu2shrD2LHeeYCl1/8WVCLv30W7oPyFjNbJX5GPASjQWzc4t5N/ijm7J7p2YoqK
        An4hbg+WdH/8H1zvUXYRDKUz6
X-Received: by 2002:a05:620a:84c5:b0:761:fc4c:b6f6 with SMTP id pq5-20020a05620a84c500b00761fc4cb6f6mr4259153qkn.7.1686755466442;
        Wed, 14 Jun 2023 08:11:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52SBPQPFUhM9K34/k1mW3GgSmlJkXZWl/Xv9ay2wYHAGf/sxrjp6jsOoO0aqMkJmMcXRKYyQ==
X-Received: by 2002:a05:620a:84c5:b0:761:fc4c:b6f6 with SMTP id pq5-20020a05620a84c500b00761fc4cb6f6mr4259129qkn.7.1686755466190;
        Wed, 14 Jun 2023 08:11:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o23-20020a05620a15d700b0075cdad9648dsm4370929qkm.25.2023.06.14.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:11:05 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:11:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Message-ID: <ZInYh3cVUil9R/cf@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:57:37PM +0200, David Hildenbrand wrote:
> On 13.06.23 23:53, Peter Xu wrote:
> > It's coming, not yet, but soon.  Loose the restriction.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/hugetlb.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f037eaf9d819..31d8f18bc2e4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	spinlock_t *ptl;
> >   	pte_t *pte, entry;
> > -	/*
> > -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> > -	 * follow_hugetlb_page().
> > -	 */
> > -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> > -		return NULL;
> > -
> >   	hugetlb_vma_lock_read(vma);
> >   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
> >   	if (!pte)
> Did you fix why the warning was placed there in the first place? (IIRC, at
> least unsharing support needs to be added, maybe more)

Feel free to have a look at patch 2 - it should be done there, hopefully in
the right way.  And IIUC it could be a bug to not do that before (besides
CoR there was also the pgtable permission checks that was missing).  More
details in patch 2's commit message.  Thanks,

-- 
Peter Xu

