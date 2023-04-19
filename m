Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783DD6E7CED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjDSOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDSOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:38:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C862D66
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:38:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l5so11031563ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681915108; x=1684507108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilxu6Q/jc5aOhDRIt3j6AWcNhm/qlHFPZW+HtjiMVA4=;
        b=CgkHuBeThgTIDC8QSyU6LY74RfHhExfygsKxzG/Fs3ZzJFDo6+UyPmSpDIpScwEBc5
         w74rChawjoSOYO8ExD5NuJQ7gvs/XzwaFhFEEuuBXwDSqwAjX3hUDFMUsN4WjCU9VJ7v
         l6GjTcZMFqukPCLdoe818esq/uNv1gt4vwtGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915108; x=1684507108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ilxu6Q/jc5aOhDRIt3j6AWcNhm/qlHFPZW+HtjiMVA4=;
        b=goI7EXCPd5IDUtdQwvIOOglfsZGw0HKAYOQEKDXQZpWIhyths3lLRNGS0Y003dNlP0
         DL//163udV5IhZMus/0Mgi30TA5vWBejg/U2vKK8jRdfTDnNCXMrAcJuYib+x1N/Xwwv
         X9ZQzf1cdqDqQcGMqNnRE4vziJbd9nrtelxmirfABdeneYZPNLa59ryXlScvks4QcyXL
         eWkLbIXkkeCl1mbOnKJz8/41nWmcfdOP6/vyxZksv7Q+eIXyh0aPQTm2lrHAN6Tlw+0u
         vZcAp9a5shqerkM+vensqxKsLpL0wOsxh3/dfAxuBHi0WV72Evl+l8A6wVVKZc2CjAX0
         mJ6A==
X-Gm-Message-State: AAQBX9fgL0LarzGlJ0Ll1xR8WaIvFGk45rp+UJjSCdCAXNLJSxarQYpv
        G9XNVA5seIUe2WN+cYcFAAhbcOOn/xWCGJ/C6Fv/lA==
X-Google-Smtp-Source: AKy350YDXN5skRdbAdBTzulhe9LDiF78z4Xe3Z7cBGZJnoELLVDr6CJHLYrt7M1K034ZCnhTzeY/eg==
X-Received: by 2002:a25:cdc9:0:b0:a35:1aa1:b023 with SMTP id d192-20020a25cdc9000000b00a351aa1b023mr126897ybf.27.1681915107806;
        Wed, 19 Apr 2023 07:38:27 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id a14-20020a056902056e00b00b8bcaf1e660sm4344140ybt.4.2023.04.19.07.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 07:38:26 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id n193so9331882ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:38:26 -0700 (PDT)
X-Received: by 2002:a25:7687:0:b0:b96:7676:db4a with SMTP id
 r129-20020a257687000000b00b967676db4amr16246ybc.0.1681915105828; Wed, 19 Apr
 2023 07:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-2-fshao@chromium.org>
 <ZD8z57MBvcfExJx8@nixie71> <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
In-Reply-To: <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Apr 2023 07:38:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
Message-ID: <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend property
To:     Fei Shao <fshao@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 3:44=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi Jeff,
>
> On Wed, Apr 19, 2023 at 8:21=E2=80=AFAM Jeff LaBundy <jeff@labundy.com> w=
rote:
> >
> > Hi Fei,
> >
> > On Tue, Apr 18, 2023 at 08:49:51PM +0800, Fei Shao wrote:
> > > We observed that on Chromebook device Steelix, if Goodix GT7375P
> > > touchscreen is powered in suspend (because, for example, it connects =
to
> > > an always-on regulator) and with the reset GPIO asserted, it will
> > > introduce about 14mW power leakage.
> > >
> > > This property is used to indicate that the touchscreen is powered in
> > > suspend. If it's set, the driver will stop asserting the reset GPIO i=
n
> > > power-down, and it will do it in power-up instead to ensure that the
> > > state is always reset after resuming.
> > >
> > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > ---
> >
> > This is an interesting problem; were you able to root-cause why the sil=
icon
> > exhibits this behavior? Simply asserting reset should not cause it to d=
raw
> > additional power, let alone 14 mW. This almost sounds like a back-power=
ing
> > problem during suspend.
> >
> There was a fix for this behavior before so I didn't dig into it on
> the silicon side.
> I can ask internally and see if we can have Goodix to confirm this is
> a known HW erratum.

Certainly it doesn't hurt to check, but it's not really that shocking
to me that asserting reset could cause a power draw on some hardware.
Reset puts hardware into a default state and that's not necessarily
low power. I guess ideally hardware would act like it's "off" when
reset is asserted and then then init to the default state on the edge
as reset was deasserted, but I not all hardware is designed in an
ideal way.


> > If this is truly expected behavior, is it sufficient to use the always_=
on
> > constraint of the relevant regulator(s) to make this decision as oppose=
d to
> > introducing a new property?
> >
> That sounds good to me. IIUC, for the existing designs, the boards
> that would set this property would also exclusively set
> `regulator-always-on` in their supply, so that should suffice.
> Let me revise the patch. Thanks!

Yeah, I thought about this too and talked about it in my original
reply. It doesn't handle the shared-rail case, but then again neither
does ${SUBJECT} patch. ...then I guess the only argument against it is
my argument that the regulator could be marked "always-on" in the
device tree but still turned off by an external entity (PMIC or EC) in
S3. In theory this should be specified by
"regulator-state-(standby|mem|disk)", but I could believe it being
tricky to figure out (what if a parent regulator gets turned off
automatically but the child isn't explicit?). Specifically, if a
regulator is always-on but somehow gets shut off in suspend then we
_do_ want to assert reset (active low) during suspend, otherwise we'll
have a power leak through the reset GPIO... :-P

...so I guess I'll continue to assert that I don't think peeking at
the regulator's "always-on" property is the best way to go. If
everyone else disagrees with me then I won't stand in the way, but IMO
the extra property like Fei's patch adds is better.

[1] https://lore.kernel.org/r/CAD=3DFV=3DV8ZN3969RrPu2-zZYoEE=3DLDxpi8K_E8E=
ziiDpGOSsq1w@mail.gmail.com
