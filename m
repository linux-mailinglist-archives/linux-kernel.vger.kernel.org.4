Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60E709DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjESRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjESRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D71B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684516323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERQYZtyC8yrGAR4Lpp1idLfOrOHvWlcfV8KyOPQ1tKc=;
        b=JD9MQLnuFy8GxgS30jyYdizkk+m5DOKBUjyx2XzwrUU38MRtMjwH/WSwD5I0ZYlxz3O6EC
        dDiFMvLN8T6dUhBURQkTNSk0F1W8RpuCl8HmhMbD5qeczhRfsNF6qZBSssnhy6ffQ8KaO5
        TuI5txNYXdM5ks8WUMhlXWlgZ+kzxco=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-li6x9b__MqqE4KlTN9rjRQ-1; Fri, 19 May 2023 13:12:01 -0400
X-MC-Unique: li6x9b__MqqE4KlTN9rjRQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7590a9db092so258859985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516321; x=1687108321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERQYZtyC8yrGAR4Lpp1idLfOrOHvWlcfV8KyOPQ1tKc=;
        b=dLKU55Oxly28skC1cM0+tME0kZ2ZdSGMcsC6xUXRA3j7ytDQn66eb9XQToqsKOXXOu
         gfZ2cAynUY5yFuGrmV7veOlNN8XnoeGwLiRfFFWsoiNSR8QqekQN7mBsxO1fsBFtbkD2
         X+ZuH31hjRqjTEPeALaMsN3AneskBbDQLFBUquYTlXPoftmzpZN2vvSuah+8JDh4Bfhx
         MM9nuA0f7/89hwLKVoVZpIp8PEqsCaFwhuTjGvswuzj6ZoZ4S4Pc/9Fbu5RB19lb+IV0
         XUu678K4bcBnLAEVzyfkIBdJopV63ovegRV2gQBI+8mNNEWQV4I9tv4cuNMSYicICtH7
         jz8A==
X-Gm-Message-State: AC+VfDxiNKh3s410nTkWopr97CyZVv05+9ulH3wNJ9n7Yn124QzD19L9
        R7q8vYJn2iURQ+M2/IrpgRc0KVK8FfnKgAx1n2lhJ0nXQSrHa5PER90fUxkokXmdv86SePAIarv
        WJNdatwQZgheILlY4JsjQGnGgbQc0cByy
X-Received: by 2002:a05:622a:1825:b0:3ef:57c1:ad7 with SMTP id t37-20020a05622a182500b003ef57c10ad7mr4366570qtc.30.1684516320764;
        Fri, 19 May 2023 10:12:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7X7UOP6hwcDTnkt/WJyzqcvnBaxy/NW3l8Evf1CMoFj8Fx9tS5A74/hQNR+L1ll2twROxXHA==
X-Received: by 2002:a05:622a:1825:b0:3ef:57c1:ad7 with SMTP id t37-20020a05622a182500b003ef57c10ad7mr4366425qtc.30.1684516319215;
        Fri, 19 May 2023 10:11:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cm26-20020a05622a251a00b003f394decd08sm1421041qtb.62.2023.05.19.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:11:58 -0700 (PDT)
Date:   Fri, 19 May 2023 10:11:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jon Pan-Doh <pandoh@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Gary Zibrat <gzibrat@google.com>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Nadav Amit <namit@vmware.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH RESEND] iommu/amd: Fix domain flush size when syncing
 iotlb
Message-ID: <5vcww4kwofeftpqyfckyacystlw2g3eiwg47liul34yzyibclh@pas4sdd5j5fc>
References: <20230518015054.2223833-1-pandoh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518015054.2223833-1-pandoh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:50:54PM -0700, Jon Pan-Doh wrote:
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
> 
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
> 
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
> 
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Suggested-by: Gary Zibrat <gzibrat@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Acked-by: Nadav Amit <namit@vmware.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..da45b1ab042d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dom->lock, flags);
> -	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
> +	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
>  	amd_iommu_domain_flush_complete(dom);
>  	spin_unlock_irqrestore(&dom->lock, flags);
>  }
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

