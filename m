Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00233601312
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJQP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJQP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642858DFE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666022222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQ9BSUfDKoJUJ+YyUq4v3/jXsEiShgxTQU4ItDdSgGE=;
        b=edb92rZ0c7o04VKukdiLfnFNszI+HiuPYRu+tnpI1gyZQ/Omj7s7HzbAP4vJIR2ishCubH
        OT8XRl6o6d2BUWB3uROGuS0OePKKtZ40MMqpgyKhD7uF9WTJFS+GcwZlZubquxd6vXflnC
        nX/sd6c+yvxOcqjZRNC8N6NaepYvqOs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-yWwjxIHIOcyPLVGUVOUSTw-1; Mon, 17 Oct 2022 11:57:01 -0400
X-MC-Unique: yWwjxIHIOcyPLVGUVOUSTw-1
Received: by mail-qv1-f70.google.com with SMTP id y14-20020a0cf14e000000b004afb3c6984bso7124105qvl.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ9BSUfDKoJUJ+YyUq4v3/jXsEiShgxTQU4ItDdSgGE=;
        b=S/CErVD3gqAapHu7T4a0Fm7GZHIiGWfjVUR5b14LFzixgOC0oSmGJDDBKPbO/NXUBf
         1cnH7P4QYmuX1cvVWvk4zPwqD4APvIIY6I1NuXYHIDseRilxB8ICwd3y1+kQ7wUA4c43
         Y0O4qHJeCOR2ldHQP3myl8GXE5bSi7Ri7JSqC/ngGcZgzjDLYmm5vDZU2rk6qu0TtZmb
         qu9kw1azF1p4eXLjBnV696Fh0WVOe1BwJoElaLhQS9vczk2jA85CsOGiaMLjCX/7DEi1
         4n9nTec16ZPJLHgbbsnDoMEXh+z8KovLHoA8ICdtLI+PbN4AB9ekS/nVCp5UvpywdB8v
         K2yA==
X-Gm-Message-State: ACrzQf04A0s5iCng7wDY3JWuifi42VHSp3gtl4idjgBcwbxWHuOR3woG
        jQd/CrNRiTUESmBv7TQZXOAljfyqOXmqP75w378IjqyEJfT6cHI8JZsXsDjUDKJ9NXoflQSEVuA
        D97jfziX/uBaRhwagFF0xOQNo
X-Received: by 2002:a05:6214:2aaf:b0:4b1:d684:f724 with SMTP id js15-20020a0562142aaf00b004b1d684f724mr9133428qvb.97.1666022219844;
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4MXOXDAWK4nrAqUigIaANtf8VLQnL+iRuWPSVrKyXzwp36CNxsgKkJX8PxMceOAIliBF741A==
X-Received: by 2002:a05:6214:2aaf:b0:4b1:d684:f724 with SMTP id js15-20020a0562142aaf00b004b1d684f724mr9133411qvb.97.1666022219641;
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a0bc900b006cfc4744589sm57440qki.128.2022.10.17.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 08:56:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: Do not enable user type Work Queue
 without Shared Virtual Addressing
Message-ID: <20221017155657.kpwvx5jicitoxbzp@cantor>
References: <20221014222541.3912195-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014222541.3912195-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 03:25:41PM -0700, Fenghua Yu wrote:
> When the idxd_user_drv driver is bound to a Work Queue (WQ) device
> without IOMMU or with IOMMU Passthrough without Shared Virtual
> Addressing (SVA), the application gains direct access to physical
> memory via the device by programming physical address to a submitted
> descriptor. This allows direct userspace read and write access to
> arbitrary physical memory. This is inconsistent with the security
> goals of a good kernel API.
> 
> Unlike vfio_pci driver, the IDXD char device driver does not provide any
> ways to pin user pages and translate the address from user VA to IOVA or
> PA without IOMMU SVA. Therefore the application has no way to instruct the
> device to perform DMA function. This makes the char device not usable for
> normal application usage.
> 
> Since user type WQ without SVA cannot be used for normal application usage
> and presents the security issue, bind idxd_user_drv driver and enable user
> type WQ only when SVA is enabled (i.e. user PASID is enabled).
> 
> Fixes: 448c3de8ac83 ("dmaengine: idxd: create user driver for wq 'device'")
> Cc: stable@vger.kernel.org
> Suggested-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> v2:
> - Update changlog per Dave Hansen's comments
> 
>  drivers/dma/idxd/cdev.c   | 18 ++++++++++++++++++
>  include/uapi/linux/idxd.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index c2808fd081d6..a9b96b18772f 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -312,6 +312,24 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>  	if (idxd->state != IDXD_DEV_ENABLED)
>  		return -ENXIO;
>  
> +	/*
> +	 * User type WQ is enabled only when SVA is enabled for two reasons:
> +	 *   - If no IOMMU or IOMMU Passthrough without SVA, userspace
> +	 *     can directly access physical address through the WQ.
> +	 *   - The IDXD cdev driver does not provide any ways to pin
> +	 *     user pages and translate the address from user VA to IOVA or
> +	 *     PA without IOMMU SVA. Therefore the application has no way
> +	 *     to instruct the device to perform DMA function. This makes
> +	 *     the cdev not usable for normal application usage.
> +	 */
> +	if (!device_user_pasid_enabled(idxd)) {
> +		idxd->cmd_status = IDXD_SCMD_WQ_USER_NO_IOMMU;
> +		dev_dbg(&idxd->pdev->dev,
> +			"User type WQ cannot be enabled without SVA.\n");
> +
> +		return -EOPNOTSUPP;
> +	}
> +
>  	mutex_lock(&wq->wq_lock);
>  	wq->type = IDXD_WQT_USER;
>  	rc = drv_enable_wq(wq);
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 095299c75828..2b9e7feba3f3 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -29,6 +29,7 @@ enum idxd_scmd_stat {
>  	IDXD_SCMD_WQ_NO_SIZE = 0x800e0000,
>  	IDXD_SCMD_WQ_NO_PRIV = 0x800f0000,
>  	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
> +	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
>  };
>  
>  #define IDXD_SCMD_SOFTERR_MASK	0x80000000
> -- 
> 2.32.0
> 

