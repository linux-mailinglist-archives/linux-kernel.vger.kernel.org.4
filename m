Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43BF6950C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBMTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBMTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:36:18 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1E01BF;
        Mon, 13 Feb 2023 11:36:17 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso4070242otq.9;
        Mon, 13 Feb 2023 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlUwM5/8oymp4K70XoDUwsO3GnP9r5Zf4hM5G2ZAGRg=;
        b=DL6ogzN03jXRR0WMlULu8x/lTz7LjCnuBbYjic0VsnSoQd5bo1gPorLCGB7x8mXUXw
         JwqI899c0IJTD5yh9QGdpsNH/OvBy2R4Kqncl0GEZZPQAL4KjjiyZGSSu/dztN8+6Adn
         lpci6Twq9QTtTgzqx81Se9K4pRcC5KWuFOf/PDQa+YvCa1KZN11ogPJLN0uTe1m7M7nQ
         GNYgjrRhGdHsTPqVxL1tkv0EsgZnGVbdGSfMK12I2iQdRSTOMS5Wbr8bHGPv4yEqtaPA
         ObAaHh4bSsompE6oUoBk+D1e/C25KSM692XG1BMbZtE5bKDBmWg8AIVUPy6P/kSYJ0ja
         bg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlUwM5/8oymp4K70XoDUwsO3GnP9r5Zf4hM5G2ZAGRg=;
        b=uUYkn7TqUDAA6lcur2dSye44k4m8cWGri7sNfV8YsiUS5mG+JfDs4JWXZmfuz/AROy
         4shzjMpH6Dks7mMo6TAUXpKn+Cc55EwcJa/7VnWcNbkkibOJpo8Y2m09tE8Z3FtIUgmf
         U8rd4JVT42Mu1dhh+LY88Kt7JAj3t8HkL99eynZ3rtb+D4saiZ/VEWaWOMq4iujtDxHi
         q/zS/8m+tIxwdIWQy+0OXxMsFa6OtbnFe7RhnhVOY2H6XvIqfJnRjo0XZm1t+l/KoN7S
         0qImrLBSfsPUJ6EuDSdu0I7eS329aljpElJtoYRSDB5n7S61QMV7rg2e/GkOw4PTt80J
         ezMw==
X-Gm-Message-State: AO0yUKUl9Eg2s6/WDq/kutee69+qSgh6suXZ7cvFTsEv8CuJ1F4YPNyU
        dMLBsmwTJq01xwqhJk3lBNq4G23DCbI=
X-Google-Smtp-Source: AK7set/xCcQ7tGUsLetlO9bx2krIG6QOtusRt6j8kS7mB55rPNflD2uXhfYgMKEaA+2X90axcSdDJA==
X-Received: by 2002:a9d:7095:0:b0:68b:d0cc:d1c2 with SMTP id l21-20020a9d7095000000b0068bd0ccd1c2mr14820687otj.19.1676316976292;
        Mon, 13 Feb 2023 11:36:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a9d638a000000b0068d3f341dd9sm5580101otk.62.2023.02.13.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:36:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Feb 2023 11:36:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Message-ID: <20230213193613.GA371102@roeck-us.net>
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
 <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
 <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
 <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
 <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net>
 <CAMhs-H9BkQNwNyYQQgSig9vkW-_+i0+x8CLogXNgkRyi9Un6xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H9BkQNwNyYQQgSig9vkW-_+i0+x8CLogXNgkRyi9Un6xw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:59:35AM +0100, Sergio Paracuellos wrote:
> On Sun, Feb 12, 2023 at 4:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 2/12/23 00:13, Sergio Paracuellos wrote:
> > > On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 11/02/2023 12:01, Sergio Paracuellos wrote:
> > >>> On Sat, Feb 11, 2023 at 11:47 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> > >>>>
> > >>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> > >>>>> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> > >>>>>>
> > >>>>>> Is this mediatek,sysctl property required after your changes on the
> > >>>>>> watchdog code?
> > >>>>>
> > >>>>> I don't really understand the question :-) Yes, it is. Since we have
> > >>>>> introduced a new phandle in the watchdog node to be able to access the
> > >>>>> reset status register through the 'sysc' syscon node.
> > >>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
> > >>>>> are getting the syscon regmap handler via
> > >>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.
> > >>>>
> > >>>> I believe you need to put mediatek,sysctl under "required:".
> > >>>
> > >>> Ah, I understood your question now :-). You meant 'required' property.
> > >>> I need more coffee, I guess :-). I am not sure if you can add
> > >>> properties as required after bindings are already mainlined for
> > >>> compatibility issues. The problem with this SoC is that drivers become
> > >>> mainlined before the device tree was so if things are properly fixed
> > >>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
> > >>> for this.
> > >>
> > >> If your driver fails to probe without mediatek,sysctl, you already made
> > >> it required (thus broke the ABI) regardless what dt-binding is saying.
> > >> In such case you should update dt-binding to reflect reality.
> > >>
> > >> Now ABI break is different case. Usually you should not break it without
> > >> valid reasons (e.g. it was never working before). Your commit msg
> > >> suggests that you only improve the code, thus ABI break is not really
> > >> justified. In such case - binding is correct, driver should be reworked
> > >> to accept DTS without the new property.
> > >
> > > Thanks for clarification, Krzysztof. Ok, so if this is the case I need
> > > to add this property required (as Arinc was properly pointing out in
> > > previous mail) since without it the driver is going to fail on probe
> > > (PATCH 5 of the series). I understand the "it was never working
> > > before" argument reason for ABI breaks. What happens if the old driver
> > > code was not ideal and totally dependent on architecture specific
> > > operations when this could be totally avoided and properly make arch
> > > independent agnostic drivers? This driver was added in 2016 [0]. There
> > > was not a device tree file in the kernel for this SoC mainlined until
> > > 2022 [1]. I also personally migrated this watchdog binding in 2022
> > > from text to YAML and maintained it without changes [2]. When this was
> > > mainlined not all drivers were properly reviewed and the current code
> > > was just maintained as it is. Most users of this SoC are in the
> > > openWRT community where the dtsi of the mainline is not used yet and
> > > they maintain their own mt7621.dtsi files. Also, when a new version of
> > > the openWRT selected kernel is added they also modify and align with
> > > its mt7621.dtsi file without maintaining previous dtb's. If "make the
> > > driver arch independent to be able to be compile tested" and this kind
> > > of arguments are not valid at all I need to know because I have
> > > started to review driver code for this SoC and other drivers also have
> > > the same arch dependency that ideally should be avoided in the same
> > > way. This at the end means to break the ABI again in the future for
> > > those drivers / bindings. So I can just let them be as it is and not
> > > provide any change at all and continue without being compile tested
> > > and other beneficial features to detect future driver breakage.
> > >
> >
> > Problem is that there are (presumably) shipped systems out there with
> > the old devicetree file. The watchdog driver would no longer instantiate
> > on those systems.
> 
> Ok, I will maintain only the PATCH that changes the driver to not use
> globals and send v5.
> 

Other options might be to search for the "syscon" node name or to search
for the "mediatek,mt7621-sysc" compatible.

Guenter

> >
> > Guenter
> >
> 
> Thanks,
>     Sergio Paracuellos
