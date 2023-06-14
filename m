Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA77308EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjFNUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjFNUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB4ED;
        Wed, 14 Jun 2023 13:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C69763417;
        Wed, 14 Jun 2023 20:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7260DC433C0;
        Wed, 14 Jun 2023 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686772913;
        bh=Lc/Rqufcz6igZq8RYtflG4DSafdtKCVG2zc6qVTzzyA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hwm2Eb1VAdk+3mcWEaEgruZ15/DaTT6uIfavlckKcuJxZXkDH2lCjkZoC52/juU9c
         dAhYmvqQ7m7OWWFJpMxOILRQkgCXFDAd898Me6JDP1a5pi2WKA5UD9ddNwHmoV1Y7m
         YIzm6Lp1N5M5Noc38PSWJiGFjpdJJ3U2pIgNN/GBzDFQIBekdzoJ8EJ0hj+niZRr7Y
         tFcADITXMY0/0hQowqZaiX02f0tu/hgZKag/kLLJ0UT8k+dPCOFTRcD0LMtV8ULWBl
         NAxFT7pA/vpYwp6+imdajTfcg2+PHSAcRMNd8pw63msD48BMbH2PJCUot4/s4Bo2Mm
         8byb00WXpcchA==
Message-ID: <a84d57dad7b69d0b8bc142b7522d214d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230614012913.122220-3-yang.lee@linux.alibaba.com>
References: <20230614012913.122220-1-yang.lee@linux.alibaba.com> <20230614012913.122220-3-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 3/3] clk: tegra: Fix unsigned comparison with less than zero
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 13:01:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Li (2023-06-13 18:29:13)
> The return value of the round_rate() is long. However, the
> return value is being assigned to an unsigned long variable
> 'rate', so making 'rate' to long.
>=20
> silence the warnings:
> ./drivers/clk/tegra/clk-periph.c:59:5-9: WARNING: Unsigned expression com=
pared with zero: rate < 0
> ./drivers/clk/tegra/clk-super.c:156:5-9: WARNING: Unsigned expression com=
pared with zero: rate < 0
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5519
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/clk/tegra/clk-periph.c | 2 +-
>  drivers/clk/tegra/clk-super.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Instead of this can you implement determine_rate() for div_ops?
