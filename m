Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA26AAF35
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCEK4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:56:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E713D68;
        Sun,  5 Mar 2023 02:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8464FCE0025;
        Sun,  5 Mar 2023 10:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41984C433D2;
        Sun,  5 Mar 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678013757;
        bh=ghe9m3Sb2ZozwkfUR3J/OZxMt72CJ2dDXwhL30J9Tgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOZT9OJBJihI6tMu2QfcwPJPPtN6tTDGw3Q54Ffxpw2/uV+mb3v7Hno20+REVOYZ+
         h9Mzi1KgMLER8Si5Z63Nh2pkrOKm6XP/69GhEb7C2ACURXP8bwIBL2guem7Ez19Efo
         wSBY/nGx7Lk6cs88HdidRV7a9b+vDOejoLKMtJQMTQ8e8/9jOohHnOgF05SMNPqvEB
         /pjVU6yiAkySo7wTZsh3dJMEN1/MLNkLuMWSO/rVS2G9STsPH6ogIikHsQzx7fk0pP
         bB0KWKNKQFtwKwuLw9JSW39dSi78dHHqFka0qdNZ9syXSkajAT/sbJ1ACryr4ikovx
         60F5s0lLB/bUA==
Date:   Sun, 5 Mar 2023 10:55:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 05/10] mfd: rt5033: Apply preparatory changes before
 adding rt5033-charger driver
Message-ID: <20230305105551.GJ2574592@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Jakob Hauser wrote:

> Order the register blocks to have the masks in descending manner.
> 
> Add new defines for constant voltage shift (RT5033_CHGCTRL2_CV_SHIFT),
> MIVR mask (RT5033_CHGCTRL4_MIVR_MASK), pre-charge current shift
> (RT5033_CHGCTRL4_IPREC_SHIFT), internal timer disable
> (RT5033_INT_TIMER_DISABLE), termination disable (RT5033_TE_DISABLE),
> CFO disable (RT5033_CFO_DISABLE), UUG disable (RT5033_CHARGER_UUG_DISABLE).
> 
> The fast charge timer type needs to be written on mask 0x38
> (RT5033_CHGCTRL3_TIMER_MASK). To avoid a bit shift on application, change the
> values of the timer types to fit the mask. Added the timout duration as a
> comment. And the timer between TIMER8 and TIMER12 is most likely TIMER10, see
> e.g. RT5036 [1] page 28 bottom.
> 
> Add value options for MIVR (Minimum Input Voltage Regulation).
> 
> Move RT5033_TE_ENABLE_MASK to the block "RT5033 CHGCTRL1 register", in order
> to have the masks of the register collected there. To fit the naming scheme,
> rename it to RT5033_CHGCTRL1_TE_EN_MASK.
> 
> Move RT5033_CHG_MAX_CURRENT to the block "RT5033 charger fast-charge current".
> 
> Add new defines RT5033_CV_MAX_VOLTAGE and RT5033_CHG_MAX_PRE_CURRENT to the
> blocks "RT5033 charger constant charge voltage" and "RT5033 charger pre-charge
> current limits".
> 
> In include/linux/mfd/rt5033.h, turn power_supply "psy" into a pointer in order
> to use it in devm_power_supply_register().

Are there no present users to account for?

> [1] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  include/linux/mfd/rt5033-private.h | 53 ++++++++++++++++++++----------
>  include/linux/mfd/rt5033.h         |  2 +-
>  2 files changed, 36 insertions(+),` 19 deletions(-)

-- 
Lee Jones [李琼斯]
