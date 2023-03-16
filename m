Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11026BD2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCPOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCPOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9BA5D47C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678977908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TphTGZVuCe0DZxn3j8EnAi84Adr40XoIVzbhoOOU1F0=;
        b=MuRhw+pLY3d+qJr5AiD1agjXbIcAhN4UGBvibP0g7fPXQsuwQmI02pMrt5u7JpUIdvdOyr
        6v+dpxjnx81BR2hIpUX84uxGpJnNw4LsDu7vN/b/4PCvoWO3q69DJ7V7BESeJyImCssox+
        Qs3UwfioR6IpuWicTVibld/trOIAvE8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5kBaPvO7OSiBqz7XzZAvrA-1; Thu, 16 Mar 2023 10:44:57 -0400
X-MC-Unique: 5kBaPvO7OSiBqz7XzZAvrA-1
Received: by mail-ed1-f71.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so3385268edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TphTGZVuCe0DZxn3j8EnAi84Adr40XoIVzbhoOOU1F0=;
        b=OWT3uVnM1Cfq+Fj0isM+i8tJ3BFSd/HzOcQFdDMqVVBHMBuD9UJqItVJLVO3VN2u6M
         XoKR6jQ6XygVHvZPX6/GYYqAbOlijMOJFwEK53ovjXVWxsgwrsVyOQufx/wtkqmwG99v
         f9AdKAu6a0CZwVkGhSrmk6VKP1iIXf2dev3vyPjY7udkmLWFiyxqQjbli3wq5XLzEDa9
         0m5J2BY0rC3LwEswXgbPp4BvBfj3VUmAzua7nzsBoQO9oj9mm+K2ho+z5skKeKOYJtPB
         LU6S+kocpb9AamhzclFFmYa2yLvyjlJ9uBmv2n7jikSAtN6zyZ7/6vchHIGAsJ2F8lJA
         mTew==
X-Gm-Message-State: AO0yUKVFMO116aMs4U2ao2q9YXqXZmM2qKcLDbr6oIh7azAA3PYtg5qb
        Tt06QqFB5I1TQMLRweltOXnnVfaMr7XevsLw3Xzp8AWN+AaI3yWao/rlPVNmex5vAGz1heYAV/N
        iw21z84285LjeKXSjIS3QZoMyEonPipqH
X-Received: by 2002:a17:906:5f90:b0:92b:f019:a9ef with SMTP id a16-20020a1709065f9000b0092bf019a9efmr10820015eju.31.1678977896258;
        Thu, 16 Mar 2023 07:44:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set9DuZBjhs9ptdouLdsm1X3QPGZ2XFmh0E+/qQZ05qJQi0TXoHGw2iTuEgLj51xbk7DKeB0JOw==
X-Received: by 2002:a17:906:5f90:b0:92b:f019:a9ef with SMTP id a16-20020a1709065f9000b0092bf019a9efmr10820003eju.31.1678977896018;
        Thu, 16 Mar 2023 07:44:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906858a00b008d173604d72sm3955001ejx.174.2023.03.16.07.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:44:55 -0700 (PDT)
Message-ID: <1af9e9c5-681b-483e-620f-c1866fafd6db@redhat.com>
Date:   Thu, 16 Mar 2023 15:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: think-lmi: Remove custom kobject sysfs_ops
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230314-think-lmi-sysfs_ops-v1-1-9d4f1cf9caec@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230314-think-lmi-sysfs_ops-v1-1-9d4f1cf9caec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/14/23 01:07, Thomas Weißschuh wrote:
> think-lmi defines its own sysfs_ops that are identical to the standard
> kobj_sysfs_ops. Use the standard definitions.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

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
> 
> This has only been compile-tested.
> ---
>  drivers/platform/x86/think-lmi.c | 31 ++-----------------------------
>  1 file changed, 2 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 86b33b74519b..2b5ae68ffce8 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1047,33 +1047,6 @@ static const struct attribute_group tlmi_attr_group = {
>  	.attrs = tlmi_attrs,
>  };
>  
> -static ssize_t tlmi_attr_show(struct kobject *kobj, struct attribute *attr,
> -				    char *buf)
> -{
> -	struct kobj_attribute *kattr;
> -
> -	kattr = container_of(attr, struct kobj_attribute, attr);
> -	if (kattr->show)
> -		return kattr->show(kobj, kattr, buf);
> -	return -EIO;
> -}
> -
> -static ssize_t tlmi_attr_store(struct kobject *kobj, struct attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct kobj_attribute *kattr;
> -
> -	kattr = container_of(attr, struct kobj_attribute, attr);
> -	if (kattr->store)
> -		return kattr->store(kobj, kattr, buf, count);
> -	return -EIO;
> -}
> -
> -static const struct sysfs_ops tlmi_kobj_sysfs_ops = {
> -	.show	= tlmi_attr_show,
> -	.store	= tlmi_attr_store,
> -};
> -
>  static void tlmi_attr_setting_release(struct kobject *kobj)
>  {
>  	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> @@ -1091,12 +1064,12 @@ static void tlmi_pwd_setting_release(struct kobject *kobj)
>  
>  static const struct kobj_type tlmi_attr_setting_ktype = {
>  	.release        = &tlmi_attr_setting_release,
> -	.sysfs_ops	= &tlmi_kobj_sysfs_ops,
> +	.sysfs_ops	= &kobj_sysfs_ops,
>  };
>  
>  static const struct kobj_type tlmi_pwd_setting_ktype = {
>  	.release        = &tlmi_pwd_setting_release,
> -	.sysfs_ops	= &tlmi_kobj_sysfs_ops,
> +	.sysfs_ops	= &kobj_sysfs_ops,
>  };
>  
>  static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
> 
> ---
> base-commit: eeac8ede17557680855031c6f305ece2378af326
> change-id: 20230314-think-lmi-sysfs_ops-e849a18299bb
> 
> Best regards,

