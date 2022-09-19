Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074FD5BC454
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiISIai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiISIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DC17A9C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663576233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h70RRnLGDocRCdId1Q3AvZ9oOdszso8M7BsFXb0vm98=;
        b=DxaS0WL/qt5z377z5qHdAEhAvKl4VvluoEGAYK7QaoYI7v/xVHB1gh8cZbeE1KIpbOqCiy
        p5OOlW85XIovdk2EQxQdf0+qcQojLj8Eisfc9j8ogIFAtedFxTzK/yRIFRDyjTMYvqjqSq
        C389BWC5PnYGXqMM4quF6SOCI3hprMs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-UEbfJa1kMKOuKx_dm_I84g-1; Mon, 19 Sep 2022 04:30:32 -0400
X-MC-Unique: UEbfJa1kMKOuKx_dm_I84g-1
Received: by mail-qk1-f200.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso6243154qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=h70RRnLGDocRCdId1Q3AvZ9oOdszso8M7BsFXb0vm98=;
        b=uj0Eet0k4UUV4dEQCNq7m9649gCp82AtduMsqo7PM5/EOxb09CDk0K057JF14pSJ3v
         6JMS3vnvIxpKO1mBkBXjszw1dsLrjxhIwU2rNyT1ecxoCqFKq9DzFPU30Fv6yZ1V+tEk
         dXE0N/+Dm2SX8S/LfRt7f8gpbdQuiIr/Ot4weuQS8/iN5oZhYU8ZW/C9PC/gY/MMkV0E
         CBa/d31cn0jLAJPDx9VpaQtsNvHMuxEc2OnrK9dz7GZa+zY/UQl3gKhHrTv5MQ3RnA2R
         jQUlZ91wvuHaD4XXwkpHE/brubUZ/HbXYRsvRVwuhAOoV80n2HCo3ICw2OlrNFWrCw5y
         QhIQ==
X-Gm-Message-State: ACrzQf2E3AYzauIMUvWUOnm950Pk6/zAIAZNjF5RvFNXmoHCil/CBcyE
        j3hOLvb0R8KKVUcectiiQlimYq5lqrMw1F9aTawfav6ZEdALKqgIo3+b7/2DO+I4XDb072sTIpb
        X9SrwIy7Pfp1D4fMaWcPn3req
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr13987401qvf.15.1663576231852;
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XbGFJVZrlxcnOG4Tqc8u7gYjO9AunLzgZXMoLWaP7MnGq098SrMu+vtT5BdoTxvmAzpO8Og==
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr13987387qvf.15.1663576231669;
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006b633dc839esm12587073qkp.66.2022.09.19.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
Date:   Mon, 19 Sep 2022 01:30:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Avoid unnecessary global DMA cache
 invalidation
Message-ID: <20220919083029.vwwxkm5kuyylgbew@cantor>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919062523.3438951-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:25:23PM +0800, Lu Baolu wrote:
> Some VT-d hardware implementations invalidate all DMA remapping hardware
> translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
> (Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
> capability bit to indicate this. With this bit set, software has no need
> to issue the global invalidation request.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/intel/iommu.h | 1 +
>  drivers/iommu/intel/iommu.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 5407d82df4d1..251a609fdce3 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -146,6 +146,7 @@
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_esrtps(c)		(((c) >> 63) & 1)
>  #define cap_esirtps(c)		(((c) >> 62) & 1)
>  #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>  #define cap_pi_support(c)	(((c) >> 59) & 1)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8e5d99197d39..c20f3e060bac 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1239,6 +1239,13 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
>  
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  
> +	/*
> +	 * Hardware invalidates all DMA remapping hardware translation
> +	 * caches as part of SRTP flow.
> +	 */
> +	if (cap_esrtps(iommu->cap))
> +		return;
> +
>  	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
>  	if (sm_supported(iommu))
>  		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> -- 
> 2.34.1
> 

