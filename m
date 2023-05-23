Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C670CF62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjEWAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjEWAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E6B1BEF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684800175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Wxa9BdaUiqlXTnGjOyK9/2k5G21kZcdrcwgly0YKkk=;
        b=Fd9Oxd3ccaiiWXdNTVNI5v/EAOfZy93JslyWUJRD+hR6qmUdwkoLbdP6zbxpvuBSsunh9/
        uyvT+ctWGPkYNES0toMtEkPhwThrQt2awrWCOnN8OhWKdmRtaO43z29o+FJaRoxwIE5rKb
        g8NEcpvwXZtEW+PA+bm/MgOOdO+Vu7k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-zA8EIP6qPbuzdbQb3BsZvw-1; Mon, 22 May 2023 20:02:52 -0400
X-MC-Unique: zA8EIP6qPbuzdbQb3BsZvw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b17aa340fso197857285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800172; x=1687392172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wxa9BdaUiqlXTnGjOyK9/2k5G21kZcdrcwgly0YKkk=;
        b=Y31MOpcQM+ukxcK2rhQhB4EXBIX3EER0N1Lx57On/5GYbGyEP+rDotnTXcFTdLLpFx
         L6Wy3/gvF7Q4O2aUDuVLowjIy7Yl4xP56lHsoiBET2WF0kI9aOflu2hqHXdG7KgiTzIt
         ITzmmkYfn+hy7CmCBUKyZ324BhHCNA7TuG4auVqBzraYP26Fx2nAaVfndj8GYlIYlG4j
         olBCDLnhRLJhaL7IpeKuh4rRfwqhYZ8DpSSUj/+53SF2iVowFMezMcLC1IPN6SE9avEn
         2zNfrvcoF12fRPgEvcpTj+B5t+DosNJuBe8ncakC/AY/oXXU/upagFIdN7+ukH+aJVAL
         hsMw==
X-Gm-Message-State: AC+VfDxZAJdysTbgJDXEVLCw8mHzUpudUSV3Co9GRo7P1AcXbu0H+4sE
        YAWf2eW0+9YFtRW1O0G62+Vi6hb7T2a8oeOqouMRs6yI8SyF6cxRhkxQX6+fh+2V3Xv80UrDZz0
        FdyJAU0JuUJHc2EDZo0uNH+AI
X-Received: by 2002:a37:bcd:0:b0:75b:23a1:442 with SMTP id 196-20020a370bcd000000b0075b23a10442mr2368797qkl.8.1684800172262;
        Mon, 22 May 2023 17:02:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fzIZoakFUWCdm0NW2bhIl82KaiHin9x/8AjhK2bBWyoCTNAQV6Mg1YqMXo2FTa9FggOBd8g==
X-Received: by 2002:a37:bcd:0:b0:75b:23a1:442 with SMTP id 196-20020a370bcd000000b0075b23a10442mr2368783qkl.8.1684800171981;
        Mon, 22 May 2023 17:02:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x25-20020a05620a12b900b007576f08d3a0sm2115151qki.44.2023.05.22.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:02:51 -0700 (PDT)
Date:   Mon, 22 May 2023 17:02:49 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 1/5] iommu/amd: Switch amd_iommu_update_ga() to use
 modify_irte_ga()
Message-ID: <xnnxp67w4a6afoliba4p2wbqc33kus5s5mpmn2jubntdwmwwkk@zcnfdot7og5x>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519005529.28171-2-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:55:25PM -0400, Suravee Suthikulpanit wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> The modify_irte_ga() uses cmpxchg_double() to update the IRTE in one shot,
> which is necessary when adding IRTE cache disabling support since
> the driver no longer need to flush the IRT for hardware to take effect.
> 
> Please note that there is a functional change where the IsRun and
> Destination bits of IRTE are now cached in the struct amd_ir_data.entry.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ebb155bfef15..4a3a7346ab21 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3700,44 +3700,26 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  
>  int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  {
> -	unsigned long flags;
> -	struct amd_iommu *iommu;
> -	struct irq_remap_table *table;
>  	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
> -	int devid = ir_data->irq_2_irte.devid;
>  	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> -	struct irte_ga *ref = (struct irte_ga *) ir_data->ref;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
> -	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
> +	    !entry || !entry->lo.fields_vapic.guest_mode)
>  		return 0;
>  
> -	iommu = ir_data->iommu;
> -	if (!iommu)
> -		return -ENODEV;
> -
> -	table = get_irq_table(iommu, devid);
> -	if (!table)
> +	if (!ir_data->iommu)
>  		return -ENODEV;
>  
> -	raw_spin_lock_irqsave(&table->lock, flags);
> -
> -	if (ref->lo.fields_vapic.guest_mode) {
> -		if (cpu >= 0) {
> -			ref->lo.fields_vapic.destination =
> -						APICID_TO_IRTE_DEST_LO(cpu);
> -			ref->hi.fields.destination =
> -						APICID_TO_IRTE_DEST_HI(cpu);
> -		}
> -		ref->lo.fields_vapic.is_run = is_run;
> -		barrier();
> +	if (cpu >= 0) {
> +		entry->lo.fields_vapic.destination =
> +					APICID_TO_IRTE_DEST_LO(cpu);
> +		entry->hi.fields.destination =
> +					APICID_TO_IRTE_DEST_HI(cpu);
>  	}
> +	entry->lo.fields_vapic.is_run = is_run;
>  
> -	raw_spin_unlock_irqrestore(&table->lock, flags);
> -
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> -	return 0;
> +	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +			      ir_data->irq_2_irte.index, entry, ir_data);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif
> -- 
> 2.31.1
> 

