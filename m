Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99A6E6F76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjDRWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjDRWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D39014
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681857527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nt4NAlgjVn3bwVtb59HBkHnV8fhtHInS8+cCLwzW3Oo=;
        b=eplRB4EYd/BRVjPcXlKnIAmoU8v/IJ+6xjqeul0/TKtSP1b0uErY34i3/0cPcUYw/dvhll
        JOFBL4SyTn+1omPMUqHD1hgc60+fPXUTEU1u4VqLuYiP2EiZVkMjZ+fOPTsfCPrvUg6jgi
        8rv7LeW1lA3uQ2eG1IxkSrUuucgqfpM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-z_2VSFFHPHOtmDLQ5vpnfg-1; Tue, 18 Apr 2023 18:38:45 -0400
X-MC-Unique: z_2VSFFHPHOtmDLQ5vpnfg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760da06b86aso189465739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857525; x=1684449525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt4NAlgjVn3bwVtb59HBkHnV8fhtHInS8+cCLwzW3Oo=;
        b=RxIBNnle6Ie8uqjT3BTCWQoCb/prEIqvHhYDOPz48IYv697HnUosK73YexfjHbiuWf
         jrL6ezdXC6qseP4ihYn57y/b5KqIF4R52cc9X6WjuPQJc15hz6v39SnxXLbGFJKk/tJO
         y4zjnKibC6kuWR6BF7lq3aIMYOG3RnXYbY7LKQIweSQpUJ9xqcm2NudT2TT9r4tX3lde
         ZSkOs3SjsojA6StLUDXcCo+zykRcB+IXEC1C+ZrWhHJ5gKN1fFINeO26y9wBU/QYILds
         YaZNNFKsLlNxsjahmBpotuZLbD3/g6UtGvH5V4AmR4UsoqOouWs0Aijz1yifKfhwfoqB
         NubA==
X-Gm-Message-State: AAQBX9c9dV5HXv31JbjdMmrsYjUNfcfx+opEHXjpjMUE0NWKvHx1xDvA
        HsUVJbruUa06eE8nR8AChXIVpoy9iA3aDX4WFakE3yNEKRCNzrrzm41Nbzu1peBu0D1etewNh7L
        04mhVwAblNzPIt1GnMPi0s0Gt
X-Received: by 2002:a5d:80d6:0:b0:760:e9b6:e6da with SMTP id h22-20020a5d80d6000000b00760e9b6e6damr3037664ior.1.1681857525016;
        Tue, 18 Apr 2023 15:38:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350YI7seWtoBWPqYjT1RzndFBvuqrDODhMJ9id2vYXvKT4+TRs/PoewlgjvRH85jDeChhXC2tOQ==
X-Received: by 2002:a5d:80d6:0:b0:760:e9b6:e6da with SMTP id h22-20020a5d80d6000000b00760e9b6e6damr3037642ior.1.1681857524746;
        Tue, 18 Apr 2023 15:38:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d9906000000b007079249a9d1sm4275565iol.34.2023.04.18.15.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:38:44 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:38:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 10/10] vfio/pci: Clear VFIO_IRQ_INFO_NORESIZE for
 MSI-X
Message-ID: <20230418163843.7b4c0366.alex.williamson@redhat.com>
In-Reply-To: <6c057618833a180da2147bffadb98e07cb73e045.1681837892.git.reinette.chatre@intel.com>
References: <cover.1681837892.git.reinette.chatre@intel.com>
        <6c057618833a180da2147bffadb98e07cb73e045.1681837892.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 10:29:21 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Dynamic MSI-X is supported. Clear VFIO_IRQ_INFO_NORESIZE
> to provide guidance to user space.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Use new vdev->has_dyn_msix property instead of calling
>   pci_msix_can_alloc_dyn() directly. (Alex)
> 
> Changes since RFC V1:
> - Only advertise VFIO_IRQ_INFO_NORESIZE for MSI-X devices that
>   can actually support dynamic allocation. (Alex)
> 
>  drivers/vfio/pci/vfio_pci_core.c | 4 +++-
>  include/uapi/linux/vfio.h        | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a3635a8e54c8..4050ad3388c2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1114,7 +1114,9 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>  	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
>  		info.flags |=
>  			(VFIO_IRQ_INFO_MASKABLE | VFIO_IRQ_INFO_AUTOMASKED);
> -	else
> +	else if ((info.index != VFIO_PCI_MSIX_IRQ_INDEX) ||
> +		 (info.index == VFIO_PCI_MSIX_IRQ_INDEX &&
> +		  !vdev->has_dyn_msix))

Isn't this the same as:

	(info.index != VFIO_PCI_MSIX_IRQ_INDEX || !vdev->has_dyn_msix)

Thanks,
Alex

>  		info.flags |= VFIO_IRQ_INFO_NORESIZE;
>  
>  	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 0552e8dcf0cb..1a36134cae5c 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -511,6 +511,9 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
>   * then add and unmask vectors, it's up to userspace to make the decision
>   * whether to allocate the maximum supported number of vectors or tear
>   * down setup and incrementally increase the vectors as each is enabled.
> + * Absence of the NORESIZE flag indicates that vectors can be enabled
> + * and disabled dynamically without impacting other vectors within the
> + * index.
>   */
>  struct vfio_irq_info {
>  	__u32	argsz;

