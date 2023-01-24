Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D467A602
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjAXWkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjAXWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:40:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B555BF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE01461386
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3793EC4339E;
        Tue, 24 Jan 2023 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674600018;
        bh=gDzHWUyUlB7parFoki5thmlIOArncsEzr3ZJ2pNiAt0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dnULDSAChkMCxVoGO3BUdahnWnRvk3tbO7hHLOqzB5Zh/oG83mrZMlYv1HsSd/Vib
         vc/+Mf+yJ2ZSDlpQdq0fE8Ygdeei9MR1z44/f/kMbgV6CeVpGkbKiVWMovn5lkDhaE
         qDiojGm8R5drZFWJq/93sXjm2Ap6VUhAO7Mca6SFYW6Ia4KzMFkXgxNvGQ2XMPi9VO
         9Q1vaR37KYgRYZ/74owssb41kCFNj/eE+CYMTW5abvC/K0VLOBM+kpgZ92mZFkYydW
         wvWyzdbF9t/7A6336JRVGp8TwiA60sN46kldnFl6BzOt7HdyXrTmeomg5yKLrikAQm
         ZHmoB7LVfo+EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF1DF83ECD;
        Tue, 24 Jan 2023 22:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167460001812.14719.10148685486902233309.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Jan 2023 22:40:18 +0000
References: <20230106161213.2374093-1-masahiroy@kernel.org>
In-Reply-To: <20230106161213.2374093-1-masahiroy@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, alexandre.ghiti@canonical.com,
        anup@brainfault.org, atishp@rivosinc.com, guoren@kernel.org,
        jszhang@kernel.org, gatecat@ds0.me
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat,  7 Jan 2023 01:12:13 +0900 you wrote:
> Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
> for W=1 builds"), building with W=1 detects misuse of #if.
> 
>   $ make W=1 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- arch/riscv/kernel/
>     [snip]
>     AS      arch/riscv/kernel/head.o
>   arch/riscv/kernel/head.S:329:5: warning: "CONFIG_RISCV_BOOT_SPINWAIT" is not defined, evaluates to 0 [-Wundef]
>     329 | #if CONFIG_RISCV_BOOT_SPINWAIT
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT
    https://git.kernel.org/riscv/c/5b89c6f9b2df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


