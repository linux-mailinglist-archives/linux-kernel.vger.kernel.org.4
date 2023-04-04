Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948026D68D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjDDQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjDDQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDF011D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680625719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MTYy0H3bhj8cXxdZNgO3n4Jj7YX7R1xpNobN78N/Po=;
        b=jAr9gpWNPrd/mrFz0+/UU3xUyIpg2+73H/ZKljzfVPcAccpfLvaES72vYVuv1ZtsQbtW41
        IHtJ/fqBDt51pJzrXRQkT4A4go+7t30yzfhYP2VxSnEy/lOpxmmY4qkdrKHanOvbBqUhJj
        SnTS7qSwbo0+sGedMEaikdmh4Fjqj4U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-BbDa2DnzN8GoTACtY0g8sA-1; Tue, 04 Apr 2023 12:28:35 -0400
X-MC-Unique: BbDa2DnzN8GoTACtY0g8sA-1
Received: by mail-qk1-f198.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso15051763qkk.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625715; x=1683217715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MTYy0H3bhj8cXxdZNgO3n4Jj7YX7R1xpNobN78N/Po=;
        b=lHWq7VJIWxRHLaT41VZfwCSdegmXpEmCDUVFKvCr7iDZ60Hb9uy2fc1MVXXKR9YdNz
         qa/1xq9a4T96NtRdNeb/LpAxy3GYjhyK7OLjub+H7fzMW5redv5FvOwxj8Mt4bZBLUm0
         ZhhiLZ0zpS2xcQ6SrPqrB4VUb21ITtvGPAhIzAOYnsiklf3A9x7KixmsoePNqGb+57/W
         FGHqQnOmd5EEwLuMHJ6pgQf+QLnPIXWxx/kMBGwdyE1nBzPN2/jM/IKXFTtjOSwsf3Yg
         DeAO/1AtRa3R2c9LAMofB2fedKVyUAKxpBKpUiFfebivB4CZ55vlqxxcb+e/o6XHTxD5
         7mVw==
X-Gm-Message-State: AAQBX9e9OJ59beyE+0zO6JijqWjn71ZejrSFNp59RWwoRmZGT33JbY6B
        sZcUr7v7HX3YJpDAkbh8COSOei2svIZGmKkUqXc2he84Nt6tPggv55vuRX+1hxiUhJewboRZbaa
        n9eslXM3ly/kRWCNDfOyFVS2fb1yFu8QJRWVeH7r5g5gEn8J+3qvkB9jzEKmwWj8ZjnL3oA4QTA
        I/+QvmFlke
X-Received: by 2002:a05:6214:e42:b0:5a3:fffa:f600 with SMTP id o2-20020a0562140e4200b005a3fffaf600mr4643144qvc.26.1680625715035;
        Tue, 04 Apr 2023 09:28:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yl4PWkJnFX/sblOhO4WDEageQOvt507SZMvRViAiNgF6myvnabeEcN/5+GN7gyUrDylxWaNw==
X-Received: by 2002:a05:6214:e42:b0:5a3:fffa:f600 with SMTP id o2-20020a0562140e4200b005a3fffaf600mr4643108qvc.26.1680625714699;
        Tue, 04 Apr 2023 09:28:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 73-20020a37074c000000b0074672975d5csm3732410qkh.91.2023.04.04.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:28:34 -0700 (PDT)
Date:   Tue, 4 Apr 2023 09:28:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: amd: Set page size bitmap during V2 domain
 allocation
Message-ID: <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
References: <20230404072742.1895252-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404072742.1895252-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:27:42AM -0700, Jerry Snitselaar wrote:
> With the addition of the V2 page table support, the domain page size
> bitmap needs to be set prior to iommu core setting up direct mappings
> for reserved regions. When reserved regions are mapped, if this is not
> done, it will be looking at the V1 page size bitmap when determining
> the page size to use in iommu_pgsize(). When it gets into the actual
> amd mapping code, a check of see if the page size is supported can
> fail, because at that point it is checking it against the V2 page size
> bitmap which only supports 4K, 2M, and 1G.
> 
> Add a check to __iommu_domain_alloc() to not override the
> bitmap if it was already set by the iommu ops domain_alloc() code path.
> 
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>



I'm still not sure this is the best solution. Feels odd with adding a
check to core code to handle something one of the drivers has
done. Another thought was something like arm does, with amd_iommu_ops
dropping the const and setting the default page size bitmap in
iommu_init_pci(), but I think that would still require adding
something in the protection domain/init code to deal with it forcing
v1, so it would still require a check in the core code.

Would adding an op make more sense, with a generic op doing what the
core code currently does for setting the default? Or am I overthinking
this?

snits

> ---
>  drivers/iommu/amd/iommu.c | 6 ++----
>  drivers/iommu/iommu.c     | 9 +++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..167da5b1a5e3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  	domain->dev_iommu[iommu->index] += 1;
>  	domain->dev_cnt                 += 1;
>  
> -	/* Override supported page sizes */
> -	if (domain->flags & PD_GIOV_MASK)
> -		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> -
>  	/* Update device table */
>  	set_dte_entry(iommu, dev_data->devid, domain,
>  		      ats, dev_data->iommu_v2);
> @@ -2048,6 +2044,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->flags |= PD_GIOV_MASK;
>  
> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> +
>  	if (domain_enable_v2(domain, 1)) {
>  		domain_id_free(domain->id);
>  		return -ENOMEM;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..256a38371120 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  		return NULL;
>  
>  	domain->type = type;
> -	/* Assume all sizes by default; the driver may override this later */
> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +	/*
> +	 * If not already set, assume all sizes by default; the driver
> +	 * may override this later
> +	 */
> +	if (!domain->pgsize_bitmap)
> +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +
>  	if (!domain->ops)
>  		domain->ops = bus->iommu_ops->default_domain_ops;
>  
> -- 
> 2.38.1
> 

