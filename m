Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB006D5AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjDDIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjDDIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199D170E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680596644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eondYP41ZcdqHyBgCzp/QPl5U7NA+4YRH0vpX2vJSmw=;
        b=aMJiWkJ+uDN4uqL8QeRYIgq9SwwnMD0dLxZHXP9D1zggOuWTsb1f9jrOJpx4vqUYU7JYqD
        7Qpc//pF64h8+QNdQTq+Yv5tt3awmCgxiZLqGP7mT3+WAVD9WTW3wtzy7Qs+G2BI9ePJ7x
        +GBUcsdzaisLEwLHMOveW1jJWCiuUB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-3qLG42WcMQ2L59IgdycCwg-1; Tue, 04 Apr 2023 04:24:03 -0400
X-MC-Unique: 3qLG42WcMQ2L59IgdycCwg-1
Received: by mail-wr1-f72.google.com with SMTP id c3-20020adfa303000000b002d5737d3835so3532451wrb.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596642;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eondYP41ZcdqHyBgCzp/QPl5U7NA+4YRH0vpX2vJSmw=;
        b=a7p8wDn4fUmysVESby687tuBl4ey+lpdo1mQ/zw95VXoddltqNG975B9pQtpUIx3Zm
         US173UJThLKCBLJyrnnzwHkU1rbTkeisK1bT+bjMZyiOuTZp+hj2/ctxnX4lHd6MZzjY
         ej15Y1gztokggVLZ6hHC9Zrfea1zVD2omXJYilg9XAoQQkT7WRayeOulJVaalq4sPPAN
         LoY+miVwTAc/Od9CetkeErMENHiDKeV0DdDufdB3c0pcoTuNBnFjvxWom4N79LYGbodA
         4HZfU1RQlfG313YzYKua7VjpFea1swTlhAaQx7M28ftS1O6zt2FaOC4cxV+hpmGWYFEk
         8nGQ==
X-Gm-Message-State: AAQBX9cdOYl2Kp0hI2AUh0v7YPU+NY+6oWD73OlEz7WOISpvMmiEZky+
        Lvcl+jFHtukUeYSIbi+xg4C2jzZQdHpNSmGO1Rk2yvNjg5MGraZStYeUE6ZzUxyk5OrMTKo/oA6
        qkdRzUwM4wjFp4Tgr/ntvPlR9
X-Received: by 2002:adf:dd91:0:b0:2ce:a8d6:7fc0 with SMTP id x17-20020adfdd91000000b002cea8d67fc0mr932724wrl.54.1680596642090;
        Tue, 04 Apr 2023 01:24:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350YoPtRKLfybx/NG9s0tw4GfCQkv6MeuGZkQfNzEQNJjq+7mW5VyRM+BbQ98NkpmRNBnKgUKFQ==
X-Received: by 2002:adf:dd91:0:b0:2ce:a8d6:7fc0 with SMTP id x17-20020adfdd91000000b002cea8d67fc0mr932710wrl.54.1680596641791;
        Tue, 04 Apr 2023 01:24:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d63d1000000b002d1daafea30sm11682318wrw.34.2023.04.04.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:24:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jarrah <kernel@undef.tools>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
Date:   Tue, 04 Apr 2023 10:24:00 +0200
Message-ID: <87h6twdpi7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarrah <kernel@undef.tools> writes:

> Hi,
>
> On 4/4/23 17:51, Heiko St=C3=BCbner wrote:
>> The interesting question is always if this will break someone else's set=
up.
>> I've never really understood the strange setting of 1.5MBps, but on the
>> other hand it _is_ a reality on most boards.
>>
>> Personally I don't care that much either way, but would like a comment
>> from the other people working on that device - if possible.
>
>
> I don't have a strong opinion either way, but I would note that=20
> Tow-Boot[0] which later models of this device ship with uses 115200,=20
> meaning that this would put the device out of sync with the default=20
> u-boot implementation from the factory.
>

Probably we can't change then because it would break the setup of people
using Tow-Boot as a bootloader.

> At least for me it's been convenient to have both the PP and PPP use the=
=20
> same settings while debugging.
>

Agreed, all my other boards use 115200 as well, the only exceptions are
the Rockpro64 and PinePhone Pro for me.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

