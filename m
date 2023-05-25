Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCDD71178D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbjEYTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbjEYTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1528A9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685043712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hG6a8dxjoLrvuutaPxgY7/ShfZWOWo5mAvJlZJg9eDk=;
        b=C207tCjeuZ8yKGDHPk8RAgGoLLb+zbybRntdwz09mbamya8SeUr6N43dfBuWaS+LYt/Z51
        rL5LWpGNRnqcwQJC2xw5OkVwzgXf+njhSnlE+qbsVcpV+J7uCbhi/QfCdtVOAUMAIqtfhI
        qAeqfC5m7sRBRWN8O0aBm0+KX7uC4pY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-LRuNQbM8M2yKHwj99wwE9w-1; Thu, 25 May 2023 15:41:50 -0400
X-MC-Unique: LRuNQbM8M2yKHwj99wwE9w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-973c263d727so43858466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685043709; x=1687635709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG6a8dxjoLrvuutaPxgY7/ShfZWOWo5mAvJlZJg9eDk=;
        b=WegHy+jCOSAGl+XKnZeC5m9SXkfk+EHaLfn2NFf2aboHhTIGUXiyj9UDecJm3b/ekX
         dy+Jg100Gll5/YrHEupE9fJolkoYXc9dLLvI5yOw+GPXItH9kqk1lYs53hTElxxiObR0
         /Gub+W41zHr4MM5uBxXO2O+DH03BKCNOPW0SzNiYv9ui/cawxSX8kLVaqNAyXB/NN5MJ
         0kSScE30bufCu75qK6JlXwtGTORSfAL2rzE8hbyO+biSMrs8A6zMmr+jrpIeausyPse+
         e60wfvr9tvaNeYVV1sSzV+jpDlln02Ox1fhMjmiQGudbfXADEQkM08QYkobQlRGsElZb
         va4Q==
X-Gm-Message-State: AC+VfDx2Ug+LVupXfx6RfVaB1Xryhlt/WuWN7UxEXjZRdN5QtBcCvIrX
        84GBKljantoLkLoSJaS+BGj7uhlfZsc/mTGwXV0b1OXIQEj46q5bvoYxXMe2/u594jUo+t//hut
        456ZdrgSJUEnRYYfxnDG8Xqmj
X-Received: by 2002:a17:907:3689:b0:967:b02c:b06a with SMTP id bi9-20020a170907368900b00967b02cb06amr2104444ejc.27.1685043709757;
        Thu, 25 May 2023 12:41:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FoBpNxiIWHwkQP7q3np75MJ/V7j8tkvrrWNzruQCldfoKD4g/CrrrJi7Yuyxu44nh7+U0fw==
X-Received: by 2002:a17:907:3689:b0:967:b02c:b06a with SMTP id bi9-20020a170907368900b00967b02cb06amr2104434ejc.27.1685043709422;
        Thu, 25 May 2023 12:41:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0096b15e4ffcesm1200378ejd.85.2023.05.25.12.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 12:41:48 -0700 (PDT)
Message-ID: <6e05df16-7125-a634-6b99-3cf3079d3d5d@redhat.com>
Date:   Thu, 25 May 2023 21:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] platform/x86: think-lmi: mutex protection around
 multiple WMI calls
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/25/23 21:31, Mark Pearson wrote:
> Add mutex protection around cases where an operation needs multiple
> WMI calls - e.g. setting password.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in V2: New commit added after review of other patches in series.
> 
>  drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 64cd453d6e7d..f3e1e4dacba2 100644
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
> @@ -463,23 +465,32 @@ static ssize_t new_password_store(struct kobject *kobj,
>  			sprintf(pwd_type, "%s", setting->pwd_type);
>  		}
>  
> +		mutex_lock(&tlmi_mutex);
>  		ret = tlmi_opcode_setting("WmiOpcodePasswordType", pwd_type);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> -
> +		}
>  		if (tlmi_priv.pwd_admin->valid) {
>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>  					tlmi_priv.pwd_admin->password);
> -			if (ret)
> +			if (ret) {
> +				mutex_unlock(&tlmi_mutex);
>  				goto out;
> +			}
>  		}
>  		ret = tlmi_opcode_setting("WmiOpcodePasswordCurrent01", setting->password);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> +		}
>  		ret = tlmi_opcode_setting("WmiOpcodePasswordNew01", new_pwd);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> +		}
>  		ret = tlmi_simple_call(LENOVO_OPCODE_IF_GUID, "WmiOpcodePasswordSetUpdate;");
> +		mutex_unlock(&tlmi_mutex);
>  	} else {
>  		/* Format: 'PasswordType,CurrentPw,NewPw,Encoding,KbdLang;' */
>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s,%s;",


I haven't take a really close / good look yet. But at a first glance
I think it would be cleaner to just take the mutex at the top
and unlock it after the out label to which all the existing goto-s
already go ?

> @@ -1000,11 +1011,16 @@ static ssize_t current_value_store(struct kobject *kobj,
>  			goto out;
>  		}
>  
> +		mutex_lock(&tlmi_mutex);
>  		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> +		}
>  		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>  				tlmi_priv.pwd_admin->save_signature);
> +
> +		mutex_unlock(&tlmi_mutex);
>  		if (ret)
>  			goto out;
>  	} else if (tlmi_priv.opcode_support) {
> @@ -1021,18 +1037,23 @@ static ssize_t current_value_store(struct kobject *kobj,
>  			goto out;
>  		}
>  
> +		mutex_lock(&tlmi_mutex);
>  		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> +		}
>  
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>  					tlmi_priv.pwd_admin->password);
> -			if (ret)
> +			if (ret) {
> +				mutex_unlock(&tlmi_mutex);
>  				goto out;
> +			}
>  		}
> -
>  		ret = tlmi_save_bios_settings("");
> +		mutex_unlock(&tlmi_mutex);
>  	} else { /* old non opcode based authentication method (deprecated)*/
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> @@ -1056,14 +1077,17 @@ static ssize_t current_value_store(struct kobject *kobj,
>  			goto out;
>  		}
>  
> +		mutex_lock(&tlmi_mutex);
>  		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&tlmi_mutex);
>  			goto out;
> -
> +		}
>  		if (auth_str)
>  			ret = tlmi_save_bios_settings(auth_str);
>  		else
>  			ret = tlmi_save_bios_settings("");
> +		mutex_unlock(&tlmi_mutex);
>  	}
>  	if (!ret && !tlmi_priv.pending_changes) {
>  		tlmi_priv.pending_changes = true;

And the same here.

Regards,

Hans


