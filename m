Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596016EDE41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDYIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjDYIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:37:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB414F75
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:35:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-959a626b622so320902666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682411695; x=1685003695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8YLT0UnqpNi70lcfgxzgtqlJHlXNg/RRy71f8KnOqk=;
        b=A0VmRR1QDWXeQGeod/3LdbAKmHX4dvNlWnc6tULPmdWjJWr9x21jRiyBrho3dPTT0U
         axHPFDyrFCzdiXMSkdrrqXvWnHK02VlJdJTFOs63R44YQDrZxMEjLrEX8lA8h6p5wyII
         imQkpmBJXJtawp34Ese8M01h5Sdp+SBLzHmQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411695; x=1685003695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8YLT0UnqpNi70lcfgxzgtqlJHlXNg/RRy71f8KnOqk=;
        b=BZab3QoUt68obLIh/m4ACO2CjzzRchtOGPkS07o4p4eOSUfM8lvxTJqX3P8O7kDYTs
         GnjGl4aTMlHGvjwlxWxxgRw26ip8uGU5NqywfwftbNvkCtA4RemFiRFdu87ZRIKoCcHp
         pz8v672etkWzHfORzDGmInbAHPXSGYYdEWiNIhSPfV4eg3RJUT7RhibFXddUvLk7QfVX
         f/Ml3o4Py3BxxFatB6u+3h2tvLlXCzv16vk2Mb9VnVmGF+zGghk3/kTX7t1j1+bwVdZB
         HRT9VHO36PECz7TXVBQQo0r7N72LJ5tSrgbcvQcPLN31UTIe/A0v6v0DPmZRvy0HU8vC
         /0mw==
X-Gm-Message-State: AAQBX9fm2yLZ4yYxJ2uWObGrhbyfZaVC4IpNlX/P1lg5nONccn2i734R
        voHeaZlSQSfKJsRVNnjZJ846Yaxhz8ARPHlGL77a5w==
X-Google-Smtp-Source: AKy350aDn2RigrLJEAqiq0pAIUc81AZKdxbxFUGityn3VjncxG0NcfULmo+HVN2Fd9ascEpEbiCPkw==
X-Received: by 2002:a17:906:7e45:b0:94f:5079:ade2 with SMTP id z5-20020a1709067e4500b0094f5079ade2mr12613385ejr.62.1682411695111;
        Tue, 25 Apr 2023 01:34:55 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id he12-20020a1709073d8c00b00953951ec91fsm6404744ejc.137.2023.04.25.01.34.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:34:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-2fde2879eabso4961589f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:34:54 -0700 (PDT)
X-Received: by 2002:a5d:428d:0:b0:2fa:c982:dd6a with SMTP id
 k13-20020a5d428d000000b002fac982dd6amr11970067wrq.64.1682411693905; Tue, 25
 Apr 2023 01:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-2-fshao@chromium.org>
 <ZD8z57MBvcfExJx8@nixie71> <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
 <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
 <ZEAGTiGyvynGA9P1@nixie71> <CAD=FV=UB393Z1zhK54Apgr-iRcvgiK0t36jt6-t5-5zz3m8OZQ@mail.gmail.com>
 <CAC=S1nj8VTXOovvianPWDYnsrbek0APD76SBNquFObaw8Vg4BQ@mail.gmail.com>
 <ZEX4BEVMf6GtvaAP@nixie71> <CAD=FV=VtrJDVB0gQp-O82V3mgU6MFVMSGrvzh0fRa7sYAt_Pqw@mail.gmail.com>
In-Reply-To: <CAD=FV=VtrJDVB0gQp-O82V3mgU6MFVMSGrvzh0fRa7sYAt_Pqw@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 25 Apr 2023 16:34:16 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhFNq_kK5zJCWQiGBuJbDXiC8BstJ5BT7pi5O8hLDQSfA@mail.gmail.com>
Message-ID: <CAC=S1nhFNq_kK5zJCWQiGBuJbDXiC8BstJ5BT7pi5O8hLDQSfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend property
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jeff LaBundy <jeff@labundy.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 2:15=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Sun, Apr 23, 2023 at 8:31=E2=80=AFPM Jeff LaBundy <jeff@labundy.com> w=
rote:
> >
> > Back-powering can come in two forms:
> >
> > 1. The one you've described, which is by far the most common. As you me=
ntion,
> > it is not the case here since the issue happens only when we drive the =
GPIO
> > low and not high.
> >
> > 2. Through a forbidden power supply sequence, an input pin of an IC wit=
h
> > multiple power supplies becomes a weak power supply itself. Grounding t=
he
> > GPIO then sinks current into the SoC.
> >
> > This problem smelled like (2), especially since asserting the GPIO or p=
owering
> > down the supply alleviates the symptom. Most Goodix controllers I've wo=
rked
> > with have two or more supplies, and the datasheet requires them to be e=
nabled
> > or disabled in a specific order.
> >
> > Based on Fei's feedback, however, this IC does not seem to be one of th=
ose
> > since there is reportedly only a single rail. I guess either vdd or vdd=
io is
> > tied to a dummy regulator? If so, then perhaps we can scratch this theo=
ry.
>
> There is one rail provided from the main board, but there can be two
> voltage levels involved depending on stuffings on the touchscreen
> itself. I talked a bit about this in commit 1d18c1f3b7d9
> ("dt-bindings: HID: i2c-hid: goodix: Add mainboard-vddio-supply").
>
>
> > Fair enough, I was simply sketpical that this was the _right_ workaroun=
d.
> > Were this an issue of only supply A left on yet the IC datasheet requir=
es
> > supply B to remain on if supply A is on, I would rather see this solved=
 by
> > updating a regulator dts node, trusted FW sequence, etc.
>
> Right. That type of stuff was looked at in detail by two separate
> teams, so I don't think this is the issue.
>
>
> > Thanks for your due diligence; if this really is a silicon issue, then
> > the driver should indeed accommodate it.
> >
> > That being said, the name 'powered-in-suspend' seems a bit conflated. W=
e
> > should not be duplicating regulator policy in this driver; the existing
> > naming also may cause confusion for other HW configurations that do lea=
ve
> > vdd and vddio on during suspend, but don't have this problem.
> >
> > Here, we actually mean to control the behavior of the reset GPIO throug=
h
> > suspend and therefore something like 'goodix,no-reset-during-suspend' i=
s
> > closer to what I understand us to intend to do. I will add more details
> > in patch [2/2].
>
> I'd be fine with that name. ...ah, and adding the "goodix," prefix is
> a good call.
>
> -Doug

That sounds good to me, too. I'll update the name in the next patch.

Regards,
Fei
