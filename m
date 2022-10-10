Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AC5FA041
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJJOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CF5F980
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665412393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0fRFJAdAFUAuGAQ/I0Ni1IMy6KgVcr8obOryEi1qB8=;
        b=iYF8WOU6MBO7PaQ1Ed7C3NmgEYcWV6t98hZTo/GhlqLKwx4eMs4BfSTkHXU9cHMwC/9ApG
        lEwC9btdVDKPLIfEYvfQDA2Q7BH+2fGe6BHnufXWFC4lgLlvqMbl8SF2TTqjM7NyeTkE8M
        b6mKu7CTsu76vBSG9j8sPcVxbffm0Q8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-bXusrwQ7Nk-CHwu_DpZ-NQ-1; Mon, 10 Oct 2022 10:33:12 -0400
X-MC-Unique: bXusrwQ7Nk-CHwu_DpZ-NQ-1
Received: by mail-oi1-f200.google.com with SMTP id m11-20020aca1e0b000000b00350c1f42f26so6261991oic.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0fRFJAdAFUAuGAQ/I0Ni1IMy6KgVcr8obOryEi1qB8=;
        b=CyKPYSiUWobqMLLE5oW9c0sVEP08TRXRew1KXpQ2W33VUPFFdEAmxdMgfGQq3u3mQV
         wq57pqNH6NXWPF6B1KGFF3NaRFapzDN6sRbrOrtKNKsK7Vt0lWodrxgzK9HiSWJul9OY
         UT1NT6XAtvejnAzxrZepAFI/PT7fUo+6UtVoo2FYQF+5POwwbfbT+1sFZ6U5eXlONXBX
         e7gVdL09EtQi8QDLVX7AM+d34YVpB31/GO9SFHVpO05lZtjjzqK5uiphPmeIU8eLL2A7
         vWAWVBDdkqO55//3JuB8e4SSsejni/JxDuk/f4Cle1Y5vfA9G86aJJNEfv+FPt8PkI7s
         4nZQ==
X-Gm-Message-State: ACrzQf3MiW299VZHgEdEVznYPmgt7AhuE+FYA45atuP/JcsxapbnVP7T
        Qa9yQKReMNCm3cPI58NbARwUWHhCx+KtxTP0P4lWchpqyJUl3AIj9drvIZvLEEq553gDufM7wkM
        Vi2zXOk3KwdtMcZC5M3rvpuHd
X-Received: by 2002:a05:6830:33e1:b0:655:e771:f572 with SMTP id i1-20020a05683033e100b00655e771f572mr8444998otu.245.1665412391362;
        Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54DQDpetaOotRbUE06O9r7QYXvmMkojLsw/9Q3/76RQLMTAjat7qte6rDhtkVbQ1+y03CLxg==
X-Received: by 2002:a05:6830:33e1:b0:655:e771:f572 with SMTP id i1-20020a05683033e100b00655e771f572mr8444979otu.245.1665412391133;
        Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z6-20020aca6706000000b00353fe4fb4casm4324793oix.48.2022.10.10.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:33:10 -0700 (PDT)
Date:   Mon, 10 Oct 2022 07:33:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: Clean up si_domain in the init_dmars() error
 path
Message-ID: <20221010143309.ed5pnkw2stjb26sc@cantor>
References: <20221010065608.281860-1-jsnitsel@redhat.com>
 <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:32:43PM +0800, Baolu Lu wrote:
> On 2022/10/10 14:56, Jerry Snitselaar wrote:
> > A splat from kmem_cache_destroy() was seen with a kernel prior to
> > commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> > when there was a failure in init_dmars(), because the iommu_domain
> > cache still had objects. While the mempool code is now gone, there
> > still is a leak of the si_domain memory if init_dmars() fails. So
> > clean up si_domain in the init_dmars() error path.
> > 
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 31bc50e538a3..8f1f80a4d0c5 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3042,6 +3042,8 @@ static int __init init_dmars(void)
> >   		disable_dmar_iommu(iommu);
> >   		free_dmar_iommu(iommu);
> >   	}
> > +	if (si_domain)
> > +		domain_exit(si_domain);
> 
> Thank you for the patch.
> 
> Above requires si_domain to be NULL or a valid pointer. So do you also
> need to add the following change?
> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2410,6 +2410,7 @@ static int __init si_domain_init(int hw)
> 
>         if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>                 domain_exit(si_domain);
> +               si_domain = NULL;
>                 return -EFAULT;
>         }
> 
> Best regards,
> baolu

Hi Baolu,

Yes. I think should add it after the domain_exit() call I added as well.

Regards,
Jerry

