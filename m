Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6B637507
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKXJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKXJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:20:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C911DA3E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:20:52 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B7603F470
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669281650;
        bh=VRx51K+Grac4imHy1DHLCU82k/uWawM5zQfqB1/2368=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BTSb5oDPfk5kVdVNwh/WPgxbI/s03ycVt3H5olgJTv9wwLfLdHt+lPsGUA1RYeRrr
         E+QELyzw7H9wkP6y64I6UlTd9z4511LRkY9EsWZ3sKZrfDF0hY8rAx5Q4XHNDuJaxR
         6uD28+ZjNaZerOIbKO33njc0E5A0XyiuYi9jTrykz5g1cVgWBFfCafTOtnn427W2pa
         3b9mfcDffeaTqB6MQb8HnSpEKSO8r3+Z6+QjACugugQrd5KxD4Jah5SgGHW7lb9uRm
         hgOueE+0qB0KF6yzt4oNdmqRLD1/k5YurnzaAaxAsh9WFzI5dneKAM4jrCq3vTybq6
         Omvj4AS2I7vnA==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-36810cfa61fso10925487b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRx51K+Grac4imHy1DHLCU82k/uWawM5zQfqB1/2368=;
        b=63MGifviAmY9Q/mS35R9d10OZhaLHBBmFqtf7KTXN4ALr3eWiWWjVMsE5r0CFwLsy2
         0XwbZWsklZW5yGuV9yLi0thU4AzjCWK7xlm3QkZsu13LuBrPtF2oBc0HRFmuQXk96HJi
         bhdzN5cCQVUM4iRviU9d8wRdSIE8riZrtgg495rHGBlAo5fOVqgCZIJ0Va60eOq2axKK
         zAi439KW4MPERaj1FOhaGqEqkhy2w3s9+2XrMuDaQSTDlT0rLl8Pu2mpFFu5X1khcS7R
         Ow4w4UoqcSJ//lJTo5xb7b9fUYrw9xTQSFqjVGycv00+RTLMpxRXminyIbE55lSYGQXa
         GwKg==
X-Gm-Message-State: ANoB5pkQBj37hIgUDWEjx5iqBL6IdvnaFzmOJUkzRA1QWFNN2R3+jQuU
        h/tildTj7+M9SRZOO+T/qkjniTAN6AU2Iw/wr5v5ZxX0qmLskBEs4Q/9jX0Xw913Z9oPh6t7cqk
        PAEqoIFtk2jV8KZWbnb4z8jFyBGBGxNqLrWlD0B87+oK33LEFqQt2vMvkyA==
X-Received: by 2002:a25:4a86:0:b0:6f1:215a:2dbe with SMTP id x128-20020a254a86000000b006f1215a2dbemr3191225yba.469.1669281648220;
        Thu, 24 Nov 2022 01:20:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4H7k0go2dHlua8ClKkvM8qah93F0sS9CYUiwz8DhwGeE2xOLmvodSBoY+vtCQ2wxqkd5uAMT6yRu2cukAu/Qc=
X-Received: by 2002:a25:4a86:0:b0:6f1:215a:2dbe with SMTP id
 x128-20020a254a86000000b006f1215a2dbemr3191211yba.469.1669281648005; Thu, 24
 Nov 2022 01:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-2-hal.feng@starfivetech.com> <202211190418.2AJ4IQjc072382@SH1-CSMTP-DB111.sundns.com>
 <ca3e341a-3dc3-39d6-7e26-89ba65aa9473@starfivetech.com>
In-Reply-To: <ca3e341a-3dc3-39d6-7e26-89ba65aa9473@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 24 Nov 2022 10:20:32 +0100
Message-ID: <CAJM55Z-zgR=LKqtg4ioj9Ez1CT7wchrNWWPVT5XAMPF736OcRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: riscv: Add StarFive JH7110 SoC and
 VisionFive2 board
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 at 06:56, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> On Sat, 19 Nov 2022 01:28:48 +0800, Emil Renner Berthing wrote:
> > On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
> > >
> > > From: Emil Renner Berthing <kernel@esmil.dk>
> > >
> > > Add device tree bindings for the StarFive JH7110 RISC-V SoC [1]
> > > and the VisionFive2 board [2] equipped with it.
> > >
> > > [1]: https://doc-en.rvspace.org/Doc_Center/jh7110.html
> > > [2]: https://doc-en.rvspace.org/Doc_Center/visionfive_2.html
> > >
> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > index 5b36243fd674..64008c57e31f 100644
> > > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > @@ -22,6 +22,10 @@ properties:
> > >            - const: beagle,beaglev-starlight-jh7100-r0
> > >            - const: starfive,jh7100
> > >
> > > +      - items:
> > > +          - const: starfive,visionfive-v2
> >
> > I think StarFive has switched to just calling it VisionFive 2 and not
> > V2. Please check up on this before committing to the compatible
> > string.
> >
> > Also there are going to be different revisions of the VisionFive 2
> > board, so maybe consider adding eg. starfive,visionfive-2-v1.1 and
> > starfive,visionfive-2-v1,2b early.
>
> I checked that the official name of this board is "VisionFive 2". The
> board has version A and version B, which are different in gmac and phy
> chip. The version A board has one 1000M and one 100M Ethernet ports
> while the version B board has two 1000M Ethernet ports. In dts, they
> have different configuration parameters for gmac. So I would like to
> distinguish them by two compatibles as below in the next version.
>
>       - items:
>           - enum:
>               - starfive,visionfive-2-va
>               - starfive,visionfive-2-vb
>           - const: starfive,jh7110

Cool. Though the silkscreen on my board says "VisionFive 2 V1.2B" so I
think it would be less confusing if you used that as the model, and
"starfive,visionfive-2-v1.2b" as the compatible string for the board.


> Best regards,
> Hal
>
> >
> > > +          - const: starfive,jh7110
> > > +
> > >  additionalProperties: true
>
