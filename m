Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163486820D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjAaAil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjAaAik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:38:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533B1F5FB;
        Mon, 30 Jan 2023 16:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0108161358;
        Tue, 31 Jan 2023 00:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFB2C433EF;
        Tue, 31 Jan 2023 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675125518;
        bh=KQ/jlA4qGwu/+ocBuikUEZAfj7MktGpHG+XmBQXFyco=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aAsjPIGH864XiwqbnnKzoXOeByYareroKqLejbu7xmoMNOm+DfVeGmSpjuRF6ui3e
         YpWMzPhydFmqGzl+UMIfhtDME7FV29ZfkfLqh9S7Tid/4rZXk8wIbb6TJD7cxdw18v
         dRpYhCDve0R0kkPduA4UK55gT7apXeR4tjFGw6C8p0ANcXZKI1O7JKEFTMn62eWTrC
         g1Mtn0RYYdXJCff1bSCdabJHnp3GxMb3D8BBYJ/os7Q/VcWe0PX2qTDnsDHrWu1r6Q
         Hrm3tZeCvW32Zg/bhZNZT7yxkyx++DHT9ltMi7mba38M1nbUesEXPwJstIiDe1CnUd
         fVy+9jNbpaQGA==
Message-ID: <26437c6f0bda4dd18e16fa1f58013911.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230120024445.244345-7-xingyu.wu@starfivetech.com>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com> <20230120024445.244345-7-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 06/11] clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 30 Jan 2023 16:38:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-01-19 18:44:40)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk=
/starfive/clk-starfive-jh7110-isp.c
> new file mode 100644
> index 000000000000..f9fc94b4c6f8
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 Image-Signal-Process Clock Driver
[...]
> +
> +static int jh7110_isp_top_crg_enable(struct isp_top_crg *top)
> +{
> +       int ret;
> +
> +       ret =3D clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
> +       if (ret)
> +               return ret;
> +
> +       return reset_control_deassert(top->top_rsts);
> +}

This needs to be undone on driver remove.
