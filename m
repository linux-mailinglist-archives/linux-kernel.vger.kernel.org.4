Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE65F14B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiI3VZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiI3VY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7637404;
        Fri, 30 Sep 2022 14:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5BB62509;
        Fri, 30 Sep 2022 21:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D2C433D6;
        Fri, 30 Sep 2022 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573095;
        bh=+joHcILUm5LRJ+jhjvcI4kVtQWiLKRRqNLNft8g5IJ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EW3JZzrMpq9bM7gQlB/PrUVLyoXFuDqmTgxyGMhA5jvd3A6kDSSBkU1cnQWite5zD
         zoHl/UG8JW5TxQYVwbbgvIhEugbvwfeqGbH9gKP4+nwK9YtV/YpXCyU0WfTiAehMvA
         +abPueK0es0bLAcgjm7mlYN0TtL2EHfkRJ3Udid0UuicelNvhcJclfx0pGjJ6wueCu
         /SF6E5ZV8AIRDLeERXbXtWEHLhTDd7dKpz74W8qD2bxGtp+hKm/FC5hZTWirLgdjD8
         vklYD2m5tBdBYf7KJE6HkUmT5U43ScklLgOEm8gPFYhv6so9xYV0a4Xnonc4O4mgXB
         4tONV3LYh0I2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929225402.9696-2-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru> <20220929225402.9696-2-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v12 1/8] clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Fri, 30 Sep 2022 14:24:52 -0700
User-Agent: alot/0.10
Message-Id: <20220930212455.3D9D2C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2022-09-29 15:53:55)
> We have discovered random glitches during the system boot up procedure.
> The problem investigation led us to the weird outcomes: when none of the
> Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
> glitches disappeared. It was a mystery since the SoC external clock
> domains were fed with different 5P49V6901 outputs. The driver code didn't
> seem like bogus either. We almost despaired to find out a root cause when
> the solution has been found for a more modern revision of the chip. It
> turned out the 5P49V6901 clock generator stopped its output for a short
> period of time during the VC5_OUT_DIV_CONTROL register writing. The same
> problem was found for the 5P49V6965 revision of the chip and was
> successfully fixed in commit fc336ae622df ("clk: vc5: fix output disabling
> when enabling a FOD") by enabling the "bypass_sync" flag hidden inside
> "Unused Factory Reserved Register". Even though the 5P49V6901 registers
> description and programming guide doesn't provide any intel regarding that
> flag, setting it up anyway in the officially unused register completely
> eliminated the denoted glitches. Thus let's activate the functionality
> submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
> enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove the
> ports implicit inter-dependency.
>=20
> Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> ---

Applied to clk-next
