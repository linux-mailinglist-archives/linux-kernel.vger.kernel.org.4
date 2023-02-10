Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884F569233D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBJQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjBJQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648638B41
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676046380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMyWSiBRS0vHXlOWzGHad9uq2iQmgPdEGhe+CLq72Oo=;
        b=Eke+XbAdPirjTQ4sztQkV3Rqz8Hu43adG+lP6ccIyFn7505YPSEnPqqZPdNijrLJ6WkMRL
        y48p78cWC8nQLwAxbB8k2y0jbxzjdaLV/GG8pTE4GtHhgzHDVHhQiG7ZCcxNwZICFYPGxa
        RSi5vghz5PiJp8g5aODXQED4oyo+Xwg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-eU-uzUzgM3a8NnNfk5MSxw-1; Fri, 10 Feb 2023 11:26:19 -0500
X-MC-Unique: eU-uzUzgM3a8NnNfk5MSxw-1
Received: by mail-ej1-f71.google.com with SMTP id lf9-20020a170907174900b0087861282038so3863596ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMyWSiBRS0vHXlOWzGHad9uq2iQmgPdEGhe+CLq72Oo=;
        b=mldvoIP0U2ZL9Aw7kLxIVMGHysJr5n3UUeXb8DllFI2EYI/zswN1UlO+Don9Y4OfdE
         55Ku2wfM2/Hi2fFtU/+Svf98dacpEFKmvU5Mtmvz8neMUtA37jiZ1Pg/UIV81+l7pXXX
         JylJXf/vIPxzHuKT5qqQp6vSVgEGApsO1aNIQaFXyXy98VLeTIcpgMcBFXvo45CM5SUs
         iGtJ/25T0ZkHZqJYXjbFQ3tS/BRMLBrcwE2BtC9C9j+V4JUb0s5hmkRIBpI0bKT6xu4S
         64l3xizDCxUJYx9vdl++TASYJAi3cKMrXbxj5N+sFYFUroTe7zsNQvnoQq48XQf9YAIw
         1tdA==
X-Gm-Message-State: AO0yUKWPAUAS3rO4lRXB/errGFalIz8EuiJoClfUkA3yQzLXnQajeeIF
        e0aOu2E70pcY2T2dVAPa+oxXuV6MgufQPJrBDr/xpsF5CmktkmEHYciqt5a3HHVGg9vQRUipndb
        u3O9BPjfODm0TrkjiOV4cpHEQ
X-Received: by 2002:a17:907:6e90:b0:8af:91a6:de6b with SMTP id sh16-20020a1709076e9000b008af91a6de6bmr1407107ejc.50.1676046378241;
        Fri, 10 Feb 2023 08:26:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9ilo535lQiADsLvDdkpzMsP0IMScu0e/tEllxGX4Ta/jL9ITP1JT7l9tVc1IlMqybnr41UJg==
X-Received: by 2002:a17:907:6e90:b0:8af:91a6:de6b with SMTP id sh16-20020a1709076e9000b008af91a6de6bmr1407095ejc.50.1676046378049;
        Fri, 10 Feb 2023 08:26:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906825a00b0084c4b87aa18sm2573294ejx.37.2023.02.10.08.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:26:17 -0800 (PST)
Message-ID: <d5851a70-dcbb-8455-b022-49fad58be7ff@redhat.com>
Date:   Fri, 10 Feb 2023 17:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC] MAINTAINERS: dell-wmi-sysman: drop Divya Bharathi
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207-maintainers-dell-wmi-sysman-v1-1-6594fea12f6c@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230207-maintainers-dell-wmi-sysman-v1-1-6594fea12f6c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/23 17:51, Thomas Weißschuh wrote:
> According to the bounce sent by Dell's mailserver this user does not
> exist (anymore).
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

I just got the same bounce, so lets move ahead with this:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb1471cb5ed3..396bb00d98a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5930,7 +5930,6 @@ F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
>  F:	drivers/platform/x86/dell/dell-wmi-ddv.c
>  
>  DELL WMI SYSMAN DRIVER
> -M:	Divya Bharathi <divya.bharathi@dell.com>
>  M:	Prasanth Ksr <prasanth.ksr@dell.com>
>  L:	Dell.Client.Kernel@dell.com
>  L:	platform-driver-x86@vger.kernel.org
> 
> ---
> base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
> change-id: 20230207-maintainers-dell-wmi-sysman-40d6cd1ceddf
> 
> Best regards,

