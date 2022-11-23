Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988D634D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiKWBml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:42:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D465BB;
        Tue, 22 Nov 2022 17:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87215619BD;
        Wed, 23 Nov 2022 01:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88DCC433D6;
        Wed, 23 Nov 2022 01:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669167753;
        bh=psYNxc4PghRst/FBPVLKrfzinaBNDKn/Y65S38AJvTU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nye0C47nSa904YcLrD9Cmy+qsD2QDU7PCEBgpclF5Cg1TVVurysadT6XtND808N+f
         8bT5v6RPoPC+mPul7e73g1oLP63lVkv3Lot/4lOlr7shXOsqlua6xRHXEvMMce4bRo
         5TZNENDDWrGjhSPVOB/W5A9ArV/LKpqsyfdy6+a14U+WftambRuR1b1nttFwOrFk5q
         Hy8JpCazikUqtJ3CKsmtyv4oZgMAB8AKlt32J2Hnjw3+NLuArA/hYmNnC/ocE+q9D8
         saMi8t7We6SxYOe9es871wBq2I5gxsRjnrEVwBaSSuYfiQ6ao1KVu5dUvwle+czK9I
         ksEJcX/DTh2mA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97c249fd-21c5-acc2-6195-bf0aed5bee8f@rasmusvillemoes.dk>
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk> <Y3ucncQOBNHpZaxn@linaro.org> <97c249fd-21c5-acc2-6195-bf0aed5bee8f@rasmusvillemoes.dk>
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Abel Vesa <abel.vesa@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Tue, 22 Nov 2022 17:42:31 -0800
User-Agent: alot/0.10
Message-Id: <20221123014233.D88DCC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2022-11-21 23:49:50)
> On 21/11/2022 16.43, Abel Vesa wrote:
> > On 22-09-28 14:41:08, Rasmus Villemoes wrote:
> >> We have an imx8mp-based board with an external gpio-triggered
> >> watchdog. Currently, we don't get to handle that in time before it
> >> resets the board.
> >>
> >> The probe of the watchdog device gets deferred because the SOC's GPIO
> >> controller is not yet ready, and the probe of that in turn gets deferr=
ed
> >> because its clock provider (namely, this driver) is not yet
> >> ready. Altogether, the watchdog does not get handled until the late
> >> initcall deferred_probe_initcall has made sure all leftover devices
> >> have been probed, and that's way too late.
> >>
> >> Aside from being necessary for our board, this also reduces total boot
> >> time because fewer device probes get deferred.
> >>
> >=20
> > I'm gonna be honest here. I can't say I'm happy with this.
> > I would suggest finding a solution to disable the external watchdog
> > before booting the kernel, up until the driver probes, would be prefera=
ble
> > to me.
>=20
> That's not an option (it would violate the very purpose of having an
> external always-running watchdog), and also simply not possible on the
> given hardware.
>=20
> I don't understand why this simple patch can't just be applied. It hurts
> nothing, it makes all imx8mp boards boot very slightly faster, there's
> no maintenance burden associated with the boilerplate code,

There is a maintenance burden. Moving the initcall around is papering
over the problem by not clearly describing the requirement to probe the
watchdog driver as soon as possible. I don't expect to remember years
from now that the watchdog driver needed this driver and the pinctrl
driver to avoid probe defer, otherwise the watchdog will bite because it
probes too late.

The problem is not being solved directly. That's why we're concerned.
Maybe if the problem statement was "don't allow probe defer", and that
was worked into the driver core so drivers can be marked as "panic when
this driver probe defers" then it would be more obvious what sort of
behavior we don't want.

Or to go further, maybe this board compatible needs to probe a board
driver that only adds the clk, pinctrl, and watchdog devices as a first
pass with a comment that these devices need to be probed as soon as
possible to avoid watchdog bites on that board. Then once those devices
are probed it can add the rest of the devices.

> it allows
> hardware that already exists to actually work with a mainline kernel
> out-of-the-box. And in an alternate universe where the init function had
> been arch_initcall in the initial commit (such as those in
> drivers/clk/mediatek/), nobody would have asked any questions.
>=20

The usage of arch_initcall() and core_initcall() should be fixed.
