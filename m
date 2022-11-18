Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2B62EFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiKRInA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Nov 2022 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiKRImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:42:55 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8FE0F7;
        Fri, 18 Nov 2022 00:42:54 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id i12so2942952qvs.2;
        Fri, 18 Nov 2022 00:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UUepPjtp7tXuNI8x6TQiQ+HTeQFYkPSiIg2QjVFvAA=;
        b=PIzYhKpPqLlXCUAJEtph3ModlJHU3wAfj1gxXaqsrQme7I9jkyhsgW5p2maGoHadij
         U5WnfW/yFvlpQ45zA5FPkpwajjPjfEhH+tW+1sxLAO41f2h7BQ1BFIv7c/kDSF6VYEFx
         qm9mcRZhn6XQa2aNQ0KYwRxJ8xpC8iY1KvhOgWWRKQTuAHnYMYJEHlgRTJxNu5avElW+
         K/MCYo/ZLeDhrtZbWqPRQw5cKnQi7VAmVdCo/PpHI3c+sED7gPHLYzPGk/5hAQr9k68z
         N2gp5NkUvnFCx6QaR8Rky6TNsejU2E1bV6hA51PLyZXxJhGan+Yp6VIUynSeCThWJXN5
         djzw==
X-Gm-Message-State: ANoB5pkxFl98KbYTbrLqP7eOwjoJ5kW1nh1dpX9Uyv9T0egZkTNxaf96
        sLLQc674XtxCg168oTf/097uaztg6YFuaA==
X-Google-Smtp-Source: AA0mqf7fmRgSuC3ZN4cd8n12HXYRTVKhQZEqGq1XsE9+BNWKhAa6eC67pOpQE38id7FyDFtHz1t9uQ==
X-Received: by 2002:a0c:ff0b:0:b0:4bb:7349:14e5 with SMTP id w11-20020a0cff0b000000b004bb734914e5mr5586353qvt.114.1668760973329;
        Fri, 18 Nov 2022 00:42:53 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id dt18-20020a05620a479200b006ea7f9d8644sm2026710qkb.96.2022.11.18.00.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:42:53 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 7so4847310ybp.13;
        Fri, 18 Nov 2022 00:42:52 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr5804957ybq.89.1668760972393; Fri, 18 Nov
 2022 00:42:52 -0800 (PST)
MIME-Version: 1.0
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com> <20221116223045.GA1130586-robh@kernel.org>
 <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
 <BL0PR12MB2401AFF244ADF7B026935A419B069@BL0PR12MB2401.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2401AFF244ADF7B026935A419B069@BL0PR12MB2401.namprd12.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Nov 2022 09:42:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuTxAZsrqHxfhwhWq6xmJVRuzFNmgMx26zBAY=D2s19A@mail.gmail.com>
Message-ID: <CAMuHMdXuTxAZsrqHxfhwhWq6xmJVRuzFNmgMx26zBAY=D2s19A@mail.gmail.com>
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     "Larson, Bradley" <Bradley.Larson@amd.com>
Cc:     Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Thu, Nov 17, 2022 at 7:39 PM Larson, Bradley <Bradley.Larson@amd.com> wrote:
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> > > ...
> > > > > +
> > > > > +title: AMD Pensando Elba SoC Resource Controller
> > > > > +
> > > > > +description: |
> > > > > +  AMD Pensando Elba SoC Resource Controller functions are
> > > > > +  accessed with four chip-selects.  Reset control is on CS0.
> > > >
> > > > One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'
> > > >
> > > > Hard to say more because I don't have the whole thread nor remember what
> > > > exactly we discussed before. That was 100s of bindings ago...
> > >
> > > I agree and the example for v7 had all 4 chip-selects shown.
> >
> > That is not what I said. Look at 'reg' above again. You have 1 device,
> > but you have 4 nodes which looks like separate 4 devices. The
> > exception would be if what's on each chip select is independent from
> > each other.
> >
> > Describe what your h/w has/is/does so we can provide better guidance.
>
> This is the hardware design for every implementation with the Elba SoC
>
>   Elba <-- spi --> One FPGA or CPLD (4 chip-selects)
>
> where there are four functions in the FPGA accessed by userspace applications except for emmc reset control which is a bit in a CS0 register.  The IP at CS0 is a bunch of miscellaneous mgmt registers.  CS1 is a designware I2C master/slave.  CS2 is a Lattice dual I2C master.  CS3 is internal storage for the CPLD or FPGA depending on the hardware implementation.
>
> 'reg = <0 1 2 3>' in the dt fragment below is indicating the chip-select which is what other bindings appear to be doing.  Maybe one answer is delete this and add our compatible to spidev.c in the patchset we provide to customers.  Adding our compatible to spidev.c was nack'ed. Recommendation?

The fragment below does not have "reg = <0 1 2 3>", but individual
subnodes, each with their own "reg" property.

> Not including 'reg' results in this compile warning:
>
>   DTC     arch/arm64/boot/dts/amd/elba-asic.dtb
> arch/arm64/boot/dts/amd/elba-asic-common.dtsi:73.28-78.4: Warning (spi_bus_reg): /soc/spi@2800/system-controller@0: missing or empty reg property
> arch/arm64/boot/dts/amd/elba-asic-common.dtsi:80.22-84.4: Warning (spi_bus_reg): /soc/spi@2800/system-controller@1: missing or empty reg property
> arch/arm64/boot/dts/amd/elba-asic-common.dtsi:86.22-92.4: Warning (spi_bus_reg): /soc/spi@2800/system-controller@2: missing or empty reg property
> arch/arm64/boot/dts/amd/elba-asic-common.dtsi:94.22-98.4: Warning (spi_bus_reg): /soc/spi@2800/system-controller@3: missing or empty reg property
>   CALL    scripts/atomic/check-atomics.sh
>
> &emmc {
>         bus-width = <8>;
>         cap-mmc-hw-reset;
>         reset-names = "hw";
>         resets = <&rstc 0>;
>         status = "okay";
> };
>
> &spi0 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         num-cs = <4>;
>         cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>                    <&porta 7 GPIO_ACTIVE_LOW>;
>         status = "okay";
>
>         rstc: system-controller@0 {
>                 compatible = "amd,pensando-elbasr";
>                 reg = <0>;
>                 spi-max-frequency = <12000000>;
>                 #reset-cells = <1>;
>         };
>
>         system-controller@1 {
>                 compatible = "amd,pensando-elbasr";
>                 reg = <1>;
>                 spi-max-frequency = <12000000>;
>         };
>
>         system-controller@2 {
>                 compatible = "amd,pensando-elbasr";
>                 reg = <2>;
>                 spi-max-frequency = <12000000>;
>                 interrupt-parent = <&porta>;
>                 interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>         };
>
>         system-controller@3 {
>                 compatible = "amd,pensando-elbasr";
>                 reg = <3>;
>                 spi-max-frequency = <12000000>;
>         };

The above describes 4 individual but further identical (they have the
same compatible value) devices, while above you say they are not identical:

    The IP at CS0 is a bunch of miscellaneous mgmt registers.
    CS1 is a designware I2C master/slave.
    CS2 is a Lattice dual I2C master.
    CS3 is internal storage for the CPLD or FPGA depending on the
hardware implementation.

So either this should be modelled as a single subnode with 4 chip
selects[*]:

        system-controller@0 {
                compatible = "amd,pensando-elbasr";
                reg = <0 1 2 3 4>;
                spi-max-frequency = <12000000>;
                #reset-cells = <1>;
        };

or as 4 separate subnodes, each using 4 different compatible values.
Giving the wildly different functionalities provided by each, you also need
4 binding documents.

[*] I'm not sure the Linux SPI core actually supports this yet.

> };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
