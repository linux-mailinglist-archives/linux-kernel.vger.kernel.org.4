Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CC6BC16A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjCOXfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCOXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9B4A225D;
        Wed, 15 Mar 2023 16:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDAA61EB1;
        Wed, 15 Mar 2023 23:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3EEC433D2;
        Wed, 15 Mar 2023 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923181;
        bh=ZW0cW6j0eZ3LRxXMTCWZrrkIV3axsHJnqHcZZpwnlco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQEoGlYRaWYHi/3uI8nc0LhUk+/xLW7zzvBumLCc+upwsanoVQoyggJaMNzHIBAah
         dUqX7NTdlqtNqmVH/DkhNlmdhG2TDo8lVKgqn9b4iqOz8VxYmzIKSA6ocnC0RE5iVF
         gCDXLOCIQ9m3MCqH92jKnf66VpJfg28tUC4YFJRgv4WmV+H6ZpiS4GYhkT0Ulh7v6k
         0P0eiOIcdIton2WyhrGiY3/0QMrCKisubp+rlcPe4QhNIGfYkwOLPEua2qEBOr2RK8
         0lW00iPAGST7rIrGR+59BXC9kt6+CZ3pQcxZeLVFPF7TYXG9jP8MadTZ9rbSwtx0/w
         ga0o2PgaBXBEA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tero Kristo <kristo@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Nishanth Menon <nm@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-tegra@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: (subset) [PATCH 00/30] clk: Convert to platform remove callback returning void
Date:   Wed, 15 Mar 2023 16:35:30 -0700
Message-Id: <167892332563.4030021.12717582908504193989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 17:14:42 +0100, Uwe Kleine-König wrote:
> this patch series adapts the platform drivers below drivers/clk
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> [...]

Applied, thanks!

[22/30] clk: qcom: Convert to platform remove callback returning void
        commit: c4dc24da5286742f8cc728379f6115c9e886a8a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
