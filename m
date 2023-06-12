Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9572CDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjFLSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjFLSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C11B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686593721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6mC2Gj4NTSoNkT1TGWH5FyPDTv10EwEaEEXjwoc+qg=;
        b=Y3YDhyALb/nSrEbj/AILhyIQwZjLGG7A+0LNFbuXGMuCt6UPIJw2HHkVIaii/RUALTi2sN
        27Vb72jvQx5yVlKIc7+TDmJKapyzi2tD9GsQlKqUKMP9aOxlznBX7GuFNFdSxmH2brS+lQ
        loufeefW+CFgSdImALMHbIWEbEgPjQU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-0_770P7BPiO_mYAL5LeyWw-1; Mon, 12 Jun 2023 14:15:12 -0400
X-MC-Unique: 0_770P7BPiO_mYAL5LeyWw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62def166643so1985196d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593711; x=1689185711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6mC2Gj4NTSoNkT1TGWH5FyPDTv10EwEaEEXjwoc+qg=;
        b=hkMj9ymXxErrcn3BX4vWiVn18T13m03+VX+f1YSlxnQ7JyA+9G06MbP+x73s6SfWkK
         S8Y1bYuCuOybP5+yI18V002JX18pYEkEmpDXeItY0vSMaeZhj0feFLZJgNRlTasY2ggx
         bDciumBuncgWVRbptP6e8TNHWdbioLIj2PQqqup41SXLruwi1dMqb8xOyl0/vxcEpwT8
         BE0uujk2FJa7Vy56hXHTNn9oCdBfUB3T14rE8IkaqE/4xz17y331ncDVmCT27+ziIZCJ
         Ym0eagJZztKzC20Uft6uUEhdTOTi/st6xM5HoJTDU988qMdp1qp5kVq/OMEmKlYV8ns0
         A48g==
X-Gm-Message-State: AC+VfDzds8HpHgtKmZhcCvc0EVIkFZ35wQ3oB6e5HaN7x2sHex9pavbX
        z7NPMca9WuPZR0CIpmaqr7JItexP6ZtYCZou/VZwUH5vIRYFant3x4zL8YIpxWSHXDWY3uXk0/v
        sG4Ph9LixnDVFbH5NRJQkObz1yda1LusR
X-Received: by 2002:ad4:5e89:0:b0:626:272b:28e9 with SMTP id jl9-20020ad45e89000000b00626272b28e9mr11413980qvb.24.1686593711638;
        Mon, 12 Jun 2023 11:15:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bESJW0vHksEPcPPYKyF5PSn9yIzTWoB+yYciwXrI3nT+mM8U9XGVRMWRepJDjc2th5lgO8w==
X-Received: by 2002:ad4:5e89:0:b0:626:272b:28e9 with SMTP id jl9-20020ad45e89000000b00626272b28e9mr11413960qvb.24.1686593711414;
        Mon, 12 Jun 2023 11:15:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b006255bcfca88sm3391563qvv.7.2023.06.12.11.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:15:10 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:15:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove commented-out code
Message-ID: <54wdooghiofgutm73l6klmr6kkalwxuw46l3kxqgccwkta3brz@dezrf7rslvl7>
References: <20230609060514.15154-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609060514.15154-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:05:14PM +0800, Lu Baolu wrote:
> These lines of code were commented out when they were first added in commit
> ba39592764ed ("Intel IOMMU: Intel IOMMU driver"). We do not want to restore
> them because the VT-d spec has deprecated the read/write draining hit.
> 
> VT-d spec (section 11.4.2):
> "
>  Hardware implementation with Major Version 2 or higher (VER_REG), always
>  performs required drain without software explicitly requesting a drain in
>  IOTLB invalidation. This field is deprecated and hardware  will always
>  report it as 1 to maintain backward compatibility with software.
> "
> 
> Remove the code to make the code cleaner.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4c0b7424c45e..e5c111ff4dd9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1312,15 +1312,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
>  			iommu->name, type);
>  		return;
>  	}
> -	/* Note: set drain read/write */
> -#if 0
> -	/*
> -	 * This is probably to be super secure.. Looks like we can
> -	 * ignore it without any impact.
> -	 */
> -	if (cap_read_drain(iommu->cap))
> -		val |= DMA_TLB_READ_DRAIN;
> -#endif
> +
>  	if (cap_write_drain(iommu->cap))
>  		val |= DMA_TLB_WRITE_DRAIN;
>  
> -- 
> 2.34.1
> 

