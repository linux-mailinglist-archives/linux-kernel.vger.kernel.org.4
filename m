Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170EE69B78C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBRBoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRBoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:44:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E16A06C;
        Fri, 17 Feb 2023 17:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ABB4B82D75;
        Sat, 18 Feb 2023 01:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158C3C433D2;
        Sat, 18 Feb 2023 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676684647;
        bh=8H3snZZWJSuvzo/06BSbGSgZEp2t4oYg6IRm6Obv9sE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AJdbqjAUjUVXrksYdPhkw0xnBzQqdWs7abpZ9z726Q02ndMtP7uxgu/6J+oC4tGCi
         O6/1/zK2BQm74BduwI3xo6c79QEW9ePX97nxFDV8XOzrvadnEoAsJYSDiup5VKiP9N
         xo0aQ8e2C76JxcnxFybqCecbuQGpWlHcFD30fRbIPV/3UwimY1ijaAM8dHGu268r+1
         ybWHgSSxG6Zovc28iNdPlD7gIhqglMAD8NXuukqz85WSp96VXaGuTzQChj3bAzQ7aJ
         Lw3nHR7lNF9p+moesgNAER7L1k8/5y16Yecqnk2FFM5ukzgjNxCan6GTQSiy5Ul+kT
         RbScxCzSB8ixA==
Message-ID: <25835181be099ba9b101d185eb5563d1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
References: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
Subject: Re: [PATCH] clk: imx: pll14xx: fix recalc_rate for negative kdiv
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Feb 2023 17:44:04 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kevin Groeneveld (2022-12-10 12:38:35)
> kdiv is a signed 16 bit value in the DEV_CTL1 register. Commit
> 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation") changed
> the kdiv variable from a short int to just int. When the value read from
> the DIV_CTL1 register is assigned directly to an int the sign of the value
> is lost resulting in incorrect results when the value is negative. Adding
> a s16 cast to the register value fixes the issue.
>=20
> Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
> ---

Applied to clk-fixes
