Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D866D04C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAPUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjAPUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF32A9B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673901440;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzleNOs+fx9ShS3MaQRPGCCH6Yc77fZfbqHMtgEybWk=;
        b=MjkHr2yBq7OLL5C5koJefNzyCaWoPOYrR9c54glY0es4v24bgnZtRHhH4wlTmZUfU/2SEf
        KnhmO1/Eo6Tvwpk3NxQfuT9rJ0G+BgNG1/afdUqNxkfPzPHq6VhSdd6ozfo5HDCYLniKYP
        jPmJPreV1OIHiFK3yv6giasSHT6AN4U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-j8wzFak0MJuDDODmKnZsvQ-1; Mon, 16 Jan 2023 15:37:19 -0500
X-MC-Unique: j8wzFak0MJuDDODmKnZsvQ-1
Received: by mail-wm1-f70.google.com with SMTP id n9-20020a05600c3b8900b003d9f14e904eso12980377wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzleNOs+fx9ShS3MaQRPGCCH6Yc77fZfbqHMtgEybWk=;
        b=UlXhCOaEIee51Qp7XL5Gwbe89mdx9bk7MSswMH3GewXfjCa0A53LgGxbEMYSUHfwAQ
         hAZ6i7LyrKOPEBO6jMapyEbgSOYd5PH95HiEhsQsq71DDWotqpsK1D0J10oiz0yYTmBc
         7a+WA+X1JzFAwodCFHxF4t64BER8ZA2kU2Tz0qPTUwD2gGudvmMEGlswypKKrhxYvxYd
         0DcxvUF/7pEQ0KsGfJi+n3M7rgLB6oT4I4jvteKvv64SvAmunYBtWJOixrfExbsEaDRa
         T/sgOkw/iJ8YQPS56HkK5Ka8KcfxxVp8I+gO/AsZdnqPDwGrIL4H73K7YITKsr8ENwTu
         gyCw==
X-Gm-Message-State: AFqh2kodyWmTGm5cZWW2xRM7YXZBuDo7gPKE80pqJVnQ5dOcQ5UtEtlM
        opFavZhzZLb8pG3VS7kZyLKRP5ASCK0htip6FhZbforrMgId1u5ZauAT1xUOODvSt/+9lDFePaY
        jcPInaf06xqbR7HdLAeeCLk5W
X-Received: by 2002:a05:600c:1d29:b0:3d9:69fd:7707 with SMTP id l41-20020a05600c1d2900b003d969fd7707mr9409430wms.2.1673901437871;
        Mon, 16 Jan 2023 12:37:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu5xB78MxySo8g9YovYDjSAM+JAMmvEIr0DeelR1MPq3dEgwbiyULjeLjckf01EINYDXK4+6A==
X-Received: by 2002:a05:600c:1d29:b0:3d9:69fd:7707 with SMTP id l41-20020a05600c1d2900b003d969fd7707mr9409422wms.2.1673901437650;
        Mon, 16 Jan 2023 12:37:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003db03725e86sm1554198wmq.8.2023.01.16.12.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 12:37:16 -0800 (PST)
Message-ID: <452c2588-0e92-7095-f25d-cfe4711e607f@redhat.com>
Date:   Mon, 16 Jan 2023 21:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio: platform: No need to check res again
To:     Angus Chen <angus.chen@jaguarmicro.com>,
        alex.williamson@redhat.com, cohuck@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230107034721.2127-1-angus.chen@jaguarmicro.com>
Content-Language: en-US
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230107034721.2127-1-angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 1/7/23 04:47, Angus Chen wrote:
> In function vfio_platform_regions_init(),we did check res implied
> by using while loop,
> so no need to check whether res be null or not again.
>
> No functional change intended.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 1a0a238ffa35..a9ad3f4d2613 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -150,9 +150,6 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
>  		struct resource *res =
>  			vdev->get_resource(vdev, i);
>  
> -		if (!res)
> -			goto err;
> -
>  		vdev->regions[i].addr = res->start;
>  		vdev->regions[i].size = resource_size(res);
>  		vdev->regions[i].flags = 0;

