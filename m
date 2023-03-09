Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12376B2CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCISTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCISTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:19:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AEC6411
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:19:31 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0660B445B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678385968;
        bh=SxKX8lAWQsQ9FTwiM9BPGc+zhxP/zhLFmNPZpha4eWo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I7EprDEuWnzyG1gL1WDHnsQlIz0LpOvut7EdYSfN3bwOYeH/KlFplOLAjI7KTczVu
         hsQQ5ougtBOE4p01TcKnX+NdbZp/okxBJV6Vi4/ZDKYDL5f6psyqPEM5m0nOcIZLSh
         pOGiDqQvURdtYkXQ32odNQNw37e/oc5LK6UWmHIxU5EZNIul2jeSXjcTzVHTEp1tCl
         5GaQYq8PEX2pGfdeGNNT90zxdg41K7r0m90xsBWXMuEKS1DbPlXrFsikOw3N+3Oka3
         Nn50V3pOfShz/JHOItlnrE3xrk+bopL2ULgpyCGDCqdKGiaEoC2iaBaackNG6u0v/F
         qZUvisH5NK1ug==
Received: by mail-qv1-f69.google.com with SMTP id z3-20020ad44143000000b005771ea56ab6so1655896qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxKX8lAWQsQ9FTwiM9BPGc+zhxP/zhLFmNPZpha4eWo=;
        b=7Knm7N8JtZVx2i64VL38uDW58caLCGn5cKJq5OXGhjcQginVbJHJY8jo5eYDNmFLLc
         oc0Y/DCyyzgk4idrDfpYwKBi0JKvK3+lmumHmqpdkRCQv7vNZsnGlcFsH4UlX32JMtUm
         L80AVUmCDdpYDv6tnWZiqPT4TAp2+1OrtTh5kaOLmK3gJGcv03uHSDCXpTvy4dBUwFWc
         +bWFTV3WlhmIA+NnXBYFVnftnp5C4hcpea0w40z1h+qZA9uE+kxcffOiALNfyiOnV/fN
         gLIpWCjwIRwo6Zg89TCfKnz5DzYDVEw9+Zfnr9uI0b89gmQe27Qak/zo6+f5Y+V535jZ
         uscw==
X-Gm-Message-State: AO0yUKVhoaN2HhizXXCJ2kaUUhRZnsoCMZa4CkJ1c7QQIIvIJCHRut3K
        deDtkcg5uFBKCcGrBtuTbjLxjtyzdSFM1qQ2WsuXbgar910mbgvmdhV6fKBDdcsixDY3IhEp0dK
        vkK87puPfnOQjs6Mw+CDYp8BpTTK/0Um6f7ZgFjaI0Rga0tDhDyndvNz7bg==
X-Received: by 2002:ac8:429a:0:b0:3bf:bba8:69b0 with SMTP id o26-20020ac8429a000000b003bfbba869b0mr6074835qtl.5.1678385963010;
        Thu, 09 Mar 2023 10:19:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9OHYCSEuIKRx9FxuLcExe2yb6O6D1LT6790n4D4PIp0zTs0FgzUhcs4O8DexM+HqsfP/U+EGkFQOY6RIH4J0w=
X-Received: by 2002:ac8:429a:0:b0:3bf:bba8:69b0 with SMTP id
 o26-20020ac8429a000000b003bfbba869b0mr6074830qtl.5.1678385962760; Thu, 09 Mar
 2023 10:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-13-hal.feng@starfivetech.com> <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
 <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com> <49ab1072-98ba-f364-9b66-68658566e732@starfivetech.com>
 <CAJM55Z9YGjD+1haWcXEZNkHnWNRZckdBmTTykTt7QZV_LUohgQ@mail.gmail.com> <032f9254-482a-4b97-8e7e-4afb1f78eb21@spud>
In-Reply-To: <032f9254-482a-4b97-8e7e-4afb1f78eb21@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 9 Mar 2023 19:19:06 +0100
Message-ID: <CAJM55Z_HGt3iu=trv0v_VzyO3NkVo+aiEaT9vxRURz-MvrbCOg@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on
 clock driver
To:     Conor Dooley <conor@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
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

On Thu, 9 Mar 2023 at 19:11, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Mar 09, 2023 at 03:06:13PM +0100, Emil Renner Berthing wrote:
> >  On Thu, 9 Mar 2023 at 10:44, Hal Feng <hal.feng@starfivetech.com> wrot=
e:
>
> > > The AON clock driver provides clocks for gmac0 which is used frequent=
ly.
> > > So I think it would be more convenient if we set "default y" here.
>
> > You're right that if we default y for the ethernet driver then the aon
> > clock/reset should also default y. Personally I don't think we should
> > default y for every ethernet driver that might be used on some
> > supported risc-v platform, but I see now that
> > arch/riscv/config/defconfig already contains CONFIG_MACB=3Dy,
> > CONFIG_E1000E=3Dy, CONFIG_R8169=3Dy and CONFIG_MICROSEMI_PHY=3Dy, so ma=
ybe
> > I'm wrong or just too late.
>
> The defconfig really needs a good bit of cleanup (one of the many things
> that I am telling myself I will do as part of kconfig.socs cleanup).
>
> w.r.t defconfig Palmer said it pretty well earlier on IRC: "defconfig
> should be useful for kernel devs, which means it should boot on the
> common dev boards".
>
> IMO, that means enough to boot an initramfs and poke the thing to see
> that it is alive, so: ethernet & serial, and the clocks/resets/pinctrl
> stuff required to get those going can all be set to y in defconfig.
>
> In the driver Kconfig entries, to me, it's more or less the same.
> I guess, answer the question "Will your customer's board get to the
> point where it can load a module ithout building this into the kernel?".
> If the answer to that question is yes, then don't make it default y.
>
> That's my =E2=82=AC0.02!

Cool. Defaulting to m in the Kconfig for anything that can be loaded
later is exactly what I was trying to say, except I mixed in the
defconfig for no good reason. That means both the aon clocks and
dwmac-starfive should default to m in Kconfig. The JH7110 (VisionFive
2) boots just fine like that and brings up aon clocks and ethernet
after loading the modules.

/Emil
