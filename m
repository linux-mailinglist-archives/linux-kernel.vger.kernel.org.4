Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A07262B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbjFGOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjFGOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:22:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593DC1BCA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:22:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d57cd373fso481262b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686147766; x=1688739766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqYHTiTmt+6bkokPZgd7QYzZ8bhU2nwFDSU1EUKZZAw=;
        b=jb0R5N3wy/ARkSOwsfs8wIpDDWZOCLPYl9Oylyey830OFdJtm87SmtHdCKAq/LQiAH
         rwmGPpis5/8ni1oCofH2ZuRgryc+pv4WcEqnuqYTAg3Gp8+4YPPM7cn0aSLFPow92ive
         zO6VbcvKOoYyTZyZyvaLI4/CuMqtSKrcrWSPWpSYujBhp5yu5UqKDeJAKqSNFOEFJK4d
         vAbCGYfDWHdiMs69lm2mYNNPLeMTouW43dNA61gH5G1HAiY6XAUx11v4rL7/3Dh1hjgY
         ZUkfV0zNnYQwii3B6T8cgOvuTKx7NCF7GOwF4oGn+x5QXORzo99WY8cgEBI4GqS2tzKK
         pINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147766; x=1688739766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqYHTiTmt+6bkokPZgd7QYzZ8bhU2nwFDSU1EUKZZAw=;
        b=Ef7JVPYoYrvxAeQ3kWw5MPM1VF2SThzAfxXwoR2J7OdnHeH8tEilx5naJiv8KEXSmu
         5E6ESmhkifdSQyzV5zFsJyTiVqyhx053aBtqVh8EQ3O+q1hztqAREbKlRw3WUViSTNNd
         UXbn4/wIhaY3gZTZDnBmVjvWsTLqioYE1O9kjQTJiEPOEnsqH0xzegTqbCd5ypuCRNop
         10Wr4pWyb1AlQj0su/taOLaJ+YNd37DoY9Q48JEtgHh5p9On1Kau+aQcMJEM/Q5X8wrD
         1IlIv65lIwPbzbZrt9FwQKKhfkgYjzvd5i38GqoO+VV1wvhkF1iW2cZVpmRAxGZ8HUCs
         d4zw==
X-Gm-Message-State: AC+VfDzy7Al41AhxY1q6qTMr+fY9mTjVQek1mt34UsnWibZQCP/CCF0u
        FQpLsgO2q6IfuTb9/RWaqCsduNsLN8j9LCFXxv8=
X-Google-Smtp-Source: ACHHUZ7qxQnVsqExHvsQTLbMLN28JDeSFBHVrePVBcZm0TOoDtDb8z0JSeFAJkTeo16Nx5mU1Bim0A==
X-Received: by 2002:a17:903:244d:b0:1b0:56cf:b8c0 with SMTP id l13-20020a170903244d00b001b056cfb8c0mr7246032pls.13.1686147765817;
        Wed, 07 Jun 2023 07:22:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001b1a2bf5274sm10497227plr.22.2023.06.07.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:22:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6u3e-003A3r-Kv;
        Wed, 07 Jun 2023 11:22:42 -0300
Date:   Wed, 7 Jun 2023 11:22:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Su Hui <suhui@nfschina.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        vasant.hegde@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix possible memory leak of 'domain'
Message-ID: <ZICSskXNlR+ckKvC@ziepe.ca>
References: <20230606070742.139575-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606070742.139575-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:07:42PM +0800, Su Hui wrote:
> free memory of domain before return NULL.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..f08e65629c74 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>  		pgtable = amd_iommu_pgtable;
>  	} else {
> -		return NULL;
> +		goto out_err;
>  	}

It might be nicer to order to allocation after the type checks, it is
more consistent with the other drivers

This is fine too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
