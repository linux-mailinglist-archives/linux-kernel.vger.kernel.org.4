Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F0646436
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLGWoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1A83273
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670452989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWjwloNvUEkkIL4IH5jVpeAOiD4Eko/MVERp2bOyZdg=;
        b=VU9nXVshkihD69icg6t4I579efh3XhiMmCs5E0rWnicRDGWrFYCBKya4bvaDpDvdI3rq9D
        QMVDlRfRNhPrcNzqBlYiHq+xgAoZQW+LdGPW564pj8/2f2XuMcWedwH7IJlCd3zdVLvSON
        It49mLuJlJW2JyHq2o/5gD9AzNtdFuY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-o0BlPDJsOI-jwkL_O6vGpQ-1; Wed, 07 Dec 2022 17:43:08 -0500
X-MC-Unique: o0BlPDJsOI-jwkL_O6vGpQ-1
Received: by mail-qk1-f199.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so25975630qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWjwloNvUEkkIL4IH5jVpeAOiD4Eko/MVERp2bOyZdg=;
        b=pj9XBmos382v0sJ/UTkOVVO5l54av+1+eK0iB3cmLUJzBJPcD/Td4ClMFAnPvcXr6X
         O15Y8u3XF05yOQMfU8fSCO3jfuchGLEmkzW9IJ0VpxAeUJ+viS82989qR3qHEUvsoYv0
         HkVTeN5I6XY+u8tGtVvKxQ7jK+e7EMS1CBODTB5IiIwg07ycTLVKk2Noyc699qoMdpgd
         9LuhzApuLHbN3LyGYxAOiksdgrSxfcWwOSdVixoH6CyNR9CbnsHR9Sr+wqquKv8BcueA
         4Q5M+b7G7V0AKdUmf+y4Br5P56SDeME/DKhA37t4fVmJjDcH90ednhHmDKG2/bGdkUe5
         BdVQ==
X-Gm-Message-State: ANoB5plXRL4WPZBMd7ZbVrY0Z1Mi6x6Xpp5QLc5QmS4g2I98msqmBlKt
        rsjFagbcKmGDDCAz5IueDyNe9KC50CqJXBUMzLqeofi2zndTAt4nyyI/hfAM0CwfigwHgeFU4/y
        FaMk/52LFFttdGeUjsRvdbGk1
X-Received: by 2002:ac8:6b16:0:b0:3a5:c7d9:15f9 with SMTP id w22-20020ac86b16000000b003a5c7d915f9mr1480100qts.49.1670452987686;
        Wed, 07 Dec 2022 14:43:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+IvWHCzpkzEmIQzaT31AjgoZDyI4bcsd2RFr41CcZw0um/Oq2E2tah8eU0le0YiwGZcXHbg==
X-Received: by 2002:ac8:6b16:0:b0:3a5:c7d9:15f9 with SMTP id w22-20020ac86b16000000b003a5c7d915f9mr1480084qts.49.1670452987444;
        Wed, 07 Dec 2022 14:43:07 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l27-20020ac84cdb000000b00399fe4aac3esm13722291qtv.50.2022.12.07.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:43:06 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:43:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma
 lock when faulted
Message-ID: <Y5EW+RTuGuGhfdNk@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-5-peterx@redhat.com>
 <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John,

Firstly, thanks for taking a look at the whole set.

On Wed, Dec 07, 2022 at 02:36:21PM -0800, John Hubbard wrote:
> > @@ -5886,8 +5866,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >   	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
> >   	 * properly handle it.
> >   	 */
> > -	if (!pte_present(entry))
> > +	if (!pte_present(entry)) {
> > +		if (unlikely(is_hugetlb_entry_migration(entry))) {
> > +			/*
> > +			 * Release fault lock first because the vma lock is
> > +			 * needed to guard the huge_pte_lockptr() later in
> > +			 * migration_entry_wait_huge().  The vma lock will
> > +			 * be released there.
> > +			 */
> > +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +			migration_entry_wait_huge(vma, ptep);
> > +			return 0;
> 
> Oh, but now (and also one other, pre-existing case, above)
> hugetlb_fault() is returning with the vma lock held.

Note that here migration_entry_wait_huge() will release it.

Sorry it's definitely not as straightforward, but this is also something I
didn't come up with a better solution, because we need the vma lock to
protect the spinlock, which is used in deep code path of the migration
code.

That's also why I added a rich comment above, and there's "The vma lock
will be released there" which is just for that.

> This is in contrast
> with most of the rest of the function, which takes great care to release
> locks before returning.
> 
> Which makes this new case really quite irregular and makes the overall
> locking harder to follow. It would be ideal to avoid doing this! But at
> the very least, there should be a little note above hugetlb_fault(),
> explaining this deviation and how it fits in with the locking rules.
> 
> Do we really have to structure it this way, though?

-- 
Peter Xu

