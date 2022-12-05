Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A3642FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiLESPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLESP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:15:26 -0500
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7A2036D;
        Mon,  5 Dec 2022 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1670264119; bh=XVPKkuLGeYz5mLqD1WBfE0UuvVM2oX5DVgXJT9tVBkQ=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=Km25UcmR+GYuyNmPwkIUcK26v4T7Pb5bdUehlqxgOfD474bB/nVk08jgTuJFGGRs0
         d8xVcN0UuEfSNROApkPTRUo2jd1iOtIbqMqHafHlXDtp9WcrgMFsUg/v2zRxY1tBBQ
         2qWkgeezJdXrgY2Y5groJgpv5zyjaLWiLS8ebypc=
Date:   Mon, 5 Dec 2022 19:15:19 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     aholmes@omnom.net, devicetree@vger.kernel.org,
        ezequiel@vanguardiasur.com.ar, frank-w@public-files.de,
        frattaroli.nicolas@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, macromorgan@hotmail.com,
        mark.kettenis@xs4all.nl, michael.riesch@wolfvision.net,
        pgwipeout@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        s.hauer@pengutronix.de, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: rk356x: Fix PCIe register and
 range mappings
Message-ID: <20221205181519.7e5diejvhiynqmv5@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chukun Pan <amadeus@jmu.edu.cn>, aholmes@omnom.net,
        devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        frank-w@public-files.de, frattaroli.nicolas@gmail.com,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, macromorgan@hotmail.com,
        mark.kettenis@xs4all.nl, michael.riesch@wolfvision.net,
        pgwipeout@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        s.hauer@pengutronix.de, yifeng.zhao@rock-chips.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221112114125.1637543-2-aholmes@omnom.net>
 <20221205162322.149967-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205162322.149967-1-amadeus@jmu.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:23:22AM +0800, Chukun Pan wrote:
> > The register and range mappings for the PCIe controller in Rockchip's
> > RK356x SoCs are incorrect. Replace them with corrected values from the
> > vendor BSP sources, updated to match current DT schema.
> 
> Hi, Andrew
> 
> This patch broken pcie3x2 on my board.

That's because 32bit mapping for pcie3x2 config should start at 0xf0000000 and
the patch declares it incorrectly at 0xf2000000.

https://megous.com/dl/tmp/6d1a04195112b1e0.png

> And the wireless card on pcie2x1 is still not working.

> [    0.405341] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [    0.670522] rockchip-dw-pcie 3c0800000.pcie: can't request region for resource [mem 0xf2000000-0xf2ffffff]
> [    0.671527] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -16
> [    7.354521] pci 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [    7.355116] mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
> [    7.355812] mt7921e: probe of 0000:01:00.0 failed with error -28

That's ENOSPC. Who knows where it's comming from. Something for you to debug. ;)

regards,
	o.
> 
> --
> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 
