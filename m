Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1B70CF91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjEWAkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjEWAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACCFE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684801037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTeHVdraaDyLmGTmp7Ytrme6w/+h6Z+q6yjLpuN0RnU=;
        b=fmDDFu9kQpjxeh4jltpoLgfaG64BW4sKgrI4OdlD7I1/x32ux5XsiZf1qSXkiQ1od27WLs
        vIFFqa634ovHaPKJqoNPq4vVeKH6bk2AtlKKX56qEhYcQCYkod7tq7v+9XU5tWXTVgF5kk
        2wSIUg5TXGt1w7SPyO1O1wsQaGNVnO8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-GEsIfCiCPoOkIkmfy_vRjw-1; Mon, 22 May 2023 20:17:16 -0400
X-MC-Unique: GEsIfCiCPoOkIkmfy_vRjw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62381540ab8so28498616d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801036; x=1687393036;
        h=in-reply-to:content-disposition:mime-version:references:\from
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTeHVdraaDyLmGTmp7Ytrme6w/+h6Z+q6yjLpuN0RnU=;
        b=G0KIpJ2xR2jsrq68uNPdlKolxvd93s3IDW7dCLm5Xi9BJqmFpXt/WEHFbL8E4KgMW5
         3M+r+81MiVkCmELML8PLbwJsXGOVIJ9nG4KHV9WtKA/2n//rPMcKvZ/cGrQKZYW8qb5X
         m9HVtZUrVjqZ+DO7oJRqOUQIqax0N/46lJgmsnPoJhSnTcfkxhXOutWqn0e7zrbP5btx
         OGI8AyarOPEDi59hw6V1EW7ixfa19g32Nv3zeY7pAZEjY1lMTxt/BfChX/MmKBVcJrZ1
         U9btnfPb7Pqqf+Xe6ZkjqBQZyj0eI4VtLrY/XpYX6oE+jXIUNfUPEzw+ZAHsDHKqo1io
         WwFg==
X-Gm-Message-State: AC+VfDyTAyFYxfwb51xC+5hTqUo1qnOr2spoVGAyTmAq1K3SGEbNVPkT
        vUfm2MvA/GkAE5qFFxi+O64RsNIvWY1VguO/q9l2KCMy/ldWe/TzrlfysfbfH2p1M7yGvOJy+mc
        bH8lPj87qJ1MzckQbuH95CDKG
X-Received: by 2002:ad4:5dcd:0:b0:5ef:6103:1475 with SMTP id m13-20020ad45dcd000000b005ef61031475mr19615153qvh.20.1684801036054;
        Mon, 22 May 2023 17:17:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Omec8OxIXzGdyaG2GXBjw0uJnau8rGKkmpAA3GeKRceyP72vusWAP6o3ol0Op1EwAoMrd4w==
X-Received: by 2002:ad4:5dcd:0:b0:5ef:6103:1475 with SMTP id m13-20020ad45dcd000000b005ef61031475mr19615139qvh.20.1684801035816;
        Mon, 22 May 2023 17:17:15 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id pp8-20020a056214138800b0061b62c15351sm2361791qvb.90.2023.05.22.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:17:15 -0700 (PDT)
From:   jsnitsel@redhat.com
Date:   Mon, 22 May 2023 17:17:13 -0700
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable
 IRTE caching
Message-ID: <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
\From:  Jerry Snitselaar <jsnitsel@redhat.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:55:28PM -0400, Suravee Suthikulpanit wrote:
> With the Interrupt Remapping Table cache disabled, there is no need to
> issue invalidate IRT and wait for its completion. Therefore, add logic
> to bypass the operation.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Would it be clearer for the summary to be "iommu/amd: Do not
Invalidate IRT when IRTE caching is disabled"?

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0c4a2796bb0a..51c2b018433d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1273,12 +1273,24 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
>  	u32 devid;
>  	u16 last_bdf = iommu->pci_seg->last_bdf;
>  
> +	if (iommu->irtcachedis_enabled)
> +		return;
> +
>  	for (devid = 0; devid <= last_bdf; devid++)
>  		iommu_flush_irt(iommu, devid);
>  
>  	iommu_completion_wait(iommu);
>  }
>  
> +static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
> +{
> +	if (iommu->irtcachedis_enabled)
> +		return;
> +
> +	iommu_flush_irt(iommu, devid);
> +	iommu_completion_wait(iommu);
> +}
> +
>  void iommu_flush_all_caches(struct amd_iommu *iommu)
>  {
>  	if (iommu_feature(iommu, FEATURE_IA)) {
> @@ -3028,8 +3040,7 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
>  }
> @@ -3048,8 +3059,7 @@ static int modify_irte(struct amd_iommu *iommu,
>  	table->table[index] = irte->val;
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
>  }
> @@ -3067,8 +3077,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
>  	iommu->irte_ops->clear_allocated(table, index);
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  }
>  
>  static void irte_prepare(void *entry,
> -- 
> 2.31.1
> 

