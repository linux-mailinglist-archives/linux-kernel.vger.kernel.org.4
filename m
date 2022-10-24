Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898ED60BEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJXXhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJXXhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5E2EA0FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666648632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jS77JQI+Wqma8EkspvaV6jJPvhgOIi/g9VzirTrOEUM=;
        b=S3mbuX4gLmENddLmfDXDA4oQzIVUkMFqBvmweMxC3t2D+U6e9BB8wWOyeQIROQd9+Tf5my
        QfJXpQ6d3xREk9PLNeBdegvlSfIfqNbdRqYDp+Utzx+/vDnjensg1YN8uSwAObbd3XB5uz
        h6P94eH+zTlrK7wn/29RSVTOcQhBBZk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-40_GtGsrNpWBPLOJEWdK9g-1; Mon, 24 Oct 2022 16:33:45 -0400
X-MC-Unique: 40_GtGsrNpWBPLOJEWdK9g-1
Received: by mail-qt1-f199.google.com with SMTP id c11-20020ac87dcb000000b0039cdb815f3bso7741925qte.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS77JQI+Wqma8EkspvaV6jJPvhgOIi/g9VzirTrOEUM=;
        b=grFA2uohqLPOeMpS2ZMYk0GcesjsiLVqHj3ciAn+zQTDRGlpOsRLp4BLs1MbzVGFkP
         VA/vS530hRdr6qsNAIwEPrfjvAoea0u3+tnpG2iqt8vRb81PROjqmrsorkNNBYRNCxgh
         lMplkbp6DOF+zefWchC/JDPPEjaZobaWGVE/jxryIB/m/HnV3NJaic4Tkp4+KnSEfybf
         YjWKAG/t13XMvCUAsbUaUuMb8ENzplCMBZBGk9Geky1Vtqxrys7e/D9ymeWSpSYp7DHz
         DLnYp760TO53HKVh74HGBO1IQTFgCLkCNSPpQ4wMvxb9WTIlJ3cErHUgpbXaBcjz3iai
         VLJw==
X-Gm-Message-State: ACrzQf07iIX8ZsFSQSIlRlLGP+S+nlH20dhFTcZKu6wO9uFq41Ilc5rv
        7WOXFe6Br/N9dRoPyJTPOaRc0XxpH2ZKeyFbiKA+lGoRPQdWKrCOXCc618J59vr8/2ewjjJ/Wpw
        s88IUxuUCqIPdecoKneMHfst6
X-Received: by 2002:a05:620a:4155:b0:6ee:e6b5:efa7 with SMTP id k21-20020a05620a415500b006eee6b5efa7mr24649752qko.54.1666643624566;
        Mon, 24 Oct 2022 13:33:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fuJ7umxduSwho5wT/1DHDzI+eD1fRK9Z2IMS9esLQ5xAyDielh1+K8ovaXy8gI3DuPHXL2w==
X-Received: by 2002:a05:620a:4155:b0:6ee:e6b5:efa7 with SMTP id k21-20020a05620a415500b006eee6b5efa7mr24649730qko.54.1666643624349;
        Mon, 24 Oct 2022 13:33:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm616099qkp.126.2022.10.24.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:33:43 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:33:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove variable cnt
Message-ID: <20221024203342.nbmqphmfbrqqtr4n@cantor>
References: <20221024134301.2158939-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024134301.2158939-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:43:01PM +0100, Colin Ian King wrote:
> Variable cnt is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d3b39d0416fa..3847f3bdc568 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -767,7 +767,7 @@ EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
>  
>  static void iommu_poll_ga_log(struct amd_iommu *iommu)
>  {
> -	u32 head, tail, cnt = 0;
> +	u32 head, tail;
>  
>  	if (iommu->ga_log == NULL)
>  		return;
> @@ -780,7 +780,6 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
>  		u64 log_entry;
>  
>  		raw = (u64 *)(iommu->ga_log + head);
> -		cnt++;
>  
>  		/* Avoid memcpy function-call overhead */
>  		log_entry = *raw;
> -- 
> 2.37.3
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

