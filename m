Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007516106A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiJ1AJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1AJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6082636;
        Thu, 27 Oct 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97C2760C24;
        Fri, 28 Oct 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590AC4347C;
        Fri, 28 Oct 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666915754;
        bh=Ay6w2dp9c6eNZbxxdqmdKJCVxnfP4v5thLJwKh9qOQs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gyCRZfoR9c29g2rZeOSqQj5EnAfIwFhPikNR2jnWSfsbi7QXiALhHGntbc/v831Bd
         1psNmYsHkJnyXM2SzMEvptjxhuO5lLiZ2LpfKpOhKIzntilbx9nxT34N28NcCIjg1c
         uFXlrthkkamHyH2LC86C4eV7B6Sy0QHBEox2jzNmzJ93yrxUPmJ1WJHO+4c62gVMlL
         K7qx0S4OUGvysfRcDx2L9FaJJTZBmZiqNwICpBjRWnFvCAQ7DO1oHnBh/XYCYnGNBj
         955Mu054cnCaCrv/B+f3xrcJKNeVMT4KSOfSuKjyr7+vnSnFgemX1KXemm499MsC/j
         bO/lSz4burAXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018-clk-range-checks-fixes-v1-2-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech> <20221018-clk-range-checks-fixes-v1-2-f3ef80518140@cerno.tech>
Subject: Re: [PATCH 2/4] clk: Initialize the clk_rate_request even if clk_core is NULL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 27 Oct 2022 17:09:11 -0700
User-Agent: alot/0.10
Message-Id: <20221028000913.E590AC4347C@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-18 06:52:57)
> Since commit c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()"),
> users that used to initialize their clk_rate_request by initializing
> their local structure now rely on clk_hw_init_rate_request().
>=20
> This function is backed by clk_core_init_rate_req(), which will skip the
> initialization if either the pointer to struct clk_core or to struct
> clk_rate_request are NULL.
>=20
> However, the core->parent pointer might be NULL because the clock is
> orphan, and we will thus end up with our local struct clk_rate_request
> left untouched.
>=20
> And since clk_hw_init_rate_request() doesn't return an error, we will
> then call a determine_rate variant with that unitialized structure.
>=20
> In order to avoid this, let's clear our clk_rate_request if the pointer
> to it is valid but the pointer to struct clk_core isn't.
>=20
> Fixes: c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-fixes
