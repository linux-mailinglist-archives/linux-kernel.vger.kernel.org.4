Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64C69512C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBMT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjBMT50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:57:26 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1081CAEE;
        Mon, 13 Feb 2023 11:57:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bd6so11208116oib.6;
        Mon, 13 Feb 2023 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tVg71Shz5sdJa0bTigxioRRGlOotY9yLlaVlnZEUMs=;
        b=DHCcPudTmDfyJ5OkqJyHbdic7qqlNpFW+zDF4Fg4xKFjdCab/OEVYYUEuIh5tQwHhi
         LzKxb1hrP8+vSukKykBOF+OqT/flI1vh6kVkGAZaU4WmEpgNrx3e8GHmPc0okOy0X/tj
         3ys3k0mnYKhze+t7Pu1x3Xyml2KBnqwVjYRgbqYsp6O9iHN9+4f4Hht3gifeiZ7JtLPJ
         Rv6zqlYgR3qWWTNESLz8gcFI8ze/3jvdWCGmfXcNwuR02USDDW+uJwSFYqCKsHM0eRBe
         A8ptQVUEOil5Odqesa+neGT7kN6Bhz7EOK57b2TgLEnH1hSJj8yFEpC2FuCMfT8dTr3+
         2TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tVg71Shz5sdJa0bTigxioRRGlOotY9yLlaVlnZEUMs=;
        b=nps/Fx5YieqXtrBHAKplIJbnYhxHTAQ4Ss4hv8ruW9AwcjBDRBnxAlyKj2HSup5kXD
         TiRdlmPmNHqWoHmXM3f0P2WDmlaSBcw+X4D0AH9D8fRIKC9XgoO/FhNRUPlqPNCPOvQG
         3nHAZEnqd0PQMA//NpErMAo0hgFXAP5l7RaUC1sDrWpjrUjSYgF2XUlt13xPbinh+Tcp
         FiE55wmXWlVvgBO6jxGDSIpz8YvFoYm2zQREeTCmtwPTR1bc58kF7DQ/aA6GzbmUoo/L
         F0v/rvBrQAjwGo9SKp83j3QwTTkE+YYHeEIvGMDnJ2E2NAzw2AAmdBra6gxu9wcF3oli
         jzyQ==
X-Gm-Message-State: AO0yUKWHWoBzPDoyoI4Yeis//20e9HK172M2bSOpTJoQjbjhREImmXaX
        +2Avm7SKV21XdTf++xDYfz8c+FPEIMWoCEzJdC0=
X-Google-Smtp-Source: AK7set9toybVTo7XPOx1ksyrfFlMZn37qatrzGsL7LF6QnYkpm2rcM9KJ7yPoOMHuSMU7MbXUbj0Bj6eeF9xDtFwFuA=
X-Received: by 2002:aca:d909:0:b0:37a:d1e1:65aa with SMTP id
 q9-20020acad909000000b0037ad1e165aamr2244287oig.83.1676318238426; Mon, 13 Feb
 2023 11:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com> <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org> <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
 <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net> <CAMhs-H9BkQNwNyYQQgSig9vkW-_+i0+x8CLogXNgkRyi9Un6xw@mail.gmail.com>
 <20230213193613.GA371102@roeck-us.net>
In-Reply-To: <20230213193613.GA371102@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 13 Feb 2023 20:57:06 +0100
Message-ID: <CAMhs-H9UW=zkLs+cPkzXUj=TEytH75Y0dX_7NP1E2s-JeoANzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 8:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Feb 13, 2023 at 09:59:35AM +0100, Sergio Paracuellos wrote:
> > On Sun, Feb 12, 2023 at 4:27 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > >
> > > On 2/12/23 00:13, Sergio Paracuellos wrote:
> > > > On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 11/02/2023 12:01, Sergio Paracuellos wrote:
> > > >>> On Sat, Feb 11, 2023 at 11:47 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc=
.unal@arinc9.com> wrote:
> > > >>>>
> > > >>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> > > >>>>> On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <ari=
nc.unal@arinc9.com> wrote:
> > > >>>>>>
> > > >>>>>> Is this mediatek,sysctl property required after your changes o=
n the
> > > >>>>>> watchdog code?
> > > >>>>>
> > > >>>>> I don't really understand the question :-) Yes, it is. Since we=
 have
> > > >>>>> introduced a new phandle in the watchdog node to be able to acc=
ess the
> > > >>>>> reset status register through the 'sysc' syscon node.
> > > >>>>> We need the bindings to be aligned with the mt7621.dtsi file an=
d we
> > > >>>>> are getting the syscon regmap handler via
> > > >>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series,=
 Ar=C4=B1n=C3=A7.
> > > >>>>
> > > >>>> I believe you need to put mediatek,sysctl under "required:".
> > > >>>
> > > >>> Ah, I understood your question now :-). You meant 'required' prop=
erty.
> > > >>> I need more coffee, I guess :-). I am not sure if you can add
> > > >>> properties as required after bindings are already mainlined for
> > > >>> compatibility issues. The problem with this SoC is that drivers b=
ecome
> > > >>> mainlined before the device tree was so if things are properly fi=
xed
> > > >>> now this kind of issues appear.  Let's see Krzysztof and Rob comm=
ents
> > > >>> for this.
> > > >>
> > > >> If your driver fails to probe without mediatek,sysctl, you already=
 made
> > > >> it required (thus broke the ABI) regardless what dt-binding is say=
ing.
> > > >> In such case you should update dt-binding to reflect reality.
> > > >>
> > > >> Now ABI break is different case. Usually you should not break it w=
ithout
> > > >> valid reasons (e.g. it was never working before). Your commit msg
> > > >> suggests that you only improve the code, thus ABI break is not rea=
lly
> > > >> justified. In such case - binding is correct, driver should be rew=
orked
> > > >> to accept DTS without the new property.
> > > >
> > > > Thanks for clarification, Krzysztof. Ok, so if this is the case I n=
eed
> > > > to add this property required (as Arinc was properly pointing out i=
n
> > > > previous mail) since without it the driver is going to fail on prob=
e
> > > > (PATCH 5 of the series). I understand the "it was never working
> > > > before" argument reason for ABI breaks. What happens if the old dri=
ver
> > > > code was not ideal and totally dependent on architecture specific
> > > > operations when this could be totally avoided and properly make arc=
h
> > > > independent agnostic drivers? This driver was added in 2016 [0]. Th=
ere
> > > > was not a device tree file in the kernel for this SoC mainlined unt=
il
> > > > 2022 [1]. I also personally migrated this watchdog binding in 2022
> > > > from text to YAML and maintained it without changes [2]. When this =
was
> > > > mainlined not all drivers were properly reviewed and the current co=
de
> > > > was just maintained as it is. Most users of this SoC are in the
> > > > openWRT community where the dtsi of the mainline is not used yet an=
d
> > > > they maintain their own mt7621.dtsi files. Also, when a new version=
 of
> > > > the openWRT selected kernel is added they also modify and align wit=
h
> > > > its mt7621.dtsi file without maintaining previous dtb's. If "make t=
he
> > > > driver arch independent to be able to be compile tested" and this k=
ind
> > > > of arguments are not valid at all I need to know because I have
> > > > started to review driver code for this SoC and other drivers also h=
ave
> > > > the same arch dependency that ideally should be avoided in the same
> > > > way. This at the end means to break the ABI again in the future for
> > > > those drivers / bindings. So I can just let them be as it is and no=
t
> > > > provide any change at all and continue without being compile tested
> > > > and other beneficial features to detect future driver breakage.
> > > >
> > >
> > > Problem is that there are (presumably) shipped systems out there with
> > > the old devicetree file. The watchdog driver would no longer instanti=
ate
> > > on those systems.
> >
> > Ok, I will maintain only the PATCH that changes the driver to not use
> > globals and send v5.
> >
>
> Other options might be to search for the "syscon" node name or to search
> for the "mediatek,mt7621-sysc" compatible.

Thanks for the hint. I didn't know about
'syscon_regmap_lookup_by_compatible()'. I will use this to avoid DTB
ABI breakage and allow the driver to be selected for COMPILE_TEST..

Thanks, Guenter.

Best regards,
    Sergio Paracuellos

>
> Guenter
>
> > >
> > > Guenter
> > >
> >
> > Thanks,
> >     Sergio Paracuellos
