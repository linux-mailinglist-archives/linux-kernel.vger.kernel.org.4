Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC673D547
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFYXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFYXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F364E50
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E6860C57
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D703EC433D9;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687735223;
        bh=V0mEthuo2hM+n0Dz9lvr8KnNHGvgUzGhIENMGfcWTFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=THDcRCI5g1R9tFFpbzLx4z7fNIuI6S/HAtD1IRVb6dp82gqwLCd4jZr9G0K7z+lNr
         Dl/UYUl+OzU6Wlehhi180XVoQP7QiUWc2tol2DNJBW98UpVDiYzVd6cjS/5HiqQM+G
         ly/I+dXcuFAQDB2uISrfrx6OxVgnIxs4mlPMqXdNOwTjfNFRLilgoT0V3dJ1nvLVWz
         O/e5CB0dV5iaW6SfRIF8c2CQUm6ayeyV7c7m0z0Hv9uGyGRveoU201foCgC/sKLuct
         mvYBzH6ChvEhQcCJtCDASos3X30RxzhFt32loak90uilAhlzPQDvDtvt3PdNcUQXpg
         cQ1AXvjujVGqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD9C3E26D41;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/4] Remove WARN_ON in save_processor_state
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168773522377.24181.6260932886978170161.git-patchwork-notify@kernel.org>
Date:   Sun, 25 Jun 2023 23:20:23 +0000
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, chris@zankel.net, jcmvbkbc@gmail.com,
        steven.price@arm.com, vincenzo.frascino@arm.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        jeeheng.sia@starfivetech.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  9 Jun 2023 15:50:45 +0800 you wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
> 
> In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
> is not defined, but the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
> We also don't have to check it in save_processor_state.
> 
> [...]

Here is the summary with links:
  - [V2,1/4] ARM: hibernate: remove WARN_ON in save_processor_state
    (no matching commit)
  - [V2,2/4] arm64: hibernate: remove WARN_ON in save_processor_state
    (no matching commit)
  - [V2,3/4] riscv: hibernate: remove WARN_ON in save_processor_state
    https://git.kernel.org/riscv/c/91afbaafd6b1
  - [V2,4/4] xtensa: hibernate: remove WARN_ON in save_processor_state
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


