Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E06D537D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjDCV25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDCV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A0198A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680557294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tf7MHv60vp2k26fwOLDFA2jNT1TsKbPHn/4l+Hwjf/s=;
        b=Q+7N8Eqx/QzYCWwXUMqJ4GNrNgd0Z35DVYQIQ3N6f/4M/evJtzQO+ctaFkSRdYdV/20MiV
        gxWrt0l/lS122kejwaiObUYQlrc3xgdKqPhtRayvvVt6McuyKN2wC7C+qr79UgFmQrfbFp
        CemeA5q5XYvNoTydL7OzwTUz87Iuleo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-v_uA91hIMgCsvHBimYaYHw-1; Mon, 03 Apr 2023 17:28:13 -0400
X-MC-Unique: v_uA91hIMgCsvHBimYaYHw-1
Received: by mail-il1-f200.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso20009544ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 14:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680557292;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tf7MHv60vp2k26fwOLDFA2jNT1TsKbPHn/4l+Hwjf/s=;
        b=3+7cmFvhaFqJ7ZJ12WHB0/PwJtapoWFUsw78nCFicJdKeNC+P/jtHLLHUgFsUKOC9t
         ov0gSAydKWuVwLlA6hxfTaSKnhcaaIPmAG9CRABuJScAIt1jLcvYzdtIc9zRG8gGjj3w
         BJXnihbz11+nEufqqzEmbHut+tC5dLZnPorlSLD371d84dpP/TQgCXY2as0WNguVysBm
         DOT+09M10dJb5QxDOMyrUyaJz6l8lmHpZOKC6T8atBzY2dBvfmThCCXG+7BJPX/30lnN
         UJljnI5uvwVbWULFxHi17G8zz5z7i9A7SrwL53o4W9YTf5nrXPJx2pVkcrpT+AkFQaRI
         7OEw==
X-Gm-Message-State: AAQBX9ffa5l8UQ9Grwl3it5Gzi7EfS+5806nJ9v2LrzxWGgcynNroRaF
        gBuKSIJfYr7Y8tYvnxlu1aObLdciDbdmACq6cTvIHiWQN5rLaKy7hnkkvf2Ab7epCh0fRF5i6VE
        vgRtRzclHhSW5CLNZ7TI0UqFrx1tci7Sc
X-Received: by 2002:a5e:a616:0:b0:753:786a:c003 with SMTP id q22-20020a5ea616000000b00753786ac003mr635331ioi.3.1680557292183;
        Mon, 03 Apr 2023 14:28:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeBK8jTQpKRj3YBDYuYCPItaKYhl3sLPkbYtcifrm13UX1o2MlMCVl8RcR5FlNr5W/UN0JmA==
X-Received: by 2002:a5e:a616:0:b0:753:786a:c003 with SMTP id q22-20020a5ea616000000b00753786ac003mr635315ioi.3.1680557291980;
        Mon, 03 Apr 2023 14:28:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v11-20020a056638250b00b00408df9534c9sm2774141jat.130.2023.04.03.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:28:11 -0700 (PDT)
Date:   Mon, 3 Apr 2023 15:28:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <git@amd.com>, <harpreet.anand@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH] vfio/cdx: add support for CDX bus
Message-ID: <20230403152809.239a4988.alex.williamson@redhat.com>
In-Reply-To: <20230403142525.29494-1-nipun.gupta@amd.com>
References: <20230403142525.29494-1-nipun.gupta@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 19:55:25 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:
> diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
> new file mode 100644
> index 000000000000..82e4ef412c0f
> --- /dev/null
> +++ b/drivers/vfio/cdx/Makefile
...
> +static int vfio_cdx_mmap_mmio(struct vfio_cdx_region region,
> +			      struct vm_area_struct *vma)
> +{
> +	u64 size = vma->vm_end - vma->vm_start;
> +	u64 pgoff, base;
> +
> +	pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	base = pgoff << PAGE_SHIFT;
> +
> +	if (region.size < PAGE_SIZE || base + size > region.size)
> +		return -EINVAL;
> +
> +	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> +
> +static int vfio_cdx_mmap(struct vfio_device *core_vdev,
> +			 struct vm_area_struct *vma)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	struct cdx_device *cdx_dev = vdev->cdx_dev;
> +	unsigned int index;
> +
> +	index = vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
> +
> +	if (vma->vm_end < vma->vm_start)
> +		return -EINVAL;
> +	if (vma->vm_start & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (vma->vm_end & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (index >= cdx_dev->res_count)
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_MMAP))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_READ) &&
> +	    (vma->vm_flags & VM_READ))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
> +	    (vma->vm_flags & VM_WRITE))
> +		return -EINVAL;
> +
> +	vma->vm_private_data = cdx_dev;
> +
> +	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
> +}

I see discussion of MMIO_REGIONS_ENABLE controlling host access to the
device in mc_cdx_pcol.h.  Is a user of vfio-cdx able to manipulate
whether MMIO space of the device is enabled?  If so, what's the system
response to accessing MMIO through the mmap while disabled?  Is MMIO
space accessible even through calling the RESET ioctl?  Is there a
public specification somewhere for CDX?  Thanks,

Alex

