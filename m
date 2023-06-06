Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE35723DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjFFJfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjFFJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A910D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686044003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyNfCyF+F3Zw1MWVQkKg+TAa5A8aDRRjK+8ILi+iQOc=;
        b=Jm7ltaxoQl31X4JePVBdNKxci5uuAxJS7kXfbyUHRVxmVThjZBkbvKbB+Lao5h56Ov/RMO
        fWrd2yckeRVEUS+yi8eILnaJes4bJL496kcLS7XceZiHlx5tV7pCjWiDczaG6PJd59eRqy
        axqk9dKQHrhWd6YkgLhFcEqYycEajPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-abOIYh2DNkOanyUC_Vkxuw-1; Tue, 06 Jun 2023 05:33:22 -0400
X-MC-Unique: abOIYh2DNkOanyUC_Vkxuw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97594143f1fso364127566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044000; x=1688636000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyNfCyF+F3Zw1MWVQkKg+TAa5A8aDRRjK+8ILi+iQOc=;
        b=Jz5+IBN3eETulCmIZ+2Qc+6sKJQ7dYQFFJVcWuSQQsRSTfwefDVCpZOb/ZKxZUkKZk
         jJIVTMZilOxTDI6s9f/bGdR79gYUu6tlULZYXYwSyeWWDg8e0VGnFspKH0+04mlSDvrA
         UDfnvGql2Xin2jS2gyFRFf3JIoIA19m6oxKKg2ogtbT+OHCTlcGpaDl8Vu8byBLmndG2
         c4PnrWBfHPD56jOOwffOAULWql/oz/DeENyzZiF2sf0DtubS97SmOfbKCuS+iyp8SI02
         RcaPWveBC7+G+niN4dt93l3NgyIjwVJM3gSA080dHE5VKH06n0ECe/jZeknEpGED0+Zp
         Azow==
X-Gm-Message-State: AC+VfDwijqqcSbpNo6QKgThoTKWFr7NlHMMvvyBcME6+3BMmiPj3atT8
        Qx9E5a+J9Axh/3oosV2ClzlN9oi5QZoqNbRXsA0F7ovF/xEzcJ1CpR9njqEcMP+5EwWIPo+cp7H
        b8yXVcpaMMstQjoUUUP5x4req5ZBbvMla
X-Received: by 2002:a17:907:2d94:b0:974:326b:f9b2 with SMTP id gt20-20020a1709072d9400b00974326bf9b2mr1822962ejc.66.1686044000699;
        Tue, 06 Jun 2023 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76alfvCiErl1w9MgdyYpRU6Y25tp7rroTmzTF7l3MteMTAdRZecT/+VppSS2C72Ft/ZkmYpA==
X-Received: by 2002:a17:907:2d94:b0:974:326b:f9b2 with SMTP id gt20-20020a1709072d9400b00974326bf9b2mr1822949ejc.66.1686044000408;
        Tue, 06 Jun 2023 02:33:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gr24-20020a170906e2d800b0096f5b48fe43sm5360223ejb.47.2023.06.06.02.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:33:19 -0700 (PDT)
Message-ID: <e884358d-a621-5dd3-7ae6-6338c77be586@redhat.com>
Date:   Tue, 6 Jun 2023 11:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/8] platform/x86: think-lmi: mutex protection around
 multiple WMI calls
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
References: <mpearson-lenovo@squebb.ca>
 <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/23 22:05, Mark Pearson wrote:
> When an attribute is being changed if the Admin account is enabled, or if a password
> is being updated then multiple WMI calls are needed.
> Add mutex protection to ensure no race conditions are introduced.
> 
> Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
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
> Changes in v2:
>  - New commit added after review of other patches in series.
> Changes in v3:
>  - Simplified mutex handling as recommended.
> Changes in v4:
>  - This was the 5th patch in the series but moved to be first.
>  - Added Fixes tag.
>  - Improved commit information to be clearer.
> 
>  drivers/platform/x86/think-lmi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 1138f770149d..6cf77bc26b05 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> +#include <linux/mutex.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
> @@ -195,6 +196,7 @@ static const char * const level_options[] = {
>  };
>  static struct think_lmi tlmi_priv;
>  static struct class *fw_attr_class;
> +static DEFINE_MUTEX(tlmi_mutex);
>  
>  /* ------ Utility functions ------------*/
>  /* Strip out CR if one is present */
> @@ -437,6 +439,9 @@ static ssize_t new_password_store(struct kobject *kobj,
>  	/* Strip out CR if one is present, setting password won't work if it is present */
>  	strip_cr(new_pwd);
>  
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
>  	pwdlen = strlen(new_pwd);
>  	/* pwdlen == 0 is allowed to clear the password */
>  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen))) {
> @@ -493,6 +498,7 @@ static ssize_t new_password_store(struct kobject *kobj,
>  		kfree(auth_str);
>  	}
>  out:
> +	mutex_unlock(&tlmi_mutex);
>  	kfree(new_pwd);
>  	return ret ?: count;
>  }
> @@ -981,6 +987,9 @@ static ssize_t current_value_store(struct kobject *kobj,
>  	/* Strip out CR if one is present */
>  	strip_cr(new_setting);
>  
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
>  	/* Check if certificate authentication is enabled and active */
>  	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
>  		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
> @@ -1039,6 +1048,7 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
>  	}
>  out:
> +	mutex_unlock(&tlmi_mutex);
>  	kfree(auth_str);
>  	kfree(set_str);
>  	kfree(new_setting);

