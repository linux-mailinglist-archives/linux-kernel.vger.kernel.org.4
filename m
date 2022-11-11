Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215D625E19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKKPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiKKPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC982912
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668179712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFfjRSX6x+xXHoXLdolT6LJnuObdR7C+VEPrQ+OyqAA=;
        b=PuDKI9vinHA12koPLu+7olOnuPzMjThZtovRz8oOo5A33pvIm3qddwpTve8FGEcXG0o2/f
        n1CVkVkoX470JTKtvUY55mykOg0OmDNeDfVyOaZkPBsiObKiomAPZ+VuCNo8ZtLt093ARo
        BWz+jvL5AKEVGMOwffjxThHV+DSkKcE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-s-Y2A5D4P6K1BaiOaTjjOg-1; Fri, 11 Nov 2022 10:15:11 -0500
X-MC-Unique: s-Y2A5D4P6K1BaiOaTjjOg-1
Received: by mail-qk1-f200.google.com with SMTP id q14-20020a05620a0d8e00b006ef0350dae1so4932739qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFfjRSX6x+xXHoXLdolT6LJnuObdR7C+VEPrQ+OyqAA=;
        b=miW7nEFqBqJYSvuQsgeTT3rmiGzXuPs+6+2r46sXMerEDp0fexEeMN+9o/b8f3rf1H
         dO6baL33aOAJ2f/DIkAbZvT6snj0VO3xZkeML+qwiRkbjloF7Kboz03Pdd8ZN9EplBgn
         6P8GZagkYjpO0UFIJVW2HI3CS2f0lFjFbOLmbWfef6lA3Abad1u+3Ifr6Nk/C1vAO8ys
         2qWJnciNAXN6TxOf2biM05mPUk1zu6L9nPJfreqiEWwKYXeBx3IBdDYkfCvIFQxmzDzz
         iaIT1IpTwZ31kC93d5eDs+TfAeNSyogY6XDozL8CAukQkevlksEFfopelTmV91R/3TfU
         DxBg==
X-Gm-Message-State: ANoB5pmilA/SmIc2pmzupyLsc5YitsTWn1GiyxJLlPAKt9DsddPDI2E/
        ExT7MhGkwtF3ERvPuQ02WUUTdiTz7X7VcC/bl6fb8i1UeZkucOTWll4bRv634ejOugRrmujNkvo
        Axo7VJH65Ho0SQnzBUdUdT88X
X-Received: by 2002:ae9:f815:0:b0:6fa:2b22:ff3e with SMTP id x21-20020ae9f815000000b006fa2b22ff3emr1360149qkh.200.1668179710677;
        Fri, 11 Nov 2022 07:15:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vYL/+fo+qZqe8owiSVEkcRSV/WH8SUV6pATe7L3qLNPu68l1cgYhGGZAQ62WVFvh21qKR/A==
X-Received: by 2002:ae9:f815:0:b0:6fa:2b22:ff3e with SMTP id x21-20020ae9f815000000b006fa2b22ff3emr1360121qkh.200.1668179710380;
        Fri, 11 Nov 2022 07:15:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id ga16-20020a05622a591000b003a598fcddefsm1375111qtb.87.2022.11.11.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:15:09 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:14:59 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        linux-kernel@vger.kernel.org, xiehong@huawei.com
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
Message-ID: <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
References: <20221111145505.1232-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221111145505.1232-1-longpeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:55:05PM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>1. We should not set status to 0 when invoking vp_vdpa_set_status().
>
>2. The driver MUST wait for a read of device_status to return 0 before
>   reinitializing the device.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index d448db0c4de3..d35fac5cde11 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> {
> 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>-	u8 s = vp_vdpa_get_status(vdpa);

Is this change really needed?

>+	u8 s;
>+
>+	/* We should never be setting status to 0. */
>+	BUG_ON(status == 0);

IMHO panicking the kernel seems excessive in this case, please use 
WARN_ON and maybe return earlier.

>
>+	s = vp_vdpa_get_status(vdpa);
> 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> 		vp_vdpa_request_irq(vp_vdpa);
>@@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
> 	u8 s = vp_vdpa_get_status(vdpa);
>
> 	vp_modern_set_status(mdev, 0);
>+	/* After writing 0 to device_status, the driver MUST wait for a read of
>+	 * device_status to return 0 before reinitializing the device.
>+	 */
>+	while (vp_modern_get_status(mdev))
>+		msleep(1);

Should we set a limit after which we give up? A malfunctioning device 
could keep us here forever.

Thanks,
Stefano

>
> 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> 		vp_vdpa_free_irq(vp_vdpa);
>-- 
>2.23.0
>

