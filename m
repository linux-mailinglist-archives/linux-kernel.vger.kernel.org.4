Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D775029E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjGLJOQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 05:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjGLJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:14:08 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408E1BD1;
        Wed, 12 Jul 2023 02:13:59 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so7517864276.3;
        Wed, 12 Jul 2023 02:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153238; x=1691745238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pzM/ps0J0V255RZBWb0G0YFpNEXWLUJowIcR6XiYjk=;
        b=ccgKbAGfadOP9Kn0mhM4AVbtPUFkE3L+kGzFT26ccT06cmjptR5IfLnsEbfU8BBLKG
         LcRCcjg0MX90UTdl3hrYMjUNXhRrQd1nPXZYUN41wWhaRPaGzFKrsuVurx317xY6wqwR
         lj+f8rGguqwSJEdmCrYt64HAhtmOXbpQC2LKlarW9hKGoagIZoBuKYVozCjoSN80ykXv
         Pk7HKij6GT8+HpsZ26FVq97tekziyeZ23CW2hfWRvsnL0yRY0eji2TVRsLbchaImMolv
         667mXbMwAI4JJ8ZjKBN2+nmWNP+VvPPPfoMM7Z7DxrAvMbosHqnssLCJoIa1Yn9Y9Z2/
         D/zA==
X-Gm-Message-State: ABy/qLZ7/csx2xDA2/ab1CUlk1PfTnCgLxIWRjvvNqpAGxAoLBxzjmqY
        RE2Pij5qzmaxNx8+iFOZOsyWQPNgcsX18g==
X-Google-Smtp-Source: APBJJlEGI9QOySKutu67FT+09g5HDKJW6QaQtkhmFtI2Gt7xYrmvF9FbCFeJua7FUXQZxkuoHvrPhw==
X-Received: by 2002:a25:743:0:b0:c42:97f9:cda6 with SMTP id 64-20020a250743000000b00c4297f9cda6mr14923290ybh.29.1689153238377;
        Wed, 12 Jul 2023 02:13:58 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00be865f3d4fdsm808105ybe.62.2023.07.12.02.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:13:57 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so7536463276.2;
        Wed, 12 Jul 2023 02:13:57 -0700 (PDT)
X-Received: by 2002:a25:9a03:0:b0:bc1:dfa5:83a4 with SMTP id
 x3-20020a259a03000000b00bc1dfa583a4mr15070011ybn.13.1689153237624; Wed, 12
 Jul 2023 02:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-squealer-walmart-9587342ddec1@wendy> <18871eff-f2be-9eed-ee4c-99eba87686d8@gmail.com>
In-Reply-To: <18871eff-f2be-9eed-ee4c-99eba87686d8@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 11:13:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX00X=L387jSrP_mZo04u0zkU8V6-g13Y2urrU1cRgS-A@mail.gmail.com>
Message-ID: <CAMuHMdX00X=L387jSrP_mZo04u0zkU8V6-g13Y2urrU1cRgS-A@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: renesas: clean up dtbs_check W=1 warning
 due to empty phy node
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, conor@kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei.

On Wed, Jul 12, 2023 at 10:43 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 7/12/23 11:14 AM, Conor Dooley wrote:
>
> > dtbs_check w/ W=1 complains:
> > Warning (unit_address_vs_reg): /soc/ethernet@11c20000/ethernet-phy@7: node has a unit name, but no reg or ranges property
> > Warning (avoid_unnecessary_addr_size): /soc/ethernet@11c20000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> >
> > The ethernet@11c20000 node is guarded by an `#if (!SW_ET0_EN_N)` in
> > rzg2ul-smarc-som.dtsi, where the phy child node is added. In
> > rzfive-smarc-som.dtsi, the ethernet node is marked disabled & the
> > interrupt properties are deleted from the phy child node. As a result,
> > the produced dts looks like:
> >       ethernet@11c20000 {
> >               compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
> >               /* snip */
> >               #address-cells = <0x01>;
> >               #size-cells = <0x00>;
> >               status = "disabled";
> >
> >               ethernet-phy@7 {
> >               };
> >       };
> >
> > Adding a corresponding `#if (!SW_ET0_EN_N)` around the node in
> > rzfive-smarc-som.dtsi avoids the complaint, as the empty child node is
> > not added:
> >       ethernet@11c20000 {
> >               compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
> >               /* snip */
> >               #address-cells = <0x01>;
> >               #size-cells = <0x00>;
> >               status = "disabled";
> >       };
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> [...]
>
> > diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > index d6f18754eb5d..c62debc7ca7e 100644
> > --- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > @@ -22,6 +22,7 @@ &dmac {
> >       status = "disabled";
> >  };
> >
> > +#if (!SW_ET0_EN_N)
>
>    Are the parens really needed here?

No they aren't. But this follows the existing style of the other users.

>
> >  &eth0 {
> >       status = "disabled";
> >
> [...]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
