Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE970E656
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbjEWUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjEWUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F265213E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684872934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuGsJq81+rG6lnQFp71rynuXDjC9rqreWyLFpkfHXI0=;
        b=UXXcEM5Sg33LZA2lfQo0GpZ+jZYsjvjxOJvT29LRc2bc/PtlLqrv+ARVkqwCkcXCLw/AR9
        J3OpstieiHZswLki9llZ4/CeTc86C9AjxEg3BNjqVJftsXRgnJ6O/j/5FsWMSsGoIHJ+k1
        EcuBzE0Pr8koixmI/bfqI1tto0/vPmA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-qLUasdn9ND28abGQ-AwPvw-1; Tue, 23 May 2023 16:15:30 -0400
X-MC-Unique: qLUasdn9ND28abGQ-AwPvw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3384bfb39b4so515535ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684872930; x=1687464930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuGsJq81+rG6lnQFp71rynuXDjC9rqreWyLFpkfHXI0=;
        b=Sz42M3Kjkrf0LRvtueaRw2S85q0TSgR+OR1H2sxNbOhkaH6JQ9Gf8WCtkgCJR0zGai
         uSDlFBPLmkty3uiIRtHIcfUCBxpNAFrQA82+FvIf8mkbnE6BYbCCvTtgABubngSIwmPf
         JyC96hvBlR7q7om7Y6vmqLh5aHzwAi+YpBARa0mwE2JY9aq5Nk6Lt1tJjIiKtiQjfFog
         ze/AE3fMQt7J37RXEUs20g/+aQLkm9MoGpXcoI6XFPc3xXqlh9wh5/o8DFQVrjtNn6UO
         zE/Ai7UCTDgwGyeTi+tMxCMcMDCmh9f/XmnQv4zjvtHMYye8pmtd6ExRpEkQ3xFlwUju
         mD+A==
X-Gm-Message-State: AC+VfDwjRgdNfdyAv+7TNbdjSwARv9KPfgk6+qslJNjnW+qOHm0EAY/i
        Qkki0iRZdoDtq0PiCNUA1JQlBNth6bc2sDP9O4wH6u4ARgXpVkz2458D+7B6C8MOg+LeL9Vmkq4
        THfDati/o9plOPbf3P44KexLa
X-Received: by 2002:a92:c691:0:b0:32b:c70b:92af with SMTP id o17-20020a92c691000000b0032bc70b92afmr10104051ilg.16.1684872929887;
        Tue, 23 May 2023 13:15:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jnBGKc1//J7T8ZKzI7utit9/2wFXFS8PyN6dZFNhg+b7iIA8IA3ZxtJniFT1wYfrexXH/Dg==
X-Received: by 2002:a92:c691:0:b0:32b:c70b:92af with SMTP id o17-20020a92c691000000b0032bc70b92afmr10104034ilg.16.1684872929599;
        Tue, 23 May 2023 13:15:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h25-20020a056638063900b004166d06f656sm2627536jar.177.2023.05.23.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 13:15:29 -0700 (PDT)
Date:   Tue, 23 May 2023 14:15:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kevin.tian@intel.com>, <jgg@nvidia.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] vfio/type1: check pfn valid before converting to
 struct page
Message-ID: <20230523141527.6186a044.alex.williamson@redhat.com>
In-Reply-To: <ZGxTpo1Zmi54UYFE@yzhao56-desk.sh.intel.com>
References: <20230519065843.10653-1-yan.y.zhao@intel.com>
        <20230522130030.44c6c5c2.alex.williamson@redhat.com>
        <ZGxTpo1Zmi54UYFE@yzhao56-desk.sh.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 13:48:22 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, May 22, 2023 at 01:00:30PM -0600, Alex Williamson wrote:
> > On Fri, 19 May 2023 14:58:43 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > Check physical PFN is valid before converting the PFN to a struct page
> > > pointer to be returned to caller of vfio_pin_pages().
> > > 
> > > vfio_pin_pages() pins user pages with contiguous IOVA.
> > > If the IOVA of a user page to be pinned belongs to vma of vm_flags
> > > VM_PFNMAP, pin_user_pages_remote() will return -EFAULT without returning
> > > struct page address for this PFN. This is because usually this kind of PFN
> > > (e.g. MMIO PFN) has no valid struct page address associated.
> > > Upon this error, vaddr_get_pfns() will obtain the physical PFN directly.
> > > 
> > > While previously vfio_pin_pages() returns to caller PFN arrays directly,
> > > after commit
> > > 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()"),
> > > PFNs will be converted to "struct page *" unconditionally and therefore
> > > the returned "struct page *" array may contain invalid struct page
> > > addresses.
> > > 
> > > Given current in-tree users of vfio_pin_pages() only expect "struct page *
> > > returned, check PFN validity and return -EINVAL to let the caller be
> > > aware of IOVAs to be pinned containing PFN not able to be returned in
> > > "struct page *" array. So that, the caller will not consume the returned
> > > pointer (e.g. test PageReserved()) and avoid error like "supervisor read
> > > access in kernel mode".
> > > 
> > > Fixes: 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()")
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > 
> > > ---
> > > v2: update commit message to explain background/problem clearly. (Sean)
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index 493c31de0edb..0620dbe5cca0 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -860,6 +860,11 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> > >  		if (ret)
> > >  			goto pin_unwind;
> > >  
> > > +		if (!pfn_valid(phys_pfn)) {  
> > 
> > Why wouldn't we use our is_invalid_reserved_pfn() test here?  Doing
> > so would also make it more consistent why we don't need to call
> > put_pfn() or rewind accounting for this page.  Thanks,
> >   
> I actually struggled in choosing is_invalid_reserved_pfn() or
> pfn_valid() when writing this patch.
> 
> Choosing pfn_valid() is because invalid PFN obviously cannot have
> struct page address and it's a bug fix.
> 
> While declining reserved pages will have the IOVA range supported by
> vfio_pin_pages() even more reduced. So I don't know if there's enough
> justification to do so, given that (1) device zone memory usually has
> PG_reserved set. (2) vm_normal_page() also contains reserved page.

Based on the exclusion we have in vaddr_get_pfn() where we unpin
zero-page pfns because they hit on the is_invalid_reserved_pfn() test
and break our accounting otherwise, this does seem like the correct
choice.  I can imagine a scenario where the device wants to do a DMA
read from VM memory backed by the zero page.  Ok.  Thanks,

Alex

