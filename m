Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9B6FB910
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEHU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA1210B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683579441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PF08ivr9oSEP89wN8+cQKlEYL8DT1MNWzBoIvN2S2Vw=;
        b=JVvPnwS1ujUdY0iuzTgEh9R+HeZlAN0Vg0j+jYVcWsPO/P33rfcbOKJxnrXZWpWK8H9Iz6
        LVsmX1h2RP/vaamWOt6kS+UHR60KLRv3P+pQ7ldBwLtCcX7uja6JMB1Ps8nyUt5GI7dchJ
        N3OtL3HURQZrnt2Z3VCpBw4QlLKVs88=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-cop6NB-9NLGhJozsMQk97Q-1; Mon, 08 May 2023 16:57:18 -0400
X-MC-Unique: cop6NB-9NLGhJozsMQk97Q-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763646b324aso747876239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579437; x=1686171437;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF08ivr9oSEP89wN8+cQKlEYL8DT1MNWzBoIvN2S2Vw=;
        b=hPtFhgUEX3Q9efEc1oXN8x3+k6F40DQ2NsCSau1sZ9T+/UlE9ORe1KsUwXsYH5R+UB
         fAteaRF6zW3Lt8ICnWR/baKW2mkY/vVZxSYpRpIQ4iH6ineiD2Wof/ulMx38feDbTGaC
         CiRUWPmfIwz2cD5iK6vnjz9uKUOBmsRGBdfgYsi7fm1a8W9VbEHYDXGFiFj8qdMfSclP
         DBHJAY2451BzIoIoYis9DZSiQsQAs3xjaq5mVECLzIJncUhNx9+vtFqA74glAsXhWgwL
         X+WdZjo8dg53NdJUSxIbaOVs/oBU8RzvH7xb8x8vfzEJu0ynNIXsmtyG/hYXcCCc2K8j
         iCrQ==
X-Gm-Message-State: AC+VfDwLfWLPcerEWAjAj84vt1fiJmRkfmFKplTgBPeAwLyNQaH1kDFQ
        +rmlmzdgHJKIGITJFWvyh+z6I9PKY5agUwuPa2/52dzB5kUkKVuLLDzCgBDrj7oXx21JOi7rs5L
        XLwyWk/kFdFRzzqM8k2PK1H/W
X-Received: by 2002:a5e:8d13:0:b0:760:d6d2:fa61 with SMTP id m19-20020a5e8d13000000b00760d6d2fa61mr8286933ioj.7.1683579437206;
        Mon, 08 May 2023 13:57:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YrMvnzexkIVya3O7RAWT/SHW6i9D8O1Nxy6GIXjeV8l8JY5b9qa8AlPCuaTDeX/E2NibREw==
X-Received: by 2002:a5e:8d13:0:b0:760:d6d2:fa61 with SMTP id m19-20020a5e8d13000000b00760d6d2fa61mr8286926ioj.7.1683579436982;
        Mon, 08 May 2023 13:57:16 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cc6-20020a056602424600b0076c3189a8d9sm1890274iob.38.2023.05.08.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:57:16 -0700 (PDT)
Date:   Mon, 8 May 2023 14:57:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kevin.tian@intel.com,
        yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Message-ID: <20230508145715.630fe3ae.alex.williamson@redhat.com>
In-Reply-To: <ZFkn3q45RUJXMS+P@nvidia.com>
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
        <ZFkn3q45RUJXMS+P@nvidia.com>
Organization: Red Hat
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

On Mon, 8 May 2023 13:48:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 08, 2023 at 08:58:42PM +0800, Yan Zhao wrote:
> > In VFIO type1, vaddr_get_pfns() will try fault in MMIO PFNs after
> > pin_user_pages_remote() returns -EFAULT.
> > 
> > follow_fault_pfn
> >  fixup_user_fault
> >   handle_mm_fault
> >    handle_mm_fault
> >     do_fault
> >      do_shared_fault
> >       do_fault
> >        __do_fault
> >         vfio_pci_mmap_fault
> >          io_remap_pfn_range
> >           remap_pfn_range
> >            track_pfn_remap
> >             vm_flags_set         ==> mmap_assert_write_locked(vma->vm_mm)
> >            remap_pfn_range_notrack
> >             vm_flags_set         ==> mmap_assert_write_locked(vma->vm_mm)
> > 
> > As io_remap_pfn_range() will call vm_flags_set() to update vm_flags [1],
> > holding of mmap write lock is required.
> > So, update vfio_pci_mmap_fault() to drop mmap read lock and take mmap
> > write lock.
> > 
> > [1] https://lkml.kernel.org/r/20230126193752.297968-3-surenb@google.com
> > commit bc292ab00f6c ("mm: introduce vma->vm_flags wrapper functions")
> > commit 1c71222e5f23
> > ("mm: replace vma->vm_flags direct modifications with modifier calls")
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index a5ab416cf476..5082f89152b3 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1687,6 +1687,12 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> >  	struct vfio_pci_mmap_vma *mmap_vma;
> >  	vm_fault_t ret = VM_FAULT_NOPAGE;
> >  
> > +	mmap_assert_locked(vma->vm_mm);
> > +	mmap_read_unlock(vma->vm_mm);
> > +
> > +	if (mmap_write_lock_killable(vma->vm_mm))
> > +		return VM_FAULT_RETRY;  
> 
> Certainly not..
> 
> I'm not sure how to resolve this properly, set the flags in advance?
> 
> The address space conversion?

We already try to set the flags in advance, but there are some
architectural flags like VM_PAT that make that tricky.  Cedric has been
looking at inserting individual pages with vmf_insert_pfn(), but that
incurs a lot more faults and therefore latency vs remapping the entire
vma on fault.  I'm not convinced that we shouldn't just attempt to
remove the fault handler entirely, but I haven't tried it yet to know
what gotchas are down that path.  Thanks,

Alex

