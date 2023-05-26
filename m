Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA56C7121EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbjEZINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbjEZIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316D101
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685088761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAAjmO+QqZSsvXAG5c3rXumlViS7qtJJsBVwCF8HN1o=;
        b=G0YklFiOxvke8V3piuAaa8/7+uzhSGyfy0h973pH0yFGZxHgHlPbT5yWTsX963ZpT2kHJK
        Jh5/sa5F7+1bwT+UhhJtUSXg06hKVBvfssjRIvIXXrXPkcS1WOfnf+VQnnEWFTG2tAqZpw
        0Znd4YhJae+mHmw2ItpqwmybVuTVPfk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-4MABhNTTNxC1UbQXkALCfA-1; Fri, 26 May 2023 04:12:39 -0400
X-MC-Unique: 4MABhNTTNxC1UbQXkALCfA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-510ec47c66aso422880a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685088758; x=1687680758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAAjmO+QqZSsvXAG5c3rXumlViS7qtJJsBVwCF8HN1o=;
        b=QZM/h5W3roPCYDYI3a9omhPbLh+canqkAHDYBcICyB/9Gz3dyAtJmpni8QChQ0zmDf
         +oviTBVFmG1LSYw63JbJl9B/opuZn/pbQnkLLb/1IDxRu9hKWEbbM9R95rOBqrVuAW4J
         vHr0QGSCXdWSlGQO8OHQk+Z7nSWDCmmx4rLUafz7lZ4Sw5fLKJrMp2d8CzARLbIPBkef
         AEMCFZvdkyhMIy+YnY5mHj/1/uL4ZRWgY7D2IFZGkGuaFbxe9T5rsj3AP6lxDYRA1y91
         Oirwa0dzodr6T4tBaR5AZVsNVRlaIMlDXmTtcF30nA4DmtX5dtoliemdgJGD9OmQmGvt
         Uu6Q==
X-Gm-Message-State: AC+VfDxO4O5alT9DBGroBIx2juWEtRKcvkeUPPsspezdkecJittdsx2k
        5eqIIdGxJrPJ3lzIPtfEbvIzv8fAjA/NYWnVcT/uUtBYBomrLXn6iZ13BpQxPv6047YJlca6DYk
        +GV+rwr2J+qtdTSzFBAq99BHyUws1/TFv
X-Received: by 2002:a17:907:168c:b0:973:d27e:bd87 with SMTP id hc12-20020a170907168c00b00973d27ebd87mr539455ejc.25.1685088757812;
        Fri, 26 May 2023 01:12:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48BE1JhPVxp0HfP1bwE5xQa7QoOwHmlfTZGPR1mBON8+fSBUkhs5jw8w6QAIdJr0I0MzSBXA==
X-Received: by 2002:a17:907:168c:b0:973:d27e:bd87 with SMTP id hc12-20020a170907168c00b00973d27ebd87mr539437ejc.25.1685088757467;
        Fri, 26 May 2023 01:12:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gs8-20020a170906f18800b0096f4389714csm1844908ejb.55.2023.05.26.01.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:12:36 -0700 (PDT)
Message-ID: <4b49873e-48ae-1164-739f-78d96ca3a7bb@redhat.com>
Date:   Fri, 26 May 2023 10:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] platform/x86: think-lmi: mutex protection around
 multiple WMI calls
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
 <6e05df16-7125-a634-6b99-3cf3079d3d5d@redhat.com>
 <f6b0b842-3ef0-4c48-afca-6d9953993c9e@app.fastmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f6b0b842-3ef0-4c48-afca-6d9953993c9e@app.fastmail.com>
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

On 5/25/23 21:50, Mark Pearson wrote:
> 
> 
> On Thu, May 25, 2023, at 3:41 PM, Hans de Goede wrote:
>> Hi Mark,
>>
>> On 5/25/23 21:31, Mark Pearson wrote:
>>> Add mutex protection around cases where an operation needs multiple
>>> WMI calls - e.g. setting password.
>>>
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> Changes in V2: New commit added after review of other patches in series.
>>>
>>>  drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++++--------
>>>  1 file changed, 35 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index 64cd453d6e7d..f3e1e4dacba2 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/acpi.h>
>>>  #include <linux/errno.h>
>>>  #include <linux/fs.h>
>>> +#include <linux/mutex.h>
>>>  #include <linux/string.h>
>>>  #include <linux/types.h>
>>>  #include <linux/dmi.h>
>>> @@ -195,6 +196,7 @@ static const char * const level_options[] = {
>>>  };
>>>  static struct think_lmi tlmi_priv;
>>>  static struct class *fw_attr_class;
>>> +static DEFINE_MUTEX(tlmi_mutex);
>>>  
>>>  /* ------ Utility functions ------------*/
>>>  /* Strip out CR if one is present */
>>> @@ -463,23 +465,32 @@ static ssize_t new_password_store(struct kobject *kobj,
>>>  			sprintf(pwd_type, "%s", setting->pwd_type);
>>>  		}
>>>  
>>> +		mutex_lock(&tlmi_mutex);
>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordType", pwd_type);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			mutex_unlock(&tlmi_mutex);
>>>  			goto out;
>>> -
>>> +		}
>>>  		if (tlmi_priv.pwd_admin->valid) {
>>>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>>  					tlmi_priv.pwd_admin->password);
>>> -			if (ret)
>>> +			if (ret) {
>>> +				mutex_unlock(&tlmi_mutex);
>>>  				goto out;
>>> +			}
>>>  		}
>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordCurrent01", setting->password);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			mutex_unlock(&tlmi_mutex);
>>>  			goto out;
>>> +		}
>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordNew01", new_pwd);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			mutex_unlock(&tlmi_mutex);
>>>  			goto out;
>>> +		}
>>>  		ret = tlmi_simple_call(LENOVO_OPCODE_IF_GUID, "WmiOpcodePasswordSetUpdate;");
>>> +		mutex_unlock(&tlmi_mutex);
>>>  	} else {
>>>  		/* Format: 'PasswordType,CurrentPw,NewPw,Encoding,KbdLang;' */
>>>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s,%s;",
>>
>>
>> I haven't take a really close / good look yet. But at a first glance
>> I think it would be cleaner to just take the mutex at the top
>> and unlock it after the out label to which all the existing goto-s
>> already go ?
>>
> I did consider that - and it was in my first implementation; but then I got concerned
> about if the mutex_unlock could potentially get called without mutex_lock having been 
> called beforehand. I couldn't find any good reference as to whether that was safe or not.
> 
> I ended up deciding that a few extra brackets and unlock calls wasn't that ugly and was 'safer'...and 
> so went that route.
> 
> Happy to change it - but do you happen to know if it's safe to call unlock without a lock? If it is then
> that implementation is cleaner.

It is not allowed to unlock without a lock. But if you put the lock directly after the malloc for which the out: does the free then there should be no goto out paths which don't have the lock.

E.g. for new_password_store() put it here:

        new_pwd = kstrdup(buf, GFP_KERNEL);
        if (!new_pwd)
                return -ENOMEM;

	mutex_lock(&tlmi_mutex);

	/* Strip out CR if one is present, setting password won't work if it is present */
	...

This does mean also taking the lock in the case where the new password store is done with a single WMI call, but that is not an issue. It makes things a tiny bit slower but WMI calls already are not fast and it is not like we are going to change the password / settings 100-times per second.

And the same thing can be done in current_value_store():

        new_setting = kstrdup(buf, GFP_KERNEL);
        if (!new_setting)
                return -ENOMEM;

	mutex_lock(&tlmi_mutex);

        /* Strip out CR if one is present */
        ...

Regards,

Hans



