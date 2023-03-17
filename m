Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0546BF380
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCQVGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCQVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92335EDF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679087160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eidmj2t5TVoRe5Cww+imZv9w1awTSYIIENbJ4rDkOhQ=;
        b=MpfBUbTkzer3uekQFTWeeYs5fdNhXle0Q1aNe1XhDcWbQj0Cb7kc8X9m6kXADxVcDmxWMy
        UV2DCsDnGLVR/D/z91XCZRW0viMzY+z1EsAqplYGvoX7WTN18YflX3f9/v8ejSOPFjvbI2
        Q7pHSUf5ycN+CRYmqlf6JSdLBxIrrJk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-rrbOpTDjM0uiEUhhGr1avg-1; Fri, 17 Mar 2023 17:05:57 -0400
X-MC-Unique: rrbOpTDjM0uiEUhhGr1avg-1
Received: by mail-io1-f69.google.com with SMTP id t15-20020a5d848f000000b00750c83214cbso3034827iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087156;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eidmj2t5TVoRe5Cww+imZv9w1awTSYIIENbJ4rDkOhQ=;
        b=D3lUhv/jWhGMDCEediZqKnv4BZRlvJtvz9qyIMV4Ktb6ehaTaafPFfiwILPnU810X5
         XOK3rnaxRelQGlw09BRITwy5pT0Z+6mRI4jor5p8jo4zZb7XVrVg5MPT3gc/MQnvVb4E
         SLAfJp50uUX1yGARjTV9ZntVxXZzMG4vgh8oPidEz1sgVwn3NYFwOni5mt9OUW3LsEGs
         z9oryAk1YzCwPWm2TxhnDyNKlYlejp49YD4yZ+20kXMCBOjC4r695GgbPdt84wQgi/vO
         iHwUSeY4yOToyOYTe2xiJyMuTInODNUhE3PGXlgIMsghCt+blnYJImXJGf6QvmprCwma
         qYew==
X-Gm-Message-State: AO0yUKXUhso7creDTpJkhiKTpwrWOuLN81JWSamsaWjAis0GoGo2DKHg
        jsGpaZQnTQD0uxzpRMpW4YTDOOdungnbntzlkB23ZrV/uB8ReFb3UPu0sY9jmW8/1ICj50XPaqU
        7V7GhTCRq6VFjB6pduqVuKGaw
X-Received: by 2002:a6b:8d47:0:b0:753:2226:952f with SMTP id p68-20020a6b8d47000000b007532226952fmr425409iod.0.1679087156513;
        Fri, 17 Mar 2023 14:05:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set+So9gahls2z5yZEpRsrtKxEhpOy+No/75PWnKI5IE9eadLO71kVBn+/GbMEDS6TWTNSole2g==
X-Received: by 2002:a6b:8d47:0:b0:753:2226:952f with SMTP id p68-20020a6b8d47000000b007532226952fmr425387iod.0.1679087156158;
        Fri, 17 Mar 2023 14:05:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o19-20020a02a1d3000000b003a0565a5750sm970769jah.119.2023.03.17.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:05:55 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:05:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] vfio/pci: Clear VFIO_IRQ_INFO_NORESIZE for
 MSI-X
Message-ID: <20230317150554.6bf92337.alex.williamson@redhat.com>
In-Reply-To: <549e6300c0ea011cdce9a2712d49de4efd3a06b7.1678911529.git.reinette.chatre@intel.com>
References: <cover.1678911529.git.reinette.chatre@intel.com>
        <549e6300c0ea011cdce9a2712d49de4efd3a06b7.1678911529.git.reinette.chatre@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 13:59:28 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Dynamic MSI-X is supported. Clear VFIO_IRQ_INFO_NORESIZE
> to provide guidance to user space.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 2 +-
>  include/uapi/linux/vfio.h        | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ae0e161c7fc9..1d071ee212a7 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1111,7 +1111,7 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>  	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
>  		info.flags |=
>  			(VFIO_IRQ_INFO_MASKABLE | VFIO_IRQ_INFO_AUTOMASKED);
> -	else
> +	else if (info.index != VFIO_PCI_MSIX_IRQ_INDEX)
>  		info.flags |= VFIO_IRQ_INFO_NORESIZE;
>  

I think we need to check pci_msix_can_alloc_dyn(), right?  Thanks,

Alex

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

