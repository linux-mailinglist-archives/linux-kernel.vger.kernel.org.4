Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E7677775
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjAWJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14819681
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674466399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=040KxTs2ePdANSvvw1yof3NNnbhFNmWMhiFuux+g674=;
        b=g25zDl+RStgvhPYZqcSGLBSPwVZ+k+dOky0LrKa7LjrbMh4tKcrXiHs2W/wB0oQxPZrK1O
        T1EedMlQY79YU/j4086argApsgpiTjLztMSrf5usl3ZyjXt3e+bcIHB+ZrYc6+Kvj5GBXZ
        WyEocA2h+nMuDMBrhVCJizXXUgk+fGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-Swrub1QiMk2wxH-CMWmkAA-1; Mon, 23 Jan 2023 04:33:18 -0500
X-MC-Unique: Swrub1QiMk2wxH-CMWmkAA-1
Received: by mail-wm1-f71.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso9141656wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=040KxTs2ePdANSvvw1yof3NNnbhFNmWMhiFuux+g674=;
        b=7I0BP/Jw3EUzEYXot8VYlROla7WIHqwYnzOVScCf479sU03Jd5tfrTQeqo65eyxErZ
         SmrMJbPg9vIU080vXGfo9KCqcw+IosRG67D1OcyLyV5XtXhDPH5abCUqqgD+Et8BRDDk
         k6Ej9jRG2q/1raF9iqWrG1ccZVvZ2YZDicFS3cgMiPaFagUWXpkFwKPsN6y4dYDTlq/F
         pXSkspJvBWb4JnaOVeeKlVYgNFEBtuTCclHFM05EmKSQSi6XzwpMDEwHCZXCmXN3bFms
         u47+lWzavEYJKWWQPl5+omqgLf4fZhNPHk4UXnrpIUTb+cwEbExDCXCLpE7yskj+hZA/
         YN5A==
X-Gm-Message-State: AFqh2kpBha+CiyeQhyfY5FCeJvolJzmCPLTTPr4JIdBIk4B6QI/ABwly
        IkRNYZ/2IAyd3XJNeEEuRutLkh4kOc5E/l0470vy4D9kQ6KI/tXNIeWD2sfVaBBVHZa1bYwDRBg
        KBXZybE//Kwyg3hh1boDDUQU+
X-Received: by 2002:adf:f606:0:b0:24b:b74d:8012 with SMTP id t6-20020adff606000000b0024bb74d8012mr19726906wrp.18.1674466396956;
        Mon, 23 Jan 2023 01:33:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQpTzU7cfyCuVx0tTBCPbzhfOp0nkTV+MwfSNgRDFPKbLiOPd39w/YPxOVRaorNKJwI43Zkw==
X-Received: by 2002:adf:f606:0:b0:24b:b74d:8012 with SMTP id t6-20020adff606000000b0024bb74d8012mr19726896wrp.18.1674466396741;
        Mon, 23 Jan 2023 01:33:16 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w8-20020adf8bc8000000b002bdc39849d1sm30257956wra.44.2023.01.23.01.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:33:16 -0800 (PST)
Message-ID: <c7a21f75-35c8-486b-1f10-7c536573cd2a@redhat.com>
Date:   Mon, 23 Jan 2023 10:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/ssd130x: Silence a `dubious: x & !y` warning
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20230121190930.2804224-1-javierm@redhat.com>
 <e5279ea9dfab400c8e6cd9346fb41a1d@AcuMS.aculab.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e5279ea9dfab400c8e6cd9346fb41a1d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Thanks for your feedback.

On 1/23/23 10:26, David Laight wrote:
> From: Javier Martinez Canillas
>> Sent: 21 January 2023 19:10
>>
>> The sparse tool complains with the following warning:
>>
>> $ make M=drivers/gpu/drm/solomon/ C=2
>>   CC [M]  drivers/gpu/drm/solomon/ssd130x.o
>>   CHECK   drivers/gpu/drm/solomon/ssd130x.c
>> drivers/gpu/drm/solomon/ssd130x.c:363:21: warning: dubious: x & !y
>>
>> This seems to be a false positive in my opinion but still we can silence
>> the tool while making the code easier to read. Let's also add a comment,
>> to explain why the "com_seq" logical not is used rather than its value.
>>
>> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>>  drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
>> index c3bf3a18302e..b16330a8b624 100644
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -81,7 +81,7 @@
>>  #define SSD130X_SET_PRECHARGE_PERIOD2_MASK	GENMASK(7, 4)
>>  #define SSD130X_SET_PRECHARGE_PERIOD2_SET(val)	FIELD_PREP(SSD130X_SET_PRECHARGE_PERIOD2_MASK, (val))
>>  #define SSD130X_SET_COM_PINS_CONFIG1_MASK	GENMASK(4, 4)
>> -#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, !(val))
>> +#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, (val))
> 
> How about just changing !(val) to (val) ? 0 : 1
> It should shut the compiler up and is probably more descriptive.
> 

I'm not sure if is more descriptive than what I have with this patch. As
mentioned, I believe this really is a sparse false positive but given that
need to change, I preferred to make it quite explicit with a new variable
and a comment.

This is only executed once at driver probe time anyways.

> 	David

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

