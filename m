Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9737A602F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJRPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJRPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:24:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7A5F7D;
        Tue, 18 Oct 2022 08:24:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29IFOC4x028995;
        Tue, 18 Oct 2022 10:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666106652;
        bh=yeXu6LAsPOv7ziEk86rcmv96Ao8dzF3pExh/3NJ67Pk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KpyywX9fcBO2sNcsnxgfhWM4e6QAi+goA4/NATSywB/PuNJzvVW+kZI4hDpvFNTkf
         5X+CBxzIxAKvHCfGempyQ0XitIKzk6pREKdds9cVKXStzaou7ZZP+F3tm0tCklF62v
         zUI7O1AFfS4ynxayuNFa3W7QQZwEzUtU6GTkBLiY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29IFOCJQ018949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 10:24:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 10:24:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 10:24:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29IFOBVm026167;
        Tue, 18 Oct 2022 10:24:11 -0500
Date:   Tue, 18 Oct 2022 10:24:11 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] AM64x Disable Incomplete DT Nodes
Message-ID: <20221018152411.iguw2mg27ahexq2e@bryanbrattlof.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 17, 2022 thus sayeth Andrew Davis:
> Hello all,
> 
> This series goes through the AM64x dtsi and disables the set of nodes
> that are not functional without additional board level information.
> This is usually pinmux data, but can also be inernal device resources.
> 
> Only when the node is completed in the board file should the node be
> enabled. This helps prevents nodes that represent IP that are not
> pinned-out on a given board from being left enabled.
> 
> This also reduces the effort needed to add a new board, one no longer
> needs to manually disable all the extra IP. For instance TI J784s4 has
> 20(!) MCAN instances. It is much easier to enable the one you pin out,
> vs disabling the 19 that you did not.
> 
> Thanks,
> Andrew
> 
> Andrew Davis (10):
>   arm64: dts: ti: k3-am64: Enable UART nodes at the board level
>   arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
>   arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
>   arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
>   arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
>   arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
>   arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
>   arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  37 ++++++
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |   6 +
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 119 ++-----------------
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 142 ++---------------------
>  4 files changed, 63 insertions(+), 241 deletions(-)
> 

Reviewed-by: Bryan Brattlof <bb@ti.com>

I wholeheartedly agree! This looks great to me!

~Bryan
