Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C645692B21
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBJX0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBJX0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:26:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09161B5;
        Fri, 10 Feb 2023 15:26:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59ED9CE28B9;
        Fri, 10 Feb 2023 23:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B079C433D2;
        Fri, 10 Feb 2023 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071572;
        bh=oPttgO5jXm2lZqDZTv/NVSsliVIw12bDAtzJ2u0WYDU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ccTLGnQyaiWPK7wgM4cpPhG7g5atjTnZ7AyC6BJz5FjxgGN/pioNGiJbVUQDymgKQ
         HRNOS7A/3cv38IIr3LXR2EDx64Ou5zPna9ORWaZu/fabjfH+lPDoavZLNixZgWRlP7
         qEfgbv6qvL4KD0F2MuaiH7sa8R7YOUuK1UI78sU3Appi0NKRlB9byM0UEy4kgv8Y6F
         u65NdHyiB9XGHAkR10SnGfQpUJwS8H9JSkml1zfZzAKCQ01AG2FE4v4VMhuh7tEN12
         sZHWnlRuRFWBsmzONqQVMhw/bIF05Eb0jg/B9hdYM7XT5rn6CJZ6JCvOFqb5Feuzs3
         LVRA9Nv0AbDaQ==
Message-ID: <347b0935e825770ebd7ebc52274708dc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221215165836.2136448-1-arnd@kernel.org>
References: <20221215165836.2136448-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: imx: fix compile testing imxrt1050
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Abel Vesa <abelvesa@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 10 Feb 2023 15:26:10 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2022-12-15 08:58:18)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Randconfig testing revealed multiple issues with this driver:
>=20
> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imxrt1050=
.o
> ERROR: modpost: "imx_clk_hw_pllv3" [drivers/clk/imx/clk-imxrt1050.ko] und=
efined!
> ERROR: modpost: "imx_clk_hw_pfd" [drivers/clk/imx/clk-imxrt1050.ko] undef=
ined!
>=20
> Export the necessary symbols from the core clk driver and add the
> license and author tags. To find this type of problem more easily
> in the future, also enable building on other platforms, as we do for
> the other i.MX clk drivers.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next
