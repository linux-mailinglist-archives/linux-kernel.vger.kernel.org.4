Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0772D371
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbjFLVjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjFLVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64CAA;
        Mon, 12 Jun 2023 14:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDF1622CA;
        Mon, 12 Jun 2023 21:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC549C433D2;
        Mon, 12 Jun 2023 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605943;
        bh=pW+2HhRl8G0UCJqWx3NwfAzoCRzjUOFPNkG02u9jq5Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tlc1PrpAu9wjqw8Fkzfc+oS2N8lHAgOIwryOA4WMifO5dLmJ3nY061GaDnoBt6wfP
         LeplpF+cbcICriSYrXTgM0o68hNlZ/lekCbzHsND6G+TGzHyDgOdBb3C29d6dWm/sW
         AzTaUoNwg7kNC5aXZi1BLJbVpbhB1YUUKNuKoITSXUWFS3aVF1hdW6Vhtjo7sFzP2o
         dsM95/IBA7W28ctT1tIZHKqAW9yfo8HqisbRzqh8HB/MYTKVfhVOcnu/ZiDzVSs5me
         Sy+BJ1aBv7YfvcWMGxuQCR9Fdlxc7nb8JUYpDJUQd54ksw6fUFRVHBnolKSNd/onf1
         gZ3VRiWW0DZAg==
Message-ID: <69a0b07442116b52e359534d93433f55.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230529133433.56215-1-frank@oltmanns.dev>
References: <20230529133433.56215-1-frank@oltmanns.dev>
Subject: Re: [PATCH] clk: fractional-divider: Improve approximation when zero based
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Frank Oltmanns <frank@oltmanns.dev>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 12 Jun 2023 14:39:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Frank Oltmanns (2023-05-29 06:34:33)
> Consider the CLK_FRAC_DIVIDER_ZERO_BASED flag when finding the best
> approximation for m and n. By doing so, increase the range of valid
> values for the numerator and denominator by 1.
>=20
> Cc: A.s. Dong <aisheng.dong@nxp.com
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
> I stumpled upon this, when familiarizing myself with clk drivers. Unfortu=
nately,
> I have no boards to test this patch. It seems the only user of this flag =
in
> mainline is drivers/clk/imx/clk-composite-7ulp.c, therefore I'm cc-ing
> get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
> in the hopes of a wider audience.
>=20
> Thank you for considering this contribution,

Thanks for looking at this. Can you add a kunit test (or a suite of
tests) to confirm that this doesn't break existing functionality and
also improves a case that would have failed or been suboptimal before?
