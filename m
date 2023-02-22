Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1230E69F551
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBVN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:27:46 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF73401B;
        Wed, 22 Feb 2023 05:27:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9474424E2B4;
        Wed, 22 Feb 2023 21:27:39 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Feb
 2023 21:27:39 +0800
Received: from [192.168.125.82] (113.72.147.165) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Feb
 2023 21:27:38 +0800
Message-ID: <c0472d7f-56fe-3e91-e0a0-49ee51700b5d@starfivetech.com>
Date:   Wed, 22 Feb 2023 21:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud> <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org>
 <Y/VWNPfApsfm3/UD@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y/VWNPfApsfm3/UD@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 23:39:32 +0000, Conor Dooley wrote:
> On Tue, Feb 21, 2023 at 02:17:17PM -0800, Stephen Boyd wrote:
>> Quoting Conor Dooley (2023-02-16 10:20:34)
>> > On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
>> > > On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
>> > > > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
>> > > Please see the picture of these external clocks in clock tree.
>> > > 
>> > > # mount -t debugfs none /mnt
>> > > # cat /mnt/clk/clk_summary
>> > >                                  enable  prepare  protect                                duty  hardware
>> > >    clock                          count    count    count        rate   accuracy phase  cycle    enable
>> > > -------------------------------------------------------------------------------------------------------
>> > >  *mclk_ext*                             0        0        0    12288000          0     0  50000         Y
>> > >  *tdm_ext*                              0        0        0    49152000          0     0  50000         Y
>> > >  *i2srx_lrck_ext*                       0        0        0      192000          0     0  50000         Y
>> > >  *i2srx_bclk_ext*                       0        0        0    12288000          0     0  50000         Y
>> > >  *i2stx_lrck_ext*                       0        0        0      192000          0     0  50000         Y
>> > >  *i2stx_bclk_ext*                       0        0        0    12288000          0     0  50000         Y
>> > >  *gmac1_rgmii_rxin*                     0        0        0   125000000          0     0  50000         Y
>> > >     gmac1_rx                          0        0        0   125000000          0     0  50000         Y
>> > >        gmac1_rx_inv                   0        0        0   125000000          0   180  50000         Y
>> > >  *gmac1_rmii_refin*                     0        0        0    50000000          0     0  50000         Y
>> > >     gmac1_rmii_rtx                    0        0        0    50000000          0     0  50000         Y
>> > >        gmac1_tx                       0        0        0    50000000          0     0  50000         N
>> > >           gmac1_tx_inv                0        0        0    50000000          0   180  50000         Y
>> > >  *osc*                                  4        4        0    24000000          0     0  50000         Y
>> > >     apb_func                          0        0        0    24000000          0     0  50000         Y
>> > >  ...
>> > > 
>> > > The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
>> > > actually used as the parent of other clocks.
>> > 
>> > > The "dummy" clocks
>> > > you said are all internal clocks.
>> > 
>> > No, what I meant by "dummy" clocks is that if you make clocks "required"
>> > in the binding that are not needed by the hardware for operation a
>> > customer of yours might have to add "dummy" clocks to their devicetree
>> > to pass dtbs_check.
>> 
>> They can set the phandle specifier to '<0>' to fill in the required
>> property when there isn't anything there. If this is inside an SoC, it
>> is always connected because silicon can't change after it is made
>> (unless this is an FPGA). Therefore, any and all input clocks should be
>> listed as required.
> 
>> If the clk controller has inputs that are
>> pads/balls/pins on the SoC then they can be optional if a valid design
>> can leave those pins not connected.
> 
> From the discussion on the dts patches, where the clocks have been put
> (intentionally) into board.dts, I've been under the impression that we
> are in this situation.

For the system (sys) clock controller, we are in this situation.
For the always-on (aon) clock controller, we are not, because some input
clocks are inside the SoC.

> Up to Hal to tell us if the hardware is capable of having those inputs
> left unfilled!

The situation is different for v1.2A and v1.3B boards.

For the v1.2A board,
gmac1 only requires "gmac1_rmii_refin", which support 100MHz
gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz

For the v1.3B board,
gmac1 only requires "gmac1_rgmii_rxin", which support 1000MHz
gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz

So we should set the "required" property depending on different
boards.

Best regards,
Hal

> 
> FWIW, there's a v4 [1] of this series - but the question has yet to be
> resolved.
> 
> Thanks,
> Conor.
> 
> 1 - https://lore.kernel.org/all/20230221024645.127922-1-hal.feng@starfivetech.com/

