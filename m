Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306286E14D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDMTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB07AB3;
        Thu, 13 Apr 2023 12:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AED060C92;
        Thu, 13 Apr 2023 19:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB8CC433D2;
        Thu, 13 Apr 2023 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412821;
        bh=oojxmeg84uBgy5mEglQuFVEA6UgalGkZRPBKKPKhBFo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A9ga6TkO9EMOZPFaQ75gllB5vx3pE6c4bPHHnSNDa2fzU+civgoKu5AQoFGHHPlxU
         OBSDwiy82lW4uZq9YTsWeB4jlmVvKxIUVE16FFibdydX2tNTXq51bd52lpA8zhKpYL
         qFOMFzYi4ObKq+4uxPXpBOvQlCp7d+xlFyOTU15EpgX9Y3b2wqQYA+Q+T76T36XFco
         t7zjYQXHMcs0D8T9EbJZmKPJr6032MyAinfTe8Kqp3KC1a1J4KbAEgDIEufSRDZvlP
         2SMQ0PElL1kTdD0Bn8qz6Sxmg8BAgPzEh4a+vs9/N3H5gX+kKn7IVNR7b65n3XdZjR
         a2gbnGqdCpJPA==
Message-ID: <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230413032439.1706448-1-u201911681@hust.edu.cn>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in 'imx8mm_clocks_probe'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Zhou Shide <u201911681@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hao Luo <m202171776@hust.edu.cn>
To:     Abel Vesa <abelvesa@kernel.org>, Bai Ping <ping.bai@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhou Shide <u201911681@hust.edu.cn>
Date:   Thu, 13 Apr 2023 12:06:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Shide (2023-04-12 20:24:39)
> The function imx8mm_clocks_probe() has two main issues:
> - The of_iomap() function may cause a memory leak.
> - Memory allocated for 'clk_hw_data' may not be freed properly
> in some paths.
>=20
> To fix these issues, this commit replaces the use of of_iomap()
> with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
> This ensures that all memory is properly managed and automatically
> freed when the device is removed.
>=20
> In addition, when devm_of_iomap() allocates memory with an error,
> it will first jump to label "unregister_hws" and
> then return PTR_ ERR(base).
>=20
> Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> Signed-off-by: Zhou Shide <u201911681@hust.edu.cn>
> ---
> The issue is discovered by static analysis, and the patch is not tested y=
et.

And you're not coordinating with each other?
