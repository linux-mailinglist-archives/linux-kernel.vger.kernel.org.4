Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9926BE585
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCQJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjCQJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:25:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EFB7184
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:25:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so17755173edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679045153;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBicrHar7M9pJTU0NNGO547h5b9WrtbC/ps2ycbJQhA=;
        b=lSFbsUeoqGdbeK1BBR6QVOVfwvtF12K5Uyq9iLvYH5rGQhZ2HZlMkU9FZ7Z+80aE+2
         nqEzw96Q8E8RLUaKnslcp2PoBOZLf5o+Xf0/64YsdA2kYWmiIHcatZzK0Dv4b8HfxIAD
         f4yTgjINRe9tPm0+JFk1skQg/OvhJcK8UCC+Gbn7ISeNSjma/XtTfdsxb+nS+3xt5yWp
         o4KrTnQM75Mi/YL+YpDpESQYS/D89DU6KT4QFcxTNZd8R64Tky+wIFt6HShATvuoz7gj
         TLn9GstwSaPSNf55JsSsD4ZIO1+JFcTZJzxJWBhNcwBo5FY2mrkucWXhliMnKQp8c234
         pZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045153;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBicrHar7M9pJTU0NNGO547h5b9WrtbC/ps2ycbJQhA=;
        b=Z0NNQI7BOUekpnOajVZyySpHEzchnUe+mmfD6W5oq93zCT0g0zp9q3eNu33PEKLtzD
         +Se/TZhQJcPYaDLPOms8b+rEsNlYNVXgL2oBxN/bPE7tGwfc6FoWquxHLMpE9XuzjRKP
         8DMmuPzaLpByPaQsnLq2IiBPQpcHMfeV4TM21szHiazfdgQEkYwLGSA9O2KzZbp3O4HF
         C/CuM9dPXrrZG7qfB65u6VMTmvtajgq1MzshSeibW3M+n0kqRCdPC+ZAhVPByPB4k8HP
         J6SZ3FnItUDu9I+Y+mLrZQ2Vqs6mu/bYke8mm1vKqhTVvxQlR8nEaX0gdj/5BR64WB2J
         R00Q==
X-Gm-Message-State: AO0yUKUC/5oXaWeQD+gosBxUIVHzC/bZ30CIWCh6vVWzJdRTHa3YtRyk
        0lTL+JQ24VVutlUIVigY4vw5l0JZgQ0=
X-Google-Smtp-Source: AK7set/fyQ2QCtpA5Htd8k4YDjd5ZlVi0gzq6ViYA1uQx8M9t1eYwX88xSL3ii+ED09Vrez8B0Vq/Q==
X-Received: by 2002:a17:907:9496:b0:92f:43a2:bf7d with SMTP id dm22-20020a170907949600b0092f43a2bf7dmr9650652ejc.73.1679045152941;
        Fri, 17 Mar 2023 02:25:52 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5b8:6200:9879:b43a:72d0:837c? (dynamic-2a01-0c23-c5b8-6200-9879-b43a-72d0-837c.c23.pool.telefonica.de. [2a01:c23:c5b8:6200:9879:b43a:72d0:837c])
        by smtp.googlemail.com with ESMTPSA id c21-20020a50f615000000b004fce9ff4830sm788612edn.88.2023.03.17.02.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:25:52 -0700 (PDT)
Message-ID: <39e60d57-60f1-d706-d922-0411252d4567@gmail.com>
Date:   Fri, 17 Mar 2023 10:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
 <ZBP14wghbJPCnAFJ@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] base: soc: set machine name in soc_device_register if
 empty
In-Reply-To: <ZBP14wghbJPCnAFJ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.2023 06:08, Greg Kroah-Hartman wrote:
> On Thu, Mar 16, 2023 at 09:35:59PM +0100, Heiner Kallweit wrote:
>> Several SoC drivers use the same of-based mechanism to populate the machine
>> name. Therefore move this to the core and try to populate the machine name
>> in soc_device_register if it's not set yet.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/base/soc.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
>> index 0fb1d4ab9..8dec5228f 100644
>> --- a/drivers/base/soc.c
>> +++ b/drivers/base/soc.c
>> @@ -7,6 +7,7 @@
>>  
>>  #include <linux/sysfs.h>
>>  #include <linux/init.h>
>> +#include <linux/of.h>
>>  #include <linux/stat.h>
>>  #include <linux/slab.h>
>>  #include <linux/idr.h>
>> @@ -110,6 +111,18 @@ static void soc_release(struct device *dev)
>>  	kfree(soc_dev);
>>  }
>>  
>> +static void soc_device_set_machine(struct soc_device_attribute *soc_dev_attr)
>> +{
>> +	struct device_node *np;
>> +
>> +	if (soc_dev_attr->machine)
>> +		return;
>> +
>> +	np = of_find_node_by_path("/");
>> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
>> +	of_node_put(np);
>> +}
>> +
>>  static struct soc_device_attribute *early_soc_dev_attr;
>>  
>>  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
>> @@ -118,6 +131,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>>  	const struct attribute_group **soc_attr_groups;
>>  	int ret;
>>  
>> +	soc_device_set_machine(soc_dev_attr);
>> +
> 
> Does this mean some SoC drivers should also be changed at the same time
> if they are trying to do this?
> 
The then duplicated code can be removed from SoC drivers afterwards.
There's no need to do it at the same time.
This change just adds a fallback in case the SoC driver doesn't set "machine".
Means if a SoC driver populates machine differently, then this is respected
and not overwritten.

> And is "model" the correct of property for this?  I thought that devices
> also had "model" as a valid entry, is this documented somewhere in the
> DTS schema that I couldn't find?
> 

"model" is used by basically all SoC drivers for this purpose, a quick grep reveals:

drivers/soc/samsung/exynos-chipid.c:    of_property_read_string(root, "model", &soc_dev_attr->machine);
drivers/soc/fsl/guts.c: if (of_property_read_string(of_root, "model", &machine))
drivers/soc/amlogic/meson-mx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
drivers/soc/amlogic/meson-gx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
drivers/soc/aspeed/aspeed-socinfo.c:    of_property_read_string(np, "model", &machine);
drivers/soc/ti/k3-socinfo.c:    of_property_read_string(node, "model", &soc_dev_attr->machine);
drivers/soc/loongson/loongson2_guts.c:  if (of_property_read_string(root, "model", &machine))
drivers/soc/renesas/renesas-soc.c:      of_property_read_string(np, "model", &soc_dev_attr->machine);
drivers/soc/imx/soc-imx.c:      ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
drivers/soc/imx/soc-imx8m.c:    ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);

Some don't set machine at all.

> thanks,
> 
> greg k-h

Heiner

