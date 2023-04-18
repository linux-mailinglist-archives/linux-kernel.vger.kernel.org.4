Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140566E6F71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDRWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDRWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F647DB0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681857489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP1ijZh35veM9qQcwnSkBW41khK7UA9WgipBEl7rzDE=;
        b=JSc0M/NNhsJ5P/qM8Rb+XkIC7e4U5S1M4GJtXSOwEUW5OtjeN5OmRhFnUwENCcboRpMXQw
        P9bVEe/143+wQhDFq15gJOFerozFDACJXKXEiIMMyxBXCLzMwxQW5+w/LKtZ9KfUP+vy4q
        BmV2yHHBk/3ThiQ6+p4rkAiCi2aGBD8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-v0UXkGVUPOSijcB_EuTJTQ-1; Tue, 18 Apr 2023 18:38:07 -0400
X-MC-Unique: v0UXkGVUPOSijcB_EuTJTQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-760718e6878so587266439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857487; x=1684449487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP1ijZh35veM9qQcwnSkBW41khK7UA9WgipBEl7rzDE=;
        b=gEMdAQbOTorSRBIdKxlJUqVlMXGTFSX6Mq4zphwRIy0RBbpizMmj9iAvO+BiUrSsqj
         gtTmj44U1JY/At81ablSvqbLN7v6Uk5XQSL+UVwOa9aIpR8KvE5kWM6jCe5aSHpM527W
         Sq6Ga1LIRM0BqeyhkPou9oYb9BVlW3x1hL3TE9W67OozB/foRUGlahCeejGQpMJawpem
         zgtgNTa9vvM4yzuVGaiXzCs0oEHXILcIyyRx7/3OAyVh/GlL4KIX4yl4466b4+ZJh4Ev
         41C77d5A9GkojlnhecY+SHDcQ3+opGsXK+/JOVGRAz1xTIaeF1w50MmgEjuw26w3Ms3x
         ehaA==
X-Gm-Message-State: AAQBX9fhp41a6z5Xo+wJW6xFZzJYUU1q02IwVFG24YRFF1ICx8MVXjMH
        vDSTx/i34CEQzwV5/rEbMuDqOThu0TDOipYyCOvVhttorotpPk44jvpcwKTQB7qwlz/wIyB+mTg
        lV2wIZ2xTu0LMGRvmZ6zVKiKh
X-Received: by 2002:a6b:7a09:0:b0:760:ea3c:7ba4 with SMTP id h9-20020a6b7a09000000b00760ea3c7ba4mr3289302iom.9.1681857487251;
        Tue, 18 Apr 2023 15:38:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bH4tyHOMvEPlf17dAXNU9k+K8/EPTKCj5SBEPj13WIpXZ8uMMQ+pj17m+7Itegs2At0Ir7ow==
X-Received: by 2002:a6b:7a09:0:b0:760:ea3c:7ba4 with SMTP id h9-20020a6b7a09000000b00760ea3c7ba4mr3289280iom.9.1681857487036;
        Tue, 18 Apr 2023 15:38:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id co9-20020a0566383e0900b0040bd3646d0dsm4445684jab.157.2023.04.18.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:38:06 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:38:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 08/10] vfio/pci: Probe and store ability to support
 dynamic MSI-X
Message-ID: <20230418163803.46a96fdc.alex.williamson@redhat.com>
In-Reply-To: <0da4830176e9c4a7877aac0611869f341dda831c.1681837892.git.reinette.chatre@intel.com>
References: <cover.1681837892.git.reinette.chatre@intel.com>
        <0da4830176e9c4a7877aac0611869f341dda831c.1681837892.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 10:29:19 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Not all MSI-X devices support dynamic MSI-X allocation. Whether
> a device supports dynamic MSI-X should be queried using
> pci_msix_can_alloc_dyn().
> 
> Instead of scattering code with pci_msix_can_alloc_dyn(),
> probe this ability once and store it as a property of the
> virtual device.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - New patch. (Alex)
> 
>  drivers/vfio/pci/vfio_pci_core.c | 5 ++++-
>  include/linux/vfio_pci_core.h    | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ae0e161c7fc9..a3635a8e54c8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -530,8 +530,11 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		vdev->msix_bar = table & PCI_MSIX_TABLE_BIR;
>  		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
>  		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
> -	} else
> +		vdev->has_dyn_msix = pci_msix_can_alloc_dyn(pdev);
> +	} else {
>  		vdev->msix_bar = 0xFF;
> +		vdev->has_dyn_msix = false;
> +	}
>  
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 148fd1ae6c1c..4f070f2d6fde 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -67,6 +67,7 @@ struct vfio_pci_core_device {
>  	u8			msix_bar;
>  	u16			msix_size;
>  	u32			msix_offset;
> +	bool			has_dyn_msix;
>  	u32			rbar[7];
>  	bool			pci_2_3;
>  	bool			virq_disabled;

Nit, the whole data structure probably needs to be sorted with pahole,
but creating a hole here for locality to other msix fields should
probably be secondary to keeping the structure well packed, which
suggests including this new field among the bools below.  Thanks,

Alex

