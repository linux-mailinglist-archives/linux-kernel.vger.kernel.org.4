Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1C6C04B2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCSUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCSUNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:13:19 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [IPv6:2001:41d0:203:375::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED040CA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:13:15 -0700 (PDT)
Date:   Sun, 19 Mar 2023 21:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1679256793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTE64vwbAiJ3iSCPE0mCVdkuhQq+1D7PyTGu9lckQYI=;
        b=T+0WP5CjO/Pt/Uz6LnIvqttZwtmN3Nynvp8c8jZvNzh+Xj6P3++1Ot67P1nfPNLLbd36CW
        cj4O3//b0tgoWk3iOqR1k2S65SyIk3mQHAvZz95FF2Q92Xu/zvgzDEPj8Ap3da2BeH+RSf
        3AcabFDFWZE9g+bBUqVP30rysNuS6g4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/2] ARM: dts: exynos: replace mshc0 alias with
 mmc-ddr-1_8v property
Message-ID: <ZBds0zxxRYHEJKP+@L14.lan>
References: <20230316211558.8526-1-henrik@grimler.se>
 <20230316211558.8526-2-henrik@grimler.se>
 <20db729f-e8fb-3d16-54a2-b9a54b9a1b55@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20db729f-e8fb-3d16-54a2-b9a54b9a1b55@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Mar 17, 2023 at 12:55:40PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2023 22:15, Henrik Grimler wrote:
> > Previously, the mshc0 alias has been necessary so that
> > MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA are set for mshc_0/mmc_0.
> > However, these capabilities should be described in the device tree so
> > that we do not have to rely on the alias.
> > 
> > The property mmc-ddr-1_8v replaces MMC_CAP_1_8V_DDR, while bus_width =
> > <8>, which is already set for all the mshc0/mmc0 nodes, replaces
> > MMC_CAP_8_BIT_DATA.
> > 
> > Also drop other mshc aliases as they are not needed.
> > 
> > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > ---
> > 
> > Changes since v4:
> > * Do not set mmc-ddr-1_8v for sdhci_0 on Exynos 4210,
> >   following Marek's tests
> > 
> > Changes since v3:
> > * Drop attempt at node sorting/cleaning
> > * Move two mmc alias additions to the other patch
> > * Update commit message
> > 
> > Changes since v2:
> > * Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0
> > 
> > 
> >  arch/arm/boot/dts/exynos3250-artik5.dtsi            | 1 +
> >  arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
> >  arch/arm/boot/dts/exynos3250-rinato.dts             | 1 +
> 
> Why you do not remove Exynos3250 aliases?

Thanks for spotting that, seems I accidentally dropped removal when
going from v3 to v4.  Will remove them again in next version, and drop
Marek's test tag since rinato is one of the devices he tests (or used
to test).

> Best regards,
> Krzysztof

Best regards,
Henrik Grimler
