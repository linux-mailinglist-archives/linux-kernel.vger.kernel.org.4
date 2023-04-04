Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0A6D64B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjDDOGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjDDOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D21AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680617098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZErceNZ2DBRx0FKsqFTrzqQZnarVosWtCgSLSqBSXc=;
        b=SyPoEicKk8HKJ1bMN5vymHIlBv7j7OFjZKC7p6qbUkXKUh2P8/epzdEkoOkC1dFsmfgDk+
        ApUY1VyITSZD7ZkwP0o+b24RoJZjOJtbaVlPRyqRPs42bZiadDUON8+YuPuhZgxT+vYOsa
        koR93vp9vBXMMVRSKpD5akkaF+gv7Ok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-KVkaRnV4P_iomqfP9J5tvQ-1; Tue, 04 Apr 2023 10:04:57 -0400
X-MC-Unique: KVkaRnV4P_iomqfP9J5tvQ-1
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a05600c3b8300b003f048e0e09eso395463wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617094;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZErceNZ2DBRx0FKsqFTrzqQZnarVosWtCgSLSqBSXc=;
        b=ZFiLO6jvoxmfjwOyg683ctCJ9xdqNDs+l8CuWAxeOq4junvKbd+VUPH8KLUlWzIA6w
         wvgTHoB9KajW0VPZYH+A4Sn7GSlD1wncXtAY8xDa/lGU8P8ztgGOUFnMmb2PKT471m9j
         mq/xosl1d7IzCCarlFwedfTpXcMtfUxHUz1BNJcNPigGxy/+luvY/SIeJsIEdZSjRDMr
         2yg/b0CP5gU+giSZrIaZXQo9LETOW2aLWg95aTyRRMlEqgJ/z39O+kFbNgEs+V+N/10p
         FQPWTimEt1jm15rTUqCMRoDHQbAbt0ylRzOzeFnPTcij/OSv9tW6sDZ/L3jmg6ntYYwM
         E8eg==
X-Gm-Message-State: AAQBX9dGtzvpdWYwDToRTqv+GzSQdWPRQe9Qe5mfQIhBPA1KYM1MSoxE
        jfUJCggN23hpGWzVyQvzuudvWWjwb2McombXAoA85s5MZXWUX+kUWPuyq3Vtw5nzR+YElrnYZ31
        I1h28xQT1MikRKi/gYRL3P9CO
X-Received: by 2002:adf:fc09:0:b0:2d7:1ec1:9e47 with SMTP id i9-20020adffc09000000b002d71ec19e47mr1715721wrr.19.1680617094536;
        Tue, 04 Apr 2023 07:04:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmb/j86HhrdUZOSB15NgWupYfuoc4o4OBboeqxVhv/UUP+fcR0c9Jfb1BYe3+wZ+kJnkgM0w==
X-Received: by 2002:adf:fc09:0:b0:2d7:1ec1:9e47 with SMTP id i9-20020adffc09000000b002d71ec19e47mr1715695wrr.19.1680617094228;
        Tue, 04 Apr 2023 07:04:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b002d2f0e23acbsm12366518wrx.12.2023.04.04.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:04:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Heiko =?utf-8?Q?St=C3=BC?= =?utf-8?Q?bner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <20230404123646.5iiznbhnyoama5pp@core>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego> <20230404123646.5iiznbhnyoama5pp@core>
Date:   Tue, 04 Apr 2023 16:04:53 +0200
Message-ID: <87r0szd9q2.fsf@minerva.mail-host-address-is-not-set>
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

Ond=C5=99ej Jirman <megi@xff.cz> writes:

> On Tue, Apr 04, 2023 at 09:51:11AM +0200, Heiko St=C3=BCbner wrote:
>> Hi,
>>=20
>> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
>> > This baud rate is set for the device by mainline u-boot and is also wh=
at
>> > is set in the Pinebook Pro Device Tree, which is a device similar to t=
he
>> > PinePhone Pro but with a different form factor.
>> >=20
>> > Otherwise, the baud rate of the firmware and Linux don't match by defa=
ult
>> > and a 'console=3DttyS2,1500000n8' kernel command line parameter is req=
uired
>> > to have proper output for both.
>>=20
>> The interesting question is always if this will break someone else's set=
up.
>> I've never really understood the strange setting of 1.5MBps, but on the
>> other hand it _is_ a reality on most boards.
>
> Normal users of the phone probably run with UART console disabled, because
> UART is muxed with audio jack output and to enable it they have to add
> console=3DttyS2 to the kernel command line and flip a physical switch ins=
ide
> the phone.
>
> Fortunately, not sepcifying stdout-path baud rate in the options part
> of the string, will make the serial driver probe for the baud rate from
> the previous boot stage and make the user happy by keeping whatever was
> already set in the bootloader.
>

As mentioned in the first email of this thread, I tried that but it didn't
work for me. Either using stdout-path =3D "serial2"; or stdout-path =3D &ua=
rt2;
gives me no serial output with console=3DttyS2, I needed to specify the baud
rate explicitly (i.e: console=3DttyS2,1500000n8).

>   https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/=
8250_port.c#L3496
>

Is that helper really used by the serial driver in the PinePhone Pro?
(drivers/tty/serial/8250/8250_dw.c), I was meaning to dig why just ttyS2
was not working but decided that could be a follow-up patch.

Since chaging to 1.5 MBps seemed to have merits on its own, decided to
post this patch anyways in the meantime.

> So we can make the kernel just keep the baudrate setup from the previous
> boot stage by:
>
> 	stdout-path =3D "serial2";
>

Did it work for you? Maybe I'm doing something silly but as mentioned it
didn't work for me with upstream u-boot.

> regards,
> 	o.
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

