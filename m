Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06A06473A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLHPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLHPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378E786A3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670514882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSwQIAXLEgbSONcjNq/ffInSzmU0ybWtoXdJxeVOOUE=;
        b=QBcJ24RjvKrPo9w2qgNtbAYyGOt8R8pMtkyw7eeD9rC/1tYuwTZQKvg1wopFXIgtc69fZG
        jTfXqs0Aqr68QfGPpa3GCTFRYwbNy8ks4jcc2ig9/GAjrT8cSQLIK0VlR0PzGU2dEWen5H
        a9Hy8tHbea3DbRRXdUoTDhpvSyV19PM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-_pbdOzFnNHiB2MNOUzMOpg-1; Thu, 08 Dec 2022 10:54:41 -0500
X-MC-Unique: _pbdOzFnNHiB2MNOUzMOpg-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a05640234cf00b0046d32d7b153so1164367edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSwQIAXLEgbSONcjNq/ffInSzmU0ybWtoXdJxeVOOUE=;
        b=vuFiG+J9/4Lvwza1TQ8hQDDJ5quQ8vFB2ECZVKM4HAXCjGEA57C1EgblEjmi9WJ5uB
         m5y7Bg5UnOl/CrF/b751nJWpSVpIneY75Jb0V+ndtUw62Xd8T2UY99kbAo7xb68orbJM
         XCHr0RVFBKY+pPHRyxQC+t0T2/J78GVn+jzuzXyRx0vWeUELy9gFSD2j/sHffOg82Hck
         ikrDouRWAv3js9R8uo6ktu6BgqzNVzmaO2GKHdLcrWxIor1SXfnDQcSUHCBXKqi0LVnV
         /fLTNAnyGxTmaTKlqS+TEvBqmOkIodP7/KOOkNkXOV/DnQYhq3dA0zbkOn9Sr81Xb+To
         GgFg==
X-Gm-Message-State: ANoB5pnbG8SFR4ZfqLjzWe7BOTXVtYylnGKG1YBqGXh/7wqh34Sbe/HI
        oacP9MkfODW1CtRkexfRLXI4gI5XB1/I97/85bPTBaR0dshOdCdd8kqF8xwPnctOEc7bGI1QXaG
        2yK0ayr6n2S8cwGwTZHXSi+q+
X-Received: by 2002:a17:906:8d08:b0:7c1:700:1e2d with SMTP id rv8-20020a1709068d0800b007c107001e2dmr3868527ejc.20.1670514879827;
        Thu, 08 Dec 2022 07:54:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7uyODccxwLAE5cE71HeJzAASQ7LjigkQuWhvT5lurqfTHE9bYPSHxRpQ+7nhoSVBNL6mhyqA==
X-Received: by 2002:a17:906:8d08:b0:7c1:700:1e2d with SMTP id rv8-20020a1709068d0800b007c107001e2dmr3868512ejc.20.1670514879579;
        Thu, 08 Dec 2022 07:54:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090631d300b007c0a90663d5sm9127485ejf.162.2022.12.08.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 07:54:39 -0800 (PST)
Message-ID: <5428fc7d-4f03-8643-58c0-431963693133@redhat.com>
Date:   Thu, 8 Dec 2022 16:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] platform/x86: use sysfs_emit() to instead of scnprintf()
Content-Language: en-US, nl
To:     ye.xingchen@zte.com.cn
Cc:     justin.ernst@hpe.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202212021705128095546@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202212021705128095546@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/2/22 10:05, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

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
>  drivers/platform/x86/uv_sysfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
> index 625b0b79d185..73fc38ee7430 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -119,12 +119,12 @@ struct uv_hub {
> 
>  static ssize_t hub_name_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->name);
> +	return sysfs_emit(buf, "%s\n", hub_info->name);
>  }
> 
>  static ssize_t hub_location_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->location);
> +	return sysfs_emit(buf, "%s\n", hub_info->location);
>  }
> 
>  static ssize_t hub_partition_show(struct uv_bios_hub_info *hub_info, char *buf)
> @@ -460,12 +460,12 @@ struct uv_pci_top_obj {
> 
>  static ssize_t uv_pci_type_show(struct uv_pci_top_obj *top_obj, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->type);
> +	return sysfs_emit(buf, "%s\n", top_obj->type);
>  }
> 
>  static ssize_t uv_pci_location_show(struct uv_pci_top_obj *top_obj, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->location);
> +	return sysfs_emit(buf, "%s\n", top_obj->location);
>  }
> 
>  static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
> @@ -475,7 +475,7 @@ static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
> 
>  static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->ppb_addr);
> +	return sysfs_emit(buf, "%s\n", top_obj->ppb_addr);
>  }
> 
>  static ssize_t uv_pci_slot_show(struct uv_pci_top_obj *top_obj, char *buf)
> @@ -737,7 +737,7 @@ static ssize_t coherence_id_show(struct kobject *kobj,
>  static ssize_t uv_type_show(struct kobject *kobj,
>  			struct kobj_attribute *attr, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", uv_type_string());
> +	return sysfs_emit(buf, "%s\n", uv_type_string());
>  }
> 
>  static ssize_t uv_archtype_show(struct kobject *kobj,
> @@ -749,13 +749,13 @@ static ssize_t uv_archtype_show(struct kobject *kobj,
>  static ssize_t uv_hub_type_show(struct kobject *kobj,
>  			struct kobj_attribute *attr, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
> +	return sysfs_emit(buf, "0x%x\n", uv_hub_type());
>  }
> 
>  static ssize_t uv_hubless_show(struct kobject *kobj,
>  			struct kobj_attribute *attr, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_get_hubless_system());
> +	return sysfs_emit(buf, "0x%x\n", uv_get_hubless_system());
>  }
> 
>  static struct kobj_attribute partition_id_attr =

