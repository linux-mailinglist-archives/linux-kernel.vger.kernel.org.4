Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAAE6D0FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC3U1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC3U1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB761A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680208022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vt0KFJq/b5KK7W4Ol+edVgEMMqXF5UAxWg/JBmJvnDU=;
        b=hQHTjMsQk8D22rMVjhtm9GE8vntSTZFKsI0hVAxtKkx3YDEsSONIC5CR9tK9K2FmGOaHgq
        ByXwVZXTrO26ikb5vBVRSXrjKjI495q61voCJ6AFtSn0Kys/XPZ8KAk9PfhV0lumZOkb9X
        Ne/tPqQCZ6SPtTHbn3qO6V5ZXLjH4Zk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-bH1hP7k0OyaB6YcY3Ao7iA-1; Thu, 30 Mar 2023 16:27:00 -0400
X-MC-Unique: bH1hP7k0OyaB6YcY3Ao7iA-1
Received: by mail-io1-f71.google.com with SMTP id j4-20020a6b5504000000b00758646159fbso12297051iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt0KFJq/b5KK7W4Ol+edVgEMMqXF5UAxWg/JBmJvnDU=;
        b=llJfMkmomeK/ki/a8JZWCAKMI48c250D9RwfGz1t42TrnB+13jpWmEG+tgyNcgZiTW
         iHtB2BtPAbdaAffOaSKk4TLdTZ4L7EUMy4XCHh03oyjStU7ayOFpznLaagAclmtld95i
         b+57BgeVox6MVo2Izb1niEbedxJU+ez4fAxVlVxYyXVPRf5eBTEHDR2WldJClGH/kqDV
         cCoN+aYxzz7OmNqjyLdlHYneVJbrNXTdSmem3spphv9CYLsTv/lUXkxCXa4cS8Q/0eh8
         W/K9lFZcuPO0xYJHl0LrU2BONezAQ29CyGUxKo6t6yPQ5n+efy0zUOW9B2nUlVTAOJwV
         aE1Q==
X-Gm-Message-State: AAQBX9eSUnhvh7eSRYiVsjXf2MmsBpgdrSKYkz/CjuTWT0ovYoBHg2rR
        UuXX1PBs2+52n22diwFjS3zcikT9qaUAxkisCc9IBfKxxmq8EpUufpqgCMR/EBewDTsAoIuNYoU
        YcL5f0oQ+hEsCzwsRgG+w1UA+
X-Received: by 2002:a05:6e02:686:b0:325:b505:f8f2 with SMTP id o6-20020a056e02068600b00325b505f8f2mr16576443ils.30.1680208019911;
        Thu, 30 Mar 2023 13:26:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQYaVnzgIKA/vjDO7WhZFxUg9kON2oJiWeH/Tmsm7FSPPVzJez1lK1KDotRGL5CgkSrvI4Ew==
X-Received: by 2002:a05:6e02:686:b0:325:b505:f8f2 with SMTP id o6-20020a056e02068600b00325b505f8f2mr16576431ils.30.1680208019647;
        Thu, 30 Mar 2023 13:26:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b14-20020a92340e000000b0032305b53b56sm153537ila.87.2023.03.30.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:26:59 -0700 (PDT)
Date:   Thu, 30 Mar 2023 14:26:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/8] vfio/pci: Remove negative check on unsigned
 vector
Message-ID: <20230330142657.3930c68b.alex.williamson@redhat.com>
In-Reply-To: <0dc2a0c8e25b13a3a41db75ab192f387a1548c80.1680038771.git.reinette.chatre@intel.com>
References: <cover.1680038771.git.reinette.chatre@intel.com>
        <0dc2a0c8e25b13a3a41db75ab192f387a1548c80.1680038771.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Tue, 28 Mar 2023 14:53:29 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> User space provides the vector as an unsigned int that is checked
> early for validity (vfio_set_irqs_validate_and_prepare()).
> 
> A later negative check of the provided vector is not necessary.
> 
> Remove the negative check and ensure the type used
> for the vector is consistent as an unsigned int.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 6a9c6a143cc3..3f64ccdce69f 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -317,14 +317,14 @@ static int vfio_msi_enable(struct vfio_pci_core_device *vdev, int nvec, bool msi
>  }
>  
>  static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> -				      int vector, int fd, bool msix)
> +				      unsigned int vector, int fd, bool msix)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct eventfd_ctx *trigger;
>  	int irq, ret;
>  	u16 cmd;
>  
> -	if (vector < 0 || vector >= vdev->num_ctx)
> +	if (vector >= vdev->num_ctx)
>  		return -EINVAL;
>  
>  	irq = pci_irq_vector(pdev, vector);
> @@ -399,7 +399,8 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  static int vfio_msi_set_block(struct vfio_pci_core_device *vdev, unsigned start,
>  			      unsigned count, int32_t *fds, bool msix)
>  {
> -	int i, j, ret = 0;
> +	int i, ret = 0;
> +	unsigned int j;
>  
>  	if (start >= vdev->num_ctx || start + count > vdev->num_ctx)
>  		return -EINVAL;

Unfortunately this turns the unwind portion of the function into an
infinite loop in the common case when @start is zero:

                for (--j; j >= (int)start; j--)
                        vfio_msi_set_vector_signal(vdev, j, -1, msix);

Thanks,
Alex


> @@ -420,7 +421,7 @@ static int vfio_msi_set_block(struct vfio_pci_core_device *vdev, unsigned start,
>  static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> -	int i;
> +	unsigned int i;
>  	u16 cmd;
>  
>  	for (i = 0; i < vdev->num_ctx; i++) {
> @@ -542,7 +543,7 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>  				    unsigned index, unsigned start,
>  				    unsigned count, uint32_t flags, void *data)
>  {
> -	int i;
> +	unsigned int i;
>  	bool msix = (index == VFIO_PCI_MSIX_IRQ_INDEX) ? true : false;
>  
>  	if (irq_is(vdev, index) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {

