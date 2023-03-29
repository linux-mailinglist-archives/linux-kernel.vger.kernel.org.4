Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934F6CF558
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC2V1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA529FB;
        Wed, 29 Mar 2023 14:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49EB361E1A;
        Wed, 29 Mar 2023 21:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959CEC4339B;
        Wed, 29 Mar 2023 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680125230;
        bh=AS0hMPzODy4Xc1L29bhWgg84MiUUzESVyfIE6SFTowE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HByzCpkd+4vCITgt+uRrRp8rFQqgl4QLr74RtztpdlJXSIXL90mhxK5ZUgC+W5QVo
         GCQcOXgWNihEYMQuQYFdsbWJRMGxIR2/JS2q4fm9I8R8zyoqdAtTyy8OpXLpIJ9UU4
         gNsCi4N0mM/KKLyLLo0lVb/TEm9QO3VfPJ1CFmdwIM7HwCLaZAglZ9EU3UBcMePND7
         WAiRIddD0YoYDodbhjwH7uPRXmjdss2HkzIjJoFyDhsKrigKxchMltrCgNf69ZEfZX
         ss+jmE3cwyhkySqpd4uei37AXKtgenN66eZJJ+T5UiUFBisZwcAbZQgjsbSvPhlIMv
         VEwDhc+n11bnQ==
Message-ID: <2f4967f2a079e23b2b8a6013012c66e0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de> <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org> <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
Subject: Re: [PATCH v4] clk: expand clk_ignore_unused mechanism to keep only a few clks on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-doc@vger.kernel.org
To:     Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date:   Wed, 29 Mar 2023 14:27:08 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-29 13:46:32)
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index c3c3f8c07258..356119a7e5fe 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > [...]
> > > @@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_subtree=
(struct clk_core *core)
> > >          * back to .disable
> > >          */
> > >         if (clk_core_is_enabled(core)) {
> > > -               trace_clk_disable(core);
> > > -               if (core->ops->disable_unused)
> > > -                       core->ops->disable_unused(core->hw);
> > > -               else if (core->ops->disable)
> > > -                       core->ops->disable(core->hw);
> > > -               trace_clk_disable_complete(core);
> > > +               if (clk_unused_keep_on) {
> > > +                       pr_warn("Keep unused clk \"%s\" on\n", core->=
name);
> > > +                       clk_unused_keep_on -=3D 1;
> > > +               } else {
> > > +                       trace_clk_disable(core);
> >=20
> > We have trace_clk_disable() here. Can you have this tracepoint print to
> > the kernel log and watch over serial console? That would be faster than
> > bisecting.
>=20
> Well no, that doesn't work for all the problems where
> clk_ignore_unused=3D7 could be useful. Consider that e.g. you know that
> eth0 is broken, but with clk_ignore_unused is works. So one of the (say)
> 25 nominally unused clks are required for eth0. But it's not possible to
> test the network after each of the 25 clk_disable()s. Unless I'm missing
> something and you can hook a userspace action on a trace line?!

In that case it sounds like you want to compile the kernel with the
support for enabling clks from debugfs. Can you use that?
