Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A68655103
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiLWN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiLWN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:29:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882E13CEB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671802118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNUnkJqBrm1AuFrEX+JHLPZilbCOMaZVyEFbDJI2g7I=;
        b=gGJlKQf0ogFjy6a4g8ku5aWQ04/nhS+yixdtJv7oNOB7ZQ+ZT9v3eGMccnJnvOh8QPWVPa
        Zv0wM+QByXQgnZe+kpl05VY2sUruJECJR5zSxCWKrBqHAVQvdXCaRTTPUpf4cWLs1DK/q5
        3Z2x1WXIK7mM0T6uRZMsmQZdcwsV6gI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-umZV6eIMPcSrdYK-QkSoGw-1; Fri, 23 Dec 2022 08:28:36 -0500
X-MC-Unique: umZV6eIMPcSrdYK-QkSoGw-1
Received: by mail-io1-f70.google.com with SMTP id l21-20020a5d9315000000b006df7697880aso1908802ion.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNUnkJqBrm1AuFrEX+JHLPZilbCOMaZVyEFbDJI2g7I=;
        b=vShBpldn4g0TyqHQOzETpGzSLTrf+52YJ1+0lnxiOEhlo3DeNf7u4/Ie1GUNLf9UZO
         hGAS72bftc5wMJVppQTyOuJuZ4n8noUubwfWqNzwzlBR0GYawiTtJlQQhfAwCyjd4ed4
         WMWjKx+0egJ6DLe3rNAjcJTEKOy03uCrZQvR2JPkVwgHnFySVNyuvG4RZ4Ydgmq7zfY1
         mF7GYMyNiRcyeybeVWeAKgEacDQJCuE2KJSy7mABIuoubIFYmh9dRDF89El5HPRVU8x0
         MapGrQmZfh+ilM0k7oBSHBCI5wrXUfJZIM/VvtL8zXEzCpaAUbfkH2uhu4U+xyjvoAyN
         D1Hw==
X-Gm-Message-State: AFqh2kpWi2jhoOES+hgxmwLIgvpDDLJXN0czb/HvRryYo2hlnmfFFiXk
        Iila8P/lrnaoSSasAyHekdJmnogAKM4oLsEsMnYMbPHpDhB1ARISDOi4IBGsNfkyt7pymnifAg4
        DbSgZAnaG+lk5JdS/pbQxPgcM
X-Received: by 2002:a05:6e02:1bc5:b0:30b:d9ab:2ae0 with SMTP id x5-20020a056e021bc500b0030bd9ab2ae0mr6309653ilv.4.1671802115687;
        Fri, 23 Dec 2022 05:28:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEC8Ar7qXJYHKn7GA1kf3ebyVYBwAe58xi0ilB+Jc00hf7Y1WK+llLlqeqENm72qHM8LJcgw==
X-Received: by 2002:a05:6e02:1bc5:b0:30b:d9ab:2ae0 with SMTP id x5-20020a056e021bc500b0030bd9ab2ae0mr6309642ilv.4.1671802115435;
        Fri, 23 Dec 2022 05:28:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e1-20020a92d741000000b00302a7165d9bsm1033153ilq.53.2022.12.23.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:28:34 -0800 (PST)
Date:   Fri, 23 Dec 2022 06:28:32 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio_iommu_type1: increase the validity check of
 function parameters
Message-ID: <20221223062832.069595f1.alex.williamson@redhat.com>
In-Reply-To: <20221223072418.3728-1-kunyu@nfschina.com>
References: <20221223072418.3728-1-kunyu@nfschina.com>
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

On Fri, 23 Dec 2022 15:24:18 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> Added validity check for count variable, return if count variable does 
> not meet the execution condition (do not execute mutex_lock and 
> mutex_unlock function).
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00..9bdf96d932e4 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -3137,6 +3137,9 @@ static int vfio_iommu_type1_dma_rw(void *iommu_data, dma_addr_t user_iova,
>  	int ret = 0;
>  	size_t done;
>  
> +	if (count <= 0)
> +		return ret;
> +
>  	mutex_lock(&iommu->lock);
>  	while (count > 0) {
>  		ret = vfio_iommu_type1_dma_rw_chunk(iommu, user_iova, data,

This is only optimizing a case that shouldn't exist, the return value
is the same.  Callers should be smart enough not to call the function
with such values.  As an internal API, we assume reasonable behavior by
the caller.  Thanks,

Alex

