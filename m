Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21606E60E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDRMNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDRMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C265A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681819918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkJh/B/i3KU/KW7H270nTjye9dmLNKxDnAlmOJnN0vY=;
        b=IaoEA9elVLy0W4DM2MEgCs85+U7t36gnmR5UyneBO7JpkvdFA2GyRoqIhG+zBubIbLbC2Q
        jt0NmOrLQTYqdSvAMWp91SvxQnIt7S69IP9OO35JFCx9OIfNdIJagPMtYcU4JWe7tZUK5f
        IcnwH2hjf5LMfOa5j2VukQ1fvdGD6wQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-qZ8UvZgZM1G1_16Ww5gV5A-1; Tue, 18 Apr 2023 08:11:55 -0400
X-MC-Unique: qZ8UvZgZM1G1_16Ww5gV5A-1
Received: by mail-wr1-f69.google.com with SMTP id e10-20020adfa44a000000b002f6c0c4884fso1788842wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819914; x=1684411914;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkJh/B/i3KU/KW7H270nTjye9dmLNKxDnAlmOJnN0vY=;
        b=GdSJjKLEIx2dtfzycUDol+cxstv7/03iFrNItri2MQ6zJ61hZ+c1dFZ1fDSZsVQyW9
         zgIkAr4peO1kjyfe1ayimT6Gflm3VqOxQORZfqB1IypT72Js8M8/aDghXvb+XLH6ymBT
         V2Zxw1ilWoCrsCd6zpqBsMrD/AiG2tU7hOudL6ugDWiPUjcGddL6F/HYy3yPo1BBp5IW
         7BxT2m0loU6igaS2qT4jxBk8N6BvckBZY8DKoYdOSFUDkmSsYx11XfcjREREG/E2lOGH
         +2YklWe6Pjjx1iSWpYRslN2ePVO48qb8WWHBeLxByluqmAbxgmhQvmffA3RpNJOTenaC
         9AyA==
X-Gm-Message-State: AAQBX9dnzDYen+po2JTjXtwknfu6EvqF1bU0D4to80OlZHZR5nxtSigW
        IfDp9EAbfSTa4KTcLgEwAecdoyHWsToGACtLWLAySE+PPNLEjI5D40UFXQOX+kKewL5bQBCitTd
        /Nt/5jWezsBjWiH20wfTWu/IG
X-Received: by 2002:a05:600c:2212:b0:3ed:711c:e8fe with SMTP id z18-20020a05600c221200b003ed711ce8femr14686233wml.2.1681819914709;
        Tue, 18 Apr 2023 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350b65iCGtMf2oVoLYMy41tFWkUlUkLBuyvo6vU/7asGqIjHXB/GjSqEJ1yCvOz3n6/Bz0bD6nQ==
X-Received: by 2002:a05:600c:2212:b0:3ed:711c:e8fe with SMTP id z18-20020a05600c221200b003ed711ce8femr14686210wml.2.1681819914409;
        Tue, 18 Apr 2023 05:11:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003ede3f5c81fsm18542538wmq.41.2023.04.18.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:11:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <3999080.iIbC2pHGDl@diego>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <CAMdYzYqT=vVZxFK=P6xYDAht_KWk3CTsTtruPAbGqx1K9EcJsQ@mail.gmail.com>
 <3999080.iIbC2pHGDl@diego>
Date:   Tue, 18 Apr 2023 14:11:53 +0200
Message-ID: <87h6tdie46.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko St=C3=BCbner <heiko@sntech.de> writes:

Hello Heiko,

> Hi Peter,
>
> Am Dienstag, 4. April 2023, 14:52:02 CEST schrieb Peter Geis:
>> On Tue, Apr 4, 2023 at 3:55=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:
>> >
>> > Hi,
>> >
>> > Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canill=
as:
>> > > This baud rate is set for the device by mainline u-boot and is also =
what
>> > > is set in the Pinebook Pro Device Tree, which is a device similar to=
 the
>> > > PinePhone Pro but with a different form factor.
>> > >
>> > > Otherwise, the baud rate of the firmware and Linux don't match by de=
fault
>> > > and a 'console=3DttyS2,1500000n8' kernel command line parameter is r=
equired
>> > > to have proper output for both.
>> >
>> > The interesting question is always if this will break someone else's s=
etup.
>> > I've never really understood the strange setting of 1.5MBps, but on the
>> > other hand it _is_ a reality on most boards.
>
>> The 1.5M baud is default because the clock structure on rockchip
>> devices does not allow a clean 115200 baud. By attempting to force
>> 115200, it will always be slightly off (either low or high depending
>> on how the driver decided to round). If this actually causes any
>> problems is the subject of much debate.
>
> thanks so much for this piece of clock-detail. As I wrote, I never really
> understood the why _before_ but also never cared that much to dive
> into it and find out.
>
> So your explanation closes one knowledge gap in my head.
>
> Thanks a lot :-)

Did you make a decision about this? I guess the clock explanation is yet
another argument in favour of switching the PPP to a 1.5 Mbps baud rate ?

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

