Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88A5BCA91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiISLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiISLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CFC167FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663586337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx7E01hSyU80wB3SXnhVQQqt90Oj6j/7g7l/TvkhTeg=;
        b=AcsrZSn1hGFBVym65BiJvtknnvRnHJN86TOD0LTTyuf501k3BkrU67J4/SMm+gVcvObMcD
        OWYw2a18V0WGxr2+nePhs1PxV6zceQRyfdoAKC+7xetRjOhZoMG8CUKLpnEvhWn7niw2u5
        sLzRfUVmrBVnQfpoMNIG7RGAHIpHOc0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-Z00D22h1Nb-gbH2l69sQqg-1; Mon, 19 Sep 2022 07:18:55 -0400
X-MC-Unique: Z00D22h1Nb-gbH2l69sQqg-1
Received: by mail-ej1-f70.google.com with SMTP id nc18-20020a1709071c1200b00780b046fb4eso2133347ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kx7E01hSyU80wB3SXnhVQQqt90Oj6j/7g7l/TvkhTeg=;
        b=jYcf7H961YVMl9yGb0CE/gNW5tQ8na2wys6DbEsQNT1C745PMzH4z+fh5UDwfakvvD
         XyAvAL6hlHGwcHlKK1TZUT3rdth/D+1sAoKv2fVIYhsSMqQhKGxHQCI8eMVvpUJWuTWU
         MPsrOKk7QQRS+Crax5RFck9uqkfjvj+1VoH15e4oNLqdcTA6S8AbFBO2k3TdIZMjezK8
         XATlAoUPmo133sYwrcHZryne2rYqR3quVUx4pPw3GXfO+FjwJYvlrQunUHVH9sXI7Wme
         6sGnM0seLL2d2JEKddUVTScjRIRdNZ8v+FMbRyznopb9ssRtySRxwhdJjSdK3xcGjG7o
         /MMg==
X-Gm-Message-State: ACrzQf2z+rdpYXEXNFr7m7s4E6raybYhDi4Lb0Se5GqMPWlIuN5u0x0v
        sgW1oOO7kqpPOMs568VWIRVsyxGdBLyRpwcl5k2U3yVdUOIpbP9s9nRtWnmCU3mbJbRW5gnlgpy
        kMHnqZRvO/9ZFO2D+bmt97ms3
X-Received: by 2002:a17:906:8457:b0:781:648c:3495 with SMTP id e23-20020a170906845700b00781648c3495mr2101338ejy.541.1663586334774;
        Mon, 19 Sep 2022 04:18:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM714cXvKgCSSJ+a8DKsDXrhpoN4BCzjAgwe5qdPnPLrQ2CLdb1EYO5ot7l5URRtlD/madaG4g==
X-Received: by 2002:a17:906:8457:b0:781:648c:3495 with SMTP id e23-20020a170906845700b00781648c3495mr2101321ejy.541.1663586334580;
        Mon, 19 Sep 2022 04:18:54 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402028500b004542c37e68esm1661498edv.33.2022.09.19.04.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:18:54 -0700 (PDT)
Message-ID: <a60266df-bf73-57e7-129a-f5395d373f1f@redhat.com>
Date:   Mon, 19 Sep 2022 12:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/5] ACPI: battery: Allow battery hooks to be registered
 multiple times.
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     markgross@kernel.org, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-4-W_Armin@gmx.de>
 <wY3UHtenNt5tmQSMtoDLmzNxvJ7B56SLwlhguYfg6rqC71dDDCYypvSqvS0SUhRJwsel8wBEy3yeS8rDlJCOii24Llo0XKU34IcSn5WNwg8=@protonmail.com>
 <155062a9-8d1a-e771-1bee-35580b1b2b73@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <155062a9-8d1a-e771-1bee-35580b1b2b73@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/22 18:29, Armin Wolf wrote:
> Am 12.09.22 um 18:42 schrieb Barnabás Pőcze:
> 
>> Hi
>>
>> 2022. szeptember 12., hétfő 14:53 keltezéssel, Armin Wolf írta:
>>
>>> Registering multiple instances of a battery hook is beneficial
>>> for drivers which can be instantiated multiple times. Until now,
>>> this would mean that such a driver would have to implement some
>>> logic to manage battery hooks.
>>>
>>> Extend the battery hook handling instead.
>> I think this is already possible by embedding the acpi_battery_hook
>> object inside the driver's device specific data object, no?
>>
>> Regards,
>> Barnabás Pőcze
>>
>>
> Yes, it indeed is. However afaik it is not possible to pass instance-specific
> data to such an embedded battery hook. It could be possible by passing the
> battery hook as an argument to add_battery()/remove_battery() and using container_of(),
> but in my opinion this would be too much of a quick hack.

Actually thinking more about this (after my reviewed-by of 4/5) I believe
that leaving the lifetime management of the struct acpi_battery_hook hook
in the caller and then modifying 4/4 to pass the hook to the callback,
so that the callback can indeed do container_of to get its top-level
driver-data struct would be a better/cleaner solution then this patch +
patch 4/5 .

Doing things this way is quite normal in the kernel and doing a single
large alloc is better then a bunch of small allocs. In this case it does
not really matter, but if we do things like this over all drivers
eventually all the small mallocs add up.

Doing things this way would also reduce the amount of churn in this
series a bit.

Regards,

Hans

