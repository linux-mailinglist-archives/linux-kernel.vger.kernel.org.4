Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637367180FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjEaNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjEaNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92D184
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685538301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR1Y7uTlBlZpPpTqhSt6hoa8GuKCXSWN+tjCf5DVvbw=;
        b=FnI/F0xw12R8yP6F6Ne6i4ai1uofKSV+g0KX9O5AcV5mt/MrIEOnAUgeBJcH7r2IMRJMqz
        FRhdRcbpDyg6iNuJZzy784BsNeHDKtj1p1mutXX0KpKlvFIUVETaLShWtghBelsIltYa2n
        ZYdLdwy9cSY2XTD3CijWlQhV+jJxs9Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-faw-0uoGMg2YP5K_qtCeFQ-1; Wed, 31 May 2023 09:01:20 -0400
X-MC-Unique: faw-0uoGMg2YP5K_qtCeFQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edb90ccaadso3112909e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538074; x=1688130074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR1Y7uTlBlZpPpTqhSt6hoa8GuKCXSWN+tjCf5DVvbw=;
        b=S5T2KDoFOiX0MF5BtZMByQxb86NOnlzCbiCY/gDJnMC1Z27chOx8Iuz0fr26JEQgZg
         gR0JXuo5qJ0LQhk03BkHtoh0sh3dykrCgsVusmNGxZrIZKdTvA+yB7XcYjYg8eQ8ROEY
         Tu2IIqunxm9y0sui2TYFZUPydNDqeX0Z0Lqw4+2fBriwB2cYYtTkT31T75VX1+ZogCmh
         TQa3ni9VNz/kp6iudVpCQcTm/AA1bi4L0H7R0lL/cm5JHrTBBLeZTR9Nr9HlbjpA1nHw
         /zr0sj5dme88DyhUFUncfPbGPQxuWzgfqBjASejoUmUxfaynerkhbN3Y5HkYOVc1U5Tx
         RJZQ==
X-Gm-Message-State: AC+VfDx3gdRmmrFfPE04HdAV9ZEYEJjCxojKlYdYs5nkCYHJnXSYPB3a
        RSDw/8RYQu/fkH6KknDrISy9PflYxFvyNKBvuPXZg4Lfdnmow0+RFwzAaUaNXMdz/JwfycElJm+
        ArdBXArCDWAm7JlN1k+eAM8UWNfx+XHRI180=
X-Received: by 2002:ac2:4d16:0:b0:4e7:dd1e:e521 with SMTP id r22-20020ac24d16000000b004e7dd1ee521mr2699472lfi.9.1685538074048;
        Wed, 31 May 2023 06:01:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YCZxJTTNZh6g/t1HiIjoxj6FPMPoopmQRHMqaYgGBEE8GvCQf77HNrvRfeg62Qi4NfxTyQQ==
X-Received: by 2002:ac2:4d16:0:b0:4e7:dd1e:e521 with SMTP id r22-20020ac24d16000000b004e7dd1ee521mr2699467lfi.9.1685538073855;
        Wed, 31 May 2023 06:01:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c059300b003f60119ee08sm24268206wmd.43.2023.05.31.06.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:01:13 -0700 (PDT)
Message-ID: <e7ec6a4c-2eeb-3a08-5add-a06e250162b6@redhat.com>
Date:   Wed, 31 May 2023 15:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] s390/vfio-ap: Wire in the vfio_device_ops request
 callback
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, alex.williamson@redhat.com,
        borntraeger@linux.ibm.com
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
 <20230530223538.279198-4-akrowiak@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230530223538.279198-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 00:35, Tony Krowiak wrote:
> The mdev device is being removed, so pass the request to userspace to
> ask for a graceful cleanup. This should free up the thread that
> would otherwise loop waiting for the device to be fully released.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44f159136891..a8f58e133e6e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1736,6 +1736,26 @@ static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
>   	vfio_ap_mdev_unset_kvm(matrix_mdev);
>   }
>   
> +static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
> +{
> +	struct device *dev = vdev->dev;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
> +
> +	if (matrix_mdev->req_trigger) {
> +		if (!(count % 10))
> +			dev_notice_ratelimited(dev,
> +					       "Relaying device request to user (#%u)\n",
> +					       count);
> +
> +		eventfd_signal(matrix_mdev->req_trigger, 1);
> +	} else if (count == 0) {
> +		dev_notice(dev,
> +			   "No device request registered, blocked until released by user\n");
> +	}
> +}
> +
>   static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   {
>   	unsigned long minsz;
> @@ -1955,6 +1975,7 @@ static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
>   	.bind_iommufd = vfio_iommufd_emulated_bind,
>   	.unbind_iommufd = vfio_iommufd_emulated_unbind,
>   	.attach_ioas = vfio_iommufd_emulated_attach_ioas,
> +	.request = vfio_ap_mdev_request
>   };
>   
>   static struct mdev_driver vfio_ap_matrix_driver = {

