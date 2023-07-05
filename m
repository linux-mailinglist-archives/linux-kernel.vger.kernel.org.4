Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3B749212
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGEXue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGEXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ACD1989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675F561812
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2095C433CD;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688601022;
        bh=9NFWdwJNIstdaH0oAEUO6KbS94hWTIY5zq+U3/Spqro=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BmCIKFGq9I5f+C9ruqceN42hW1bwMXVJcwLjzh0Nl4Rr7aq/Mp0ZrWvZjJ188Qagc
         gweAnMXm+J1v0V7CUXZiwK9tb99CLzbasGFu2XGSVtIv45rdnIh43TrXiuRjrl2hHo
         2HW2SGYeZb5mtCaH6vTipZCZ5K54CSDHkyuD4qG8B+4Wr5EpeWI00d20bhXpefCuic
         wQZq7GEtIqUmQwoYydr9zT0vfy3nC64o67vy9fSMG0hdw6r4pJJYhBfo42nZeaVLd9
         bkFPNc6ubnpDKv3z7LDiH7ydK7spYEbatxuVkQUcVnECRgpz4ua/bDS0Ykoewm0o2M
         FSXm5wGhLaENw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A44CAC691F1;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168860102266.23922.10126828574164842204.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:50:22 +0000
References: <20230703190044.311730-1-jhubbard@nvidia.com>
In-Reply-To: <20230703190044.311730-1-jhubbard@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        ajones@ventanamicro.com, hughd@google.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, panqinglin2020@iscas.ac.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jthoughton@google.com, ryan.roberts@arm.com
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 3 Jul 2023 12:00:44 -0700 you wrote:
> The WARN_ON_ONCE() statement in riscv's huge_pte_alloc() is susceptible
> to false positives, because the pte is read twice at the C language
> level, locklessly, within the same conditional statement. Depending on
> compiler behavior, this can lead to generated machine code that actually
> reads the pte just once, or twice. Reading twice will expose the code to
> changing pte values and cause incorrect behavior.
> 
> [...]

Here is the summary with links:
  - mm: riscv: fix an unsafe pte read in huge_pte_alloc()
    https://git.kernel.org/riscv/c/62ba41d27612

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


