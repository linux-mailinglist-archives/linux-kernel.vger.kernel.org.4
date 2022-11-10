Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70B624B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiKJUSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiKJUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F304D5DB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZltWYVEOG+yM5d6qffeJBrblT1mFe5B3vZnJjt5Y+Xc=;
        b=FUOlChClLbJ38gBK2dAYAvacYEbilqV0dXEhgcMKSIobBSWZsBMvRKiRtqs3AZg9+1gY2Z
        3O3M9cRrsfkXrNaNaBO8NVTtR/WPehJO+Yh0+sgCPbsH2fWxeEsGOonhRCgDdr6s5nnzHm
        zBY18eUQ6sTmlyGQCzqM26IEIlFDK0g=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-NxEpFRPlNDCDocIR4EqZxQ-1; Thu, 10 Nov 2022 15:16:54 -0500
X-MC-Unique: NxEpFRPlNDCDocIR4EqZxQ-1
Received: by mail-il1-f197.google.com with SMTP id n8-20020a056e02100800b00300906a2170so2382247ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZltWYVEOG+yM5d6qffeJBrblT1mFe5B3vZnJjt5Y+Xc=;
        b=bxSpBLtsTpo/ViLGFBCicAMs1lxG6RKQicghOH56qA8uswerPuhfsNyMIIL3D7dCU8
         TksunyN74QzwlMG6inIbccEyangaofpISNkex3O6at8bQPJhAzgDLRsUX5502nSvPYvw
         w/OIujKJ+HKkt2F5P6cDqhFRzwcvGRURcDLnAojeRaKK/ROlriwsdCSNSW8pQ7hesvf3
         n3rEr36BeeGwNGZ6Qe+sDlTjtwz8dCeKK2O+pXLIJZ9Mv2Lan1RzMYegs6Hd8rWY0A4x
         HYeC1p26nDXfPyawYdvuShwNmiNFfOcCFTs9xAPfCCVfW6b+CuJK8BMmL8JEfu/CwR8R
         APJQ==
X-Gm-Message-State: ACrzQf1TNy2Fe2NdW/hcaX+joN/66i1J5BYevGugf8cPLosgkSN4yN87
        8NiXJIdtaqMFFLkydEwkmqXxhC7C3a9/QE62AbnUW+4I83mOaH6TNFwgfkNgGOhtoZhnS6uRmFf
        aqeXqXY34vOV+04Swx8rheafo
X-Received: by 2002:a5e:920b:0:b0:6c8:209:fe2d with SMTP id y11-20020a5e920b000000b006c80209fe2dmr3399050iop.47.1668111413930;
        Thu, 10 Nov 2022 12:16:53 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5y8RGsajiWLk30+1ihf0E1uH/5XlBuSC0OV502Coz+hBDuflZrAA1lW9ysp1dWVQh2wvRhPw==
X-Received: by 2002:a5e:920b:0:b0:6c8:209:fe2d with SMTP id y11-20020a5e920b000000b006c80209fe2dmr3399039iop.47.1668111413704;
        Thu, 10 Nov 2022 12:16:53 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i7-20020a0566022c8700b006bbea9f45cesm25981iow.38.2022.11.10.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:16:52 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:16:36 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: platform: Do not pass return buffer to ACPI _RST
 method
Message-ID: <20221110131636.1097802c.alex.williamson@redhat.com>
In-Reply-To: <20221018152825.891032-1-rafaelmendsr@gmail.com>
References: <20221018152825.891032-1-rafaelmendsr@gmail.com>
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

On Tue, 18 Oct 2022 12:28:25 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> The ACPI _RST method has no return value, there's no need to pass a return
> buffer to acpi_evaluate_object().
> 
> Fixes: d30daa33ec1d ("vfio: platform: call _RST method when using ACPI")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
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

Applied to vfio next branch for v6.2.  Thanks,

Alex

