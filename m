Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0421690D11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBIPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBIPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:30 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094A60D5D;
        Thu,  9 Feb 2023 07:34:16 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 319FXqnU125642;
        Thu, 9 Feb 2023 09:33:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675956832;
        bh=bQs2LuMKvXtGlz/nyDz00lfj4KMUBI7mZMrw6IqBs2k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=joRjVW9boTlaeJHW0l9pr2Vae3H8UU5Hfd2oQWp12s/2AsT0QNiGcYqFNV9p6AZsf
         VuA3Feztb1MsaK+A+e/R2qEQJaqCbGR/tR1CdaP9x5WYZtP1iSEOH5xEaCs4fMitCB
         7vHlQnOwUTsio2vDnuEwgVNFGQg8USrKdBaI0jWY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 319FXq9r078704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Feb 2023 09:33:52 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Feb 2023 09:33:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Feb 2023 09:33:52 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 319FXqaZ117869;
        Thu, 9 Feb 2023 09:33:52 -0600
Date:   Thu, 9 Feb 2023 09:33:52 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <francesco.dolcini@toradex.com>
Subject: Re: K3 AM62x SoC dts/dtsi include hierarchy and naming scheme
Message-ID: <20230209153352.5tgkqe3xbby7pmju@polio>
References: <Y+KcJdvgDw9EqFCz@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+KcJdvgDw9EqFCz@francesco-nb.int.toradex.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:44-20230207, Francesco Dolcini wrote:
> Hello Vignesh and all,
> I am writing you to get some clarification on the way the dts/dtsi
> naming and include hierarchy is designed for the TI K3 AM62x SOC family.
> 
> I read commit f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC").
> 
> I plan to send in the next few weeks some device tree files for
> inclusion in the kernel for SOM (or computer on module) based on the
> AM62x SOC.
> 
> I do envision to have the same dts file for different machine that are
> going to use different variant of the AM62x SOC, e.g. AM623 vs AM625 or
> just a different number of CPU cores, handling the differences at
> runtime (patching the .dtb in U-Boot?) to limit the maintenance effort and
> limit the amount of very similar dts files.
> 
> Said that we would prefer to stay close with what is considered/agreed
> to be the best approach.
> 
> Would something like that work or you would have a completely different
> expectation?
> 
> What would be the expected naming scheme? k3-am62-${board_name}.dts ?
> Something else?
> 
> k3-am625.dtsi defines the CPU nodes, why are these in a AM625 specific
> file? To me this looks like something that would be just the same with
> AM623, and at the same time AM6251 has only one core (see [0] Table 5-1).
> Am I missing something?
> 
> Thanks for your help,
> Francesco
> 
> [0] https://www.ti.com/lit/ds/symlink/am625.pdf 
> 

Typically, our strategy has been to introduce the superset device,
primarily because the device variants are quite a few, and without
actual users, it makes no sense to introduce a dtsi in kernel
in-anticipation of a potential board. Now that said, also keep in mind
the part number definitions do change depending on the market demands
over time (qualification requirements etc..), The initial device tree
was based on the definition we had at the time, as usual, over time,
definitions are changing :(.

Considering the potential combinatorial explosion if we are trying
to constantly catching up with variations of chip configurations as
market definitions change over time, we need to be a bit pragmatic in
the various dtsi files we introduce. With that in mind, If we have
just one board using the part variant, we should reduce the churn in
the tree by keeping the processor variation isolated to the board
(See arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi as an
example), on the other hand, the AM6251 (Single A53 variant) promises
to be a variant that will probably get used in multiple boards, I'd
suggest introducing a dtsi that is reused across the boards.

NOTE: this would be no different from similar strategies we have
followed in OMAP devices, for example.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
