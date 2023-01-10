Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9566480F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjAJSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjAJSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:03:12 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6570175AA;
        Tue, 10 Jan 2023 10:00:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a25so4447852qto.10;
        Tue, 10 Jan 2023 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyG+8YFdvLUpAei0RlPj/u0E083+3iqqd0fUYi+e4hI=;
        b=hlUlj1T6QU9tmHjx0VkzeyTxfiMYHflpa1gJ0uZbgUy3PnNKj3MwGqgcohq0hDaL2M
         4y1giI0+Zbzz9kqlIzCJRN76kMSYaQKqBt6dBgrxTU/wIKml2Wjm+urd9X/lHyQjr/KL
         pCWp/rsBC0ZX0+CaW4grvu+8SorABEA71iCsjJVVUjG2EA2lcNesxJDd2eaput8mFPT9
         JeKhfkgpxHCHp9z9Fh5h4sPqW0pvvCL3gXD+nzeMlBKIcJZpIZXuf+yr99suuY0MltTy
         KllYDnJZfzADROnTIuUJrCQnHMDT/5luQDbOL2uUusqQlG1NOpPXnd+MSHQZJ+d3a1S9
         ShOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyG+8YFdvLUpAei0RlPj/u0E083+3iqqd0fUYi+e4hI=;
        b=gETWRaRnibpvRz85dnFiVbXYPqmqwonx2gubAPpqt7k0OsNumguNdmftuSYnHCgInS
         7UUdPJ8GhuDmabqoL/ZpMYkv4oFYmQRf2/2EBq0io9uwgKXTpqCbNc0zd5b044cF0TaA
         GhyG5lfp3ToVsfwudac3NmeI05SiljNEriGG2XZuBkr8TKbd/hbSiIJa3rAmdDZG9Y0e
         mFPOH2/AJmIescm56wF6SdW7eJGxCAol6SQJKFhFRMthqSBs8ydQPttj3ll9g9AStAXI
         vaAH/V6Tznl4K/f5QymGvUD0e0klYx7ccOHVP++gDHARDyWsvcGyomyt53EPJtJC19Ke
         xAzQ==
X-Gm-Message-State: AFqh2kqaT54lc4AqP0cn2cBer5tboWOUkHER9pxIuaEacgpQm2JfzlFL
        Ud90HqYXak3/5/hdczvn4dj2zkdIyXE=
X-Google-Smtp-Source: AMrXdXuq2ucaPQo98qceDvz2cAnyXkU5xyZjXe32FpJCZfxeQul//Tc2B5xwKnCwIlpr/tbPcbpOLg==
X-Received: by 2002:ac8:568a:0:b0:3a6:348c:5159 with SMTP id h10-20020ac8568a000000b003a6348c5159mr82440960qta.26.1673373644030;
        Tue, 10 Jan 2023 10:00:44 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:d099:a873:89ed:9688? ([2600:1700:2442:6db0:d099:a873:89ed:9688])
        by smtp.gmail.com with ESMTPSA id z2-20020ac86b82000000b003a5c6ad428asm6299533qts.92.2023.01.10.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:00:43 -0800 (PST)
Message-ID: <1194985a-1353-2f7b-3a83-eeb317dfab83@gmail.com>
Date:   Tue, 10 Jan 2023 12:00:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] of: overlay: fix warning being reported as error in
 add_changeset_property
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     "Ankit 16. Kumar (Nokia)" <ankit.16.kumar@nokia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1671195782-23078-1-git-send-email-ankit.16.kumar@nokia.com>
 <VI1PR0701MB68298749C8133A7D69CFDBBFC9F09@VI1PR0701MB6829.eurprd07.prod.outlook.com>
 <a7e15b62-8929-b76e-77d7-42d78aaa02e1@gmail.com>
 <2ec3f5dc-b974-e799-2b96-d7b09dee4df1@gmail.com>
In-Reply-To: <2ec3f5dc-b974-e799-2b96-d7b09dee4df1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 00:23, Frank Rowand wrote:
> On 1/2/23 08:35, Frank Rowand wrote:
>> On 12/30/22 02:40, Ankit 16. Kumar (Nokia) wrote:
>>>
>>> The print causes false reporting of the issue which actually is a warning
>>
>> How did you select the commit in this Fixes tag?
>>
>>> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
>>>
>>> Signed-off-by: Ankit Kumar <ankit.16.kumar@nokia.com>
>>> ---
>>>  drivers/of/overlay.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c index ed4e6c144a68..0da39b8461e7 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>  	}
>>>  
>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, 
>>> +property: %pOF/%s\n",
>>>  		       target->np, new_prop->name);
>>>  
>>>  	if (ret) {
>>> --
>>> 2.30.1
>>>
>>
>> NACK.  This patch is incorrect.  The reported memory leak is a bug, not a warning.
>>
>> I'll write up some information about why the memory leak occurs, then reply to this
>> email with the additional info.
> 
> The additional information is now available at:
> 
>    https://elinux.org/Device_Tree_Linux#Object_Lifetime

I have now expanded the information at that link to content that is beyond
the original topic.  Those interested in devicetree memory object may find
the additional info useful.

> 
>>
>> -Frank
> 

