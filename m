Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11E676123
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjATXAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:00:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7630D5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674255569;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fk6zwjdAPg++qxNG9UidD0OeR2HvPJDJMjUwVtjzkS8=;
        b=UGMoyY6NhLWVM/81n1gVCLr1L/S5/vX3I+JjLZ5UJrnjEk+GMZJVWRI+7rxBMs4NvPVfXQ
        URiQmRS5dlVlG/Epjcp2pDmR76Xqf/UWgI06jbuSddeDtpfnZETj6wq0qH6n6ApalR85Ha
        I0+Yhzj2xIwpeKfoGPvvpojihzPxyxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-x84FmGXwMB2dQ7ouR-CW5w-1; Fri, 20 Jan 2023 17:59:26 -0500
X-MC-Unique: x84FmGXwMB2dQ7ouR-CW5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 120BD8533AE;
        Fri, 20 Jan 2023 22:59:26 +0000 (UTC)
Received: from [10.64.54.98] (vpn2-54-98.bne.redhat.com [10.64.54.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9114A40C6EC4;
        Fri, 20 Jan 2023 22:59:23 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] drivers/base/memory: Use array to show memory block
 state
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        osalvador@suse.de, rafael@kernel.org, shan.gavin@gmail.com
References: <20230120055727.355483-1-gshan@redhat.com>
 <20230120055727.355483-3-gshan@redhat.com> <Y8qTyEgc8ih6M+DW@kroah.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <bf2a6311-4610-6cdd-1810-2419ff330871@redhat.com>
Date:   Sat, 21 Jan 2023 09:59:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Y8qTyEgc8ih6M+DW@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 12:14 AM, Greg KH wrote:
> On Fri, Jan 20, 2023 at 01:57:27PM +0800, Gavin Shan wrote:
>> Use an array to show memory block state from '/sys/devices/system/
>> memory/memoryX/state', to simplify the code.
>>
>> No functional change intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/base/memory.c | 25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index b456ac213610..9474f25c452c 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -141,28 +141,15 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>>   			  char *buf)
>>   {
>>   	struct memory_block *mem = to_memory_block(dev);
>> -	const char *output;
>> +	static const char *const mem_state_str[] = {
>> +		NULL, "online", "going-offline", NULL, "offline",
>> +	};
>>   
>> -	/*
>> -	 * We can probably put these states in a nice little array
>> -	 * so that they're not open-coded
>> -	 */
>> -	switch (mem->state) {
>> -	case MEM_ONLINE:
>> -		output = "online";
>> -		break;
>> -	case MEM_OFFLINE:
>> -		output = "offline";
>> -		break;
>> -	case MEM_GOING_OFFLINE:
>> -		output = "going-offline";
>> -		break;
>> -	default:
>> -		WARN_ON(1);
>> +	if (WARN_ON(mem->state >= ARRAY_SIZE(mem_state_str) ||
>> +		    !mem_state_str[mem->state]))
> 
> Ick, the whole WARN_ON() should just be removed please.  We don't want
> to reboot any systems if this changed incorrectly.
> 
> Please fix this up to properly handle this and keep going on, don't mess
> with WARN_ON() anymore in code that can recover properly.
> 

Thanks for your review, Greg. Indeed, the WARN_ON() here is no sense because
the warning can be caught from the return value. "ERROR-UNKNOWN-%ld\n" is
returned for unknown or invalid state.

I will drop WARN_ON() in v2. PATCH[1/2] won't be reposted since it has been
merged to driver.core git tree.

Thanks,
Gavin

