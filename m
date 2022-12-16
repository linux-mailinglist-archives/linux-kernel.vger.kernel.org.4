Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD264F131
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiLPSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLPSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:44:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA1289;
        Fri, 16 Dec 2022 10:44:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383B6621D1;
        Fri, 16 Dec 2022 18:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A426C433D2;
        Fri, 16 Dec 2022 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671216242;
        bh=vXaRsUEz+ZU8atzp08Gu7TMGOkHET3ojPGwll8eK0S0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tGo8OHTV3CB03XAOEEgy1LKM4ohkr0fVmRfCega/FzvnUSuCVoJ+CDhUpjIBdre9c
         bf2gOLmN6g3k085im1FXmhLt7h5Hug/Y5A1mKl3g5SKLWP3tqIP0zBTx1FF6Xmbh0S
         fo5p20JfswWi214OwwDiwMBNRghWmB8gfqQR6u2ryZ5jQbtdjhNULoip0TfaxkoSIG
         66WtsvwamBuCGdO+2WRko2xfwOhUEvL9F0r6QyipLdIgoDYmFXXFsNrnuN03sShRaE
         +np/w+rgP9EpZkwSe0PC7KqaZfK52ywIsiV0Se+dyMYH53jO1xe5YEZ42lULFcelxi
         xnSbomOAZruxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221211204324.169991-2-tmaimon77@gmail.com>
References: <20221211204324.169991-1-tmaimon77@gmail.com> <20221211204324.169991-2-tmaimon77@gmail.com>
Subject: Re: [PATCH v14 1/1] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        benjaminfair@google.com, joel@jms.id.au, mturquette@baylibre.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date:   Fri, 16 Dec 2022 10:44:00 -0800
User-Agent: alot/0.10
Message-Id: <20221216184402.8A426C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-12-11 12:43:24)
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..08ee7bea6f3a
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
[...]
> +#define NPCM8XX_CLK_S_RCP        "rcp"
> +
> +static const u32 pll_mux_table[] =3D { 0, 1, 2, 3 };
> +static const struct clk_parent_data pll_mux_parents[] =3D {
> +       { .fw_name =3D NPCM8XX_CLK_S_PLL0, .name =3D NPCM8XX_CLK_S_PLL0 },

As this is a new driver either you should only have .fw_name here. The
.name field is a backup to migrate code over to a new binding. When
.fw_name is used there should be an associated DT binding update. I
doubt the usage of .fw_name is correct though, because aren't these clks
internal to the controller? The .fw_name field is about describing
parents that are an input to the clk controller node in DT (because the
controller is a consumer of these clks that are external to the device).

So can you use the .hw field for these internal clks? Check out
CLK_HW_INIT_HWS() macro and friends for a possible way to initialize
this.

> +       { .fw_name =3D NPCM8XX_CLK_S_PLL1, .name =3D NPCM8XX_CLK_S_PLL1 },
> +       { .fw_name =3D NPCM8XX_CLK_S_REFCLK, .name =3D NPCM8XX_CLK_S_REFC=
LK },

Maybe this is external? If so, it would be great to have this in the
binding as a `clocks` property.
