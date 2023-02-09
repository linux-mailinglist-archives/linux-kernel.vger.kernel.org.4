Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17F691038
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBISUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBISUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:20:46 -0500
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF032CA1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:20:43 -0800 (PST)
Date:   Thu, 9 Feb 2023 19:20:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675966841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=183SMf2nAH4QkN2wPxRVbmQZxrMWhKzQtKvEVPjSMg0=;
        b=lvwftqjY5IhD81XTl0ruR++xWv68m0RjKbYH8ZSP2kQcwvSlIyDTl4pL3F2VAWvaJ/4/iu
        6UclhUQg2UYSQ6ErNoeyoGAVtT4MToQGMUfWkis0rd131Acvjj6+tuAJCluvlJG1Zg8C8j
        LKUhVACMSACKKLfc+RMEnlQcJJ1opAs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
Message-ID: <Y+U5d7dpKceXkh6f@L14.lan>
References: <20230128133151.29471-1-henrik@grimler.se>
 <20230128133151.29471-3-henrik@grimler.se>
 <CGME20230209142330eucas1p2d7ba56b6496bb90ed6af2054fe929c9d@eucas1p2.samsung.com>
 <99a17d21-2cf9-a573-29cb-827568c9709b@linaro.org>
 <8fd04935-0553-e04b-7d8c-470573816e6f@samsung.com>
 <e6c8ba8a-7d53-6931-a2e8-bcf4ecfbcd81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c8ba8a-7d53-6931-a2e8-bcf4ecfbcd81@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 04:18:33PM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2023 15:50, Marek Szyprowski wrote:
> > On 09.02.2023 15:23, Krzysztof Kozlowski wrote:
> >> On 28/01/2023 14:31, Henrik Grimler wrote:
> >>> Add aliases for eMMC, SD card and WiFi where applicable, so that
> >>> assigned mmcblk numbers are always the same.

[ ... ]

> >>> +	aliases {
> >>> +		mmc0 = &sdhci_0;
> >>> +		mmc2 = &sdhci_2;
> >>> +		mmc3 = &sdhci_3;
> >> 1. Is this actually correct? Since mmc1 was disabled, sdhci_2 had mmc1
> >> index but now will have mmc2.
> >>
> >> 2. I tested Odroid U3 and the ID changed. emmc went from 1 to 0. Any
> >> idea why? Both patches should be transparent.
> > 
> > Nope, eMMC and SD order changed a few times in the past and now they get 
> > indices based on the probe time, so any order is possible depending on 
> > the presence of the sd card / eMMC module.
> > 
> >> 3. Patchset does not look bisectable, so both patches should be squashed.
> > 
> > Why? First patch removes obsolete mshc aliases, which don't determine 
> > the logical MMC device number in the system. The second one adds fixed 
> > indices to the local MMC devices created by the respective MMC host 
> > controllers.
> 
> Ah, I see now, so mshc only determined the caps. That makes sense and
> answers my two questions.
> 
> But my question (1) a bit remains - these numbers of aliases should
> reflect what is wired on the board, so:
> A. before indices were mmc0, mmc1, mmc2 (and sdhcio_1 disabled). Now
> indices will be mmc0, mmc2 and mmc3, right?

Yes (and before indices could change between reboots).

> B. How the interface is called on the board? For some boards we actually
> can check with schematics.

Based on the limited public information like user manuals ([1] and
[2]) I *think* the internal storage, sdhci_0 and mshc_0 on 4210 and
4412 (respectively), is connected to data lines belonging to both
SDMMC0 and SDMMC1 (4+4 data lines, SDMMC# is what the IP is called in
user manuals), since they have a bus-width of 8.  The sdcard reader
however has a bus-width of 4 and is connected to just SDMMC2 on both.

So, I think suggested aliases best describe the hardware.  Maybe Marek
or someone else at Samsung has a better understanding of these boards
though :)

> Best regards,
> Krzysztof

[1] https://web.archive.org/web/20170918162018/http://www.samsung.com/global/business/semiconductor/file/product/Pulbicmanual_Exynos_4_Dual_45nm_Ver00-2.pdf
[2] https://github.com/lian494362816/Tiny4412/blob/master/Pdf/Exynos%204412%20SCP_Users%20Manual_Ver.0.10.00_Preliminary0.pdf

Best regards,
Henrik Grimler
