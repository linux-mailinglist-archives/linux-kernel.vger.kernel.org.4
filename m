Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6DA5EEA91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiI2Aah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI2Aae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:30:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D74264BC;
        Wed, 28 Sep 2022 17:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D11DB80D8E;
        Thu, 29 Sep 2022 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61AC433D6;
        Thu, 29 Sep 2022 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664411430;
        bh=eUy48D9x0nlhjh0pYpVDrtBH/wuQAKXXf/796K5eIlo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gV8D/rXoETDpYx4KplcHKwUCcpisrEiEhucasBC0Ud5gY7J/Ur9szwI6bqVnyqOAZ
         VoOltze3ZHCRcJmGtAwGvG/nudYSBtu0FmXIZ46WQznDSQNzDPQ8doPWTT25LBsShG
         QTkpoeZDiV+oCB0kVI+DjOve+k/45SlvYQu+qAjPH6uq3LvOMi9o++bX4eYySeeCt+
         N7RYj/gUB10IKcpORHKSYuFbTOUY6RjTHeerPLVKNKWST+yhSXsbWvNRhSpWxIbwM0
         lTw8RXM+4xl8q+qsSKnHtnlDGXhIsFVNOy4d/pmNO/GwQBgrufOETKy8MW8aLuSDYW
         UI+9aTHUVAKmg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220909123123.2699583-2-conor.dooley@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com> <20220909123123.2699583-2-conor.dooley@microchip.com>
Subject: Re: [PATCH v5 01/14] clk: microchip: mpfs: fix clk_cfg array bounds violation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Sep 2022 17:30:28 -0700
User-Agent: alot/0.10
Message-Id: <20220929003030.0A61AC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2022-09-09 05:31:10)
> There is an array bounds violation present during clock registration,
> triggered by current code by only specific toolchains. This seems to
> fail gracefully in v6.0-rc1, using a toolchain build from the riscv-
> gnu-toolchain repo and with clang-15, and life carries on. While
> converting the driver to use standard clock structs/ops, kernel panics
> were seen during boot when built with clang-15:
>=20
[...]
>=20
> If parent is RTCREF, so the macro becomes: &mpfs_cfg_clks[33].cfg.hw
> which is well beyond the end of the array. Amazingly, builds with GCC
> 11.1 see no problem here, booting correctly and hooking the parent up
> etc. Builds with clang-15 do not, with the above panic.
>=20
> Change the macro to use specific offsets depending on the parent rather
> than the dt-binding's clock IDs.
>=20
> Fixes: 1c6a7ea32b8c ("clk: microchip: mpfs: add RTCREF clock control")
> CC: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

I'll merge this patch over to clk-fixes as well.
