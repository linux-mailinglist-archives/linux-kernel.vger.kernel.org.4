Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACC76EA568
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjDUH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDUH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645809757
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682063726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESPESgM91xh/lMsc1yOsPFi1GlFz8zsJkocCN9t7IWU=;
        b=VoDOK/i26y65nCcrGxweY/v3Ybw5iRgOjrDQKEpTaCh4DXTG7oC5BVAJoJN49VlouYTnMq
        TO+jwAumYD3Z+ES2LEhMij06Wrr/KpvsDYFLcKRZMDMDxUYK7GkHrlYee5WIvi0XZoVoVu
        Esm1vpleelfjAbKw9LLSp4PNjQpWlIM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-geQtMnhQMS-ZxFwOTZgCKg-1; Fri, 21 Apr 2023 03:55:25 -0400
X-MC-Unique: geQtMnhQMS-ZxFwOTZgCKg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5066c9c2ed6so1572050a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063723; x=1684655723;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESPESgM91xh/lMsc1yOsPFi1GlFz8zsJkocCN9t7IWU=;
        b=S2AKR6fSetdyhD9qcUzm2wKkNkEV7i7MEuPuOJEOs5SGrhiRdHNp9S1A/Yu73kdnSp
         UtT1ONjr92SIIlRiyF8lk5ugaLxEXaJmeKI456jQysBlif54YFbIcbhmGZTxcGApgoRn
         ROTh3hPqGwGl/zRAkrnLED8qFrFCFUecLuUpxkugodeLUWOUPjpEq5Q6insDb78mdu1w
         xuMPJxTumITfRvgbhVQRALfBJ9fOTl8QHI1R/MVA4farvhw8ZRVvcC1EMmiKKEK9KKyB
         wvfOgHlyXPSZbh7C0XTeYmqTD3pjBaP4/NIGztFswFQs4eetd6So3ZdIkQ0u5C4aRDYN
         85Ew==
X-Gm-Message-State: AAQBX9cCLNsOEsfQhnLqhczLWMtZPeRLuKB40ZsNXTKIbd3Q63+6txGX
        ngHhmAb4auZ6uENRHhXb7AXD6txg427Xv3Tl59GYwhcbgAVYlpZMNRk75UUwVDvTWTJaOqQ6Th3
        Aywtv1Xv9VeJoXvAAv1NcSjTx
X-Received: by 2002:aa7:de92:0:b0:504:a2c8:ea60 with SMTP id j18-20020aa7de92000000b00504a2c8ea60mr3870174edv.35.1682063723518;
        Fri, 21 Apr 2023 00:55:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350YJgL61ShkQoLQ//neSduz5Vb3bvnQFRw0O5sty7xGAP4DjPX2wDuYK66FDTSaxFjHLfrDj/w==
X-Received: by 2002:aa7:de92:0:b0:504:a2c8:ea60 with SMTP id j18-20020aa7de92000000b00504a2c8ea60mr3870164edv.35.1682063723249;
        Fri, 21 Apr 2023 00:55:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x3-20020aa7cd83000000b004fbf6b35a56sm1588535edv.76.2023.04.21.00.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:55:22 -0700 (PDT)
Message-ID: <fef45f01-81ee-c973-3d4f-86d537df98b6@redhat.com>
Date:   Fri, 21 Apr 2023 09:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/6] iio: st_sensors: Add lsm303d support
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marius Hoch <mail@mariushoch.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230415231130.115094-1-mail@mariushoch.de>
 <3eb3de24-41b4-9566-9b11-a12d21904793@redhat.com>
In-Reply-To: <3eb3de24-41b4-9566-9b11-a12d21904793@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marius,

On 4/16/23 22:19, Hans de Goede wrote:

<snip>

> 2: There are some other unsupported sensors on these models too,
> perhaps you are interested in adding support for these too?
> 
> Here are my personal notes on this:
>  -Light sensor should work with drivers/iio/light/al3320a.c
>   https://github.com/JideTechnology/remixos-kernel/commit/c52d55b4bd907e87b7b115b3943219f3e089a77a
> 
>  -MXM1120 HALL sensor, have datasheet, measures angle of kickstand thingie, use
>   for SW_TABLET_MODE. Do a pdx86 driver just for the Tab 2 which checks that the
>   kick stand is out *and* the BT keyboard is paired, in that case report
>   SW_TABLET_MODE=0, in all other cases report SW_TABLET_MODE=1 ??
>   For the commit msg:
>   Datasheet available here: http://haechitech.com/tech-support/
>   Requires creating an account, once you have an account you can immediately download
>   the provided datasheets (or let me know if you want me to email you a copy)

A quick follow up on this, since you said you were going to take a look.

I think with the way bluetooth works under Linux, with a bunch of the work
being done in userspace that figuring out if the BT keyboard is paired is
not going to work in kernelspace. So I think the best we can do here is
simply export the angle of the kickstand as an iio angle sensor.

Regards,

Hans


