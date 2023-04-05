Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E506D8996
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDEVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjDEVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC93C22;
        Wed,  5 Apr 2023 14:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FDF6414C;
        Wed,  5 Apr 2023 21:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F616C4339E;
        Wed,  5 Apr 2023 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680730333;
        bh=ZYZdVwjMqTBVBqbOREzP3WGiwNtKl7X0AW2KpDiF5Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVFH337fZB65dZthbJjHQjCHT9K0MYnncK7lreCGZYiCg3v6yhy10TSuWvklUzlCe
         ac2QmZICG3nHF+5P8AE9UfUQNnsNMQdXF2Ih/Ymfy2Wwd9Q/KZPX1+W3pSTRJrCwyJ
         St0XMmFyV64kAhh1kYAjCG3nyB3Fe/cvozReILboJQ1BgTOlgnid3nS9TVrLpEG9iW
         z+wZnY8/7fjfp0ngFIEEDfdDAH8y7ed5zzsKUxamD5btKo0bwx7KiVQzg2hyBzKLzY
         Mmp10FVIjYFbDpubGwWFIJ1P6JzeCMNC2Pe8U2ENGqAH7HyIkr84DR3WdUzN4mCnaj
         II/nkpsPvWj9Q==
From:   Conor Dooley <conor@kernel.org>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC
Date:   Wed,  5 Apr 2023 22:30:45 +0100
Message-Id: <20230405-wharf-rejoin-5222e5958611@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401111934.130844-1-hal.feng@starfivetech.com>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4xdzTSoq3uZ4FVpJV9Db9fLME5Mlhkbk3nlXZWw5e0A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCm6L5o5ZL4EGarNDnjAsS2G/efL0C9fE1ZU3vmjmmf4c Efr5Hf/OkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR5jyGf0ZuRvlXBA6/CdjM FaeX867RpMiBeeKtSw0Zgf6341e8dmf4zZqZ3G1mK/v6feLC+dvlOuO6pDwXmGxPTTZ9zl3zsnY WLwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Sat, 01 Apr 2023 19:19:12 +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC.
> 
> @Stephen and @Conor, I have made this series start with the shared
> dt-bindings, so it will be easier to merge.
> 
> @Conor, patch 1, 2, 16~21 were already in your branch. Patch 22 is the
> same with the patch [1] I submitted before, which you had accepted but
> not merge it into your branch.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[01/22] dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
        https://git.kernel.org/conor/c/7fce1e39f019
[02/22] dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
        https://git.kernel.org/conor/c/3de0c9103258

These two are shared with clk.

[16/22] dt-bindings: timer: Add StarFive JH7110 clint
        https://git.kernel.org/conor/c/1ff5482ab9a5
[17/22] dt-bindings: interrupt-controller: Add StarFive JH7110 plic
        https://git.kernel.org/conor/c/8406d19ca049

I took these bindings too, as Palmer has done that in the past for new
SoC support.

[18/22] dt-bindings: riscv: Add SiFive S7 compatible
        https://git.kernel.org/conor/c/8868caa2a073
[19/22] riscv: dts: starfive: Add initial StarFive JH7110 device tree
        https://git.kernel.org/conor/c/60bf0a39842e
[20/22] riscv: dts: starfive: Add StarFive JH7110 pin function definitions
        https://git.kernel.org/conor/c/e22f09e598d1
[21/22] riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device tree
        https://git.kernel.org/conor/c/54baba33392d
[22/22] riscv: dts: starfive: jh7110: Correct the properties of S7 core
        (squashed)

Hal, can you get your folks to resend whatever dts bits that are now
applicable? IOW, the dt-bindings for the entries are in a for-next
branch for some subsystem.

Thanks,
Conor.
