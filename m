Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3C6C4F31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCVPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCVPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:16:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A462DA7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:16:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t9so22985791qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679498196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HBQCTOq+QqVNkJZ+4QIpkhFmpEgZaWVINrTQNwuq8s=;
        b=jtA9AxTTQYLWB7g+hH3bMTXf6/+n7o0yqNShap1Y/5kaqMz+ZsQnoWfMK1YEkR6vDv
         uMbSfqrKL63R8h/d8AAZZxfhib1Yl8fU/pUs0IRRH/JLWeU8RlOS9nlRbvSWA9kYGUip
         4yJwpCY5y7QdCfczUsHb4aoiMShjYNLlqTJhvKfdjKrkbGAf+Ta21paUjWRmky2YCMrn
         N3M3oBmgh14x5VM9Z6JOP1a/w38eI60Cx3MmdhFC2PPDKJBJ6mFobV8yTrRjb4CZg6gU
         HVcsrp6lVMLs1xFPb0KY92STzTZ/CNk7B2shU5ztbNJAK9qBev/T+OqBSPBW+eg5XXr5
         aUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679498196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HBQCTOq+QqVNkJZ+4QIpkhFmpEgZaWVINrTQNwuq8s=;
        b=SJ0Yc5zeVt7+DCdok0Bi/oq56p679ytQsH6zkFPvax1nofIslhjsUfpz6cFG98xS5w
         hb8JQH2luP1ASvrLz+jhlsPbCc0OjvPeju72KKQ/Dh8dsJouCckIMkhCgwL1yt13XI66
         LlrLCJzPYJNHhXmCqbqjU+F2YQx7rosngYEH4vt0TO0XDMxbeRPKvE+2Tq5tve5+bdtX
         xVZoT88MGrPd3KvvHYbAOjIHBOF2mP8+ji/PpHfnwdp1+K+gszlSMryi3WVJ6QJ7Uk3k
         kLKsFdSW8rVTxnrmWW+kBkJvMsocaEax1Ygqe2XkXS4slvnCxdVVyrwWhD0sTLQv9NGm
         Waqw==
X-Gm-Message-State: AO0yUKVe8SUi7ghjtPUa2OHjuWKsH0TYOR1N2aYpuZ6RajrapMrlO9Ns
        MeYGNhIOnH5QPEDncVvJA4lUcQ==
X-Google-Smtp-Source: AK7set+HNhejSvnBIYwhuwgNNsDv6NGN+2OSNq9lmKgrCuFnU40+7H4+Cr6NnogIE+bN3TKzqj+3nA==
X-Received: by 2002:a05:622a:cf:b0:3e3:7dff:663e with SMTP id p15-20020a05622a00cf00b003e37dff663emr4344627qtw.27.1679498196355;
        Wed, 22 Mar 2023 08:16:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t21-20020a37aa15000000b00746b7372d62sm459437qke.27.2023.03.22.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:16:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pf0CZ-000oxC-3N;
        Wed, 22 Mar 2023 12:16:35 -0300
Date:   Wed, 22 Mar 2023 12:16:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBsb01emBJJMZIt0@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca>
 <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:08:41PM +0000, Steven Price wrote:
> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  	if (iommu->domain == domain)
>  		return 0;
>  
> -	if (iommu->domain)
> -		rk_iommu_detach_device(iommu->domain, dev);
> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
> +	if (ret)
> +		return ret;

>  
>  	iommu->domain = domain;
>  
> @@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  		return 0;
>  
>  	ret = rk_iommu_enable(iommu);
> -	if (ret)
> -		rk_iommu_detach_device(iommu->domain, dev);

I think this still needs error handling, it should put it back to the
identity domain and return an error code if it fails to attach to the
requested domain.

It should also initlaize iommu->domain to the identity domain when the
iommu struct is allocated. The iommu->domain should never be
NULL. identity domain means the IOMMU is turned off which was
previously called "detached".

Otherwise it looks like I would expect, thanks

Jason
