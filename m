Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60196441CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiLFLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiLFLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360D24BD4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670324455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnhqMeUW5gkAJH3i2M2e0zkZdF9yQL6BjlLwXPeq/ho=;
        b=OuN0bGKRm/+ut9t5sF7TS1aN7ZZRkWWzV35MtWnZgDHT3ZjeCf/85u8P79nlJH12OEuakE
        1la6Nz/8gs6T92XCgKdRNeJQ+0I1tcX+81QTCieuDzbckvqBrKj50J6GrBc1RXX4W++sYy
        nMdT1b7dx7s7Jw8idNkbGqUI6a+58wQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-p3LsUzXXNTGNnfBKPinOTg-1; Tue, 06 Dec 2022 06:00:54 -0500
X-MC-Unique: p3LsUzXXNTGNnfBKPinOTg-1
Received: by mail-qv1-f71.google.com with SMTP id nh17-20020a056214391100b004bb6c16bd4dso33213265qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 03:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnhqMeUW5gkAJH3i2M2e0zkZdF9yQL6BjlLwXPeq/ho=;
        b=IddmH0ytiyq+dRjJCi24qL1wmKoRIcOfBhau5Qze+MOUjwhOgt/FkBEeZ1cBsygigO
         QW2jBB2A7K6hLHL23+9YGEMXzot+LXJAcMS0L6wXHwcM6cHWM24V/uyGkXpqzAjxa6eB
         gs2rJvy6XpkmYx0lu2wahN9NUPq+cDCgutIVGiwTb/OtybmuZEGS4D8QMXywIRlgvveG
         pbnoZKvQ3wo0txZn7U9R7ceMnjIoIY2Bpyu0czx6ol8iiV1eJvoWrGXceq59N8zhDB/N
         UL5L3ZZIKcDgw7TGs89NiaX8hDrBlmfhZXq3stf4EtX7CFubc6DIYRPyCWWmeZ4qkEG/
         Nxew==
X-Gm-Message-State: ANoB5pnQ/k8ns6YmaG1UctZf4OrO8B2xlHN4HMMpAVS+AVUO3nmXwHYP
        UE/hUw8J6TkjALjnfqV7OlDZe0/wBrhYWtBb36nkayX/jW+u/GYxwyAzxidXSJswNZfG6MU0zi+
        YyU26kACIFPy4suoQ/xmmhUrC
X-Received: by 2002:a05:6214:170d:b0:4c7:4add:6123 with SMTP id db13-20020a056214170d00b004c74add6123mr14971769qvb.100.1670324453406;
        Tue, 06 Dec 2022 03:00:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6O4cvnwiNG/1UoAXIkBQIklV5lMHMzKytVq4RHoVXR9XHDwZ6NxwUPqwnijsvhRUZGuVdF0g==
X-Received: by 2002:a05:6214:170d:b0:4c7:4add:6123 with SMTP id db13-20020a056214170d00b004c74add6123mr14971755qvb.100.1670324453175;
        Tue, 06 Dec 2022 03:00:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id dm12-20020a05620a1d4c00b006fb11eee465sm14082021qkb.64.2022.12.06.03.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:00:52 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:00:40 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        eperezma@redhat.com, cohuck@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vp_vdpa: harden the logic of set status
Message-ID: <20221206110040.q5i2k7ypojuira2e@sgarzare-redhat>
References: <20221206021321.2400-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221206021321.2400-1-longpeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 10:13:21AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>   trigger a warning in that case.
>
>2. The driver MUST wait for a read of device_status to return 0 before
>   reinitializing the device. But we also don't want to keep us in an
>   infinite loop forever, so wait for 5s if we try to reset the device.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
>Changes v1->v2:
>  - use WARN_ON instead of BUG_ON. [Stefano]
>  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>  - use usleep_range instead of msleep (checkpatch). [Longpeng]
>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index 13701c2a1963..a2d3b13ac646 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -214,6 +214,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> 	u8 s = vp_vdpa_get_status(vdpa);
>
>+	/* We should never be setting status to 0. */
>+	WARN_ON(status == 0);
>+
> 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> 		vp_vdpa_request_irq(vp_vdpa);
>@@ -222,14 +225,33 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> 	vp_modern_set_status(mdev, status);
> }
>
>+#define VP_VDPA_RESET_TMOUT_MS 5000 /* 5s */

What about moving this define on top of this file?
Near the other macro.

And I would use TIMEOUT entirely.

>+
> static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
> {
> 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> 	u8 s = vp_vdpa_get_status(vdpa);
>+	unsigned long timeout;
>
> 	vp_modern_set_status(mdev, 0);
>
>+	/*
>+	 * As the virtio v1.1 spec (4.1.4.3.2) says: After writing 0 to

I think we can refer to the lates v1.2 (the section should be the same).

>+	 * device_status, the driver MUST wait for a read of device_status
>+	 * to return 0 before reinitializing the device.
>+	 * To avoid keep us here forever, we only wait for 5 seconds.
>+	 */
>+	timeout = jiffies + msecs_to_jiffies(VP_VDPA_RESET_TMOUT_MS);
>+	while (vp_modern_get_status(mdev)) {
>+		usleep_range(1000, 1500);
>+		if (time_after(jiffies, timeout)) {
>+			dev_err(&mdev->pci_dev->dev,
>+				"vp_vdpa: fail to reset device\n");
>+			return -ETIMEDOUT;
>+		}
>+	}
>+
> 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> 		vp_vdpa_free_irq(vp_vdpa);
>
>-- 
>2.23.0
>

The rest LGTM!

Thanks,
Stefano

