Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922A692502
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBJSGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBJSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:06:09 -0500
Received: from smtp-out-01.comm2000.it (smtp-out-01.comm2000.it [212.97.32.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45B5FE44;
        Fri, 10 Feb 2023 10:06:06 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-01.comm2000.it (Postfix) with ESMTPSA id 8C7DF845A11;
        Fri, 10 Feb 2023 19:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1676052365;
        bh=83nAANJlK4M4gL9DKeam0l5vJQbWuPFRJm5+aaywfzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SstJCzq2MMb/cksZ8+31Qg8lsSTjvRt6XT4XtFZOiuQhyssqakHkX6qjZvlxl0UIF
         fyCs4010y3ljx+QgS6vnOcJK6ANBVXekyIPRsqaqJWo9afmc03ZGfouwa7V/DQhFlH
         Fkqabi17aadhaMlSaJA2pkT3T3UAOAtBfWXSdOLpCWOB6XGZZ28V5Gmi8uYuSU3sWz
         UPREQb+/+53wZ8QdkufJozYkpJp9btTM6g5v6+pMBCwC3WjwQDJy0vog2YoTih9YJO
         1HiKOufaeiCN0IsXPhDFG4Ls1jkY28ouKq9t/Ntp7xK3SaLX3xhFFnpvTEYbrUDJRF
         LnZ76aQ6DONtw==
Date:   Fri, 10 Feb 2023 19:05:59 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com
Subject: Re: K3 AM62x SoC dts/dtsi include hierarchy and naming scheme
Message-ID: <Y+aHh7B73mkAjR7Q@francesco-nb.int.toradex.com>
References: <Y+KcJdvgDw9EqFCz@francesco-nb.int.toradex.com>
 <20230209153352.5tgkqe3xbby7pmju@polio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209153352.5tgkqe3xbby7pmju@polio>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:33:52AM -0600, Nishanth Menon wrote:
> On 19:44-20230207, Francesco Dolcini wrote:
> > Hello Vignesh and all,
> > I am writing you to get some clarification on the way the dts/dtsi
> > naming and include hierarchy is designed for the TI K3 AM62x SOC family.
> > 
> > I read commit f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC").
> > 
> > I plan to send in the next few weeks some device tree files for
> > inclusion in the kernel for SOM (or computer on module) based on the
> > AM62x SOC.
> > 
> > I do envision to have the same dts file for different machine that are
> > going to use different variant of the AM62x SOC, e.g. AM623 vs AM625 or
> > just a different number of CPU cores, handling the differences at
> > runtime (patching the .dtb in U-Boot?) to limit the maintenance effort and
> > limit the amount of very similar dts files.
> > 
> > Said that we would prefer to stay close with what is considered/agreed
> > to be the best approach.
> > 
> > Would something like that work or you would have a completely different
> > expectation?
> > 
> > What would be the expected naming scheme? k3-am62-${board_name}.dts ?
> > Something else?
> > 
> > k3-am625.dtsi defines the CPU nodes, why are these in a AM625 specific
> > file? To me this looks like something that would be just the same with
> > AM623, and at the same time AM6251 has only one core (see [0] Table 5-1).
> > Am I missing something?
> > 
> > Thanks for your help,
> > Francesco
> > 
> > [0] https://www.ti.com/lit/ds/symlink/am625.pdf 
> > 
> 
> Typically, our strategy has been to introduce the superset device,
> primarily because the device variants are quite a few, and without
> actual users, it makes no sense to introduce a dtsi in kernel
> in-anticipation of a potential board. Now that said, also keep in mind
> the part number definitions do change depending on the market demands
> over time (qualification requirements etc..), The initial device tree
> was based on the definition we had at the time, as usual, over time,
> definitions are changing :(.
	
... and from my point of view this is normal and fine. All good :-)

> Considering the potential combinatorial explosion if we are trying
> to constantly catching up with variations of chip configurations as
> market definitions change over time, we need to be a bit pragmatic in
> the various dtsi files we introduce. With that in mind, If we have
> just one board using the part variant, we should reduce the churn in
> the tree by keeping the processor variation isolated to the board
> (See arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi as an
> example), on the other hand, the AM6251 (Single A53 variant) promises
> to be a variant that will probably get used in multiple boards, I'd
> suggest introducing a dtsi that is reused across the boards.

Our current plan is to have multiple SKUs that will differentiate by the
specific SoC SKU, not sure if this was clear to you, as an example we
will have.

for board in variant1 variant2 variant3
  k3-am6251-${board}.dts
  k3-am6252-${board}.dts
  k3-am6254-${board}.dts
  k3-am6231-${board}.dts
  k3-am6232-${board}.dts
  k3-am6234-${board}.dts

that are just the same apart the AM62x SKU.
Do you expect something like that (18 .dts files, in this example) ?

To me this is absolutely fine, I just want to be sure this is what you
expect.

For example we do have these dts boards file here

arch/arm64/boot/dts/freescale/imx8mm-verdin-*.dts

and the FDT is patched in U-Boot in
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-imx/imx8m/soc.c#L1245

with the this approach we have 4 dts files instead of the 16 if we would
use the exact SOC SKU variant [0].

Francesco

[0] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini-nano

