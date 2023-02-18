Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3184469B830
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBRFic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:38:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D33A08F;
        Fri, 17 Feb 2023 21:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 532A2CE22F6;
        Sat, 18 Feb 2023 05:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FA4C433D2;
        Sat, 18 Feb 2023 05:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676698705;
        bh=Oxt0iejN3V58EN6vZUzQan+IRypPIMXTdgAy3ihC6GM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L5dXVgrxLN/6Mm7rXvR8j0Ohg78CnHdjr05fWcd4Pa5PrYWpEtLV9DLBaExA097rG
         ojJjwfySDiu0HNDC0vmbB8MXJ4nqoVKXs3SGGvAQSO3Vz2t7uCoEsYW1iN4c5T1DeC
         i30flI/QOsOI0l2n98lzCJ32/nEFdDoj3BNaqMv9La0HSJyfKRFP3d7GLzDECka+0G
         T/+IcPd/+vNM1KMgtJ/TxVN6maIvdD3BXHOtA3rY/1bqWzjZLowiD3lXElcFTe40ND
         ORBVWA3mDyiOz/E8u1p8YQpurVdwNEpoyzJbU1HgUoYDhzJtz1pXSpnsnl6Xlr9xEe
         vdXvQtkSazBiA==
Message-ID: <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221227204528.1899863-1-abel.vesa@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling unused clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Fri, 17 Feb 2023 21:38:22 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-12-27 12:45:27)
> There are unused clocks that need to remain untouched by clk_disable_unus=
ed,
> and most likely could be disabled later on sync_state. So provide a gener=
ic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> skip disabling its clocks.

How does that avoid disabling clks randomly in the clk tree? I'm
concerned about disabling an unused clk in the middle of the tree
because it doesn't have a driver using sync state, while the clk is the
parent of an unused clk that is backed by sync state.

   clk A -->  clk B=20

clk A: No sync state
clk B: sync state

clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
from late init. Imagine clk A is the root of the tree.

	clk_disable_unused_subtree(clk_core A)
	  clk_disable_unused_subtree(clk_core B)
	    if (from_sync_state && core->dev !=3D dev)
	      return;
	  ...
	  clk core A->ops->disable()

clk core B is off now?

Also sync_state seems broken right now. I saw mka mentioned that if you
have a device node enabled in your DT but never enable a driver for it
in the kernel we'll never get sync_state called. This is another
problem, but it concerns me that sync_state would make the unused clk
disabling happen at some random time or not at all.

Can the problem be approached more directly? If this is about fixing
continuous splash screen, then I wonder why we can't list out the clks
that we know are enabled by the bootloader in some new DT binding, e.g.:

	clock-controller {
		#clock-cells =3D <1>;
		boot-handoff-clocks =3D <&consumer_device "clock cells for this clk provi=
der">;
	};

Then mark those as "critical/don't turn off" all the way up the clk tree
when the clk driver probes by essentially incrementing the
prepare/enable count but not actually touching the hardware, and when
the clks are acquired by clk_get() for that device that's using them
from boot we make the first clk_prepare_enable() do nothing and not
increment the count at all. We can probably stick some flag into the
'struct clk' for this when we create the handle in clk_get() so that the
prepare and enable functions can special case and skip over.

The sync_state hook operates on a driver level, which is too large when
you consider that a single clk driver may register hundreds of clks that
are not related. We want to target a solution at the clk level so that
any damage from keeping on all the clks provided by the controller is
limited to just the drivers that aren't probed and ready to handle their
clks. If sync_state could be called whenever a clk consumer consumes a
clk it may work? Technically we already have that by the clk_hw_provider
function but there isn't enough information being passed there, like the
getting device.

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 842e72a5348f..cf1adfeaf257 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device =
*dev, const char *name,
>                 void __iomem *reg, u8 shift, u8 width,
>                 u8 clk_divider_flags, const struct clk_div_table *table,
>                 spinlock_t *lock);
> +void clk_sync_state_disable_unused(struct device *dev);

This is a weird place to put this. Why not in the helper functions
section?

>  /**
>   * clk_register_divider - register a divider clock with the clock framew=
ork
>   * @dev: device registering this clock
