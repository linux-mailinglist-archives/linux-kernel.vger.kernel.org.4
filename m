Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C699A6B71CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCMI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCMI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:56:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA81F49D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:53:38 -0700 (PDT)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AC5C3F592
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678697599;
        bh=rdDSrE0VIq+XmHMRyMrdPIQatR30pRaMUhYB/xPPqz8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dRUkVaI76q9CPTpgxlSgLIfN4e3vgNOB02uAdgPMCpwRnqavAYzp25GQl+WpX1rS0
         Sw1bRRtLl5SXKuVE27+UYAG8Cw1+tbsNWy49t29TwQvYGVeAcXEoAZtMHaAN0mrNhx
         yhGNLbyc5+w2Q83MfACT8R3zb0ymOk9olWtDQv2qde79eRTjn1sqWl5BQahmvjD3L8
         OnK+9NlqOBIRqGVYVoYgQjBrrcn2elM4Ol4x8QgOBsXMujTC5k3zgAiLjOKhUp7TQ/
         To5mgY6XVkqUg/Uom4YGKXYHACx8L0z6NaIonii6dQEopthGcXLkU+lct6q0nR5W6p
         0EgQ/1CYptxsw==
Received: by mail-qv1-f72.google.com with SMTP id x10-20020ad440ca000000b005800220da38so6653100qvp.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdDSrE0VIq+XmHMRyMrdPIQatR30pRaMUhYB/xPPqz8=;
        b=IRUePND7QkbSkKFueFaYLMr1SqY8JHmIPyIBws0uISMbBUGcsXVU5N92NcAhYF8T3Y
         ajC2Tlq7a7BKCmEM6Ajs+DncFir4e65f9k9tHRCTegyj86DX32omPI2nXVx1bQhx+FYH
         +r2UflWmVP90L6wK0zBIEaU6ROfIBAfeigzA/qJ64LM3zT5YsUMI0HQmivc8I2YJPMKS
         B/Zw9RV4Z9igDOGgB2nO/Qis4ruEzRRFEe58uQI20ASjsw6o6fTpKBieiL6AYqFdsX8J
         dLEsHLDRwowaWnot85npsTg8Q1n4T79JgJxBcvA5syvLl95NTuZBnwoxceqUZrujx9Vn
         MEYg==
X-Gm-Message-State: AO0yUKUlYbgqAQDYq/SJ5MRsYicJ1edin+rTz6e+1hlKcr+DQJztrwCe
        exaNKTZN6TBHhKVdzL7f1tmgZGKG6LRVn5FiaEVD993XtiiIAYCserAjMiDwu4RlvaJE2urpuql
        p5IjQ78B8Vjzj3DUqKY6jOA4RNKmTJZcEs5B/pk2qduYnn6zn26QaRadD5g==
X-Received: by 2002:ac8:56f7:0:b0:3bf:b9a4:6d41 with SMTP id 23-20020ac856f7000000b003bfb9a46d41mr9407542qtu.5.1678697598303;
        Mon, 13 Mar 2023 01:53:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set8AA0sa2nCnrV8w1Osh5NxDD45ICECbteHeANn3sQWk04rh+36JVMJfWLEQ4krvOlUN6FZfm4pVyPz1TdTFshg=
X-Received: by 2002:ac8:56f7:0:b0:3bf:b9a4:6d41 with SMTP id
 23-20020ac856f7000000b003bfb9a46d41mr9407529qtu.5.1678697597999; Mon, 13 Mar
 2023 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-12-hal.feng@starfivetech.com> <34b0473a-91bd-453b-91dd-01defde92d68@spud>
 <92306b73-d7d2-0d60-de15-87bcd71714ed@starfivetech.com>
In-Reply-To: <92306b73-d7d2-0d60-de15-87bcd71714ed@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 13 Mar 2023 09:53:01 +0100
Message-ID: <CAJM55Z-zps4gEohCGyia0nESWYWqQmoChnJZXkw2Zmi5TPV2Wg@mail.gmail.com>
Subject: Re: [PATCH v5 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 at 04:22, Hal Feng <hal.feng@starfivetech.com> wrote:
> On Sat, 11 Mar 2023 13:11:38 +0000, Conor Dooley wrote:
> > On Sat, Mar 11, 2023 at 05:07:23PM +0800, Hal Feng wrote:
> >> From: Emil Renner Berthing <kernel@esmil.dk>
> >>
> >> Add bindings for the system clock and reset generator (SYSCRG) on the
> >> JH7110 RISC-V SoC by StarFive Ltd.
> >>
> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---
> >>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
> >>  MAINTAINERS                                   |   8 +-
> >>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
> >>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
> >>  4 files changed, 454 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
> >>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >> new file mode 100644
> >> index 000000000000..84373ae31644
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >
> >> +  clock-names:
> >> +    oneOf:
> >> +      - items:
> >> +          - const: osc
> >> +          - enum:
> >> +              - gmac1_rmii_refin
> >> +              - gmac1_rgmii_rxin
> >> +          - const: i2stx_bclk_ext
> >> +          - const: i2stx_lrck_ext
> >> +          - const: i2srx_bclk_ext
> >> +          - const: i2srx_lrck_ext
> >> +          - const: tdm_ext
> >> +          - const: mclk_ext
> >> +
> >> +      - items:
> >> +          - const: osc
> >> +          - const: gmac1_rmii_refin
> >> +          - const: gmac1_rgmii_rxin
> >> +          - const: i2stx_bclk_ext
> >> +          - const: i2stx_lrck_ext
> >> +          - const: i2srx_bclk_ext
> >> +          - const: i2srx_lrck_ext
> >> +          - const: tdm_ext
> >> +          - const: mclk_ext
> >
> > Assuming nothing else here is optional,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Yeah, nothing else here is optional. Thanks for your review.

Wait, what kind of optional are we talking about here? Surely all the
i2s and tdm external clocks are optional in the sense that you don't
need them on a board that never does any audio processing.

/Emil

>
> Best regards,
> Hal
