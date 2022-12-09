Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D564897D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLIUVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLIUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:21:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A992319;
        Fri,  9 Dec 2022 12:21:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEC3AB82912;
        Fri,  9 Dec 2022 20:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECA8C433EF;
        Fri,  9 Dec 2022 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670617300;
        bh=xcuiBQzabq84yS4fNajYYh9WazbQ6zYnMdbrlj+GMJE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jPJE4xAUNg93r8z0OrtxZbcpBErVeT95EI0uNsjlmUQvzTAFj7Lnskrk2D56QlaQE
         cu6a6iA8V3h295QgtKEudTxJtK3FET8pesev17VRzQ2DoSfNt39R9MNkBUa8zC3vmN
         w1nRE1h8ISmP53J4vsPPKvqkekq0EaUQR1rKwuPtY8TGb9tAmOku4XK9xG3VJhI6xR
         /RN0f4SapBsX66PN39vPsvzbAfxAtNekR4gAvmpEFJomNRrxp70XUcnGEWsKOzrS0s
         9V3Pv08PPmVRNJfdQJtWa3c7FNjV2tw9HJEYqtgcQlj/54SnqR9HCX+YvacLHSCGWS
         XT876BoAuVfWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221104161850.2889894-6-j.neuschaefer@gmx.net>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net> <20221104161850.2889894-6-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v5 5/6] clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Fri, 09 Dec 2022 12:21:38 -0800
User-Agent: alot/0.10
Message-Id: <20221209202140.4ECA8C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-11-04 09:18:49)
> This driver implements the following features w.r.t. the clock and reset
> controller in the WPCM450 SoC:
>=20
> - It calculates the rates for all clocks managed by the clock controller
> - It leaves the clock tree mostly unchanged, except that it enables/
>   disables clock gates based on usage.
> - It exposes the reset lines managed by the controller using the
>   Generic Reset Controller subsystem
>=20
> NOTE: If the driver and the corresponding devicetree node are present,
>       the driver will disable "unused" clocks. This is problem until
>       the clock relations are properly declared in the devicetree (in a
>       later patch). Until then, the clk_ignore_unused kernel parameter
>       can be used as a workaround.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
