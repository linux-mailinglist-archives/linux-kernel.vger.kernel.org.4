Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771C360D911
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 04:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiJZCIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 22:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 22:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40498B14EB;
        Tue, 25 Oct 2022 19:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE7361BE6;
        Wed, 26 Oct 2022 02:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC8C433C1;
        Wed, 26 Oct 2022 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666750080;
        bh=0C3A6REuaewLmHH5E6YwXG5jrIKOyFuUNR9RkKLw9IU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m9iKShnnwhLbiPWx2w7g9PXODebLnovzuRsSnzNbL/zeRqf+w7wnuHt2WyvYtn1Ny
         jsk2o2p09U/rdliEzdXGsAYf7egrCekTiul4MpC1J0mDdofpADju2pq33wVF8OPazh
         QLIJqfJ0XAOWukihNpEXbN4NrVIsR1c30WnOn5bxep8Iva0PqmaicHnvZgLKZd5URZ
         xhCrYh+vXDr9m/bde6lsmSLldE5ydZ5+5eBKTHAJGSf9oc6hyk2a97OYCcM21exWQ0
         +ZeUKJT3wfIPOC0cGtMxtIgF6HstIcSllG+cOZylmLOuW1IBirSiQEIp+irIoNzwGy
         e164CJ/ynBOPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech> <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 25 Oct 2022 19:07:58 -0700
User-Agent: alot/0.10
Message-Id: <20221026020800.38AC8C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-18 06:52:59)
> The determine_rate hook allows to select the proper parent and its rate
> for a given clock configuration. On another hand, set_parent is there to
> change the parent of a mux.
>=20
> Some clocks provide a set_parent hook but don't implement
> determine_rate. In such a case, set_parent is pretty much useless since
> the clock framework will always assume the current parent is to be used,
> and we will thus never change it.
>=20
> This situation can be solved in two ways:
>   - either we don't need to change the parent, and we thus shouldn't
>     implement set_parent;
>   - or we don't want to change the parent, in this case we should set
>     CLK_SET_RATE_NO_REPARENT;
>   - or we're missing a determine_rate implementation.
>=20
> The latter is probably just an oversight from the driver's author, and
> we should thus raise their awareness about the fact that the current
> state of the driver is confusing.

There is another case which is a leaf clk that is a mux where you only
expect clk_set_parent() to be used, and not clk_set_rate(). This use
case is odd though, so I'm not sure how much we care.

>=20
> It's not clear at this point how many drivers are affected though, so
> let's make it a warning instead of an error for now.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/clk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 57b83665e5c3..11c41d987ff4 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3700,6 +3700,11 @@ static int __clk_core_init(struct clk_core *core)
>                 goto out;
>         }
> =20
> +       /* TODO: Promote to an error */

The documentation should be updated in this patch (see the table of
hardware characteristics in Documentation/driver-api/clk.rst).

> +       if (core->ops->set_parent && !core->ops->determine_rate)
> +               pr_warn("%s: %s must implement .set_parent & .determine_r=
ate\n",

You can grep for it:

 $ git grep -W 'struct clk_ops .*=3D'

but I'm fairly certain a coccinelle script can detect most of these
because clk_ops are usually statically defined (although not always).

Either way I already see that 'owl_comp_div_ops' will trigger this
warning. And 'at91sam9x5_smd_ops' looks even more likely. Given that I'm
not super keen on applying this patch.
