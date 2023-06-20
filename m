Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C787360F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFTBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFTBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D6E7E;
        Mon, 19 Jun 2023 18:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A949860F32;
        Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 045F6C433CA;
        Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687222824;
        bh=wKn3JK30iCELZzAybdtpR5nHk34wWPJ1QywkzzhvQ0k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F7Ydm/tK+13fLP9A9NcnuVJC950Qz765+hxiBCCuSw5NBR9HnXzPpKf3yEfKt2luk
         WjLNeteyf8hshL0a7b16KTCEYWQ0F7VA/LMGbFCfgtIZV+WQ/cfWhE4V/p9MoF70dT
         Ou27prk09vZr8p+pw46UArC39zsniH5bBw/9abVr05D3oodZQ/yaxDyNhGDEss45uN
         T2wbxNKh95UufklR8PagZNoPYcLFyppjMZLMw8vnYcVsyabkqLLYVa2U8ULu512N00
         eWM+Bw6MJp1MM1/MPLmsUWo6a9RemcSR5QErv0iKp65RtD7N4Uh58k4l9lu7iyKMBy
         A6qQViXvRbiqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6011C561EE;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] RISC-V: Export Zba, Zbb to usermode via hwprobe
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168722282387.22807.6974446089239901729.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 01:00:23 +0000
References: <20230509182504.2997252-1-evan@rivosinc.com>
In-Reply-To: <20230509182504.2997252-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu, corbet@lwn.net,
        abrestic@rivosinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        coelacanthus@outlook.com, jszhang@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        heiko.stuebner@vrull.eu, ajones@ventanamicro.com
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

On Tue,  9 May 2023 11:25:00 -0700 you wrote:
> This change detects the presence of Zba, Zbb, and Zbs extensions and exports
> them per-hart to userspace via the hwprobe mechanism. Glibc can then use
> these in setting up hwcaps-based library search paths.
> 
> There's a little bit of extra housekeeping here: the first change adds
> Zba and Zbs to the set of extensions the kernel recognizes, and the second
> change starts tracking ISA features per-hart (in addition to the ANDed
> mask of features across all harts which the kernel uses to make
> decisions). Now that we track the ISA information per-hart, we could
> even fix up /proc/cpuinfo to accurately report extension per-hart,
> though I've left that out of this series for now.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] RISC-V: Add Zba, Zbs extension probing
    https://git.kernel.org/riscv/c/c6699baf1064
  - [v2,2/3] RISC-V: Track ISA extensions per hart
    https://git.kernel.org/riscv/c/82e9c66e81c8
  - [v2,3/3] RISC-V: hwprobe: Expose Zba, Zbb, and Zbs
    https://git.kernel.org/riscv/c/c0baf321038d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


