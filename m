Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5966C1430
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCTN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCTN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33D279AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679320660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+CEP1ecKYJJWy5MN12l2QlgzIzK+4nT+47I9FyLBHw=;
        b=CAsggrfse9aTT8BIHOdHFT92VD34qhPFL9BP3ORPrkDfMPbJZkFr2wcydAxl755QCtZCI6
        YyBnaWgk1EHJ7u4g7HJMVpboax3AcKDjsDY6vO35kF+6Dc9js7mT2qk/lXtCEP23MCjBG0
        bUKII3vp5w1arFr8wgCJGqihFxO/oEQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-s__V3VN4PeOdbuUVjhY9OQ-1; Mon, 20 Mar 2023 09:57:38 -0400
X-MC-Unique: s__V3VN4PeOdbuUVjhY9OQ-1
Received: by mail-ed1-f69.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so17826294edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679320657;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+CEP1ecKYJJWy5MN12l2QlgzIzK+4nT+47I9FyLBHw=;
        b=XGZLtn/yYN0OjCpo4htLYGZvBFDwss5RO8C5U2y5taP75yiKRBckBa5adQF+CSeO3f
         EYTFFVV1pCbSeRXytG7StmntD/1KeQ3LwEzX8Xj5F0GuxhRmKLk7MGi0ijR0MAt6d16B
         g1/jzQswUaN+mSs5wJq1F3/jRQ0GZQB5BwW5snOMIVw/G5WIYHJrTcfVIRdLO+yX4k3S
         OrQYFZyF5R1k78C6PakIfvkEhAWFMpohGY9w+mMmaqOan/Y4UEOyBxaUe23jpMd6fZio
         OsdSirZaLui9Zgs9+y961gjyEEVPuGdG1m9jTaI5q7CyjAEoFLcLVo7pjo0IEwnfJ9aD
         Wp7g==
X-Gm-Message-State: AO0yUKV9fSQxvynrPf8e+eSbVhGpc11VcW0l+HmUZG0nucqa0bZWVBiy
        fZ6tLmorVEGllLZEHrkbzXJerMKsjD5TjBUbrQR9RGGFkfIqjug5nelwNPd5Y4ELOtSCFumMUX+
        v3BaZSsVMuBapDN9RZFAY9kBx
X-Received: by 2002:a17:906:387:b0:92b:e1ff:be4e with SMTP id b7-20020a170906038700b0092be1ffbe4emr9127455eja.1.1679320657669;
        Mon, 20 Mar 2023 06:57:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set/cHTG68r2MYrYcSZ1mK0aDFHOnbOPGk5HohZjJSWkyIQXyxNfoIWTXYsJVrYOgw2/sbgDxKg==
X-Received: by 2002:a17:906:387:b0:92b:e1ff:be4e with SMTP id b7-20020a170906038700b0092be1ffbe4emr9127438eja.1.1679320657357;
        Mon, 20 Mar 2023 06:57:37 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b008e2dfc6382asm4448983ejz.125.2023.03.20.06.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 06:57:36 -0700 (PDT)
Message-ID: <087797f9-9303-cbf2-dcdc-c78a10f92118@redhat.com>
Date:   Mon, 20 Mar 2023 14:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/4] platform/x86: think-lmi: add missing type
 attribute
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     markgross@kernel.org, markpearson@lenovo.com, thomas@t-8ch.de,
        pobrn@protonmail.com, linux-kernel@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
 <8b6dd11e-f166-37e4-8ed4-f92b94b3a7ac@redhat.com>
In-Reply-To: <8b6dd11e-f166-37e4-8ed4-f92b94b3a7ac@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/20/23 14:56, Hans de Goede wrote:
> Hi Mark,
> 
> It seems that while adding linux-kernel@vger.kernel.org you have dropped
> platform-driver-x86@vger.kernel.org. For future patches please Cc both.
> 
> platform-driver-x86@vger.kernel.org needs to be Cc-ed for patches
> to show up in patchwork:
> https://patchwork.kernel.org/project/platform-driver-x86/list/
> 
> Which I use as my primary means of tracking which patches I need
> to review / merge (note no need to resend this series I have it
> on my radar).
> 
> More importantly you seem to not have Cc-ed
> Thomas Weißschuh on this version ?

Never mind, I just noticed that Thomas has 2 email addresses
and you did Cc their other address...

Regards,

Hans



> On 3/20/23 01:32, Mark Pearson wrote:
>> This driver was missing the mandatory type attribute...oops.
>>
>> Add it in along with logic to determine whether the attribute is an
>> enumeration type or a string by parsing the possible_values attribute.
>>
>> Upstream bug https://bugzilla.kernel.org/show_bug.cgi?id=216460
>>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v4:
>>  - Unchanged. Sending to linux-kernel mailing list as recommended
>> Changes in v3:
>>  - Rebased on latest pdx86, review_hans branch
>> Changes in v2: 
>>  - Simplify the code and move type determination into show function
>>  - Don't use Fixes with URL in commit info
>>
>>  drivers/platform/x86/think-lmi.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index cc66f7cbccf2..a765bf8c27d8 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -947,6 +947,20 @@ static ssize_t possible_values_show(struct kobject *kobj, struct kobj_attribute
>>  	return sysfs_emit(buf, "%s\n", setting->possible_values);
>>  }
>>  
>> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +		char *buf)
>> +{
>> +	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
>> +
>> +	if (setting->possible_values) {
>> +		/* Figure out what setting type is as BIOS does not return this */
>> +		if (strchr(setting->possible_values, ','))
>> +			return sysfs_emit(buf, "enumeration\n");
>> +	}
>> +	/* Anything else is going to be a string */
>> +	return sysfs_emit(buf, "string\n");
>> +}
>> +
>>  static ssize_t current_value_store(struct kobject *kobj,
>>  		struct kobj_attribute *attr,
>>  		const char *buf, size_t count)
>> @@ -1036,10 +1050,13 @@ static struct kobj_attribute attr_possible_values = __ATTR_RO(possible_values);
>>  
>>  static struct kobj_attribute attr_current_val = __ATTR_RW_MODE(current_value, 0600);
>>  
>> +static struct kobj_attribute attr_type = __ATTR_RO(type);
>> +
>>  static struct attribute *tlmi_attrs[] = {
>>  	&attr_displ_name.attr,
>>  	&attr_current_val.attr,
>>  	&attr_possible_values.attr,
>> +	&attr_type.attr,
>>  	NULL
>>  };
>>  

