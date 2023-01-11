Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D44665B30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjAKMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjAKMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235C65FD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673439347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFAkQuK5J6VynRmWh5QJhjwoVHbQgVeBD61MItSLDEM=;
        b=hNLXZv38LtdP+FhHRWZGLaYPZRuGxftlByWR/XiltwlNfi+2Jz8jaLDGq3IiMfWgWi6Wx9
        ZNHrxaGnMT7gt0mxRB9gSkVqyAMhPRTZkRxd9Pv/XgV3Ibh4opTu8a2i6Pxo0rrChtFd5W
        UTBeMERiaBIZBjXTQF+sz0Hr/+1dEBI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-pGsX4W4qM0empz81XKM-dQ-1; Wed, 11 Jan 2023 07:15:45 -0500
X-MC-Unique: pGsX4W4qM0empz81XKM-dQ-1
Received: by mail-ej1-f71.google.com with SMTP id oz11-20020a1709077d8b00b007c0dd8018b6so10093696ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFAkQuK5J6VynRmWh5QJhjwoVHbQgVeBD61MItSLDEM=;
        b=4z1Ot0f9F5byc3uIm2lncPBidSrny2o4cWZDyT2RxwVqVLG2BLC1ySKHh313N2Zt52
         n+jzL5j7F/2zKffXLjVRfzMwSYvYVAOnp59WCWtntFZZEl7KAKGAPRoYBNAh82ORp6ho
         dGzw70QcgSPKfBACzNGIHMAJIsFzQKzic0xOhka8DSOcy3D+fvbFls4h3vhEYJ+xuOyW
         ZmbgQKVfjKCUacL6RCmjsB++BrjGgjrTFfArJ7n9MRDc+b7jgDvOREXPmzWWXz/y2JIR
         0AeSHmFbSeUFSwOf5Rm98ChKmBWr5q5Mrq4uSSPY3gMiaOc2BpyylWGRbkDBJ+ExmQUR
         VlgQ==
X-Gm-Message-State: AFqh2kqqaf4nHgOJr50g1PPtEX4zM2aSuUI4ihZAIYQKTyNyyux8mtLj
        7KpFnmq461WwaIBhbsmFU3escswLDdFftx8EuUlcBXZKQlPZmfJl53fn725sY6+LDHo5xV3Mg94
        2thkSSYneBl7JsrwcnsDWkHeS
X-Received: by 2002:a17:907:80ca:b0:7c1:20ff:c044 with SMTP id io10-20020a17090780ca00b007c120ffc044mr62441347ejc.27.1673439344784;
        Wed, 11 Jan 2023 04:15:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNpH4xqot6t0evlmhZpFZTpoa8mnkGSUeADqTRM85jhsp/Q7VbBT1hGrxbYxAdbSD0CclpOQ==
X-Received: by 2002:a17:907:80ca:b0:7c1:20ff:c044 with SMTP id io10-20020a17090780ca00b007c120ffc044mr62441334ejc.27.1673439344579;
        Wed, 11 Jan 2023 04:15:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b0084f7d38713esm2689685ejb.108.2023.01.11.04.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:15:44 -0800 (PST)
Message-ID: <4656f2a5-9a81-58b1-742e-f466fd5c5128@redhat.com>
Date:   Wed, 11 Jan 2023 13:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 03/16] platform/surface: aggregator: move
 to_ssam_device() to use container_of_const()
Content-Language: en-US, nl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-4-gregkh@linuxfoundation.org>
 <cc8125e0-a52e-f804-8e57-c3a1372ee6fc@redhat.com>
 <Y76oFmWJzEJv68yr@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y76oFmWJzEJv68yr@kroah.com>
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

On 1/11/23 13:14, Greg Kroah-Hartman wrote:
> On Wed, Jan 11, 2023 at 12:54:54PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 1/11/23 12:30, Greg Kroah-Hartman wrote:
>>> The driver core is changing to pass some pointers as const, so move
>>> to_ssam_device() to use container_of_const() to handle this change.
>>> to_ssam_device() now properly keeps the const-ness of the pointer passed
>>> into it, while as before it could be lost.
>>>
>>> Cc: Maximilian Luz <luzmaximilian@gmail.com>
>>> Cc: platform-driver-x86@vger.kernel.org
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  include/linux/surface_aggregator/device.h | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
>>> index 46c45d1b6368..24151a0e2c96 100644
>>> --- a/include/linux/surface_aggregator/device.h
>>> +++ b/include/linux/surface_aggregator/device.h
>>> @@ -229,10 +229,7 @@ static inline bool is_ssam_device(struct device *d)
>>>   * Return: Returns a pointer to the &struct ssam_device wrapping the given
>>>   * device @d.
>>>   */
>>> -static inline struct ssam_device *to_ssam_device(struct device *d)
>>> -{
>>> -	return container_of(d, struct ssam_device, dev);
>>> -}
>>> +#define to_ssam_device(d)	container_of_const(d, struct ssam_device, dev)
>>
>> There is a kernel-doc comment for this helper, I'm not sure if sphinx is going
>> to like changing this from a static inline to a #define ?
>>
>> At a minimum I guess the generated docs are going to loose some type info
>> by switching to a define. Can we keep this as a static inline ?
> 
> No, container_of_const() will not work properly as an inline function as
> you don't know the return type until the preprocessor runs.  I thought
> kerneldoc should still work just fine here as it does work for defines
> in other places.

Ok then this is fine as is. Thanks for clarifying why the switch to
a #define is necessary.

Regards,

Hans



