Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F863406B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKVPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiKVPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8E716F3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669131459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYJvZpyPquZ6swRZiIUcOh5y3RG1j/mpcsdgMWy7LiQ=;
        b=Cpardqg6t3Ss7nB3VrcdbaQ6cuiGx7ylZ2cYySroILs2fHYJFwLgtt7yRjLRf74pUAkkXt
        V4Jc4xpR75RD/YRFzreU87+ocvSRkuQTH9JN6Xq3okWjrFZy+WbYDV/G2dh5f0vKxP1q3X
        8SjK8t3oZub6IK3FMWIErmHdJ9pfRss=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-FdxfKEs5NymGllJQBR5nXw-1; Tue, 22 Nov 2022 10:37:38 -0500
X-MC-Unique: FdxfKEs5NymGllJQBR5nXw-1
Received: by mail-qt1-f198.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so14830988qtc.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYJvZpyPquZ6swRZiIUcOh5y3RG1j/mpcsdgMWy7LiQ=;
        b=SWTbHgjG5gYodTapV4MmWSEiCX4VU4+dSNfiYQm60DSGXiOCnTdr4AZAkJ+pjYisIq
         VHWY2xBnj1uSCwGH+xW2al/BxfYNX4KyV7vS3qCuzVtObfjGaoG6Q9DY9F/peu2z+EOs
         Urt6Hp/V8W6TgrQaqCHrie2YEh7eTSmVOI5hEHH6Z40J5/cAT2mpMDXUTAV66smN9t4O
         sXrAshXL5diYay9K88d1V6NhmcgZ55EjzewoXzQoR7GF/6P81z3ad8QgPBVNDupJAhV3
         3A7+T40ht14XS3v40GJfxuXLb8eeVFZyPslA7OmPwFNEpwLZ+3EA5tXwd6xGuxesnf5a
         UwHQ==
X-Gm-Message-State: ANoB5pm84bQP+vIBYtkFTLlU4y60KqCWFgH7wwidf5d4VokzxLUMRcOB
        J1zkauHwppJVofOwAD9aRLbNFdvpaEtQv6H9aa+04NzbhidjQhOSoDPXIbuIh72dCU6hAQitsED
        RNGTMFgtFi1lc5mLJxf7YP8wG
X-Received: by 2002:a37:cd1:0:b0:6fb:74c7:ccf with SMTP id 200-20020a370cd1000000b006fb74c70ccfmr7682948qkm.146.1669131457578;
        Tue, 22 Nov 2022 07:37:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QcSoyyAxhrMKUbI9B03XaxqOQnOQuQhGiLn/VICj3mwjpfdUO6hBBmalLljb94SkdlehA4Q==
X-Received: by 2002:a37:cd1:0:b0:6fb:74c7:ccf with SMTP id 200-20020a370cd1000000b006fb74c70ccfmr7682932qkm.146.1669131457341;
        Tue, 22 Nov 2022 07:37:37 -0800 (PST)
Received: from [192.168.33.110] (c-73-19-232-221.hsd1.tn.comcast.net. [73.19.232.221])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006bb82221013sm10418903qko.0.2022.11.22.07.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 07:37:36 -0800 (PST)
Message-ID: <e1150971-ec16-0421-a13a-d6d2a0a66348@redhat.com>
Date:   Tue, 22 Nov 2022 10:37:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH net-next 2/2] bonding: fix link recovery in mode 2 when
 updelay is nonzero
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1668800711.git.jtoppins@redhat.com>
 <cb89b92af89973ee049a696c362b4a2abfdd9b82.1668800711.git.jtoppins@redhat.com>
 <38fbc36783d583f805f30fb3a55a8a87f67b59ac.camel@redhat.com>
 <1fe036eb-5207-eccd-0cb3-aa22f5d130ce@redhat.com>
 <5718ba71a8755040f61ed7b2f688b1067ca56594.camel@redhat.com>
Content-Language: en-US
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <5718ba71a8755040f61ed7b2f688b1067ca56594.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/22/22 09:45, Paolo Abeni wrote:
> On Tue, 2022-11-22 at 08:36 -0500, Jonathan Toppins wrote:
>> On 11/22/22 05:59, Paolo Abeni wrote:
>>> Hello,
>>>
>>> On Fri, 2022-11-18 at 15:30 -0500, Jonathan Toppins wrote:
>>>> Before this change when a bond in mode 2 lost link, all of its slaves
>>>> lost link, the bonding device would never recover even after the
>>>> expiration of updelay. This change removes the updelay when the bond
>>>> currently has no usable links. Conforming to bonding.txt section 13.1
>>>> paragraph 4.
>>>>
>>>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>>>
>>> Why are you targeting net-next? This looks like something suitable to
>>> the -net tree to me. If, so could you please include a Fixes tag?
>>>
>>> Note that we can add new self-tests even via the -net tree.
>>>
>>
>> I could not find a reasonable fixes tag for this, hence why I targeted
>> the net-next tree.
> 
> When in doubt I think it's preferrable to point out a commit surely
> affected by the issue - even if that is possibly not the one
> introducing the issue - than no Fixes as all. The lack of tag will make
> more difficult the work for stable teams.
> 
> In this specific case I think that:
> 
> Fixes: 41f891004063 ("bonding: ignore updelay param when there is no active slave")
> 
> should be ok, WDYT? if you agree would you mind repost for -net?
> 
> Thanks,
> 
> Paolo
> 

Yes that looks like a good one. I will repost to -net a v2 that includes 
changes to reduce the number of icmp echos sent before failing the test.

Thanks,
-Jon

