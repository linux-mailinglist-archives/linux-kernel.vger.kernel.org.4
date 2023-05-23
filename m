Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45870CF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjEWAit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjEWAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CC1BF4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684800202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09PE5mXwg0VZJC96eImbk77DVfIGkrjglKMDBIgjoZU=;
        b=ITMwbQ4nK9ZOiLSQChcp5AI5YKaEXJtuDajgXxwFn2MWfzuZZ2tQ3TYhfF6X01ffFIJiQN
        rZZ/E9SAX6RCHEuNhzXJ9ASlEAZUBv7oqj7SlRHilba1Zk6XrX2Gm7Yar3jsMgPGVgEYfj
        Rakv8xfewIW5DFKZpHyc9CLqMMR+LQ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-zdcn0XPsNSaw6amgLcVEyw-1; Mon, 22 May 2023 20:03:20 -0400
X-MC-Unique: zdcn0XPsNSaw6amgLcVEyw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f392b106b8so97075931cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800200; x=1687392200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09PE5mXwg0VZJC96eImbk77DVfIGkrjglKMDBIgjoZU=;
        b=GXudbjXlgVsxaCxJTnPMw5n26SEIuCMhSs6gkdfRdoFpnyglH+OKb6fShJBs5Wq+Xb
         fuTJ/iWK5x3LTHiIet9lvp8udznUJ2Pcbkb023FNteFUtMFgncM1ZXzgcfaq+oLR3ZFj
         kbzT9omQ0X0LHw4HkOWq/vzCbelGnL/RFJc0QepB04eI/NlPYFJzHpT5AszIgks2i/SN
         xufz4kBFWLuzJtj9JQ0Is4E2E34b9+IdKHCuZVvOl/UA+7aeAaXooJGaaLNqdYM7b2JR
         1I5aeOO1WM7eRBfUOTKR5yXoCFZyI20XwpQaCvN73Hot20IaQPt5WuV33TAzzqmTWlYC
         lW4w==
X-Gm-Message-State: AC+VfDyMMUNZ5wxo2c7fv3LaMZsRIH+6Fw7UTNRFXuTBAjqxcqEIY5p+
        pQbIURt5vMV/pnHI0vthnmf10Rjw6o595ZkVwhbsPW7rOKTk1nQe35IHtoaunHJ8AO5575DFlE8
        0YkQpg7dQoD1TPT6DaiOvW98s
X-Received: by 2002:a05:622a:3cf:b0:3e6:2bba:87f3 with SMTP id k15-20020a05622a03cf00b003e62bba87f3mr19299478qtx.47.1684800200215;
        Mon, 22 May 2023 17:03:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cXJcFCg8wqGN4NZ2TIl0op0gSxJUnt0t8jqr1MVzdIAXS6vttKL0SzjYWlmH8BMqUckzAhQ==
X-Received: by 2002:a05:622a:3cf:b0:3e6:2bba:87f3 with SMTP id k15-20020a05622a03cf00b003e62bba87f3mr19299458qtx.47.1684800199969;
        Mon, 22 May 2023 17:03:19 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q14-20020a05622a04ce00b003e8160cf93asm2442964qtx.80.2023.05.22.17.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:03:19 -0700 (PDT)
Date:   Mon, 22 May 2023 17:03:18 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 2/5] iommu/amd: Remove the unused struct
 amd_ir_data.ref
Message-ID: <rlurmw6n6eyyhtnfr6wva6azur2gvgcrdn4mvykr3nvsosj5py@ieaivyv6cqrv>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-3-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519005529.28171-3-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:55:26PM -0400, Suravee Suthikulpanit wrote:
> Since the amd_iommu_update_ga() has been switched to use the
> modify_irte_ga() helper function to update the IRTE, the parameter
> is no longer needed.
> 
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 -
>  drivers/iommu/amd/iommu.c           | 17 +++++++----------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3d684190b4d5..a0ff1e852efc 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -993,7 +993,6 @@ struct amd_ir_data {
>  	struct irq_2_irte irq_2_irte;
>  	struct msi_msg msi_entry;
>  	void *entry;    /* Pointer to union irte or struct irte_ga */
> -	void *ref;      /* Pointer to the actual irte */
>  
>  	/**
>  	 * Store information for activate/de-activate
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4a3a7346ab21..0c4a2796bb0a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2999,7 +2999,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>  }
>  
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte, struct amd_ir_data *data)
> +			  struct irte_ga *irte)
>  {
>  	bool ret;
>  	struct irq_remap_table *table;
> @@ -3026,9 +3026,6 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  	 */
>  	WARN_ON(!ret);
>  
> -	if (data)
> -		data->ref = entry;
> -
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
>  	iommu_flush_irt(iommu, devid);
> @@ -3117,7 +3114,7 @@ static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u1
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 1;
> -	modify_irte_ga(iommu, devid, index, irte, NULL);
> +	modify_irte_ga(iommu, devid, index, irte);
>  }
>  
>  static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> @@ -3133,7 +3130,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 0;
> -	modify_irte_ga(iommu, devid, index, irte, NULL);
> +	modify_irte_ga(iommu, devid, index, irte);
>  }
>  
>  static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> @@ -3157,7 +3154,7 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
>  					APICID_TO_IRTE_DEST_LO(dest_apicid);
>  		irte->hi.fields.destination =
>  					APICID_TO_IRTE_DEST_HI(dest_apicid);
> -		modify_irte_ga(iommu, devid, index, irte, NULL);
> +		modify_irte_ga(iommu, devid, index, irte);
>  	}
>  }
>  
> @@ -3508,7 +3505,7 @@ int amd_iommu_activate_guest_mode(void *data)
>  	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
>  
> @@ -3538,7 +3535,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
>  				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
>  
> @@ -3719,7 +3716,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  	entry->lo.fields_vapic.is_run = is_run;
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif
> -- 
> 2.31.1
> 

