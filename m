Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1E66E3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjAQQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjAQQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:45:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02212144BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:45:47 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHp5b-0008KV-38; Tue, 17 Jan 2023 17:45:35 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHp5a-0002Vy-0G; Tue, 17 Jan 2023 17:45:34 +0100
Date:   Tue, 17 Jan 2023 17:45:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, abel.vesa@linaro.org,
        abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Message-ID: <20230117164533.gkli3p4a2j4q73jw@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
 <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
 <20221005230609.5BA04C433D6@smtp.kernel.org>
 <f85808f9-979d-1dc5-ac9a-9519c62e2737@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85808f9-979d-1dc5-ac9a-9519c62e2737@denx.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

sorry for the delay.

On 22-10-06, Marek Vasut wrote:
> On 10/6/22 01:06, Stephen Boyd wrote:
> > Quoting Marco Felsch (2022-10-05 01:23:48)
> > > Hi Stephen, Michael,
> > > 
> > > I know it is a busy time right now, but maybe you have a few minutes for
> > > this RFC. I know it is incomplete, but the interessting part is there
> > > and it would fix a real issue we encountered on the imx8mm-evk's.
> 
> The i.MX8M hang when using 32kHz supplied by PMIC is solved by modeling the
> clock in DT correctly, see:
> 
> https://lore.kernel.org/all/20220924174603.458956-1-marex@denx.de/

Thanks for this link, but I have a few doubts about your modeling. As
you already noted in the above link, the 32K osc is critical for some
reason not listed in the RM.

My doubts about your modeling are:
 - The snvs-rtc driver will be required no matter if it is used or not
 - According the i.MX8MM RM rev.3 11/2020: The SNVS is supplied by clock
   gate 71 (CCM_CCGR71). So this would be the clock provider for the
   SNVS modul. This clock gate is enabled by the ROM loader and the
   clock driver have no support for it yet. As soon as the clock driver
   have support for it your modeling will break since the clock
   gate gets turned off since you specify an other clock source.

With my solution the modeling is still correct and the user is not
enforced to enable driver for an _maybe_ unused modul. What do you
think?

Regards,
  Marco

> > There's another approach by Marek[1]. Can you work together on a
> > solution? I think we should step away from trying to make the critical
> > flag work during clk registration, and turn on the clk during provider
> > registration instead.
> 
> So that would work like the qualcomm-specific 'protected-clock' property?
> 
> I really want to avoid such clock-driver specific hacks which are poorly or
> inconsistently supported. This critical-clock should be a generic solution
> and that should be in clock core.
> 
> > That hopefully makes it simpler. We can keep the
> > clk flag of course, so that the clk can't be turned off, but otherwise
> > we shouldn't need to make registration path check for the property.
> > 
> > [1] https://lore.kernel.org/all/20220924174517.458657-1-marex@denx.de/
> 
> 
