Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD965C54C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjACRpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjACRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:44:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE66E19
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672767823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jO6Zl402uF1R5RJR+aDfFIjsGFP/yqalvVW+NL65RNM=;
        b=A09Foso3tZUCqMiNJZcMvg6dYytvjYOxsUthAoTAdI0r5uCJbJX9X1X6BMllHg7/WLh1R6
        Iwpnc/SLNOW6gdqWsGLaHapoVwJiYHPgWBZywnYd8XROKOMeJl8lrXydigiTKWFQ4wzHYj
        Ru3aAVsMN4hoac1XFhV691LUpYCk21o=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-ePpLUsuUNUacPkRNaBXBBQ-1; Tue, 03 Jan 2023 12:43:41 -0500
X-MC-Unique: ePpLUsuUNUacPkRNaBXBBQ-1
Received: by mail-io1-f72.google.com with SMTP id h26-20020a5e841a000000b006e408c1d2a1so8600710ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO6Zl402uF1R5RJR+aDfFIjsGFP/yqalvVW+NL65RNM=;
        b=4Xa0LxoWrl0o3zSgkePDN6dALW6bm7a1Oj75NLu7quIgDQuxgEQcxa+nAS1Sqz3NeL
         nJZlM0nK3Z+wYedrjGp7uSgMPgQlnnUinubxaFK44+A1fTHxsHYCiQ5hu1256mF5E1hk
         CF8In1A8Yw8nHgYFjYIq3iketvd56arokc6aMPo7J5QiBaSLGqSxmDa7/ESqwb7aCbsA
         9XW2QHP2RNCeRreu4UPD4hEerOKJTzDbmXIxJEnsku/OrNG1LGUIJ9+/YYJa96FvkYLr
         X6ZRvhTvRyw2Ma0liW3GpsysPFPdsu/49vZgVgofX9Ibp/p7hojMkcg0LDUOpZQCw+Eb
         5FWA==
X-Gm-Message-State: AFqh2kpLxLCyO7bBRSI9VEDENyoiiPp28+ynfA2pNmYq+pjog6ZcUfOi
        KWfTVAiKwefoTs5Y2vqCO6BFhJgBi6zvtjNV3dTMqYe8++1as6fp04Xt69IMz4i3EbRVaRnpHnX
        kESKVTrWxXRNmf8OWqIaqxsCB
X-Received: by 2002:a6b:6310:0:b0:6d6:4daf:623f with SMTP id p16-20020a6b6310000000b006d64daf623fmr27685233iog.6.1672767821068;
        Tue, 03 Jan 2023 09:43:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXum1NkGfbp5wP/yTi/4H0MnD8Iv6ksddlNLbXCBrWU4pLdAWOiz5nI4pkUUR+nGBnIUSJw+7A==
X-Received: by 2002:a6b:6310:0:b0:6d6:4daf:623f with SMTP id p16-20020a6b6310000000b006d64daf623fmr27685220iog.6.1672767820803;
        Tue, 03 Jan 2023 09:43:40 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r6-20020a02aa06000000b00389b6c71347sm10422648jam.60.2023.01.03.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:43:40 -0800 (PST)
Date:   Tue, 3 Jan 2023 10:43:38 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shachar Raindel <shacharr@google.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert backwards goto into a while loop
Message-ID: <20230103104338.4371e012.alex.williamson@redhat.com>
In-Reply-To: <20221228213212.628636-1-shacharr@google.com>
References: <20221228213212.628636-1-shacharr@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 21:32:12 +0000
Shachar Raindel <shacharr@google.com> wrote:

> The function vaddr_get_pfns used a goto retry structure to implement
> retrying.  This is discouraged by the coding style guide (which is
> only recommending goto for handling function exits). Convert the code
> to a while loop, making it explicit that the follow block only runs
> when the pin attempt failed.

What coding style guide are you referring to?  In
Documentation/process/coding-style.rst I only see goto mentioned in 7)
Centralized exiting of functions, which suggests it's a useful
mechanism for creating centralized cleanup code, while noting "[a]lbeit
deprecated by *some people*", emphasis added.  This doesn't suggest to
me such a strong statement as implied in this commit log.
 
> Signed-off-by: Shachar Raindel <shacharr@google.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index 23c24fe98c00..7f38d7fc3f62
> 100644 --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -570,27 +570,28 @@ static int vaddr_get_pfns(struct mm_struct *mm,
> unsigned long vaddr, }
>  
>  		*pfn = page_to_pfn(pages[0]);
> -		goto done;
> -	}
> +	} else

Coding style would however discourage skipping the braces around this
half of the branch, as done here, as a) they're used around the former
half and b) the below is not a single simple statement.  Thanks,

Alex

> +		do {
> +
> +			/* This is not a normal page, lookup PFN for P2P DMA */
> +			vaddr = untagged_addr(vaddr);
>  
> -	vaddr = untagged_addr(vaddr);
> +			vma = vma_lookup(mm, vaddr);
>  
> -retry:
> -	vma = vma_lookup(mm, vaddr);
> +			if (!vma || !(vma->vm_flags & VM_PFNMAP))
> +				break;
>  
> -	if (vma && vma->vm_flags & VM_PFNMAP) {
> -		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> -		if (ret == -EAGAIN)
> -			goto retry;
> +			ret = follow_fault_pfn(vma, mm, vaddr, pfn,
> +					       prot & IOMMU_WRITE);
> +			if (ret)
> +				continue; /* Retry for EAGAIN, otherwise bail */
>  
> -		if (!ret) {
>  			if (is_invalid_reserved_pfn(*pfn))
>  				ret = 1;
>  			else
>  				ret = -EFAULT;
> -		}
> -	}
> -done:
> +		} while (ret == -EAGAIN);
> +
>  	mmap_read_unlock(mm);
>  	return ret;
>  }

