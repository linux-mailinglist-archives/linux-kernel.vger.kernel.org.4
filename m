Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2035E65640F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLZQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 11:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLZQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 11:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F69FE2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672073006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3pL3cTQ8P+EkZ+tkmmVBasG/BMVwRJB5+rbf28XYV8=;
        b=AUYyDWQ3EJ5h4GzuQwq2YCk7UACUwtODoFVCa/47e+KvB7PLr9lKn3Mw4RbGqNl7iy9wWq
        FX51Dz3SP/YzF4Rl1CwiqD7xP4oYh+zgokhfl2u321VJPiV26k+GrClJG7UOd84mIuMi6c
        GHXLPxnJrkB5+woTqxwtZgnGeXgkfYs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-NpZNmrxCOESM-9ecu7-qyA-1; Mon, 26 Dec 2022 11:43:25 -0500
X-MC-Unique: NpZNmrxCOESM-9ecu7-qyA-1
Received: by mail-wr1-f71.google.com with SMTP id v4-20020adfa1c4000000b002753317406aso728617wrv.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 08:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3pL3cTQ8P+EkZ+tkmmVBasG/BMVwRJB5+rbf28XYV8=;
        b=Jea3BaEdHsxJrBXEDDPJ8bouiu9njgH9xA7fx85Yhu/RGJ1vOWJRo748hRudey+ffP
         ZWlA+g+AnRokgNSlRaG+CogMvojkaNlafPMqSGf1lV6m6/PSfD8Omp6UtdkgmoNUtAdR
         oGTnkeea9zuPRoQxofmQ56QHivvGfFOQS0x2VDhVBUCTdxWQwsLRgfcoNk2pJ54+PNf/
         bLMZWpyAmbYd2cWnxvurKjdbUpQzhoy3V+CttEfopyL+AeoxFzoJa07HB0udNVw979Mm
         B7sMPkoWduw8eA8TTcv2r5xke5KT8yk4xOTdgntrQRxalZV2dPq6V7htE61kbm1iIFy7
         TfEg==
X-Gm-Message-State: AFqh2kqLecqY42kgLjcMhX4K+LzcOm0HzOM9MB44ERNzqX5NZuSGvQpt
        lKrZulvnIh2FqgJMzD9gvwksWpFit3DDV6m5A1oaGkTtY7XvDjTEPWk67pNivC0YsWTx9zX7cHo
        WJNeOPKCKvv6c6VSJ+sAjncN7
X-Received: by 2002:a05:600c:3c9f:b0:3d9:6b72:39da with SMTP id bg31-20020a05600c3c9f00b003d96b7239damr9865088wmb.11.1672073004305;
        Mon, 26 Dec 2022 08:43:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt2Ug7UkoT1ikyApNLj7BW9efQKzPgYIf1x/YHJ+c9vwXHxnbqwQplE0ribCCFroDYEk13iyw==
X-Received: by 2002:a05:600c:3c9f:b0:3d9:6b72:39da with SMTP id bg31-20020a05600c3c9f00b003d96b7239damr9865071wmb.11.1672073004147;
        Mon, 26 Dec 2022 08:43:24 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c024600b003cfd0bd8c0asm13989526wmj.30.2022.12.26.08.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 08:43:23 -0800 (PST)
Message-ID: <3a7c442b-dcdb-0f3c-6a46-ebb921aea074@redhat.com>
Date:   Mon, 26 Dec 2022 17:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/4] drm: panel: Add Himax HX8394 panel controller
 driver
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20221226134909.2822179-1-javierm@redhat.com>
 <20221226134909.2822179-2-javierm@redhat.com> <Y6m4LONOyoPo/+Cv@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y6m4LONOyoPo/+Cv@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
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

Hello Sam,

On 12/26/22 16:05, Sam Ravnborg wrote:
> Hi Javier.
> 
> On Mon, Dec 26, 2022 at 02:49:05PM +0100, Javier Martinez Canillas wrote:
>> From: Kamil Trzciński <ayufan@ayufan.eu>
>>
>> The driver is for panels based on the Himax HX8394 controller, such as the
>> HannStar HSD060BHW4 720x1440 TFT LCD panel that uses a MIPI-DSI interface.
>>
>> Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>

Thanks!
 
> Strictly speaking the binding should be applied before the driver.
>

Indeed. I'll change the order of the patches in the next iteration.

Funny that I added to Documentation/devicetree/bindings/submitting-patches.rst
that info in commit ef0b97e3daea ("Documentation: dt-bindings: Explain order
in patch series"), but didn't follow my own advice :)

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

