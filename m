Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BF70C5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjEVTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjEVTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB07DB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684782035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEdSZfvbZO+EhCCmXRIUmzTZEn//g4Gjj2xDSD4w9qo=;
        b=G09VcZ7/argKED23E3Io4MJUhWiX8vk3EB1tlgk1CsT0aDUlgYXVYAoi3IRYsz68fG7uU+
        o4i4MKKPI6Cc4iqmC3AazNJAVaLzcdlQXg2nzW/UYJYQI1H+az8j5dQzjeIUkLSxcWmM8/
        DlKtlRLR0kZnoNUY2T6oZd6tvqLdd+s=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-W949FHKUOymPEmttl6BYqQ-1; Mon, 22 May 2023 15:00:33 -0400
X-MC-Unique: W949FHKUOymPEmttl6BYqQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33868d4a686so36750205ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782032; x=1687374032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEdSZfvbZO+EhCCmXRIUmzTZEn//g4Gjj2xDSD4w9qo=;
        b=KL6UK98CDiMlTE4cUpTf3vfCVMzME31fNNTlqvxKYRs3aXf1VPaJgSLekDrZCxisyR
         4IxrbAWHDOcLypiAsh5cLGDHY60TAk4mJITORFMhYQNQwvJeG7Jv1tfBmDUEY+7xVjzv
         4ZRbVs4SzHiF4ZNXnhM8wSbh4vRKG5T6m9bYE9UF4duPthcFPJVQ8NJm1n+2kOmS70Xj
         NNC9+WEwrgIi1hqHs2oby2bMs4F8Xjw2mMCFnnJ379isLHZQKZgRQRrlAPPBBlq2oPGD
         hYNFhv8l1aWujYpGRdG1WpKzEpWxi15pdBqxiMzXlBNnfXB1FmD0O5zDjJm8ugooaya7
         F6ag==
X-Gm-Message-State: AC+VfDxrC00cqaNReJYjFCJtecuEyIsA8FTpg7mCcIlJPB+ebBu7VP51
        pYCEkivKf77+VbIDVy6bybPZKxwxwayCOuQojhGTtZTEPUYmqPXBJRoG8n75U4J0aPpzfY0doFI
        wuw2l981J9aBob8fkKwFw0GSgx7h7hLw1
X-Received: by 2002:a92:c70e:0:b0:335:38b:e734 with SMTP id a14-20020a92c70e000000b00335038be734mr6587202ilp.28.1684782032347;
        Mon, 22 May 2023 12:00:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YQ+ECS6de+PurjamzC27suSNV0n/CZhf01g4wobY35E8M9AaSfoteJFN3ptWeCzMGLKW7/A==
X-Received: by 2002:a92:c70e:0:b0:335:38b:e734 with SMTP id a14-20020a92c70e000000b00335038be734mr6587179ilp.28.1684782032004;
        Mon, 22 May 2023 12:00:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id do16-20020a0566384c9000b0041abd81975bsm1882825jab.153.2023.05.22.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:00:31 -0700 (PDT)
Date:   Mon, 22 May 2023 13:00:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevin.tian@intel.com, jgg@nvidia.com,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] vfio/type1: check pfn valid before converting to
 struct page
Message-ID: <20230522130030.44c6c5c2.alex.williamson@redhat.com>
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

Why wouldn't we use our is_invalid_reserved_pfn() test here?  Doing
so would also make it more consistent why we don't need to call
put_pfn() or rewind accounting for this page.  Thanks,

Alex

> +			ret = -EINVAL;
> +			goto pin_unwind;
> +		}
> +
>  		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
>  		if (ret) {
>  			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
> 
> base-commit: b3c98052d46948a8d65d2778c7f306ff38366aac

