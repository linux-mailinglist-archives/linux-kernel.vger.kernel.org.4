Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4527657352
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiL1GhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiL1Ggz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770FAE08B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672209366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+zBLxn+Zbw2TrfTyqVY7Ndr4jEPeMjeEB3bk31p0XY=;
        b=Pft5azIOCC3uPJ5T5U1jGBGi/ss7G1jdX9wf5biaYvKHwd8qiiylNAwbOwwCImgiaoovYz
        7vdFilbNAFENexzHTClAuOZITRGkRC5NeKx0Q2ZqGFx4PUSQ+LToHUjDP7ePsa35g4e2/M
        x1NqRl0WAUC8bNpk43/l/+7wteM4XHI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-Ut6dEUfEOC2I8PqfW2Ynew-1; Wed, 28 Dec 2022 01:36:04 -0500
X-MC-Unique: Ut6dEUfEOC2I8PqfW2Ynew-1
Received: by mail-pg1-f199.google.com with SMTP id 23-20020a630017000000b0048d84f2cbbeso7545575pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+zBLxn+Zbw2TrfTyqVY7Ndr4jEPeMjeEB3bk31p0XY=;
        b=KjfTQ9zXztGlKOUk2+qO/Fpt7Q95m5GtMCeOLDIUsAdJFIzJB8IutpwmuVpwO2HpLb
         AY0PFY3lPovOFGonLzsnY0QXVm9aEOJgw6iF0OwylrmHMEvdoMtB23eOyMh7OHj4XeYG
         mRuIm8dJNGBQiuvUFKuZMOXnDnvALVYOALcuBb3oLWRWptb4Bde8ZjwK/zyFzb1ee4U2
         eH7H5NMvNeM0cueNG/exa1LEnHYokD9Wq8BGB4qaOJ6PyFvkMkZ/CX3lw1NMW+NiRTP+
         AziGuwyCKZbBx0qJvSlxbtvecs01zes7WK1rMzfZfKUimrAlX/82Ft2+giYd2B7De9gk
         VL4g==
X-Gm-Message-State: AFqh2kr3dZX0nKyddvKW/i4EmKjUdjRUCe9nIAK2CcOGQz96POivwN77
        DQZuD4lsBXCatIh5mZ4dV6D7vtLUR8BeCb7JUdsrrT9fs4gqNVpqmtfcuGAQJdcKHZAp6mTHGZV
        DwD5J0iFpC0iu1R0BiP8kP8pW
X-Received: by 2002:a17:902:ee41:b0:191:2181:d6e0 with SMTP id 1-20020a170902ee4100b001912181d6e0mr24566551plo.8.1672209363805;
        Tue, 27 Dec 2022 22:36:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7PTvGIi4AYHXcrJhhBc8J2Wq9geK2D6iRjgRfX+XHd+/ICMcRm+yCxoD9vchCHpVfGZfBhQ==
X-Received: by 2002:a17:902:ee41:b0:191:2181:d6e0 with SMTP id 1-20020a170902ee4100b001912181d6e0mr24566543plo.8.1672209363600;
        Tue, 27 Dec 2022 22:36:03 -0800 (PST)
Received: from [10.72.13.7] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00186ad73e2d5sm10086583pls.208.2022.12.27.22.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 22:36:03 -0800 (PST)
Message-ID: <03d53bb3-49e8-4bab-176f-f76fdede885a@redhat.com>
Date:   Wed, 28 Dec 2022 14:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
 <20221227042855-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227042855-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/27 17:31, Michael S. Tsirkin 写道:
> On Tue, Dec 27, 2022 at 05:17:20PM +0800, Jason Wang wrote:
>>>>> In particular, we will also directly break the device.
>>>> It's kind of hardening for malicious devices.
>>> ATM no amount of hardening can prevent a malicious hypervisor from
>>> blocking the guest. Recovering when a hardware device is broken would be
>>> nice but I think if we do bother then we should try harder to recover,
>>> such as by driving device reset.
>>
>> Probably, but as discussed in another thread, it needs co-operation in the
>> upper layer (networking core).
> To track all state? Yea, maybe. For sure it's doable just in virtio,
> but if you can find 1-2 other drivers that do this internally
> then factoring this out to net core will likely be accepted.


One thing that might be useful is to reuse tx_timeout() but current 
virtio-net doesn't do more than a simple warning (other drivers may try 
to reset).

So I would leave it for future investigation.

Thanks


>

