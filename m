Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3466E5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjAQSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjAQSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:16:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184A17CC7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:56:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHqBd-0000ph-Pk; Tue, 17 Jan 2023 18:55:53 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHqBd-0006Lb-82; Tue, 17 Jan 2023 18:55:53 +0100
Date:   Tue, 17 Jan 2023 18:55:53 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     abel.vesa@linaro.org, abelvesa@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marek Vasut <marex@denx.de>
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Message-ID: <20230117175553.fedlob24udnhgdkn@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
 <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
 <20221005230609.5BA04C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005230609.5BA04C433D6@smtp.kernel.org>
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

Hi Stephen,

sorry for the delay.

On 22-10-05, Stephen Boyd wrote:
> Quoting Marco Felsch (2022-10-05 01:23:48)
> > Hi Stephen, Michael,
> > 
> > I know it is a busy time right now, but maybe you have a few minutes for
> > this RFC. I know it is incomplete, but the interessting part is there
> > and it would fix a real issue we encountered on the imx8mm-evk's.
> > 
> 
> There's another approach by Marek[1]. Can you work together on a
> solution? I think we should step away from trying to make the critical
> flag work during clk registration, and turn on the clk during provider
> registration instead. That hopefully makes it simpler. We can keep the
> clk flag of course, so that the clk can't be turned off, but otherwise
> we shouldn't need to make registration path check for the property.

Can you please explain your idea a bit more in detail so I can follow
you. The whole idea of this patchset is to enable a clock and never turn
it off. According the clk-provider.h comment this is the exact use-case
for the CLK_IS_CRITICAL flag. For static clock provider tree's like
soc-clock tree's this can be done by the driver by setting the
CLK_IS_CRITICAL flag within the struct clk_init_data. Now the question
is how I can add such a handling to "dynamic" clock providers which are
added by system-designs e.g. an i2c-clock provider. Of course each I2C
clock provider driver can check the flag but I wanted to make it common
to all.

Regards,
  Marco


> 
> [1] https://lore.kernel.org/all/20220924174517.458657-1-marex@denx.de/
> 
