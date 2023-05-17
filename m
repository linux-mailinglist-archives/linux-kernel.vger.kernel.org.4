Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5B70679F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjEQMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEQMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1A1AD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA5363B49
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26563C4339B;
        Wed, 17 May 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684325422;
        bh=sW0FRrqOmDhG5KmpEjyQNNMkOe9ZvgHDFcIviNx97QQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lf+FJa2SwDGMapP1t5rodG6n3R0jzkxyQ8gTeam5haKY3C7eGD3XVtmOzBX3c8tWu
         C8+nYkj9PMbr+P2AucXBEWWHWEKsfmlB+PLNXp0iSsv+efW1NBT0ijGaGqp2rWfJCm
         uHrvz2bSlpiVyiYBKY4naDI5qxlgbQSooJqrzomRqG5pMlRu1mxVSPZmXYAdsn8A5r
         H4SGedo+E0R3Lj0ksnDq8yt428/YcAhILPrytW8LZXZyXy7rAlc9l5xqhWvg89FbXE
         kwyLSvRcKITUl3pBnVe+gV+I5BZdb3COFxawWtl7q8AQmt8cuM0IJDZzUGo/TN+VFU
         79yougumarNsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1EE0E5421C;
        Wed, 17 May 2023 12:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: wwan: t7xx: Ensure init is completed before system
 sleep
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168432542198.5953.10423705837174683660.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 12:10:21 +0000
References: <20230517052451.398452-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230517052451.398452-1-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 17 May 2023 13:24:51 +0800 you wrote:
> When the system attempts to sleep while mtk_t7xx is not ready, the driver
> cannot put the device to sleep:
> [   12.472918] mtk_t7xx 0000:57:00.0: [PM] Exiting suspend, modem in invalid state
> [   12.472936] mtk_t7xx 0000:57:00.0: PM: pci_pm_suspend(): t7xx_pci_pm_suspend+0x0/0x20 [mtk_t7xx] returns -14
> [   12.473678] mtk_t7xx 0000:57:00.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1b0 returns -14
> [   12.473711] mtk_t7xx 0000:57:00.0: PM: failed to suspend async: error -14
> [   12.764776] PM: Some devices failed to suspend, or early wake event detected
> 
> [...]

Here is the summary with links:
  - [v2] net: wwan: t7xx: Ensure init is completed before system sleep
    https://git.kernel.org/netdev/net/c/ab87603b2511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


