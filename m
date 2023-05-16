Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E12705AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjEPWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjEPWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5333C00
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684277605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss0pPdFOewpkZHx2T3QpB5km0Ro73ZOgGxvoEbK/oys=;
        b=TQm5TAHdFAoY79i1Oz2h0avRiTfKSqfgiHAkT2orWAJiKNXCRmJ5Da6zXw878XOHN/6UbI
        SlS4bV4iThXzDY++Zgue4XZqIKlTfCHnlQhHRUxm4HLq6ieCp8dEbX1d0e0lRQlE5S2GFo
        UTGxcEv2PnyWJcut/WnY7AiFF9fgV1c=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-DxxXZaHsPymJH9wQJ1SY2Q-1; Tue, 16 May 2023 18:53:24 -0400
X-MC-Unique: DxxXZaHsPymJH9wQJ1SY2Q-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32b5ec09cffso769565ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684277604; x=1686869604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss0pPdFOewpkZHx2T3QpB5km0Ro73ZOgGxvoEbK/oys=;
        b=KdVFmBFs+4k8RnNBgwzS7g6ZE3shGWHVpf6ZDwueWdcFN8/YaiBYsqW8qNTpqjOSDU
         eYT8ckkLvvVzTXLdW/SLi+41wCeoBdY7KvTvSWfxTY6o8jGBbcq+yY95YoonhbPXiJUc
         gCQpG/p5X9+aUxLC7ZG+z2SfFvhBCAA9vbjNk+5UOHnj0UjKI1JK6hD/mXdcY5xRCaNB
         cvKMBwwVQxgE7wbOGciuRoXi1A/BHqRGY51kOufGQsUGz0luXFUBK4+h/gH0TDyX8vtU
         qLO1PxQrHbF8plG5VTF/x0BZ/38sobmcZRVhxa+lhOyKh/TLcy/m1kxi192urE9QgZs7
         ztZg==
X-Gm-Message-State: AC+VfDw8s+GtSe7UZv5h8fMaKyBipeKYM9I8biLm4SVUK5XOF2ZLaVaF
        njAbvRDPqGBxupFUuH8mkBntmKDCx7im6xsSMoqbpFuUbo/NcXiDwHcbAMuGZjOBWTUPkT1GGth
        poOAn3jlg3l+g+BBT1j1ejuJo
X-Received: by 2002:a92:d70e:0:b0:331:45e5:7eb4 with SMTP id m14-20020a92d70e000000b0033145e57eb4mr488682iln.8.1684277603534;
        Tue, 16 May 2023 15:53:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fpANkITD6op5AHWN6yBz8DB2WTjb/xxFk/WaISkGfqMQwFcV3PIer4KT9w9F11idIcYp4qA==
X-Received: by 2002:a92:d70e:0:b0:331:45e5:7eb4 with SMTP id m14-20020a92d70e000000b0033145e57eb4mr488673iln.8.1684277603187;
        Tue, 16 May 2023 15:53:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m16-20020a92d710000000b0032e1f94be7bsm3606691iln.33.2023.05.16.15.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:53:22 -0700 (PDT)
Date:   Tue, 16 May 2023 16:53:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 00/11] vfio/pci: Support dynamic allocation of MSI-X
 interrupts
Message-ID: <20230516165320.229b4928.alex.williamson@redhat.com>
In-Reply-To: <cover.1683740667.git.reinette.chatre@intel.com>
References: <cover.1683740667.git.reinette.chatre@intel.com>
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

On Thu, 11 May 2023 08:44:27 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Changes since V4:
> - V4: https://lore.kernel.org/lkml/cover.1682615447.git.reinette.chatre@intel.com/
> - Add Kevin's Reviewed-by tag as applicable.
> - Treat non-existing INTx interrupt context as kernel bug with WARN. This
>   exposed an issue in the scenario where INTx mask/unmask may occur without
>   INTx enabled. This is fixed by obtaining the interrupt context later
>   (right before use) within impacted functions: vfio_pci_intx_mask() and
>   vfio_pci_intx_unmask_handler(). (Kevin)
> - Treat pci_irq_vector() returning '0' for a MSI/MSI-X interrupt as a kernel
>   bug via a WARN instead of ignoring this value. (Kevin)
> - Improve accuracy of comments. (Kevin)
> - Please refer to individual patches for local changes.

Looks good to me.

Kevin, do you want to add any additional reviews or check the changes
made based on your previous comments?

Thanks,
Alex

 
> Changes since V3:
> - V3: https://lore.kernel.org/lkml/cover.1681837892.git.reinette.chatre@intel.com/
> - Be considerate about layout and size with changes to
>   struct vfio_pci_core_device. Keep flags together and transition all to
>   use bitfields. (Alex and Jason)
> - Do not free dynamically allocated interrupts on error path. (Alex)
> - Please refer to individual patches for localized changes.
> 
> Changes since V2:
> - V2: https://lore.kernel.org/lkml/cover.1680038771.git.reinette.chatre@intel.com/
> - During testing of V2 "kernel test robot" reported issues resulting from
>   include/linux/pci.h missing a stub for pci_msix_can_alloc_dyn() when
>   CONFIG_PCI_MSI=n. A separate fix was sent to address this. The fix can
>   be found in the kernel (since v6.3-rc7) as
>   commit 195d8e5da3ac ("PCI/MSI: Provide missing stub for pci_msix_can_alloc_dyn()")
> - Biggest change is the transition to "active contexts" for both MSI and MSI-X.
>   Interrupt contexts have always been allocated when the interrupts are
>   allocated while they are only used while interrupts are
>   enabled. In this series interrupt contexts are made dynamic, while doing
>   so their allocation is moved to match how they are used: allocated when
>   interrupts are enabled. Whether a Linux interrupt number exists determines
>   whether an interrupt can be enabled.
>   Previous policy (up to V2) that an allocated interrupt has an interrupt
>   context no longer applies. Instead, an interrupt context has a
>   handler/trigger, aka "active contexts". (Alex)
> - Re-ordered patches in support of "active contexts".
> - Only free interrupts on MSI-X teardown and otherwise use the
>   allocated interrupts as a cache. (Alex)
> - Using unsigned int for the vector broke the unwind loop within
>   vfio_msi_set_block(). (Alex)
> - Introduce new "has_dyn_msix" property of virtual device instead of
>   querying support every time. (Alex)
> - Some smaller changes, please refer to individual patches.
> 
> Changes since RFC V1:
> - RFC V1: https://lore.kernel.org/lkml/cover.1678911529.git.reinette.chatre@intel.com/
> - Improved changelogs.
> - Simplify interface so that vfio_irq_ctx_alloc_single() returns pointer to
>   allocated context. (Alex)
> - Remove vfio_irq_ctx_range_allocated() and associated attempts to maintain
>   invalid error path behavior. (Alex and Kevin)
> - Add pointer to interrupt context as function parameter to
>   vfio_irq_ctx_free(). (Alex)
> - Ensure variables are initialized. (Dan Carpenter)
> - Only support dynamic allocation if device supports it. (Alex)
> 
> Qemu allocates interrupts incrementally at the time the guest unmasks an
> interrupt, for example each time a Linux guest runs request_irq().
> 
> Dynamic allocation of MSI-X interrupts was not possible until v6.2 [1].
> This prompted Qemu to, when allocating a new interrupt, first release all
> previously allocated interrupts (including disable of MSI-X) followed
> by re-allocation of all interrupts that includes the new interrupt.
> Please see [2] for a detailed discussion about this issue.
> 
> Releasing and re-allocating interrupts may be acceptable if all
> interrupts are unmasked during device initialization. If unmasking of
> interrupts occur during runtime this may result in lost interrupts.
> For example, consider an accelerator device with multiple work queues,
> each work queue having a dedicated interrupt. A work queue can be
> enabled at any time with its associated interrupt unmasked while other
> work queues are already active. Having all interrupts released and MSI-X
> disabled to enable the new work queue will impact active work queues.
> 
> This series builds on the recent interrupt sub-system core changes
> that added support for dynamic MSI-X allocation after initial MSI-X
> enabling.
> 
> Add support for dynamic MSI-X allocation to vfio-pci. A flag
> indicating lack of support for dynamic allocation already exist:
> VFIO_IRQ_INFO_NORESIZE and has always been set for MSI and MSI-X. With
> support for dynamic MSI-X the flag is cleared for MSI-X when supported,
> enabling Qemu to modify its behavior.
> 
> Any feedback is appreciated
> 
> Reinette
> 
> [1] commit 34026364df8e ("PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X")
> [2] https://lore.kernel.org/kvm/MWHPR11MB188603D0D809C1079F5817DC8C099@MWHPR11MB1886.namprd11.prod.outlook.com/#t
> 
> Reinette Chatre (11):
>   vfio/pci: Consolidate irq cleanup on MSI/MSI-X disable
>   vfio/pci: Remove negative check on unsigned vector
>   vfio/pci: Prepare for dynamic interrupt context storage
>   vfio/pci: Move to single error path
>   vfio/pci: Use xarray for interrupt context storage
>   vfio/pci: Remove interrupt context counter
>   vfio/pci: Update stale comment
>   vfio/pci: Use bitfield for struct vfio_pci_core_device flags
>   vfio/pci: Probe and store ability to support dynamic MSI-X
>   vfio/pci: Support dynamic MSI-X
>   vfio/pci: Clear VFIO_IRQ_INFO_NORESIZE for MSI-X
> 
>  drivers/vfio/pci/vfio_pci_core.c  |   8 +-
>  drivers/vfio/pci/vfio_pci_intrs.c | 305 ++++++++++++++++++++----------
>  include/linux/vfio_pci_core.h     |  26 +--
>  include/uapi/linux/vfio.h         |   3 +
>  4 files changed, 229 insertions(+), 113 deletions(-)
> 
> 
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4

