Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22F707824
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjERCpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjERCpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:45:08 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5A135;
        Wed, 17 May 2023 19:45:05 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pzTdR-0006Qg-2S;
        Thu, 18 May 2023 02:44:57 +0000
Date:   Thu, 18 May 2023 03:44:45 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: arm: mediatek: add
 mediatek,boottrap binding
Message-ID: <ZGWRHeE3CXeAnQ-5@makrotopia.org>
References: <cover.1683813687.git.daniel@makrotopia.org>
 <f2d447d8b836cf9584762465a784185e8fcf651f.1683813687.git.daniel@makrotopia.org>
 <55f8ac31-d81d-43de-8877-6a7fac2d37b4@lunn.ch>
 <7e8d0945-dfa9-7f61-b075-679e8a89ded9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8d0945-dfa9-7f61-b075-679e8a89ded9@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:54:36AM +0200, Krzysztof Kozlowski wrote:
> On 11/05/2023 17:53, Andrew Lunn wrote:
> > On Thu, May 11, 2023 at 04:10:20PM +0200, Daniel Golle wrote:
> >> The boottrap is used to read implementation details from the SoC, such
> >> as the polarity of LED pins. Add bindings for it as we are going to use
> >> it for the LEDs connected to MediaTek built-in 1GE PHYs.
> > 
> > What exactly is it? Fuses? Is it memory mapped, or does it need a
> > driver to access it? How is it shared between its different users?
> 
> Yes, looks like some efuse/OTP/nvmem, so it should probably use nvmem
> bindings and do not look different than other in such class.

I've asked MediaTek and they have replied with an elaborate definition.
Summary:
The boottrap is a single 32-bit wide register at 0x1001f6f0 which can
be used to read back the bias of bootstrap pins from the SoC as follows:

* bit[8]: Reference CLK source && gphy port0's LED
If bit[8] == 0:
- Reference clock source is XTRL && gphy port0's LED is pulled low on board side
If bit[8] == 1:
- Reference clock source is Oscillator && gphy port0's LED is pulled high on board side

* bit[9]: DDR type && gphy port1's LED
If bit[9] == 0:
- DDR type is DDRx16b x2 && gphy port1's LED is pulled low on board side
If bit[9] == 1:
- DDR type is DDRx16b x1 && gphy port1's LED is pulled high on board side

* bit[10]: gphy port2's LED
If bit[10] == 0:
- phy port2's LED is pulled low on board side
If bit[10] == 1:
- gphy port2's LED is pulled high on board side

* bit[11]: gphy port3's LED
If bit[11] == 0:
- phy port3's LED is pulled low on board side
If bit[11] == 1:
- gphy port3's LED is pulled high on board side

If bit[10] == 0 && bit[11] == 0:
- BROM will boot from SPIM-NOR
If bit[10] == 1 && bit[11] == 0:
- BROM will boot from SPIM-NAND
If bit[10] == 0 && bit[11] == 1:
- BROM will boot from eMMC
If bit[10] == 1 && bit[11] == 1:
- BROM will boot from SNFI-NAND

The boottrap is present in many MediaTek SoCs, however, support for
reading it is only really needed on MT7988 due to the dual-use of some
bootstrap pins as PHY LEDs.

We could say this is some kind of read-only 'syscon' node (and hence
use regmap driver to access it), that would make it easy but it's not
very accurate. Also efuse/OTP/nvmem doesn't seem accurate, though in
terms of software it could work just as well.

I will update DT bindings to contain the gained insights.

Please advise if any existing driver (syscon/regmap or efuse/OTP/nvmem)
should be used or if it's ok to just use plain mmio in the PHY driver.


Best regards


Daniel
