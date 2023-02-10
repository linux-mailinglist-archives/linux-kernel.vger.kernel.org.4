Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860C692A82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjBJWtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjBJWtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:49:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DA32CDE;
        Fri, 10 Feb 2023 14:49:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1192BB825E3;
        Fri, 10 Feb 2023 22:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E317C433D2;
        Fri, 10 Feb 2023 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676069358;
        bh=SaVWEZqi6FK5RZrvwlP3inTyWF9/jTYSLZIuA+RQlOY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Fjsc41PSUvuYhRh/p0FRD7O8YG83EbFsky6WgGPSPQj4me6aOpo/Fu5UKT0XpT5OH
         BsJp9v8VLp64Nm6UIcXN+q8KNJNkwLpz6ikFjQqEQoT7fKL2d7aPBB9plkgu4PhYhg
         EjW/bDmSSV5ALnQMklISKwzbg/PtN6IBGHXD+v9xkjCKkqfoI+R43SMw4qAonK55gT
         eilyYyzi/i10qxnuwqrRzTACU0gZuVzCxpd6XFxPGTAAmY8E55PFcV5bFXrMpkLuxl
         3O+lMjm8g83o0N9gcRJfHmiTOmtkaTUCFmN8vb1+MTNm8RPpB/obE2Shu9z7dRN8mV
         wmwjutvgTLw7w==
Message-ID: <83a3c8d0abf217369f045df0217b1f64.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOf5uwkMRSc7q1xUv4D=hc4w0HL=+x1_J60yyru_hGSuf5m0bA@mail.gmail.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com> <1fc8686b0b66c3b3ff80c044ecf1add6.sboyd@kernel.org> <CAOf5uwkMRSc7q1xUv4D=hc4w0HL=+x1_J60yyru_hGSuf5m0bA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] clk: imx8mn: setup clocks from the device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, angelo@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 10 Feb 2023 14:49:16 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Nazzareno Trimarchi (2023-01-26 02:49:54)
> Hi
>=20
> On Wed, Jan 25, 2023 at 10:11 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Dario Binacchi (2023-01-01 09:57:29)
> > > The idea for this series was born back from Dublin (ELCE 2022) after
> > > having attended the talk entitled "Updating and Modernizing Clock
> > > Drivers" held by Chen-Yu Tsai and the availability of a board with
> > > imx8mn SOC.
> >
> > Interesting. I didn't see any mention of putting clks into DT in that
> > presentation.
> >
> > >
> > > This series aims to setup all imx8mn's clocks from the device tree and
> > > remove the legacy setup code with hardwired parameters.
> >
> > Please, no! We don't want one node per clk style of bindings.
>=20
> I think the idea behind is:
> - create a way from silicon vendor to export their clock mapping with
> automatic exportation

I suspect silicon vendors automatically generate their clk drivers
today.

> - reduce the copy and paste code across the drivers
> - avoid code duplication

Code duplication should be avoided. Surely the clk_ops is shared? Data
duplication is the real problem here. The status quo has been to have
data descriptions of clks in drivers so that drivers can turn them on.
If we're trying to avoid bloat then we only enable the drivers that we
care about, or make them modular so they don't waste kernel memory.

If you have ideas on how to avoid duplication there then by all means
implement them. Don't move the data duplication problem to devicetree
though.

I've been wondering if we can tag drivers that are compiled into the
kernel as freeable if they aren't ever going to probe because they're
for some SoC that isn't present. That would allow us to shed various
builtin clk drivers on systems instead of forcing us to make everything
a module.

>=20
> Is the binding a way to solve this problem?

Don't think so.

> If you don't want one node
> per clk style bindings, did you still think that the way
> to go is totally wrong?

Yes.
