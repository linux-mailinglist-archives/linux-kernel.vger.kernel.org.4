Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A66CAA50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC0QRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC0QRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19E4C2B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679933767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tr+WD6+CTYSVy+3bIJpQprNnSLspmj5WbXleE2+KZLo=;
        b=evVHkYKR3Zpof0fj5A0w9Mp0jAtLK8loq+hefER+HiTl3dnbPRvKI8mCVD1En4lB76x6VO
        eNPw9RI88nLcGbOPfsMJiw70pXpa5/dMOyRFwzhcS3D8s/ARRix8EqXEJ82epvhJySfMgT
        Z4M5nCLpRrQbiu+s9IU47YO8CwMPKZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-87TqmFQxPL2a0pOlxffX7Q-1; Mon, 27 Mar 2023 12:15:58 -0400
X-MC-Unique: 87TqmFQxPL2a0pOlxffX7Q-1
Received: by mail-wm1-f70.google.com with SMTP id k1-20020a05600c1c8100b003ee6dbceb81so5046294wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933757;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr+WD6+CTYSVy+3bIJpQprNnSLspmj5WbXleE2+KZLo=;
        b=ry5RIUAH2GsnGSYlAYTa291Byvr23lrYjZsjEJDWpikQ+voSsOFeeji7ctdE4PP2LL
         M6poe6bvrBZ+jVwwCIIhMc7h9xeBCgsALMAcz9aBHfL/nJr+d8LWSZbU9lAODK+pliSl
         s2CNvDrICqPSP27IdBkbIEDOoxksAsCxih23HJckwI+BGij/AqjlTjvnER9B5zmGOoeq
         OeDjNpb3Jt44qOe5RjebY2ldMG43leqfN8yb6wuHAc+E+w5uIt3n4NmFpQ41v5tCi9AG
         /ZcxXeFMI4EuGX2YCxP5hGSNKc+EQh5x+sjFeO//g9srPTUM1gyoDDy/cPqPASFKOWwl
         wSrQ==
X-Gm-Message-State: AO0yUKWBQCJdXDOSacKBX8P1Qcqj01rvH4ZQefFSYqHp0lSRyDfXgnxs
        H1Q0RUyMZ2N8MVPVkO7gR+QNtiycJdNF2kG8vzWSkL114YnXZYgd6bnuYH61yfsLt2Pk/vQ/I7v
        PrX/6fjuZVbeQFzNijIRS1Arj
X-Received: by 2002:a05:600c:2114:b0:3ed:492f:7f37 with SMTP id u20-20020a05600c211400b003ed492f7f37mr9156565wml.10.1679933757079;
        Mon, 27 Mar 2023 09:15:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set9k+XPb+CPOEQbw1BrWiSX82Db3GJ1LZxPLDOINlpFxnu2WxagxZuxwLYswHAaRRCivF3Rkbw==
X-Received: by 2002:a05:600c:2114:b0:3ed:492f:7f37 with SMTP id u20-20020a05600c211400b003ed492f7f37mr9156549wml.10.1679933756765;
        Mon, 27 Mar 2023 09:15:56 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020a1c7709000000b003ed1ff06faasm14048979wmi.19.2023.03.27.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:15:56 -0700 (PDT)
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
Date:   Mon, 27 Mar 2023 18:15:55 +0200
Message-ID: <87mt3yrwzo.fsf@minerva.mail-host-address-is-not-set>
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

Hello Heiko,

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

It is broken though? This is what is in Ondrej downstream tree and I see
no issues on my Pinephone Pro. He mentioned some flicker when looking at
the signals with a scope and hooking a photoresistor.

But that's fair. I'll let Ondrej then post a v3 if he wants to address the
issues he pointed out, since is his patch after all.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

