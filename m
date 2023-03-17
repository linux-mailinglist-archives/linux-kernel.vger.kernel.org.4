Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19D66BF5F2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCQXFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCQXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269182411F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679094114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/94TvF1Fz70m6qlCXlMjPstFPPIdfGfUyWnvmD7eY/k=;
        b=dGQA0xCd82lKbdyRQQxuyw0/S2k8/ZHtwuFDgZjVpxXcz056Zp3d28mmfeNyJ7uVJQEUN1
        pH+sFOBfgHEAo5iU+AH8RVhublmjoeRv8DbCDaVTr4H452gKB+WHHPPtE0iAtfXwCwt8Td
        E/aVkyzcosAFjBl8Wco/mf5eSb8vLlg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-zJaOCNx3NX-bvWJQm6EagA-1; Fri, 17 Mar 2023 19:01:52 -0400
X-MC-Unique: zJaOCNx3NX-bvWJQm6EagA-1
Received: by mail-io1-f72.google.com with SMTP id w4-20020a5d9604000000b0074d326b26bcso3152135iol.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/94TvF1Fz70m6qlCXlMjPstFPPIdfGfUyWnvmD7eY/k=;
        b=ag3ykqV5E4vyUVSNfmuIKilHr2KLRyXc/dg4H7nfOndPlZP4xk3R0XXYz+IDDCKXPj
         OZ5Sv7raOW10ky+XlZejq5syQmGHCPA3n5hAgqSWv0sGOnqxkoGGAZCVPiB9nf0OiOU1
         KusNhWgPMu9Yz8K2RxlYjeJd75ss9JPONP1Jx8INN0q5a9UHBEAl/0t4QBAp2wIl8xFY
         7VZZtQTq/mgRAkv0f71v9q4qSUBhvyePkWrH+tpVgT3u0v38ucr1ZNcRkeYkhhcFutl+
         c+CTc+oQIOSOfmFVJaVxOzVvP6rP0ILYuuBMwOoTMxC57r2kll1D47hRa0U9+PLnF4+8
         jxpw==
X-Gm-Message-State: AO0yUKUzSFuvMlTNxk92J4QdJ/vX6276NgHDd0EyeFBB58oHdNGuhOjL
        2AAvu7DjTpQLXDYb3N9XdtIk5NHsqM6sCf54gnN2B9ZWL5Xui+mWcEm8Z5hQypuKD+H/KZmLH9V
        eGXBJHM4pGRtwUIflRVv0hxXR
X-Received: by 2002:a05:6602:2d48:b0:74c:aa8f:1f4c with SMTP id d8-20020a0566022d4800b0074caa8f1f4cmr83636iow.8.1679094111820;
        Fri, 17 Mar 2023 16:01:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set/hbFFjQroE25o0w5nOwPNstS/VaKl1roJN/8GNmSHqgvSJ7cCNhJuZdIIDqtRxBMOhkL0k4g==
X-Received: by 2002:a05:6602:2d48:b0:74c:aa8f:1f4c with SMTP id d8-20020a0566022d4800b0074caa8f1f4cmr83629iow.8.1679094111540;
        Fri, 17 Mar 2023 16:01:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k27-20020a02335b000000b003eafd76dc3fsm1099612jak.23.2023.03.17.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:01:50 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:01:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     <jgg@nvidia.com>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <tglx@linutronix.de>, <darwi@linutronix.de>, <kvm@vger.kernel.org>,
        <dave.jiang@intel.com>, <jing2.liu@intel.com>,
        <ashok.raj@intel.com>, <fenghua.yu@intel.com>,
        <tom.zanussi@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 8/8] vfio/pci: Clear VFIO_IRQ_INFO_NORESIZE for
 MSI-X
Message-ID: <20230317170149.2be79d5a.alex.williamson@redhat.com>
In-Reply-To: <61296e93-6268-05cd-e876-680e07645a16@intel.com>
References: <cover.1678911529.git.reinette.chatre@intel.com>
        <549e6300c0ea011cdce9a2712d49de4efd3a06b7.1678911529.git.reinette.chatre@intel.com>
        <20230317150554.6bf92337.alex.williamson@redhat.com>
        <61296e93-6268-05cd-e876-680e07645a16@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 15:21:09 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Alex,
> 
> On 3/17/2023 2:05 PM, Alex Williamson wrote:
> > On Wed, 15 Mar 2023 13:59:28 -0700
> > Reinette Chatre <reinette.chatre@intel.com> wrote:
> >   
> >> Dynamic MSI-X is supported. Clear VFIO_IRQ_INFO_NORESIZE
> >> to provide guidance to user space.
> >>
> >> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >> ---
> >>  drivers/vfio/pci/vfio_pci_core.c | 2 +-
> >>  include/uapi/linux/vfio.h        | 3 +++
> >>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index ae0e161c7fc9..1d071ee212a7 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1111,7 +1111,7 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
> >>  	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
> >>  		info.flags |=
> >>  			(VFIO_IRQ_INFO_MASKABLE | VFIO_IRQ_INFO_AUTOMASKED);
> >> -	else
> >> +	else if (info.index != VFIO_PCI_MSIX_IRQ_INDEX)
> >>  		info.flags |= VFIO_IRQ_INFO_NORESIZE;
> >>    
> > 
> > I think we need to check pci_msix_can_alloc_dyn(), right?  Thanks,  
> 
> Can pci_msix_can_alloc_dyn() ever return false?
> 
> I cannot see how pci_msix_can_alloc_dyn() can return false when
> considering the VFIO PCI MSI-X flow:
> 
> vfio_msi_enable(..., ..., msix == true) 
>   pci_alloc_irq_vectors(..., ..., ..., flag == PCI_IRQ_MSIX) 
>     pci_alloc_irq_vectors_affinity() 
>       __pci_enable_msix_range() 
>         pci_setup_msix_device_domain() 
>           pci_create_device_domain(..., &pci_msix_template, ...)
> 
> The template used above, pci_msix_template, has MSI_FLAG_PCI_MSIX_ALLOC_DYN
> hardcoded. This is the flag that pci_msix_can_alloc_dyn() tests for.
> 
> If indeed pci_msix_can_alloc_dyn() can return false in the VFIO PCI MSI-X
> usage then this series needs to be reworked to continue supporting
> existing allocation mechanism as well as dynamic MSI-X allocation. Which
> allocation mechanism to use would be depend on pci_msix_can_alloc_dyn().
> 
> Alternatively, if you agree that VFIO PCI MSI-X can expect
> pci_msix_can_alloc_dyn() to always return true then I should perhaps
> add a test in vfio_msi_enable() that confirms this is the case. This would
> cause vfio_msi_enable() to fail if dynamic MSI-X is not possible, perhaps even
> complain loudly with a WARN.

pci_setup_msix_device_domain() says it returns true if:

 *  True when:
 *      - The device does not have a MSI parent irq domain associated,
 *        which keeps the legacy architecture specific and the global
 *        PCI/MSI domain models working
 *      - The MSI-X domain exists already
 *      - The MSI-X domain was successfully allocated

That first one seems concerning, dynamic allocation only works on irq
domain configurations.  What does that exclude and do we care about any
of them for vfio-pci?  Minimally this suggests a dependency on
IRQ_DOMAIN, which we don't currently have, but I'm not sure if
supporting irq domains is the same as having irq domains.  Thanks,

Alex

