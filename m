Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430655BC451
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiISI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiISI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6171420F64
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663576163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3xg0oZZ6d2RRIQotHdVIz60qRrzyRMeJDEgCiAZ0Mw=;
        b=Bt5mFHt6EBQywdcNK+Mj37sj5xwC9y+LJl0HRlYzQA9661VmuWlOUi5m6Wwiu/7e71ARqU
        1rs/AC3YMxGeAGDsPhu5O/qsLrtNyXgoqsv1RlMcR0EmL75o2NPQRLoUl4BGDekp4/3Hnn
        CXfO5g6e/TZJJfG0fBAD50bVdikR6Ks=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-LorgHIu2P9Os9jSbz6c6Jg-1; Mon, 19 Sep 2022 04:29:22 -0400
X-MC-Unique: LorgHIu2P9Os9jSbz6c6Jg-1
Received: by mail-qt1-f197.google.com with SMTP id j25-20020ac84c99000000b0035bb13ed4ffso17058176qtv.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=F3xg0oZZ6d2RRIQotHdVIz60qRrzyRMeJDEgCiAZ0Mw=;
        b=mIdgvbiZf1q1i8lMxomXWEVdw+jJ0Q4/K9wGZT0tHe3RsfXCD8P+IPtzniaqKVZHu2
         7aEb945u+xQcTSnEfxvYkJPda0hWNw+MpqqTU1eOOMGC0Vo5Jijg+VSGyMDOwqkgtckN
         rRatXWhZfek1VZ8f3NVUZT6XKdX/X9cJ8BNWpRQO/edAt/ekrRDJ5NxV3oTqlA8GnQOM
         7jxieFAW/ZhELdGSJf9ZCtO9ATViWC+DQdaIx0C6Y0i+xTueWL8Yc8itKUiPGoCEUST4
         UuJyt0pvFgFaQ2/OiBosHnXPjNOlSs/Dy2jWqs8lSsg4LaSQ/xgA0jrYA0whHucvdJHA
         YFHw==
X-Gm-Message-State: ACrzQf0sSsLmT9M+cVNyDsWuoy7ys2pO/P2DbZakg5IlNZ1Ckgngw6vC
        WnpTbcT0/l99r4I2N1HGrK2bbxXhQqvRp8wzbdlj7G3VRfHl/L+AohcJOOS8LlMlDSJBLqiKIUY
        iOF0dTddgU7jXsMqFY8yMJm9X
X-Received: by 2002:a05:6214:e6f:b0:4ad:d5a:f09b with SMTP id jz15-20020a0562140e6f00b004ad0d5af09bmr12869554qvb.34.1663576161982;
        Mon, 19 Sep 2022 01:29:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VS5dzoLRy04YcELRQ5ZPTfY+JNNMRe/H4swC5sEjj6xjJyMhB4a94m3imvsO8Jdb3Xu7zug==
X-Received: by 2002:a05:6214:e6f:b0:4ad:d5a:f09b with SMTP id jz15-20020a0562140e6f00b004ad0d5af09bmr12869543qvb.34.1663576161746;
        Mon, 19 Sep 2022 01:29:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0034355a352d1sm9779291qtv.92.2022.09.19.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:29:20 -0700 (PDT)
Date:   Mon, 19 Sep 2022 01:29:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Message-ID: <20220919082919.ekv6p47y2nnmpswk@cantor>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919062523.3438951-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:25:22PM +0800, Lu Baolu wrote:
> Some VT-d hardware implementations invalidate all interrupt remapping
> hardware translation caches as part of SIRTP flow. The VT-d spec adds
> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
> 11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
> software has no need to issue the global invalidation request.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/intel/iommu.h         | 1 +
>  drivers/iommu/intel/irq_remapping.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index eef1a166b855..5407d82df4d1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -146,6 +146,7 @@
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_esirtps(c)		(((c) >> 62) & 1)
>  #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>  #define cap_pi_support(c)	(((c) >> 59) & 1)
>  #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 2e9683e970f8..b4a91fbd1c2f 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
>  	 * Global invalidation of interrupt entry cache to make sure the
>  	 * hardware uses the new irq remapping table.
>  	 */
> -	qi_global_iec(iommu);
> +	if (!cap_esirtps(iommu->cap))
> +		qi_global_iec(iommu);
>  }
>  
>  static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
> -- 
> 2.34.1
> 

