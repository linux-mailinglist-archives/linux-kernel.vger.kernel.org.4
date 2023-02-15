Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB0697A93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBOLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjBOLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:21:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C137B6D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:21:28 -0800 (PST)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 059193F4B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676460087;
        bh=hwzNkkVHAMig3SgTdNBISffkqWyB+YZfYs1moUFjJBQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cQ/cbKTc7GkCr29Mxcb5UBckJwcf7/15OPWJehCFZc66ItYrp/W6igA0CYlVe3/kB
         x1JuRl4ascRlF0s06xqPeox0O50+4fLmNf4u3tlgO95jZiS7fFwVkfr0sUbZO4El5J
         ezi550gUwk3tYvGylY3NAttl32HRIHwhFSnJzRHnwxiFJ8/nHVbhvcK0ocklPsDEZB
         zdtC2uXFSaev8AeeqBKlA4dmSmiDdTf2UN4xpFxnPoWpKCYsti3+JT72//NsVu232j
         L3BbhFtUZrSDWe0W5pKhIzZi+HqmK1W6zPrXpKoMMRoU5oLzg+QU0AdA7atq9V84Hq
         jMp5Zbu2aSMng==
Received: by mail-qt1-f200.google.com with SMTP id a24-20020ac87218000000b003bb7c7a82f7so10799292qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwzNkkVHAMig3SgTdNBISffkqWyB+YZfYs1moUFjJBQ=;
        b=E7zm06h2AX5NDEoDgkwBShdaKB9Z8LxlpnlgOMUGLehVHumal/lGTdq03MUkz+h2+M
         G+yvBQ0M5lga/3A6mQRPvqUlxPs9jMgRiVvnuQuHwlBTjPBI1HjCOIemq2vTyklAcGBX
         QO1c3SMDNoOwi9IlDPl9qnAkMCpvmPs8ElWqcVoNH/yoeCCJssC04P6eDPDiZXCpQjc+
         C48fMsjCpYLXmzbSA5etft+ibOJDb7rDs89EQXqT5SigctnZWUt65rJYAIAq77xq13Y6
         etYXdnPr71Ni7IcHZC/R0qCldNEZt1jbO9a3GsPgfxM8uJgz0ERBq85S0YC5vt5z8fgl
         Pexw==
X-Gm-Message-State: AO0yUKXILDmdmum1rnkxSHGrudQvUD21uC1hLL5dD124+FV8hVhyAkrp
        ZRFeky39Cu0tLpIgMmyv9YdhUKoDRwiF69gdwNqd4nIVPSB9lfoWZuAeMJ3mjKmqwfgxABprg9g
        CyJEcVKM6ZGkyI3pjS9qvj3L1m9weHZmex3SEcrMM10jGV3hlsXnXIbUFuQ==
X-Received: by 2002:a05:622a:164f:b0:3bc:e3a8:d1d6 with SMTP id y15-20020a05622a164f00b003bce3a8d1d6mr195956qtj.229.1676460075472;
        Wed, 15 Feb 2023 03:21:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9/NeWH75yJcn/t46NzwvdAG3kpXtrEWKot0xC2tKbCmHsBGrLAxxXzoc7xjxLRcnJ3CgUfTfDnKiYp8juZgUM=
X-Received: by 2002:a05:622a:164f:b0:3bc:e3a8:d1d6 with SMTP id
 y15-20020a05622a164f00b003bce3a8d1d6mr195937qtj.229.1676460075213; Wed, 15
 Feb 2023 03:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20230211031821.976408-1-cristian.ciocaltea@collabora.com>
 <20230211031821.976408-9-cristian.ciocaltea@collabora.com>
 <Y+e+N/aiqCctIp6e@lunn.ch> <d1769dac-9e80-2f0d-6a5c-386ef70e1547@collabora.com>
In-Reply-To: <d1769dac-9e80-2f0d-6a5c-386ef70e1547@collabora.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 12:20:58 +0100
Message-ID: <CAJM55Z8Uq2ZU3KvJZKDLZUJDLEyvHjCRJKcYn5CAOR0c2rhT7Q@mail.gmail.com>
Subject: Re: [PATCH 08/12] net: stmmac: Add glue layer for StarFive JH7100 SoC
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 01:09, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 2/11/23 18:11, Andrew Lunn wrote:
> >> +
> >> +#define JH7100_SYSMAIN_REGISTER28 0x70
> >> +/* The value below is not a typo, just really bad naming by StarFive =
=C2=AF\_(=E3=83=84)_/=C2=AF */
> >> +#define JH7100_SYSMAIN_REGISTER49 0xc8
> >
> > Seems like the comment should be one line earlier?

Well yes, the very generic register names are also bad, but this
comment refers to the fact that it kind of makes sense that register
28 has the offset
  28 * 4 bytes pr. register =3D 0x70
..but then register 49 is oddly out of place at offset 0xc8 instead of
  49 * 4 bytes pr. register =3D 0xc4

> > There is value in basing the names on the datasheet, but you could
> > append something meaningful on the end:
> >
> > #define JH7100_SYSMAIN_REGISTER49_DLYCHAIN 0xc8
>
> Unfortunately the JH7100 datasheet I have access to doesn't provide any
> information regarding the SYSCTRL-MAINSYS related registers. Maybe Emil
> could provide some details here?

This is reverse engineered from the auto generated headers in their u-boot:
https://github.com/starfive-tech/u-boot/blob/JH7100_VisionFive_devel/arch/r=
iscv/include/asm/arch-jh7100/syscon_sysmain_ctrl_macro.h

Christian, I'm happy that you're working on this, but mess like this
and waiting for the non-coherent dma to be sorted is why I didn't send
it upstream yet.

> >> +    if (!of_property_read_u32(np, "starfive,gtxclk-dlychain", &gtxclk=
_dlychain)) {
> >> +            ret =3D regmap_write(sysmain, JH7100_SYSMAIN_REGISTER49, =
gtxclk_dlychain);
> >> +            if (ret)
> >> +                    return dev_err_probe(dev, ret, "error selecting g=
txclk delay chain\n");
> >> +    }
> >
> > You should probably document that if starfive,gtxclk-dlychain is not
> > found in the DT blob, the value for the delay chain is undefined.  It
> > would actually be better to define it, set it to 0 for example. That
> > way, you know you don't have any dependency on the bootloader for
> > example.
>
> Sure, I will set it to 0.
>
> >
> >       Andrew
>
> Thanks for reviewing,
> Cristian
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
