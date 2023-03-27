Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B856CA9FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjC0QHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjC0QHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69302C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679933207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTwv4j9Dt3cE1Rn1R2k+nbDL5QUCJu5c21gncHvR2lM=;
        b=egA1wJFXCoWC4Tv9jn0HbrhMHbKnyVFhphFXeaVkaDqCRF6wCnl6T28cIp+4pES0jb+dWz
        5Kn+B+1Xz8hapOmgajJN6uCU4UXOGeaQBp+6f12OC92+Jw2VxEggQXICQ0mDO2uocLwC5L
        mVbMPV6z6/qpAWJ2PHA1TQDaBAEa6y0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-8cvQzeqRM2WD_0SKckdtDA-1; Mon, 27 Mar 2023 12:06:46 -0400
X-MC-Unique: 8cvQzeqRM2WD_0SKckdtDA-1
Received: by mail-wr1-f71.google.com with SMTP id d5-20020adfa345000000b002d716fc080fso835171wrb.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933205;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTwv4j9Dt3cE1Rn1R2k+nbDL5QUCJu5c21gncHvR2lM=;
        b=e/2kS4UosfIfOYFUt9uatO26SXcIW9i32MviHx0LRhPG/Yp5ggrPo74XDQ+6GenSL1
         HcVtInwbUqHcGhS2nYBuxyZqtburGgzOSo1AcWEWgFVHC14v5Q9KmfoJ8j2eLWSX/Mwx
         nFyJde7zlGDVo/chawnBB7Gpwq3xqMppfB5bCc9fMWPXVOvVGVbzBGRxLNpgFEYN8yMb
         mEYFKkDG8+Q9UBrEEW5qG7S6dzEBZRSATt2Bdzfbd5PID+tMcc9EwzmRzTlR6n4uq3xu
         TTW/7C1kOhpOUtxxtXD6eWsAtjH7WJWVyb3Z7k5VmLU4RAWFfUxfjGgXyGuImcf0LsDQ
         akoQ==
X-Gm-Message-State: AO0yUKUDsheQPhzd/vp9umM5+ES6cnXJeoLQztEEcsYHZ/bEzsEkx0ux
        N5awqIvMDEV9vsqjNeGQIi3WIav8NQQXmW6eGyZJtEUd4m6FAJ4HsGe0czu+BRqaoAIweCJbmwS
        fFEdZefQVYOlitZ9eJl7k1moT
X-Received: by 2002:a1c:6a05:0:b0:3ee:138f:be54 with SMTP id f5-20020a1c6a05000000b003ee138fbe54mr9967829wmc.3.1679933204853;
        Mon, 27 Mar 2023 09:06:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/4VpQPD+Dnoy5eFSGDAYNq2D3uuoqcCuqB5KNtZBlZO7dGv45tAgjmZujpD3LTO+xh5ItTZA==
X-Received: by 2002:a1c:6a05:0:b0:3ee:138f:be54 with SMTP id f5-20020a1c6a05000000b003ee138fbe54mr9967801wmc.3.1679933204578;
        Mon, 27 Mar 2023 09:06:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003ef4cd057f5sm9441471wmp.4.2023.03.27.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:06:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        =?utf-8?Q?Ond=C5=99e?= =?utf-8?Q?j?= Jirman <megi@xff.cz>
Cc:     linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
In-Reply-To: <1924921.PYKUYFuaPT@diego>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <20230327130147.wgxl2qayhzsi2xak@core>
 <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
 <1924921.PYKUYFuaPT@diego>
Date:   Mon, 27 Mar 2023 18:06:43 +0200
Message-ID: <87r0tarxf0.fsf@minerva.mail-host-address-is-not-set>
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

Heiko St=C3=BCbner <heiko@sntech.de> writes:

> Am Montag, 27. M=C3=A4rz 2023, 17:39:57 CEST schrieb Javier Martinez Cani=
llas:
>> Ond=C5=99ej Jirman <megi@xff.cz> writes:
>>=20
>> Hell Ond=C5=99ej,
>>=20
>> > Hi Javier,
>> >
>> > I've tried the patch on top of linus/master and it works as expected. =
My
>> > DRM test app shows 16.669ms between frames. The display output is ok on
>> > developer batch pinephone pro, and is corrupted on production version.
>> > Display also doesn't come back after blanking. All as expected.
>> >
>> > Tested-by: Ondrej Jirman <megi@xff.cz>
>> >
>>=20
>> Thanks for testing.
>>=20
>> > A few more comments below.
>> >
>>=20
>> I'm OK with these comments but I did a git diff with your orange-pi-6.3
>> branch just before posting and this was the latest that's in your tree.
>>=20
>> So feel free to either post a v3 addressing the things you are pointing
>> out or lets land this and we can post any further cleanups on top IMO.
>
> I would really like to _not_ apply essentially broken code, so really
> would prefer the v3-approach.
>
> Thanks
> Heiko
>
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

