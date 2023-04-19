Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B056E77A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDSKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDSKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:44:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEF7E5C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:44:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-76073fb4511so124036039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681901090; x=1684493090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC1F9AUB3Liv54B7ZdgG3WiGq9lyqgr8Df3/jIkfoOU=;
        b=DkzPBN9I5LHhIsDlFpY1hThuwHGBVF2rLOb3SSNH5om9lIwYi8QR+lhZK5wDHD35QZ
         h/bo7dbB7insCGHEs4pfMu+B7EMTB/xVkL38LttW7JheuaN3uHwAdZIW0bwxJWByL/l6
         iFYZyWdf7TeMzDDbSEXN6G5dk3QbKIJQi9elg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681901090; x=1684493090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZC1F9AUB3Liv54B7ZdgG3WiGq9lyqgr8Df3/jIkfoOU=;
        b=RhePxKCgNo9Cc5E/hMUklTLnNfy2PkjvaTnzdjiivoVSq5wnKegkINcISMO1aTTKXs
         PPChOz3ChRQD7EUfTUriCY0D5gq14W6sVOpfSrjx+SVql/5uyKOhmQXIOVIQm8cSl+Pb
         wq3grFWWXB7m/vXVJbXY1b1Hcit4DhZdnO3Uo4IsCi6KQq2v/yzG8i5MmGTPDeRCorbi
         iWTrVdkYGuTpna3njsM2o5yOruhSee2PzSczs64jabfH2Cm8haZmoym1TSX6i1v/vJpY
         DvnuvqYNmULB0XhGPK1JgP9HyV98uZvIusEMDldYmC/XVQd5z/BfMlBCtqqDIEYG0LRR
         EiHw==
X-Gm-Message-State: AAQBX9c3CQ/sL3WruZcNC/8annGjXOAx7v+ag+8hWypqxc410RAZoj7z
        51+kTNL8EmWn0UJwANE4Eli5cxKQGbqPlE/5VoFNM/aD
X-Google-Smtp-Source: AKy350bCQWU1KCXYeBzDMVbEL4jMOWw1BsPTKpEbh6cmrOoiDkMRYUzdl1uZ9sBVJ9hJ3xOJRRYPQw==
X-Received: by 2002:a6b:6810:0:b0:74c:b348:738 with SMTP id d16-20020a6b6810000000b0074cb3480738mr4548280ioc.11.1681901090017;
        Wed, 19 Apr 2023 03:44:50 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id u2-20020a6be302000000b007608af6dfb4sm2469176ioc.31.2023.04.19.03.44.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:44:48 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-32b482bbc26so15763385ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:44:48 -0700 (PDT)
X-Received: by 2002:a92:ced0:0:b0:329:4c5e:15d8 with SMTP id
 z16-20020a92ced0000000b003294c5e15d8mr10421971ilq.2.1681901088205; Wed, 19
 Apr 2023 03:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-2-fshao@chromium.org>
 <ZD8z57MBvcfExJx8@nixie71>
In-Reply-To: <ZD8z57MBvcfExJx8@nixie71>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 19 Apr 2023 18:44:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
Message-ID: <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend property
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, Apr 19, 2023 at 8:21=E2=80=AFAM Jeff LaBundy <jeff@labundy.com> wro=
te:
>
> Hi Fei,
>
> On Tue, Apr 18, 2023 at 08:49:51PM +0800, Fei Shao wrote:
> > We observed that on Chromebook device Steelix, if Goodix GT7375P
> > touchscreen is powered in suspend (because, for example, it connects to
> > an always-on regulator) and with the reset GPIO asserted, it will
> > introduce about 14mW power leakage.
> >
> > This property is used to indicate that the touchscreen is powered in
> > suspend. If it's set, the driver will stop asserting the reset GPIO in
> > power-down, and it will do it in power-up instead to ensure that the
> > state is always reset after resuming.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
>
> This is an interesting problem; were you able to root-cause why the silic=
on
> exhibits this behavior? Simply asserting reset should not cause it to dra=
w
> additional power, let alone 14 mW. This almost sounds like a back-powerin=
g
> problem during suspend.
>
There was a fix for this behavior before so I didn't dig into it on
the silicon side.
I can ask internally and see if we can have Goodix to confirm this is
a known HW erratum.

> If this is truly expected behavior, is it sufficient to use the always_on
> constraint of the relevant regulator(s) to make this decision as opposed =
to
> introducing a new property?
>
That sounds good to me. IIUC, for the existing designs, the boards
that would set this property would also exclusively set
`regulator-always-on` in their supply, so that should suffice.
Let me revise the patch. Thanks!

Fei
> >
> >  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yam=
l b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> > index ce18d7dadae2..942acb286d77 100644
> > --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> > +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> > @@ -43,6 +43,12 @@ properties:
> >        itself as long as it allows the main board to make signals compa=
tible
> >        with what the touchscreen is expecting for its IO rails.
> >
> > +  powered-in-suspend:
> > +    description:
> > +      This indicates that the touchscreen is powered in suspend, so th=
e driver
> > +      will not assert the reset GPIO in power-down to prevent power le=
akage.
> > +    type: boolean
> > +
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
> Kind regards,
> Jeff LaBundy
