Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB06F7B40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEECzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84B30F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683255301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjYsetGrBM63KihX4CFzxpJKx/AEwalSZhpNQfLiHHI=;
        b=UBarOmyGeFiiwGYp3KWzflb/hjYPynGNWl7+MRpdSbek36z7sN8kw9ReYrmdRfQDwIr4eN
        YEfDJRnYBimPEHCbU5MOGGK5PsdVZfetL7I0iI4EXW4kDhY6sEDbizVA7dMfS+ur7MAIqK
        1BvsZAVIYKy/15fhSLIuyussgJR3rF8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-KEouOSSJPDehW1b7pOyhoQ-1; Thu, 04 May 2023 22:55:00 -0400
X-MC-Unique: KEouOSSJPDehW1b7pOyhoQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-751319bd93cso1014202685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 19:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683255300; x=1685847300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjYsetGrBM63KihX4CFzxpJKx/AEwalSZhpNQfLiHHI=;
        b=RaDCZE66WxdV8D4z4BvTl0/wsN8s6M17cLdnATNVInEg4lENZrd3oTgB2qpbcEMqzo
         BCGO6TxeNXoG9Yg9afpkGpO1d6PUULYOKbEaCJT11ed+odRWgiajEMVKGZXGoyfnHb4L
         s41Hk+Nja+QWHb14u/U7x9fVX8pGF8WyqnjFS4fAZDZicHcKIDNUUNIehg2UvqW0xFHL
         4wIHSdhL18KdWZG/yoBXXal1ovE8s8PQszCgsF+C+SKQxHLUBtn7vhlIyiZbvfZpI0W+
         THI3xN5D8EI+LqS+ugA/LZR9HC0Qc/CUzkWqGuzdrPGCPqfNx3hjtmq6RPAgIuEaM6XE
         zxFg==
X-Gm-Message-State: AC+VfDyoS1Xx9tGh2MTy8X4F0sGP/yq96MMOp76qjpoiAKu/jRbU8Zh/
        IDVcA9NktnashhT264QzdFYUhQzPvsV4SjXJ15XhMpzt0sGpo4X4qFiJuF5/I8JjRWmet6BlZVB
        U5F2w8CaTvX23556xNuSqCgOp
X-Received: by 2002:a05:622a:409:b0:3e8:e986:b20a with SMTP id n9-20020a05622a040900b003e8e986b20amr9397764qtx.16.1683255299969;
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7L0Ig8yDCWu38q+AtSaJhk9cd5e+dZXKeZcxELnYEzOlnIFTyqh+dBVg8LWeBBdmN88tPaWg==
X-Received: by 2002:a05:622a:409:b0:3e8:e986:b20a with SMTP id n9-20020a05622a040900b003e8e986b20amr9397756qtx.16.1683255299748;
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a15d000b0074a1d2a17c8sm282513qkm.29.2023.05.04.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
Date:   Thu, 4 May 2023 19:54:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, will@kernel.org,
        schnelle@linux.ibm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
References: <cover.1683233867.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Since it came up in discussion on the default domain series, it seemed
> pertinent to dig this idea up, whcih I started a while ago, and finish
> it off.
> 
> Cheers,
> Robin.
> 
> 
> Robin Murphy (2):
>   iommu: Add a capability for flush queue support
>   iommu: Use flush queue capability
> 
>  drivers/iommu/amd/iommu.c                   | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
>  drivers/iommu/dma-iommu.c                   | 3 ++-
>  drivers/iommu/intel/iommu.c                 | 2 +-
>  drivers/iommu/iommu.c                       | 3 ++-
>  include/linux/iommu.h                       | 6 ++++++
>  7 files changed, 16 insertions(+), 6 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

