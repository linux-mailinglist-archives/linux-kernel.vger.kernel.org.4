Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9470E7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbjEWVpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbjEWVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB412B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nvxqud0FjTLjvGDJMG3+cwcxjpMw4N6HqudGh9PriUk=;
        b=ZcwTft4TtSS0whDf+ICip3ag6eVcNuE+3796maqH4ASJf5AOCe2hxg0wB6lbgC3zX9+VM0
        /WOoXg7LVD33VyZmaAcLdPxEifPleg9rhzVoxZLPTzCCJj81FEv8pKiTie8fB52eDn/c+d
        60L0FcfW6UuMKyGb85Pj7uOOnpMBVXM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3aKQDNpFOQ2XL471kENhXQ-1; Tue, 23 May 2023 17:44:47 -0400
X-MC-Unique: 3aKQDNpFOQ2XL471kENhXQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c27782e30so17699139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878286; x=1687470286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvxqud0FjTLjvGDJMG3+cwcxjpMw4N6HqudGh9PriUk=;
        b=YDKHI1Ndmg+T3Crvv5cY0qU0ljjyAZ1YKUjg4C4Q1CjP7KC+lrPLhygKv8WQdpre6X
         n6eXqLMijTm5y9+SVlkOPZC1GbtdPXjDTpFBZNq6dLD8VFAcHJZmu16b2JYKycYkPPR1
         pKu559cgIP1T8QbrPPRFOdrIABcqwFcwpvciDzY6hVfHRzLGMDjPm9DD92YZetcov2d7
         sWepbP4pmdp94QDL5lOAQUJVcQEealzXfORhze+cBGLigbWJwhok6xLL0nIkWM8JeZRV
         Ep6RyfnklrKjMcQDoJWRxLNA5YB28H3xeRNdnVszZ24PUNm4NR/QrLmfXE0FIzi6QHC5
         aB3Q==
X-Gm-Message-State: AC+VfDwIOui4ZgZnjdDU134nquopqNWidZR6zzFpacB2tnq+nRHEQ3Qg
        lFAArhtpRp3vU/m3dgVbt3ySFioJX3XDS2lltVT86muwUthDjMNVKv7MO+i2vLd+zK2ZhVvq2bv
        Mtb973nZqgwK40b6XjJpk9LG1
X-Received: by 2002:a6b:491a:0:b0:76e:748b:e49a with SMTP id u26-20020a6b491a000000b0076e748be49amr9777781iob.5.1684878286600;
        Tue, 23 May 2023 14:44:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rDseY1faRRc/pd/upGZpjVZYmrCO9bGux2IbtdYoLRepumcSspUjcz+tMtMzAp8YndrDfWA==
X-Received: by 2002:a6b:491a:0:b0:76e:748b:e49a with SMTP id u26-20020a6b491a000000b0076e748be49amr9777775iob.5.1684878286345;
        Tue, 23 May 2023 14:44:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o22-20020a02a1d6000000b0041650ca49casm2767353jah.83.2023.05.23.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:44:45 -0700 (PDT)
Date:   Tue, 23 May 2023 15:44:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevin.tian@intel.com, jgg@nvidia.com,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] vfio/type1: check pfn valid before converting to
 struct page
Message-ID: <20230523154444.46d84950.alex.williamson@redhat.com>
In-Reply-To: <20230519065843.10653-1-yan.y.zhao@intel.com>
References: <20230519065843.10653-1-yan.y.zhao@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 14:58:43 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> Check physical PFN is valid before converting the PFN to a struct page
> pointer to be returned to caller of vfio_pin_pages().
> 
> vfio_pin_pages() pins user pages with contiguous IOVA.
> If the IOVA of a user page to be pinned belongs to vma of vm_flags
> VM_PFNMAP, pin_user_pages_remote() will return -EFAULT without returning
> struct page address for this PFN. This is because usually this kind of PFN
> (e.g. MMIO PFN) has no valid struct page address associated.
> Upon this error, vaddr_get_pfns() will obtain the physical PFN directly.
> 
> While previously vfio_pin_pages() returns to caller PFN arrays directly,
> after commit
> 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()"),
> PFNs will be converted to "struct page *" unconditionally and therefore
> the returned "struct page *" array may contain invalid struct page
> addresses.
> 
> Given current in-tree users of vfio_pin_pages() only expect "struct page *
> returned, check PFN validity and return -EINVAL to let the caller be
> aware of IOVAs to be pinned containing PFN not able to be returned in
> "struct page *" array. So that, the caller will not consume the returned
> pointer (e.g. test PageReserved()) and avoid error like "supervisor read
> access in kernel mode".
> 
> Fixes: 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()")
> Cc: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> 
> ---
> v2: update commit message to explain background/problem clearly. (Sean)
> ---
>  drivers/vfio/vfio_iommu_type1.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 493c31de0edb..0620dbe5cca0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -860,6 +860,11 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  		if (ret)
>  			goto pin_unwind;
>  
> +		if (!pfn_valid(phys_pfn)) {
> +			ret = -EINVAL;
> +			goto pin_unwind;
> +		}
> +
>  		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
>  		if (ret) {
>  			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
> 
> base-commit: b3c98052d46948a8d65d2778c7f306ff38366aac

Applied to vfio for-linus branch for v6.4.  Thanks!

Alex

