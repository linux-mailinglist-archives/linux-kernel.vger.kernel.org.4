Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C965CD5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjADGvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjADGu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DB186
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672815010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vea5lJTy+gjY/3+KcsOMv2NJYNGUHXdzcZ168NbAmUY=;
        b=Wv6JQyDu10gg1/xCdJl5x3SeNXtg8Gfku7XCsqyCcfG5j0T+DM6kkBmD/RDpj7fY4p12RY
        v+2cIbmNcWIR2Robt5c/4UXaqBW2Ap6qkj4fjM9YYcY1bfNzKCHuFNUQr0c6JN7tQoGsvK
        JqZC8cpFHdgtdKq3HY/PQaSAOiNlQh4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-p_odDzc-O7mW7dwnigl5gQ-1; Wed, 04 Jan 2023 01:50:09 -0500
X-MC-Unique: p_odDzc-O7mW7dwnigl5gQ-1
Received: by mail-wr1-f70.google.com with SMTP id i26-20020adfaada000000b0027c76c49445so2830689wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vea5lJTy+gjY/3+KcsOMv2NJYNGUHXdzcZ168NbAmUY=;
        b=UADWO5AWsnaUAZkmB26RS7Oz3xdi/VrTN3FPgoDh6/OHV/Iz05N6KKfc1HIFQbrgKs
         5Fsc/LOqMhMRGEF0k6Vwk9JU2lFCPmT79WbXknbqhBJHEYzEgIylhmHaOC3kwAzwABrO
         kakHRiywYL+KYVXTaOq9cTJU2wJ0yU0hQ/IFeE6TX5dvfLSSdTmT0mZirypCvMzoZr9n
         8eCNbKMP9Jkne8m5ZdtLptoKGETccBLjBJ73pffakFNeMQlhiI/C5YsosycSjbsXe8VP
         +IKvcRKFIE1Z3ahSXHhw2zxCtW5fvUUJnbHZ8rLLsmM/2Q+HbPPdg3kvnOHt+T4k+E9+
         Om3A==
X-Gm-Message-State: AFqh2kpluxCPpdPsL46TLwM24dDVBagKBEf6fIlL+gOT7oq5jJ1TWvRJ
        A19ZP1UyF1aBF7hQnK1gHAQD7Gpz1nlgIh9ckQ17MxvRplTip6NDbGpniFBANaMsPlKp4FnMkfQ
        LxHLUIS754go/Xn1IJCT28EpR
X-Received: by 2002:adf:c648:0:b0:275:618c:83ea with SMTP id u8-20020adfc648000000b00275618c83eamr28049813wrg.29.1672815007869;
        Tue, 03 Jan 2023 22:50:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7g0bFTzdYAfQahFXgYRuRC8zuN09it3a2IlDnQW6kW1CpENpFCTTXq5lgReA9X3HF3QEWlg==
X-Received: by 2002:adf:c648:0:b0:275:618c:83ea with SMTP id u8-20020adfc648000000b00275618c83eamr28049798wrg.29.1672815007650;
        Tue, 03 Jan 2023 22:50:07 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b00282194eaf7bsm22977814wrq.71.2023.01.03.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:50:07 -0800 (PST)
Date:   Wed, 4 Jan 2023 01:50:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     jasowang@redhat.com, sgarzare@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vp_vdpa: harden the logic of set status
Message-ID: <20230104014642-mutt-send-email-mst@kernel.org>
References: <20230104042519.170-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104042519.170-1-longpeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:25:19PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>    trigger a warning in that case.
> 
> 2. The driver MUST wait for a read of device_status to return 0 before
>    reinitializing the device. But we also don't want to keep us in an
>    infinite loop forever, so wait for 5s if we try to reset the device.
> 
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v3->v2:
>  - move VP_VDPA_RESET_TIMEOUT_US near the other macros. [Stefano]
>  - refer v1.2 in comments. [Stefano]
>  - s/keep/keeping/  [Jason]
>  - use readx_poll_timeout. [Jason]
> 
> Changes v1->v2:
>  - use WARN_ON instead of BUG_ON. [Stefano]
>  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>  - use usleep_range instead of msleep (checkpatch). [Longpeng]
> 
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index d448db0c4de3..3fc496aea456 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  #include <linux/pci.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio.h>
> @@ -22,6 +23,7 @@
>  #define VP_VDPA_QUEUE_MAX 256
>  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>  #define VP_VDPA_NAME_SIZE 256
> +#define VP_VDPA_RESET_TIMEOUT_US 5000000 /* 5s */
>  
>  struct vp_vring {
>  	void __iomem *notify;
> @@ -214,6 +216,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>  	u8 s = vp_vdpa_get_status(vdpa);
>  
> +	/* We should never be setting status to 0. */
> +	WARN_ON(status == 0);
> +
>  	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>  	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>  		vp_vdpa_request_irq(vp_vdpa);

Isn't this user-triggerable? What prevents that?

> @@ -226,10 +231,25 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>  {
>  	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>  	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> -	u8 s = vp_vdpa_get_status(vdpa);
> +	u8 tmp, s = vp_vdpa_get_status(vdpa);
> +	int ret;
>  
>  	vp_modern_set_status(mdev, 0);
>  
> +	/*
> +	 * As the virtio v1.1/v1.2 spec (4.1.4.3.2) says: After writing 0 to
> +	 * device_status, the driver MUST wait for a read of device_status
> +	 * to return 0 before reinitializing the device.
> +	 * To avoid keeping us here forever, we only wait for 5 seconds.
> +	 */
> +	ret = readx_poll_timeout(vp_ioread8, &mdev->common->device_status, tmp,
> +				 tmp == 0, 1000, VP_VDPA_RESET_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(&mdev->pci_dev->dev,
> +			"vp_vdpa: fail to reset device, %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>  		vp_vdpa_free_irq(vp_vdpa);

Do all callers actually check return status of reset?
If not they will happily reinitialize the device and violate the spec.



> -- 
> 2.23.0

