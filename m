Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED466A3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjAMTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjAMTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:48:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD06C06D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:48:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id x7so9839670qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCsX8uc4cCu1oNFGRmQtZZmdp5RBV4+wTc8HN1xnvho=;
        b=e+cndpq5AbJCc9ropmy8+4Yd1TlOSMPwhQX6qeOHJmbJ4npOBH+R4Rgtl0Qp4/BK2G
         sJIdxB8UWVpBrXxGOV6Semfw2WkqB9XY+7S+V8VS+YyVe98F2na5c+Wsnj02XNGXg6Wt
         VYa2jZYY2i5Mre4MYmOrBY0C2RdWKQtTVUNLU3wnGoPuUYloUFmRibD39QKHMnFbcm8V
         4QAhBuLCMXHDygbkQhOBzebF5ckjucVjZvZGHA1xpp45CkDNmWJ/cOlPydNz7rM0XUEf
         PfKIszSirtyvvhSY0gdp7LZ0j2ohnw1RAbYfmVeuf7OixQXYvAGuFrUurJHwXwRv45wt
         kIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCsX8uc4cCu1oNFGRmQtZZmdp5RBV4+wTc8HN1xnvho=;
        b=ZN1nMPpXhv72yxlDLqUCyHokLgTPD3KjmxR5sRDXpQo7W6+EEh2Y+DUM9UhdtFuIxb
         ZHK+cZ9aoZkSGyP9AFBfxRXooXrFPDtRHNCu7XuBvQewCxPvv0uGsW4VF43mE7FKmRw4
         9LsZDphij67orfoJzLJLFNysNvoc4dkE8jdCb8zK/01nI9NzAAj64BdwlKch3UAI3ykL
         lYCBHyTLKrjpH2Kx5NU+iefcWKl6qZepQWIkBNXhlXImPe/a4gQGks7ndOTIpicMtayk
         wyc+JmDGjEGlBrrB6OpTeG0LJtRpY1eQoGmUVaweXKPqO4CF+Y8o43mLtaXr1PwU9SaW
         x3UQ==
X-Gm-Message-State: AFqh2kq5MfAL2wbXe+HqYHZ7sU9ddenepFWnrQQ2nHaQPRwBmT6i7T5p
        juKDLm9xz0O08Bt3Qe00vJjr1A==
X-Google-Smtp-Source: AMrXdXtm3RrwRr6RHb4naiD4l5n6+JmgDWK7TdiQX//Ern7jngXe0ppdvazLqngqV/8wLCwN25LO2g==
X-Received: by 2002:a05:622a:1e99:b0:39c:da1f:f817 with SMTP id bz25-20020a05622a1e9900b0039cda1ff817mr124418233qtb.61.1673639335588;
        Fri, 13 Jan 2023 11:48:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006fbbdc6c68fsm13212326qkb.68.2023.01.13.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:48:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pGQ2o-00AgoL-Fw;
        Fri, 13 Jan 2023 15:48:54 -0400
Date:   Fri, 13 Jan 2023 15:48:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/fsl_pamu: Fix compile error after adding
 set_platform_dma_ops
Message-ID: <Y8G1puXtbsHrXZfn@ziepe.ca>
References: <20230113191528.23638-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113191528.23638-1-joro@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:15:28PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The struct initializer for set_platform_dma_ops uses a semicolon as
> separator where a comma is required. Fix the compile error by using the
> correct separator.
> 
> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'd probably just squash these :\

Jason
