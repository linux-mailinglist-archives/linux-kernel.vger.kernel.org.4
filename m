Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE1692B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBJXZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBJXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:25:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5E1F4A1;
        Fri, 10 Feb 2023 15:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D88461ECC;
        Fri, 10 Feb 2023 23:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB2C433EF;
        Fri, 10 Feb 2023 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071496;
        bh=pY/6dp0qgOqHjnt0x5AtFF4eHqafITwwbuPlyj1PCEM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eGqnzLgGu/0OmFkFyM2Gms/HqzzYxQwEPdC9U+u4l5Ne5+M8wXBsCtrT+dgnMxFfS
         bg8E/4pqmYKC180pXyO0KwUIpu7mukf/Y4Girt65V/t+fSY0riyd+DJQrOvE6wFLkT
         YUrBjoxrW8O+GS077SJhqQ/VBUjSgDGLzyJMZD2FpOMK1oxsW7RsywGweslJ0ChyqX
         CF2+20omGvZs/92WUnJlKG8LyHRN374U942yHJtD0kamqy7MED9sFS7JY2zejhC31u
         UYdY3s+iL0O0MARCrbWzRJk61hsfg9wOQhRChr2SgIWYrZCDrc/Hi4grS0bwCdv2ky
         CtAjKtZi2afzw==
Message-ID: <21e4cb835f678faa911ef97d28931246.sboyd@kernel.org>
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
Date:   Fri, 10 Feb 2023 15:24:54 -0800
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

Can the field be negative?

> a s16 cast to the register value fixes the issue.
>=20
> Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
