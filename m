Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7743F70834E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjERN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjERN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10BE5C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684418175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9G+1XrAaU0cSPGAU040yGSGutqJCVEvC7RcTLOgdsIw=;
        b=IRBP7pdCeUfMKJ/LRqllgoxn8x/LIhYHIaX7MyrJhG+uGQWO6lNxfyVmYUBMkU+bTSOoP1
        jUPxEIVA8XsQUX4rIA4zxHgAOUOJIbIACQIPFnsGlb9wvQr0KBT3OzYSuF72C1117Hkmh5
        zi4E2kEBy5vkO5R2OmH/5zGs8FeNbrc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Eba1lcboPqqwfyusGekqIw-1; Thu, 18 May 2023 09:56:14 -0400
X-MC-Unique: Eba1lcboPqqwfyusGekqIw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f426ffdbc6so12057615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418171; x=1687010171;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G+1XrAaU0cSPGAU040yGSGutqJCVEvC7RcTLOgdsIw=;
        b=IsKIlTjGVmH84IBCp4kWnClPbYJDHwMqr3JZDmy9bwjKmfNyL8rXBwSWeuVLbOKIH1
         vKwC4ectRELpAQcic9bOnvGsRjDsvBpum/nR/o/hvlDysL6iJNQAwXOjA+zCtSCVGpM8
         sXKfSGw026jV5mYM6A/UlsNs5SQsPdzCGxPYFkj+pRkdEv5ushkH7vsvqgYHSyYZ3O3G
         v0AREL0ugfvkBB5oiokhjIa+HsX2cJ+eNpLjC84RxnmqoL+rJwKHkW5hKupojHAYrlsw
         2R/fyXvfSiWDBL7dh40UL3vZ+qBpPNOuYLrhmDZSSslEMVs32Alz5d5uaLM7tpsQnXzS
         3h4w==
X-Gm-Message-State: AC+VfDwmUT3tymbJTZP2WmB8EDLiS25U5gehFZafIzA711rBVwmY6w3E
        NQQhTpmw2gb/aIHAV+g4CTjn/MaWqBB0vY6jd+LNWOecVRhju3EGNiwEzAP0TDe2OP2Dgn7S/q6
        2vo5AIgNUlbtFHxpASPeCwHOn
X-Received: by 2002:a1c:7709:0:b0:3f0:7e15:f8fc with SMTP id t9-20020a1c7709000000b003f07e15f8fcmr1815030wmi.14.1684418171629;
        Thu, 18 May 2023 06:56:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zTN1jfqC6YSkeSA1dlL4CIMd/zs+KIjkUkDS2ygUv3B0QCgzy/yPlAS20AqPmbILcgoLC7w==
X-Received: by 2002:a1c:7709:0:b0:3f0:7e15:f8fc with SMTP id t9-20020a1c7709000000b003f07e15f8fcmr1815015wmi.14.1684418171265;
        Thu, 18 May 2023 06:56:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:2a00:ac0a:9a14:a490:dc02? (p200300cbc7152a00ac0a9a14a490dc02.dip0.t-ipconnect.de. [2003:cb:c715:2a00:ac0a:9a14:a490:dc02])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6442000000b002c70ce264bfsm2289924wrw.76.2023.05.18.06.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 06:56:10 -0700 (PDT)
Message-ID: <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
Date:   Thu, 18 May 2023 15:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
To:     Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
 <ZGWnq/dAYELyKpTy@infradead.org>
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.23 08:08, Sumit Garg wrote:
> On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
>>> In general: if user space controls it -> possibly forever -> long-term. Even
>>> if in most cases it's a short delay: there is no trusting on user space.
>>>
>>> For example, iouring fixed buffers keep pages pinned until user space
>>> decides to unregistered the buffers -> long-term.
>>>
>>> Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
>>> unpin in essentially one operation.
>>
>> Btw, one thing that's been on my mind is that I think we got the
>> polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
>> behavior it really should be the default, with a FOLL_EPHEMERAL flag
>> to opt out of it.  And every users of this flag is required to have
>> a comment explaining the life time rules for the pin..
> 
> It does look like a better approach to me given the very nature of
> user space pages.

Yeah, there is a lot of historical baggage. For example, FOLL_GET should 
be inaccessible to kernel modules completely at one point, to be only 
used by selected core-mm pieces.

Maybe we should even disallow passing in FOLL_LONGTERM as a flag and 
only provide functions like pin_user_pages() vs. 
pin_user_pages_longterm(). Then, discussions about conditional 
flag-setting are no more :)

... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to 
make the default be longterm.

-- 
Thanks,

David / dhildenb

