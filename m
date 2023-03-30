Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A906D1085
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC3VK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC3VKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE7E04A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B91C7B82A38
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 666F9C433A7;
        Thu, 30 Mar 2023 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210618;
        bh=O+cjS7yD8pHdzp5zgruktqo14qk19j88CY4jY2VsQ60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XsQZrw4qX2tAz1ujPErzk7Jd3b0KRFzPlz6dPw5oJVkkL3kizsBhwQkTrF4Z+oDPk
         tluXzJa9qA5ysmfMm7Ab9kwE/8I/z8woScFX2U5o3/7YfvKGcGt9MVq9uVDLfI5JiW
         /x/7DanIoJrxEJth8NXlSJDXfZYWUpbntWnuDkfW1Xr2iUQQwuUQl1a62cEU2y4a2w
         Z0zHKTlgdv77IbChVhadvsGKlKMG5v9VEt3uRN+cJgGELY/oloVOnX6fhPVBXtKM3c
         4RuYDYp8kXPH+aXOZFKwzf6ATRS5tmaLbsKqAjx1H37t25wXyy16J0/0m+CFjVABKs
         5j33IkwbFQuSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52B31E2A03F;
        Thu, 30 Mar 2023 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for riscv_has_extension[un]likely()'s
 alternative dependency
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168021061833.10339.16976818508528489046.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 21:10:18 +0000
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor@kernel.org, paul.walmsley@sifive.com,
        heiko.stuebner@vrull.eu, ajones@ventanamicro.com,
        apatel@ventanamicro.com, jszhang@kernel.org, Jason@zx2c4.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 24 Mar 2023 10:05:37 +0000 you wrote:
> Here's my attempt at fixing both the use of an FPU on XIP kernels and
> the issue that Jason ran into where CONFIG_FPU, which needs the
> alternatives frame work for has_fpu() checks, could be enabled without
> the alternatives actually being present.
> 
> For the former, a "slow" fallback that does not use alternatives is
> added to riscv_has_extension_[un]likely() that can be used with XIP.
> Obviously, we want to make use of Jisheng's alternatives based approach
> where possible, so any users of riscv_has_extension_[un]likely() will
> want to make sure that they select RISCV_ALTERNATIVE.
> If they don't however, they'll hit the fallback path which (should,
> sparing a silly mistake from me!) behave in the same way, thus
> succeeding silently. Sounds like a
> 
> [...]

Here is the summary with links:
  - [v1,1/2] RISC-V: add non-alternative fallback for riscv_has_extension_[un]likely()
    https://git.kernel.org/riscv/c/1aa866931b80
  - [v1,2/2] RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
    https://git.kernel.org/riscv/c/1ee7fc3f4d0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


