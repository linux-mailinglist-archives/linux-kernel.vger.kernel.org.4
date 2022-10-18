Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332F6030F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJRQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJRQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D9BBF34
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666111564;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZP3yvTEQQM8pWfWWjNvcvdOOz/gh8bcKPbdVAik3fQ=;
        b=SelquGwYOU6J1rZnhrCVg48LK2X+QZy/f5HrimnYJTEAXDrP5Muf3K7hBwCqIqH00WNF7y
        9nefzf0zVFYXmGDwiOIxogtmhY9kOIgyAcQpUeb0YHkjglGfaARUV51qtaLnQfyLEQoiB5
        stoW0jNPB4aQX6B+TlEf5YMxZDzp/pY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-1RGJqJN8N16pwnMmCAp9bw-1; Tue, 18 Oct 2022 12:46:03 -0400
X-MC-Unique: 1RGJqJN8N16pwnMmCAp9bw-1
Received: by mail-qv1-f71.google.com with SMTP id kr13-20020a0562142b8d00b004b1d5953a2cso8963948qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZP3yvTEQQM8pWfWWjNvcvdOOz/gh8bcKPbdVAik3fQ=;
        b=niADSiI7uaxgDL0LifZ7dRAD0Rn4Ars/BTdtJIdbXYXhUQ1pB6N2uzN2Vyo3FfpOeW
         S8+eid1YMT+hfLZjvLUhhYXZXnI/X0TGR4R49Or18BbwIr6OrAdzd1oCUzuD8C5kKifI
         sRLeuBrt2LBYJqaMWN+0gh+nTTQzE+XJHC4AlTKY1nTAmkDZ9KDnk8e1WSQokXRGNeJU
         lBVnhbLw+b5q4TuglIK2UTdCH5jnFGV1N/GFOrxGHi6iWJrtlf8zqvZFI2KEurSxWRLs
         KIyLW73GiVmdEOTJPQEIgYd0VhSup+IV/LnoGNLxDNkeI2vV1LoslIeUaHEwqjr7699r
         mo7g==
X-Gm-Message-State: ACrzQf0/o7wzrauIZDzjGkLIuMPfc79yJSv7VQVAzjI1zTMSAXJvcrQr
        9iWaXegrYktn4HxmsAgzNXXbSOPkWZJL4PgQmyd7dw8XcobvvVStEcsY4AH/bY45hYKNyDfP+D4
        PdPOxDHdNgX0hbE+Mxiyp1IN8
X-Received: by 2002:a0c:9122:0:b0:4b1:80fc:c405 with SMTP id q31-20020a0c9122000000b004b180fcc405mr3134941qvq.120.1666111562691;
        Tue, 18 Oct 2022 09:46:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5qRKddE7VWNwmZ5E6Sy6/79Fxdoo5cJ0pbCHMIAhFQSQw6AiGBLAstyLwyrj9w+PYdaDSKhg==
X-Received: by 2002:a0c:9122:0:b0:4b1:80fc:c405 with SMTP id q31-20020a0c9122000000b004b180fcc405mr3134927qvq.120.1666111562513;
        Tue, 18 Oct 2022 09:46:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8148d000000b0039c72bb51f3sm2185059qtj.86.2022.10.18.09.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 09:46:01 -0700 (PDT)
Message-ID: <12a6fae1-c7c5-c531-fce7-1a57cf6122fa@redhat.com>
Date:   Tue, 18 Oct 2022 18:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio: platform: Do not pass return buffer to ACPI _RST
 method
Content-Language: en-US
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018152825.891032-1-rafaelmendsr@gmail.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20221018152825.891032-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,
On 10/18/22 17:28, Rafael Mendonca wrote:
> The ACPI _RST method has no return value, there's no need to pass a return
> buffer to acpi_evaluate_object().
>
> Fixes: d30daa33ec1d ("vfio: platform: call _RST method when using ACPI")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 55dc4f43c31e..1a0a238ffa35 100644
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

