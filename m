Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2489663D85C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiK3Oi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiK3Oix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:38:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7966303D5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:38:51 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C54613F176
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669819126;
        bh=yJuPcYaDmRotD++RbdlV7xUD6m84JuqaQZoAA3YlHoQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uYBi8y+hPu2Jmt7CR3+2bwYi90EyIRZh3KJDMgemdYzqG7ia5/CcyoCGm4cJiffbr
         72NplW7cgPgAxAZHWbblKxrZC7ZBIlftTafeIO64j02ykAd5f/dS2hFZX3W0QmNbt7
         ahFC2Dlxja5y+eHa74OmQjQ+100Sq1uzpHPMfAabAmbYmscGQsWCe4mSafxbTeZPQl
         JJVJ1HhJ/GRWVOKoskwtqWaGLJY4CvZc7OhdOx/7ctzCwzkHIuBtoFoWlBhkSUBggb
         IDBxP/JY/GWnDhWRjMJXCQ0EPS6JJIbDNNKFjbZgCggisqxVjO6HEpYcI55q/asyil
         6lfbyGvznq5PA==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3b5da1b3130so153324017b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJuPcYaDmRotD++RbdlV7xUD6m84JuqaQZoAA3YlHoQ=;
        b=duYORKqfWDOnP+/zTbhNz+9xogG0+/uA9UM2vnAnGAqhZwx0mQC8PStfQeLTRodHgG
         C01B8cwVtVCU+FjfmCqx7HrhuXb4pzA+k5g795CHTR1IftEbLnBfnOCJ34nBTaSRja/n
         rQUGbdxR0NdrY4GqNyjwV3vz90OFBScDgYp4gl1gJQw8Ya8vkdAdWQtn9Es4JCgmu5yw
         cnt3lcv7INydIgw8c0nOCFStz282Ot089GeTGx+FPiwMbw5VGfe+GLE4nAjRZ8DjzpD7
         ARK1gYznQj3eedudk49OrypesInF6MI9s0pE5dfYcG9esrl++8ubsaG7AlpglpmJxgT2
         8SJA==
X-Gm-Message-State: ANoB5pmekaKsjKXOXvk+bfrj/+s3mxGsR7aXKHLC1038MEox02LM0buQ
        kFNMiCwZh/2o2wa0j06sbeeaaFiImYr2sEb8YbZAw/c6m7VtcCZUERPMfTWHxod+5H7R09fj5ww
        Vz/8RaFby+Tk7FA8CqSDDS9VOE4Qi2I6F2QPT8ESUYwWh6VE7uXtKuXkqrQ==
X-Received: by 2002:a25:d24b:0:b0:6f1:e822:14e8 with SMTP id j72-20020a25d24b000000b006f1e82214e8mr27924560ybg.467.1669819124622;
        Wed, 30 Nov 2022 06:38:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5h/y9Ufc7p86Pb9tYohSEhT0Ol5lHnhilFhXj6V/t+wLileZuNKNQC9L+9a86g1iFspQXp7Tl/67+u+EK8RTE=
X-Received: by 2002:a25:d24b:0:b0:6f1:e822:14e8 with SMTP id
 j72-20020a25d24b000000b006f1e82214e8mr27924544ybg.467.1669819124392; Wed, 30
 Nov 2022 06:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-5-walker.chen@starfivetech.com> <CAJM55Z9bJqpEGbbx1=EBXhmhigxuHw=ObBdTJ7xy+QY=pTJyoQ@mail.gmail.com>
 <f794e9fb-7ce0-2649-9839-b9ce36b80d1d@starfivetech.com>
In-Reply-To: <f794e9fb-7ce0-2649-9839-b9ce36b80d1d@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 30 Nov 2022 15:38:27 +0100
Message-ID: <CAJM55Z8=eTY+i+ggLSiUEKwnPrKgOybKJP5sNFwRNpx_t35HUA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] riscv: dts: starfive: add power controller node
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 at 03:12, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> On 2022/11/19 2:36, Emil Renner Berthing wrote:
> > On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:
> >>
> >> This adds the power controller node for the Starfive JH7110 SoC.
> >> The pmu needs to be used by other modules such as ISP, VPU, etc.
> >>
> >> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> >
> > Hi Walker,
> >
> > You called the driver jh71xx which suggests it also applies to the
> > jh7100. Are you missing a node in the jh7100 device tree?
>
> No, there is no power domain controller on the jh7100. Our next generation of chips jh7120 will
> still use this power management unit, so here this driver name is called jh71xx_pmu.c or changed
> to jh71xx_power.c , do you think such a name is appropriate ?
> Your reply will be highly appreciated!

I see. In that case jh71xx seems appropriate, thanks.

> >
> >> ---
> >>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> index c22e8f1d2640..fa7b60b82d71 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> @@ -356,6 +356,13 @@
> >>                         #gpio-cells = <2>;
> >>                 };
> >>
> >> +               pwrc: power-controller@17030000 {
> >> +                       compatible = "starfive,jh7110-pmu";
> >> +                       reg = <0x0 0x17030000 0x0 0x10000>;
> >> +                       interrupts = <111>;
> >> +                       #power-domain-cells = <1>;
> >> +               };
> >> +
> >>                 uart0: serial@10000000 {
> >>                         compatible = "snps,dw-apb-uart";
> >>                         reg = <0x0 0x10000000 0x0 0x10000>;
> >> --
> >> 2.17.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
