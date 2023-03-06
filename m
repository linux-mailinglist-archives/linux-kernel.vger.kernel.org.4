Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C316ACDA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCFTOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFTOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403FA5F6;
        Mon,  6 Mar 2023 11:14:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46C0861083;
        Mon,  6 Mar 2023 19:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C55C433D2;
        Mon,  6 Mar 2023 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678130083;
        bh=F9tNbM7t9Vpm0Rv/1V+KNmg6eSO1TudR1o7MzfIZ02E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RdRvJa4STP0SwyOHFUZhxCjebUQmMwak5Xr8mkWzE8Iks9FQMGMbzeQde9hueRspR
         6Mi37iYAxCDZiYiNr4/X9h3/0GLQAZktNxN1doPXdjbmaIH6RCdepqW/x23BgtV/tY
         sYacQbOhFP6LsMg44pZasCqgyZHJNKq2lG9vlfudpO9aPCAjJcyB6vq3WLa4rhcHmd
         BwcESKVQZhoFPu2jGzRTzcXiF7jC9XQeeuISJnIvTPhbmG6nD8ZIDcvY7MYsfOO/Bk
         yZc6ZILubeBk6ejMG2OMC3UTSoUV/NK30FgiqTJ1AUUg9LQnAbN5kuC7bQMtzpL905
         G34s6VXYSa+fg==
Message-ID: <7e28fb6ea6c1f646b02cd166c9782539.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230302014639.297514-1-saravanak@google.com>
References: <20230302014639.297514-1-saravanak@google.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Date:   Mon, 06 Mar 2023 11:14:41 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2023-03-01 17:46:38)
> We already mark fwnodes as initialized when they are registered as clock
> providers. We do this so that fw_devlink can tell when a clock driver
> doesn't use the driver core framework to probe/initialize its device.
> This ensures fw_devlink doesn't block the consumers of such a clock
> provider indefinitely.
>=20
> However, some users of CLK_OF_DECLARE() macros don't use the same node
> that matches the macro as the node for the clock provider, but they
> initialize the entire node. To cover these cases, also mark the nodes
> that match the macros as initialized when the init callback function is
> called.
>=20
> An example of this is "stericsson,u8500-clks" that's handled using
> CLK_OF_DECLARE() and looks something like this:
>=20
> clocks {
>         compatible =3D "stericsson,u8500-clks";
>=20
>         prcmu_clk: prcmu-clock {
>                 #clock-cells =3D <1>;
>         };
>=20
>         prcc_pclk: prcc-periph-clock {
>                 #clock-cells =3D <2>;
>         };
>=20
>         prcc_kclk: prcc-kernel-clock {
>                 #clock-cells =3D <2>;
>         };
>=20
>         prcc_reset: prcc-reset-controller {
>                 #reset-cells =3D <2>;
>         };
>         ...
>         ...
> };
>=20
> This patch makes sure that "clocks" is marked as initialized so that
> fw_devlink knows that all nodes under it have been initialized.
>=20
> If the driver creates struct devices for some of the subnodes,
> fw_devlink is smart enough to know to wait for those devices to probe.
> So, no special handling is required for those cases.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=3DD3rkHp17f5pwGdB=
VhzFU90-0MHY6dQ@mail.gmail.com/
> Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Applied to clk-fixes
