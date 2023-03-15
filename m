Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB73F6BB38E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjCOMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjCOMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB8A83C0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678884367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAOu6GreRWRu6ba4nX0ao5vFBWbgQLRTWPfGkR3xwgk=;
        b=gBxNYIPBDwXhwfMqaCCXrMCFmgilzuSkMAO3GIN8tVIWghDiGDd9SAlMf7ptAslQiLycth
        /w68WcB0Qoc3ucWIAJ++c5REXNlPOze8Z4S1lfbAXtqLiM50erwGq5ghXytb8bvo9uWBoM
        0rtRetU8T7BcX5zy4iZdJr5MwIlPLJQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-t5mnS9ygOsq0jIpQlDDYsw-1; Wed, 15 Mar 2023 08:46:06 -0400
X-MC-Unique: t5mnS9ygOsq0jIpQlDDYsw-1
Received: by mail-ed1-f69.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so26565138edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAOu6GreRWRu6ba4nX0ao5vFBWbgQLRTWPfGkR3xwgk=;
        b=PgO8nCVm+lX1yEeEsUeSxpZHxdzeNoF41vA+6vMP7EyEKeSM50UWArky4YU9RL8cDv
         cVXjhK7s6sWaPAUJ1WdUXapzkFGNr6dCSNmfwpJMeLZUGXgrl4WXEUgzm8sfxDu1NHq/
         GTNzqsFZfPVbeZcXpKkF3GyxG5Dh5b8+US0O9LXGC3/oFC4eiQFHKPn9HcMR4EY3uH4A
         Kyn9/f7lULGsGBmLUurxYrb3UW+4RfYN+OmgK11+uMimJH0bpphwtGmT5UroOqLGUvEB
         tflEX/c/H3IHCplxH6kOuymabumPJqSSflTXFAJRJgPZ5Iu9yRyu2lsgzGKukxGwHjca
         yREg==
X-Gm-Message-State: AO0yUKXKRJt3oIZrtnFm1u4nz6k6539aivGLh8Yf93MDN0V0yf0ww81o
        YihWQ3auFpAfYKc5POnDhbT8ZFgMn8j/SzrOwLvIy9HCGw8h/1TVzU1CU89Yeg+ASWvM4lGZ92A
        DaNwD3M4NkL7b5k6sEGMLXb/Y
X-Received: by 2002:a17:906:1b09:b0:88e:e498:109b with SMTP id o9-20020a1709061b0900b0088ee498109bmr5920012ejg.5.1678884364966;
        Wed, 15 Mar 2023 05:46:04 -0700 (PDT)
X-Google-Smtp-Source: AK7set8OEq3BFBrcLG8/KFs1ITZCvS/IL/+Swv1Lb8TgKsXIb/7EvmChXQfebSgll4X6Ay7VUbiI8A==
X-Received: by 2002:a17:906:1b09:b0:88e:e498:109b with SMTP id o9-20020a1709061b0900b0088ee498109bmr5919998ejg.5.1678884364753;
        Wed, 15 Mar 2023 05:46:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ga31-20020a1709070c1f00b008b904cb2bcdsm2514203ejc.11.2023.03.15.05.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 05:46:04 -0700 (PDT)
Message-ID: <8dde2c71-0c79-50af-e5aa-de3c9ee2955d@redhat.com>
Date:   Wed, 15 Mar 2023 13:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/36] platform/x86: ibm_rtl: move to use
 bus_get_dev_root()
Content-Language: en-US, nl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-4-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230313182918.1312597-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/23 19:28, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

Taking this upstream through the driver-core tree is fine by me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>  drivers/platform/x86/ibm_rtl.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/ibm_rtl.c b/drivers/platform/x86/ibm_rtl.c
> index 5fc665f7d9b3..2ab7d9ac542d 100644
> --- a/drivers/platform/x86/ibm_rtl.c
> +++ b/drivers/platform/x86/ibm_rtl.c
> @@ -199,16 +199,26 @@ static int rtl_setup_sysfs(void) {
>  
>  	ret = subsys_system_register(&rtl_subsys, NULL);
>  	if (!ret) {
> -		for (i = 0; rtl_attributes[i]; i ++)
> -			device_create_file(rtl_subsys.dev_root, rtl_attributes[i]);
> +		struct device *dev_root = bus_get_dev_root(&rtl_subsys);
> +
> +		if (dev_root) {
> +			for (i = 0; rtl_attributes[i]; i ++)
> +				device_create_file(dev_root, rtl_attributes[i]);
> +			put_device(dev_root);
> +		}
>  	}
>  	return ret;
>  }
>  
>  static void rtl_teardown_sysfs(void) {
> +	struct device *dev_root = bus_get_dev_root(&rtl_subsys);
>  	int i;
> -	for (i = 0; rtl_attributes[i]; i ++)
> -		device_remove_file(rtl_subsys.dev_root, rtl_attributes[i]);
> +
> +	if (dev_root) {
> +		for (i = 0; rtl_attributes[i]; i ++)
> +			device_remove_file(dev_root, rtl_attributes[i]);
> +		put_device(dev_root);
> +	}
>  	bus_unregister(&rtl_subsys);
>  }
>  

