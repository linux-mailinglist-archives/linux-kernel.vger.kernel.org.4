Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B066473B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjAJRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjAJRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:17:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092C1CB2B;
        Tue, 10 Jan 2023 09:17:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B9E9B816AC;
        Tue, 10 Jan 2023 17:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D7C433EF;
        Tue, 10 Jan 2023 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673371046;
        bh=arVpxsbh0h2qnQmd5r0sVza5zxutwpvfWMQgiktyXT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxNWhH6Yjiv4wOv9cVVXT82/l6vxYNZdDrp/wlfKwQuaxuFcI4qv4M4XcL06dbPl2
         It/FCnCQcvsL/SQ84h8bS/OU+m9RX1WLUcVu+RDpgeZIYNBoVYsnqApeLI329Tkjjv
         0N9dvGChwElbfccQv7PuP0Pb+rLKlXw0mI5VIxNrzkWKE6Haw5Vbn6f1idXNDDEX5b
         p1FRzcng4UrZGf78AeucC+047vODPRoD64cVCvmuaRNv978DkqTtjXmqhF+u3LqPkO
         xxeDSi3rQnd0BtFvWvqDCg3tJS3LsAD0ZREP22lA7ranVk5E3mtEkFD6ZSMeU+dVVK
         L0V+McfvB6CHw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.baryshkov@linaro.org, sboyd@kernel.org, agross@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com,
        konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v3 1/2] clk: Add generic sync_state callback for disabling unused clocks
Date:   Tue, 10 Jan 2023 11:17:22 -0600
Message-Id: <167337103771.2139708.5296972457662830009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221227204528.1899863-1-abel.vesa@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 22:45:27 +0200, Abel Vesa wrote:
> There are unused clocks that need to remain untouched by clk_disable_unused,
> and most likely could be disabled later on sync_state. So provide a generic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> skip disabling its clocks.
> 
> [...]

Applied, thanks!

[1/2] clk: Add generic sync_state callback for disabling unused clocks
      commit: 26b36df7516692292312063ca6fd19e73c06d4e7
[2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
      commit: 99c0f7d35c4b204dd95ba50e155f32c99695b445

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
