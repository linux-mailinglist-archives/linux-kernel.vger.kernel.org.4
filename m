Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4372CD96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjFLSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD3E73
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686593530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WfC+fA7QHuUg+7zV3oJP34eZ8O1o0OXP59IbCjsY+f8=;
        b=JZRXBvCPkQ0cvlrCxdDniboiCRx/KRkuNM4cMrG20tcDvQbu9uwl5CByR68dTrbNFKNnC3
        CR1een9yjFM60SVCofyy+xEgJmNvCU7rv6ZNZDXFf5kKpcOc4bqsJQ4U381gw0ux0JGuad
        JFrYPvSe06VicfwIdGS6yJoglTCMpjU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-pb1OOchDNjOFsa1bjgJVWA-1; Mon, 12 Jun 2023 14:12:09 -0400
X-MC-Unique: pb1OOchDNjOFsa1bjgJVWA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-558a4d70fa9so3816365eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593529; x=1689185529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfC+fA7QHuUg+7zV3oJP34eZ8O1o0OXP59IbCjsY+f8=;
        b=J78F/w3q92fbf6Q0Zfx3MjUomCOUuo7NKaEQtemZCuSiC6xwHsy025CPzUypsVgbdO
         ghFyk0Uxig8PCRTC3zkncweujNak6XFnjJ2BYeQGF91ubfQ/6BrJymdfHwk5QPaEFEpd
         asBbIFbVLwdSKo0xIvoiZ6gANnQHtVp0WsaRCt8JvOhrUAgrssuG/C/Dth27KFJKG5SY
         ZIMGoIpWHhsTP2dTHe+VDYfDIzAVYxzJ9x1XoEcZEyz7hSUuG8KXntLRLT3cpNJETozu
         HY7xfnKvQIYt33ZkjD6U3dyyLqeNtkEtKR1rlE9ajcG1oPJRls45NSGiX5qwOvZo1wte
         DDkg==
X-Gm-Message-State: AC+VfDzX2j9qWYO4RSCjeRds6C1WbgqWsvXyXPegQuzqxY9Y+T/HwcsK
        IS78LGcv8c+64VdapStwAO2xKlWEMPONsDroJBSIN8WrDFc/lZ7wA8iNQc+NEQihIjd53ZEzpqc
        UoXdAAuliLRfUP9WKrq+GuGFD
X-Received: by 2002:a05:6808:bce:b0:39c:5ef9:a287 with SMTP id o14-20020a0568080bce00b0039c5ef9a287mr5838740oik.28.1686593528938;
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5siJQtPBzzmM7yK6WLPkp0yQIVivZKClJMlvcgOVp6oXj9tBIggGZOzsc2/5O0+BibBQWFng==
X-Received: by 2002:a05:6808:bce:b0:39c:5ef9:a287 with SMTP id o14-20020a0568080bce00b0039c5ef9a287mr5838723oik.28.1686593528694;
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ay9-20020a05622a228900b003f7a54fa72fsm3617904qtb.0.2023.06.12.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:12:06 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        vasant.hegde@amd.com, jgg@ziepe.ca, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Message-ID: <g6iqzwutmdtmi2enfogchhs3toduy4e2hs45hjipuuybcawbhh@uuzohezj3ryj>
References: <20230608021933.856045-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608021933.856045-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:19:34AM +0800, Su Hui wrote:
> Move allocation code down to avoid memory leak.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> Changes in v2:
> 	change code order is better and more consistent with other
> drivers. 
>  drivers/iommu/amd/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..e8a2e5984acb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2078,10 +2078,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	int mode = DEFAULT_PGTABLE_LEVEL;
>  	int ret;
>  
> -	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -	if (!domain)
> -		return NULL;
> -
>  	/*
>  	 * Force IOMMU v1 page table when iommu=pt and
>  	 * when allocating domain for pass-through devices.
> @@ -2097,6 +2093,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  		return NULL;
>  	}
>  
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +
>  	switch (pgtable) {
>  	case AMD_IOMMU_V1:
>  		ret = protection_domain_init_v1(domain, mode);
> -- 
> 2.30.2
> 

