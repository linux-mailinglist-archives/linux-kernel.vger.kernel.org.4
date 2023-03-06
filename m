Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDB6AC3FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCFOwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCFOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:52:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D57EC2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:52:10 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 712D43F487
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678114320;
        bh=/Ed2pnKpFihOgpPVhJbTQbuHmKlsVltnb1sm0Sd0bF4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=a7/JSHVI51npvAWV0XP8n7D3hA3EGctpaj8WEazmLKtEsoDKufWJmBLi4sO9a0Udi
         l7LOFg/QMl/5fJ51gjAT57GHgKYkB5JWwljy9l28AIf0VzNz+UuBCFd41bzQuRKA/k
         3di35WLWGRt1ar9VXCDW9O1r1N+iUXOXOigJ8uK9EI8PUYhCKZyF42VWqmKYzM74Ro
         Bww0A4tg+AwSYnrpwsFwr+OLBjQq+PLATL69bPddgcSKT7t5xY1IT7JuDOtb+EYXXt
         KFp0q/dw1RYycp1USPePlWY9qBsEPEHfuFtA+cB4168xhWi5xvHHGadY+vsHIuUsIl
         DrCKpbtR/BmZw==
Received: by mail-qt1-f199.google.com with SMTP id l12-20020ac84a8c000000b003bfe751a7fdso5326266qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ed2pnKpFihOgpPVhJbTQbuHmKlsVltnb1sm0Sd0bF4=;
        b=YHZ3wyZzAA0xgDacNX0MV7gj2biQhixaVCQ3THzAp8RVfkHQ4BXKpA+Bq6q13hYSPu
         /jqcmfa2bYkNYbwmiHvDv/y4z1ue/YS8WZIGZPsKBcUJNa9GtfUAt/1+rowWLPxpLdWx
         5bJ8hXpLARYUP4HhutLCv8mkKwmzENBxtVgryybCoiXyBCNTb/jRrhyaz7ES7pGKB4dU
         MTc5bRcXHJ4N1+qH+y3O/o7uT6mrxU9s1cf1yKRaAVyGxXh8DzWuh26N5DnY6slprtLp
         dNez4BC3emlyPheZ0u0YDiYevHSaQpjG25dN40uaSi62JBUNU0k4QpQjNk7aooOJ/6SU
         WDcw==
X-Gm-Message-State: AO0yUKUX1BE7CIJVBxNCLacJUzC1fu8Kqdqp6PSlJdvG4iTN7URUtMmw
        dJLuFAzOircs07f+Iw60hoCszzCRpadAl7GONKUnqKnX2b8kcTmgJpvMF22UxgLf0dZrgrMdEPn
        ZqTEQkHV09DNVkltS/590bFtJEGW3C5nIiokZRLTTriUJAsjep204PiwLAg==
X-Received: by 2002:ac8:4289:0:b0:3bf:c266:da25 with SMTP id o9-20020ac84289000000b003bfc266da25mr2822557qtl.3.1678114319138;
        Mon, 06 Mar 2023 06:51:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8hGVIO5dLFFjZH2MJTAfwE9FdnA1Tbubej5zA4FV5EKtDEGcMH23xPAGo7OGnX+zEfPlevEWgvQY4tT+oFLFQ=
X-Received: by 2002:ac8:4289:0:b0:3bf:c266:da25 with SMTP id
 o9-20020ac84289000000b003bfc266da25mr2822551qtl.3.1678114318908; Mon, 06 Mar
 2023 06:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20230306140430.28951-1-walker.chen@starfivetech.com> <20230306140430.28951-4-walker.chen@starfivetech.com>
In-Reply-To: <20230306140430.28951-4-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 6 Mar 2023 15:51:42 +0100
Message-ID: <CAJM55Z9j79mar+bXrFEu3sZ=THY=LWwQbqQMf0AqgtUs2uJfwg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: add dma controller node
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Mon, 6 Mar 2023 at 15:04, Walker Chen <walker.chen@starfivetech.com> wrote:
> Add the dma controller node for the Starfive JH7110 SoC.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 697ab59191a1..191b6add72c8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -510,6 +510,24 @@
>                         #gpio-cells = <2>;
>                 };
>
> +               dma: dma-controller@16050000 {
> +                       compatible = "starfive,jh7110-axi-dma";
> +                       reg = <0x0 0x16050000 0x0 0x10000>;
> +                       clocks = <&stgcrg JH7110_STGCLK_DMA1P_AXI>,
> +                                <&stgcrg JH7110_STGCLK_DMA1P_AHB>;
> +                       clock-names = "core-clk", "cfgr-clk";
> +                       resets = <&stgcrg JH7110_STGRST_DMA1P_AXI>,
> +                                <&stgcrg JH7110_STGRST_DMA1P_AHB>;
> +                       interrupts = <73>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <4>;
> +                       snps,dma-masters = <1>;
> +                       snps,data-width = <3>;
> +                       snps,block-size = <65536 65536 65536 65536>;
> +                       snps,priority = <0 1 2 3>;
> +                       snps,axi-max-burst-len = <16>;
> +               };
> +
>                 aoncrg: clock-controller@17000000 {
>                         compatible = "starfive,jh7110-aoncrg";
>                         reg = <0x0 0x17000000 0x0 0x10000>;
> --
> 2.17.1
>
