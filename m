Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF2643FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiLFJ0C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiLFJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:25:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB1DF77
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:25:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2UCh-000107-DT; Tue, 06 Dec 2022 10:25:31 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2UCe-002fDd-8C; Tue, 06 Dec 2022 10:25:29 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2UCe-0002Fh-EA; Tue, 06 Dec 2022 10:25:28 +0100
Message-ID: <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon
 devices
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Tue, 06 Dec 2022 10:25:28 +0100
In-Reply-To: <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
         <20221206073916.1606125-3-jk@codeconstruct.com.au>
         <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2022-12-06 at 09:41 +0100, Arnd Bergmann wrote:
> On Tue, Dec 6, 2022, at 08:39, Jeremy Kerr wrote:
> > Simple syscon devices may require deassertion of a reset signal in order
> > to access their register set. Rather than requiring a custom driver to
> > implement this, we can use the generic "resets" specifiers to link a
> > reset line to the syscon.
> > 
> > This change adds an optional reset line to the syscon device
> > description, and code to perform the deassertion/assertion on
> > probe/remove.
> > 
> > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> I see that this will only work after the device has been registered,
> but not for early users of the syscon framework that bypass the
> device logic and just call device_node_to_regmap() or 
> syscon_regmap_lookup*() during early boot.
> 
> It should be possible to solve this by adding the reset logic
> into the of_syscon_register() function and using the
> of_reset_control_get*() helpers instead of the devm_* ones,
> but I'm not sure if that causes other problems with probe
> order, or if that helps at all, if reset drivers already
> require the device subsystem to be running.
> 
> Philipp, what is the earliest point at which
> reset_controller_register() can be called? Is that
> possible before postcore_initcall() or driver_register()?

reset_controller_register() only initializes a few fields in the passed
rcdev structure and adds it to a static list under a static mutex, so
there's not much of a limit.

However, reset controllers that choose to register early without
creating a platform device may run into issues with devlink inhibiting
reset consumers' probe [1].

[1] a1467faa1041 ("ARM: imx: register reset controller from a platform driver")
    https://lore.kernel.org/linux-arm-kernel/20211005100618.730907-1-p.zabel@pengutronix.de/

regards
Philipp
