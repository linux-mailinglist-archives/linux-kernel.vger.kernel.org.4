Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE16576DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiL1NSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1NSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:18:08 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F8B36;
        Wed, 28 Dec 2022 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JzEiDFI5EH6PN63FRnjKDVSaqSSqZ6cbt0nBtY//C7I=; b=h2RnegPWDsKYsJUcS62pCEUwzY
        7KBi2vS+4R0PubsiVVSummaOQh7e2XbmM0JemyvxQ5sqF+dRIzXLxCeUWHp5Qj/LXLd8rC3niw5t7
        wp1vUTWF8T/Ej1T1MkMrztJbivXSJgSaX/6nr6m8Hcb0urJNzD0fJfKt3j3bI87UOyQM2w3iiM9xM
        Qv5mmeDGXnTjiSSyni09PtrKVHyyrIQyEZVcTwE1doB0Oj7cd9I4JIM1Bos70FNWhqCSEbKrYTwit
        7vE30X31wtYyiCE0cMUpYkb7fKtqg9p7Cd/wmT6zT0UdqYaP8jpa+we9ZPCEn6qfF25ksmOSudC5m
        T44MPmHQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pAWJk-008grl-2M; Wed, 28 Dec 2022 15:18:00 +0200
Message-ID: <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
Date:   Wed, 28 Dec 2022 15:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/tegra: submit: No need for Null pointer check before
 kfree
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi> <Y6w/4IzoMFsVnCmu@qemulion>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <Y6w/4IzoMFsVnCmu@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 15:08, Deepak R Varma wrote:
> On Wed, Dec 28, 2022 at 02:28:54PM +0200, Mikko Perttunen wrote:
>> On 12/27/22 19:14, Deepak R Varma wrote:
>>> kfree() & vfree() internally perform NULL check on the pointer handed
>>> to it and take no action if it indeed is NULL. Hence there is no need
>>> for a pre-check of the memory pointer before handing it to
>>> kfree()/vfree().
>>>
>>> Issue reported by ifnullfree.cocci Coccinelle semantic patch script.
>>>
>>> Signed-off-by: Deepak R Varma <drv@mailo.com>
>>> ---
>>>    drivers/gpu/drm/tegra/submit.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
>>> index 066f88564169..06f836db99d0 100644
>>> --- a/drivers/gpu/drm/tegra/submit.c
>>> +++ b/drivers/gpu/drm/tegra/submit.c
>>> @@ -680,8 +680,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
>>>    		kfree(job_data->used_mappings);
>>>    	}
>>>
>>> -	if (job_data)
>>> -		kfree(job_data);
>>> +	kfree(job_data);
>>> +
>>>    put_bo:
>>>    	gather_bo_put(&bo->base);
>>>    unlock:
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>> It continues to be the case that I think this transform is bad. Same applies
>> to the host1x patch.
> 
> Hello Mikko,
> Thank you for responding to the patch proposal. Could you please explain why is
> this bad?
> 
> Regards,
> ./drv
> 
>>
>> Mikko
> 
> 

Hi,

it gets rid of visual hints on code paths indicating the possible 
liveness of pointer variables. I.e., after the change, whether the 
pointer can be NULL or not is more difficult to reason about locally, 
instead requiring more global reasoning which is mentally more taxing.

Since C's type system doesn't help with tracking these kinds of things, 
I believe it is important to have these kinds of local contextual cues 
to help the programmer.

Mikko
