Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49E63C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiK2Txn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK2Txl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC5FAE5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669751564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0LHlDBeIbC0trt454N6iCOu40POMMvW1sX+cWMEbNI=;
        b=OqEH1bwPP8G200zVC23PMEqYtKHPV7ubSENNWBOvkjADefA1LqBvhWoSXf36Iuv8h/uZLu
        c927KEC7Uu4+qtkWpYzQBUqr6HvistbKJ0OUC+bI4UWkK3FUOOcTC+ZdN8fw96NnILfy7T
        roXQ+sT27VubHm53Sy6Cm9PeF4lNHas=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-UElRUtsYMs6T1rDwlHQzjw-1; Tue, 29 Nov 2022 14:52:42 -0500
X-MC-Unique: UElRUtsYMs6T1rDwlHQzjw-1
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so13177398ild.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0LHlDBeIbC0trt454N6iCOu40POMMvW1sX+cWMEbNI=;
        b=Lc5le/0e/cJtk61L2nmENSLEEZ4Majn36z5xLH5ox8nHNepZbyS7RNg5UnnDeNd9jn
         Wx+KzASDRlVqX2W87T9/HecEkiZ9vCQmHSv9ClHsFrkmkBNFVbEObKXdxg4j1GabbMjD
         uTMnfNGnCLit+F4TEo8e2vul+1wbTBHVZfR1LIGbPau3/XPwwOhBh5uPXDUJ4rcXyesn
         69o/qFEU8doqJGbtCI2ydO0w0edQ2ryRbT10hpn17bs/qNE9AAMpZxUNELN5dEytXKoA
         Xv6BYV5KqcPrhrsEtfYrW3uPLUvEIrrlj3nUeJXw9H2PkaP3UVPq4KVlSishMctOOwcG
         4bRw==
X-Gm-Message-State: ANoB5pl+j7qa056etWVeGtumIwqlQSF9SpFV+yBTK0mnZva4oVZxJLRz
        onokAJk+s4bYziopTDa3pv22l1355rMIJRZkuRkzAosNUhC+1BVXEZyEB9dmvti0iRgIzxJqXCI
        MYrmlRVBtGhipEYX+/E1PRKy9
X-Received: by 2002:a5d:8741:0:b0:6cd:6e75:69fd with SMTP id k1-20020a5d8741000000b006cd6e7569fdmr20221999iol.49.1669751561821;
        Tue, 29 Nov 2022 11:52:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf64WeR7cHbEWolS5fDJR5NuL8MvT0oFF/qwuq/GYCUnPG1OSX/ZEd+tXHXz2I1ZbGwSMx0ckg==
X-Received: by 2002:a5d:8741:0:b0:6cd:6e75:69fd with SMTP id k1-20020a5d8741000000b006cd6e7569fdmr20221992iol.49.1669751561599;
        Tue, 29 Nov 2022 11:52:41 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m5-20020a0566022ac500b006cfdf33825asm5735411iov.41.2022.11.29.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:52:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:52:38 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] vfio/platform: Remove the ACPI buffer memory to fix
 memory leak
Message-ID: <20221129125238.4ecdb3f0.alex.williamson@redhat.com>
In-Reply-To: <1669116598-25761-1-git-send-email-guohanjun@huawei.com>
References: <1669116598-25761-1-git-send-email-guohanjun@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

On Tue, 22 Nov 2022 19:29:58 +0800
Hanjun Guo <guohanjun@huawei.com> wrote:

> The ACPI buffer memory (buffer.pointer) returned by acpi_evaluate_object()
> is not used after the call of _RST method, so it leads to memory leak.
> 
> For the calling of ACPI _RST method, we don't need to pass a buffer
> for acpi_evaluate_object(), we can just pass NULL and remove the ACPI
> buffer memory in vfio_platform_acpi_call_reset(), then we don't need to
> free the memory and no memory leak.
> 
> Fixes: d30daa33ec1d ("vfio: platform: call _RST method when using ACPI")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 55dc4f4..1a0a238 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -72,12 +72,11 @@ static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
>  				  const char **extra_dbg)
>  {
>  #ifdef CONFIG_ACPI
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct device *dev = vdev->device;
>  	acpi_handle handle = ACPI_HANDLE(dev);
>  	acpi_status acpi_ret;
>  
> -	acpi_ret = acpi_evaluate_object(handle, "_RST", NULL, &buffer);
> +	acpi_ret = acpi_evaluate_object(handle, "_RST", NULL, NULL);
>  	if (ACPI_FAILURE(acpi_ret)) {
>  		if (extra_dbg)
>  			*extra_dbg = acpi_format_exception(acpi_ret);

An identical change was already posted and accepted into the vfio next
branch, see:

https://lore.kernel.org/all/20221018152825.891032-1-rafaelmendsr@gmail.com/

In linux-next as:

e67e070632a6 ("vfio: platform: Do not pass return buffer to ACPI _RST method")

Thanks,
Alex

