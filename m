Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237068AB31
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBDQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 11:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:27:29 -0500
Received: from out-135.mta1.migadu.com (out-135.mta1.migadu.com [IPv6:2001:41d0:203:375::87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6693D4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 08:27:25 -0800 (PST)
Date:   Sat, 4 Feb 2023 17:27:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675528043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6CjYk8EtEf6fAK6NSdNEXA8dI2Iw2y8gEGpp/id1NY=;
        b=F6cP3CajJGx3wXlb8Lu+U6S5k0cMuusHCgbFcNrzhJ0P/87aOWHJDHsP+Lbv0HVHDe9RX6
        Ks/9jvHG9mDea9Kz1si19/efKKoInDFfcPN7ItdWxOQUDxROoeDWPi5r7amJofTD44tOvw
        tzOvvR6U/i/nk3hIKLr+lLtH9GDspOw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     David Virag <virag.david003@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] arm64: dts: exynos: drop mshc aliases
Message-ID: <Y96HY3D/JDk9t1MU@localhost>
References: <20230203204000.14410-1-henrik@grimler.se>
 <20230203204000.14410-2-henrik@grimler.se>
 <398401ce6a1e37b42f895b86fa2ed90c2676e15a.camel@gmail.com>
 <6c528b24aa94751d568d3b43bd00a4795964b3ae.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c528b24aa94751d568d3b43bd00a4795964b3ae.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sat, Feb 04, 2023 at 01:45:15PM +0100, David Virag wrote:
> On Sat, 2023-02-04 at 12:43 +0100, David Virag wrote:
> > On Fri, 2023-02-03 at 21:39 +0100, Henrik Grimler wrote:
> > > They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
> > > exynos: use common_caps").
> > > 
> > > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > > ---
> > >  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
> > >  arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 2 --
> > >  2 files changed, 4 deletions(-)
> [...]
> > In dw_mmc-exynos.c, there's a caps array specified like this:
> > 
> > /* Common capabilities of Exynos4/Exynos5 SoC */
> > static unsigned long exynos_dwmmc_caps[4] = {
> >         MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA,
> >         0,
> >         0,
> >         0,
> > };
> > 
> > As I understand these capabilities are added to the mmc controllers
> > based on mshc alias id. Shouldn't these capabilities be moved to
> > device-tree before removing these aliases? This also applies to the
> > 32bit arm patch. If I understand correctly, removing these aliases
> > without adding the capabilities to dt removes the capability
> > "MMC_CAP_1_8V_DDR" and "MMC_CAP_8_BIT_DATA" from mshc_0/mmc_0.

Thanks for pointing this out (I should have seen it already), will
send a new version to update device trees and remove the need for
those mshc alias based capabilities.

> Actually, it defaults to 0, so these capabilities will be added to all
> mmc nodes, not just those with mshc0 alias. That may cause problems.

I think I see what you mean: ctrl_id will be set to 0 if mshc alias is
missing, and then caps is set as
    mmc->caps |= drv_data->caps[ctrl_id];
where
    drv_data->caps[0] = MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA

Should be fixed in next version of patchset then in any case, maybe it
deserves a "Fixes:" tag as well, will have a look in git history if
there is a particular commit that introduced this situation.

> Best regards,
> David

Best regards,
Henrik Grimler
