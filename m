Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823105B82AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiININi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiININf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:13:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23944F195
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:13:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oYNWE-0004no-Qr; Wed, 14 Sep 2022 10:13:14 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oYNWE-0001w4-9Q; Wed, 14 Sep 2022 10:13:14 +0200
Date:   Wed, 14 Sep 2022 10:13:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Message-ID: <20220914081314.hrzpborwquwqpgda@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
 <30a8c599-583a-3eea-c7bf-04062c43b736@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a8c599-583a-3eea-c7bf-04062c43b736@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 22-09-13, Peng Fan wrote:
> On 9/13/2022 6:21 PM, Marco Felsch wrote:
> > Hi,
> > 
> > this proposal is to mark clocks as critical. It is somehow inspired by
> > the regulator-always-on property. Since sometimes we can end in circular
> > dependcies if we wanna solve the dependcies for a specific clock
> > provider.
> > 
> > The property is generic so it can be used by every hw clock provider. So
> > it can be seen as generic implementation to [1].
> 
> Thanks for working on a generic solution, I think your proposal could also
> help [1] and try to resolve same issue as [2].

Didn't noticed that there was already a on going discussion on this
topic. Maybe a combination of my proposal and [2] is the solution, but I
have no idea if I my solution can work on a ID based array. Let's see
what the maintainers say.

> [1] https://lore.kernel.org/all/CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com/
> [2] https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
> 
> Thanks,
> Peng.
> 
> 
> > 
> > [1] https://lore.kernel.org/linux-clk/20220913092136.1706263-1-peng.fan@oss.nxp.com/
> > 
> > Marco Felsch (2):
> >    clk: add support for critical always-on clocks
> >    arm64: dts: imx8mm-evk: mark 32k pmic clock as always-on
> > 
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  1 +
> >   drivers/clk/clk.c                             | 18 ++++++++++++++++++
> >   2 files changed, 19 insertions(+)
> > 
> 
