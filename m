Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC157624CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiKJVUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiKJVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03612082
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668115157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaDM9AF34T4yePmDmSyJsFxr2n24Jtip0IViwoic0/w=;
        b=ToxQDIxJ0+11Q3+q76Au6pxuK/3u8w1LCoIeqjbsvbv0iheNa04yiZUEQiuvs9sEoABYO4
        hSKWMaLPz0ATnOVWRNpY+X+HaD6l+HjcmdOm2dzcUjGvAWM7XSP8mg/mTvZLnhLc5eEzzo
        VA4YG9USbfRSzojSAT70/tQTzDOF3+o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-5oQ_T76HMAWx4SDa6I52aw-1; Thu, 10 Nov 2022 16:19:15 -0500
X-MC-Unique: 5oQ_T76HMAWx4SDa6I52aw-1
Received: by mail-ed1-f71.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so2315248edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaDM9AF34T4yePmDmSyJsFxr2n24Jtip0IViwoic0/w=;
        b=OudvsSG1MQ9Syw3mROzcTAiKGepfUF1rdigwD986a17Esf9HCYsmeqYa398qqZmXQa
         icQFX/wKrmmvStQUSi+qHV+P1ri8q0a+4QhKL8cufE4oH21w7dVp+thXpjwh34B9CML9
         HDIL28NGgigHoM28Iic0b4wKc7Ah9ocvpTw3p2oHw8sE3ZGl6OkVHDvokCDX7g5HB7Tf
         jWcKSNISmYKbnwC/DmAg7wp30/dhdy95jgnVuM+5WxlpIPqC+Aok2Z5ley9WximYr654
         WOYj2w1Noc6HXdtgaa821Gb5Xw38vIOLseeoqKUfKTEYurZDVPQKJkNfOxprCbXALHnR
         ClKQ==
X-Gm-Message-State: ACrzQf13C7YAie5pFq39mbi5UhQCPoxgVpetWesg12hwHGGgxxo+qgLk
        ZO/+UigRYIbN1glcqk3m3PccV8TsWOM25LEfxTbffAu/7TSGRXN4/72Ar9dYHCXBsrB/USeWp4o
        BsTGEDQtbV6ueMJMP8EHASez9
X-Received: by 2002:a05:6402:545:b0:460:8384:e263 with SMTP id i5-20020a056402054500b004608384e263mr3472072edx.230.1668115154519;
        Thu, 10 Nov 2022 13:19:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5TrfOU8xnS5qiH0IQ6ZsFuGN1gd1cTF742kGeaSBVauzyQN5NZpKi56ioRPBX0xA2mgumlTg==
X-Received: by 2002:a05:6402:545:b0:460:8384:e263 with SMTP id i5-20020a056402054500b004608384e263mr3472056edx.230.1668115154339;
        Thu, 10 Nov 2022 13:19:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id rl24-20020a170907217800b00770880dfc4fsm158693ejb.29.2022.11.10.13.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:19:13 -0800 (PST)
Message-ID: <2446cc07-dc2b-d010-a8b4-93d867e8a6f3@redhat.com>
Date:   Thu, 10 Nov 2022 22:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 11/14] platform/x86/intel/ifs: Remove reload sysfs
 entry
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-12-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-12-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/7/22 23:53, Jithu Joseph wrote:
> Reload sysfs entry will be replaced by current_batch, drop it.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/ifs/sysfs.c | 29 --------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index 65dd6fea5342..e077910c5d28 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -87,34 +87,6 @@ static ssize_t run_test_store(struct device *dev,
>  
>  static DEVICE_ATTR_WO(run_test);
>  
> -/*
> - * Reload the IFS image. When user wants to install new IFS image
> - */
> -static ssize_t reload_store(struct device *dev,
> -			    struct device_attribute *attr,
> -			    const char *buf, size_t count)
> -{
> -	struct ifs_data *ifsd = ifs_get_data(dev);
> -	bool res;
> -
> -
> -	if (kstrtobool(buf, &res))
> -		return -EINVAL;
> -	if (!res)
> -		return count;
> -
> -	if (down_interruptible(&ifs_sem))
> -		return -EINTR;
> -
> -	ifs_load_firmware(dev);
> -
> -	up(&ifs_sem);
> -
> -	return ifsd->loaded ? count : -ENODEV;
> -}
> -
> -static DEVICE_ATTR_WO(reload);
> -
>  /*
>   * Display currently loaded IFS image version.
>   */
> @@ -136,7 +108,6 @@ static struct attribute *plat_ifs_attrs[] = {
>  	&dev_attr_details.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_run_test.attr,
> -	&dev_attr_reload.attr,
>  	&dev_attr_image_version.attr,
>  	NULL
>  };

