Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E996D5F57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjDDLnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjDDLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31355E9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680608560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g43LgwR7XrUP0mLCRkPUDCErg1tewsdsK7C1g51lbMU=;
        b=VugpXvSz97BafVwLwbKV+1yZXHlSFEs5/5AIKDQVcwopEPszy+AQiI3DA+K0XLy9C9Z1m7
        qajjaNhv+bNUrsGHSsbhKNr7OTE3ijculYWY95hmuh3w30NFq20voQoc+cwaNhfpEkJE7F
        FIn7zdze6i7Ollewgj6QhW5ZAKHsyrw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-7XdTs7NaPzKqTBSoELZqSA-1; Tue, 04 Apr 2023 07:42:39 -0400
X-MC-Unique: 7XdTs7NaPzKqTBSoELZqSA-1
Received: by mail-wm1-f70.google.com with SMTP id p10-20020a05600c358a00b003edf7d484d4so16199745wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680608558;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g43LgwR7XrUP0mLCRkPUDCErg1tewsdsK7C1g51lbMU=;
        b=ibFejy7RMYM4esCzdmS7OwK1yJKeT3xsjpNHF03ofrskxRfdBgj0icuzfKxKTM5UPQ
         qB8RkEM8YZ6hj5TnEEhz5YNeHcZVTjJZ8ifTJ+7O3D7eOCYR4Mn+kmunh75VS4LBBrmc
         syj1hsyXeo08jkNBGLhU4dnYa9JP9VxRzJgII82NA8NSiKkJ6fpBYThYMSmre2Tzcj4l
         bxsYr3Vx5Fnodu4cksYzC5Ko4VRkyEiTSGU0jIRz7BZ9bttKF72jo+QMT97Gn4ZZdMtf
         JH1iyyYEUv9+RkSj32I0G9JSECPa9nF14r5Up8OI21yh3m80mDoA5X5ugQjAttXJAAFk
         MPaA==
X-Gm-Message-State: AAQBX9cOPyX6/uiWgju6Smn3jElNkm6vJbBC4tsZAWtyhTdm29PH0Jx5
        N15aG+FpodBItvxHMznRmpbxpvitbY0ZdFDHoD5V91U55e8YHrgK2G+o5FXLYUUybvQfIqHbICk
        jI1UxEXFsGyPwJc42Uleoku63
X-Received: by 2002:adf:eace:0:b0:2ce:a098:c6b8 with SMTP id o14-20020adfeace000000b002cea098c6b8mr1553459wrn.55.1680608558085;
        Tue, 04 Apr 2023 04:42:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YFNy2ACkTPYDUy7IvZluDlWudCyXewZR1HLl8dA6ab7O3s3motR/Cir3GQt7z1geCNLF6cnQ==
X-Received: by 2002:adf:eace:0:b0:2ce:a098:c6b8 with SMTP id o14-20020adfeace000000b002cea098c6b8mr1553441wrn.55.1680608557825;
        Tue, 04 Apr 2023 04:42:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003ef6bc71cccsm22744629wmq.27.2023.04.04.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:42:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Martijn Braam <martijn@brixit.nl>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <52d83a29-0f16-cd4c-9810-7c6bd497fe85@brixit.nl>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <52d83a29-0f16-cd4c-9810-7c6bd497fe85@brixit.nl>
Date:   Tue, 04 Apr 2023 13:42:36 +0200
Message-ID: <87ttxvdgb7.fsf@minerva.mail-host-address-is-not-set>
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

Martijn Braam <martijn@brixit.nl> writes:

> On 4/4/23 09:51, Heiko St=C3=BCbner wrote:
>> Hi,
>>
>> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
>>> This baud rate is set for the device by mainline u-boot and is also what
>>> is set in the Pinebook Pro Device Tree, which is a device similar to the
>>> PinePhone Pro but with a different form factor.
>>>
>>> Otherwise, the baud rate of the firmware and Linux don't match by defau=
lt
>>> and a 'console=3DttyS2,1500000n8' kernel command line parameter is requ=
ired
>>> to have proper output for both.
>> The interesting question is always if this will break someone else's set=
up.
>> I've never really understood the strange setting of 1.5MBps, but on the
>> other hand it _is_ a reality on most boards.
>
> It breaks my device test setup at least. The extra speed isn't worth the=
=20
> hassle

More than the extra speed is to have consistency accross all the rockchip
devices in upstream and also sync with mainline u-boot.

> of having a few devices at weird baudrates and the bootloader already
> starts outputting debug logs at 115200 baud.
>

And mine starts outputting at 1.5MBps :) I guess that there isn't a one
size fits all, so the question is whether the bikeshed color is what was
painted in all other rockchip boards or the one that Tow-Boot has chosen.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

