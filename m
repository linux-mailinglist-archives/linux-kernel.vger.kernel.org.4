Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB15E6D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIVVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiIVVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:00:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C7B3B3E;
        Thu, 22 Sep 2022 14:00:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m22so1967442lfg.0;
        Thu, 22 Sep 2022 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=y9ZryuHbz2n1RmlIcr6kYgVVPHmzSeh1TTQ2UPMCWZ8=;
        b=dY2Oab+4GOPR7pWtxem4R5vYkh4AslUQFYkkJSZA9wYVABohYQsRfHaMSfOISC8HZV
         3/U1psa699fCt+rPm8D5XobgDqNuVujopn75z+fGDEDtXEVX1mb5hkqWxqNFFkuj2ohY
         mtO+UIlQdXHLPREJVqwW15YLN7lMoXZ8T9RGM9BmOm1ZeteJQKODGOI+hNYb8YbkkYR3
         BXopDdfXSPvyZfT8PpFJb7uURdDnWpIdnqyIko8AYHaO7wfjC510ty85cjN/fDMUQ7w1
         sZez98f3sNyX+ryRsSZJoAsDLOf8BjnE56+Qd5gGBY1babtvC0HdkzS0nU7Em9a3WaxJ
         LO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y9ZryuHbz2n1RmlIcr6kYgVVPHmzSeh1TTQ2UPMCWZ8=;
        b=qzzN6ft8JvRSZtOcN4vWFsXOOTkDuldQGq6dhMB2+2ycd4UEqkbS2nqDIZVedqYD/W
         woqx83JjvMEbwH1jFgxLWPq7ozYEKGjt/7g/rCHel1JQY/yIQmVNCqdy0gP7UnjK9Z/F
         GJie7EoR7Ear1P5wkcu9RRJpQK9JzcOjOau7bFV1LNuAhLsQhlPqNdncdS8WDL/Tbude
         pAOh3U0oGMyPxWKFKKpBrfj6Pq1gW4jTEWPjHeBI+UsxRusbiN36qUgHahp6IrzTmkHH
         oVh4NVXlex4HJqRTtX6v+Ml4LRXIE8JxzpIT+dtSYlgLQ+/9H5GHSQW2cHzF3M7y1uwe
         1yDA==
X-Gm-Message-State: ACrzQf1uQ3ZdkVz5P5yke2FDxTV9lrko24+GHCSVrkm8webdW2KKKUbZ
        3DFt8eBWrEay0rKTUMNRb0k=
X-Google-Smtp-Source: AMsMyM54g87IkTa0vToTSQ0FfSnK9InN+XNBh4lGnMLzJjCjQbR/uvSQhAkDZuZAYVi6kQeWZn5zmg==
X-Received: by 2002:a05:6512:a86:b0:499:f794:5cc2 with SMTP id m6-20020a0565120a8600b00499f7945cc2mr1877553lfu.100.1663880416252;
        Thu, 22 Sep 2022 14:00:16 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.79.119])
        by smtp.gmail.com with ESMTPSA id h2-20020ac250c2000000b00497aa190523sm1095333lfm.248.2022.09.22.14.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 14:00:15 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
To:     Greg KH <gregkh@linuxfoundation.org>, Jim Lin <jilin@nvidia.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aniruddha TVS Rao <anrao@nvidia.com>
References: <20220908175615.5095-1-jilin@nvidia.com>
 <YxrRPxeh/iCeCW4R@kroah.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7493474c-beba-5abd-1647-2690829e3d27@gmail.com>
Date:   Fri, 23 Sep 2022 00:00:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YxrRPxeh/iCeCW4R@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/9/22 8:38 AM, Greg KH wrote:

>> NULL check is performed after params->dev is dereferenced in
>> dev_get_stats.
> 
> I do not understand this statement.
> 
>> Fixed by adding a NULL check before dereferencing params->dev and
>> removing subsequent NULL checks for it.
>>
>> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
>> Signed-off-by: Jim Lin <jilin@nvidia.com>
>> ---
>>  drivers/usb/gadget/function/rndis.c | 37 ++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
>> index 64de9f1b874c..d2f18f34c8e5 100644
>> --- a/drivers/usb/gadget/function/rndis.c
>> +++ b/drivers/usb/gadget/function/rndis.c
>> @@ -198,6 +198,9 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
>>  	outbuf = (__le32 *)&resp[1];
>>  	resp->InformationBufferOffset = cpu_to_le32(16);
>>  
>> +	if (!params->dev)
>> +		return -ENODEV;
>> +
> 
> As Sergey points out, this check is useless and the ones below should
> also be removed.

   Would you accept this patch modulo the above check then? If not,
I'll just resolve the corresponding SVACE checker as "won't fix" here. :-)

> But, why make this check at all, how did you trigger a problem with the
> current code?

   There's no problem, just the redundant NULL checks...

> Are you using this driver?  If so, why?  It is totally broken (as per
> the specification) and we really really need to just delete it from the
> tree to prevent anyone else from ever using it.

   Well, delete it then... :-)

> thanks,
> 
> greg k-h

MBR, Sergey
