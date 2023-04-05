Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550D6D894E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjDEVJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDEVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EC26B0;
        Wed,  5 Apr 2023 14:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4EB627F6;
        Wed,  5 Apr 2023 21:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86856C4339B;
        Wed,  5 Apr 2023 21:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680728922;
        bh=uNUC5y8+1DWaQ1gzKDswwcu7Qz09JzNjcB+YzkBa764=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aR0q3j20MoLZfEApPuo3lXhkS4XB0DQSdyVHXtqfRs1U6ZPuqzmUfKf/Me4bDTop3
         HySYKLdzTx1dOwnO8BeFKE+0kUWnPqv5Ub8ovkfhcGfH5S1iQ3FDfuh/HmAH7z9m1K
         D4GRJ4XgCD+J2FOULhabup35l8keTFbZEs3nUDyQ40HXo5s2CfLHeDOphf2xD5x/kU
         Gese56SuawrZEH3D6iO/RnMQMNk62qhSpuQ2X9Bh/Dr6pk4QDdOA8mAgBaym/FUwzK
         2kS+9mjOECi8w+Xhc3yC+StDtF/wKuYzpi3l9owXdr6lMnHO+jL0gOrchYsGNtQH8t
         KgtEWLoBvdmlQ==
Message-ID: <75e805c3df18d674f1a9816882db5d9f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230329075104.165176-4-mmyangfl@gmail.com>
References: <20230329075104.165176-1-mmyangfl@gmail.com> <20230329075104.165176-4-mmyangfl@gmail.com>
Subject: Re: [PATCH v2 3/4] clk: hisilicon: Convert to platform driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 05 Apr 2023 14:08:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-29 00:50:52)
> -                                    clk_data);
> -       hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
> -                                      ARRAY_SIZE(hi3620_fixed_factor_clk=
s),
> -                                      clk_data);
> -       hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks=
),
> -                             clk_data);
> -       hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_=
clks),
> -                                 clk_data);
> -       hisi_clk_register_gate_sep(hi3620_separated_gate_clks,
> -                                  ARRAY_SIZE(hi3620_separated_gate_clks),
> -                                  clk_data);
> -}
> -CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
> +static const struct hisi_clocks hi3620_clks =3D {
> +       .nr =3D HI3620_NR_CLKS,

Can this simply be calculated by adding together all the _num members?

> +       .fixed_rate_clks =3D hi3620_fixed_rate_clks,
> +       .fixed_rate_clks_num =3D ARRAY_SIZE(hi3620_fixed_rate_clks),
> +       .fixed_factor_clks =3D hi3620_fixed_factor_clks,
> +       .fixed_factor_clks_num =3D ARRAY_SIZE(hi3620_fixed_factor_clks),
> +       .mux_clks =3D hi3620_mux_clks,
> +       .mux_clks_num =3D ARRAY_SIZE(hi3620_mux_clks),
> +       .divider_clks =3D hi3620_div_clks
