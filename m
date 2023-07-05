Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F5749213
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGEXug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGEXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0DF1730
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5913161807
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB1EC433CB;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688601022;
        bh=QC3N5FVDNiAZMmLVWV062ludq+R2W6w7g38+nOSTnWY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u6KQwRVwHXDmLQPVdu4F1jHwH2h5UfG4IISxdZGmCs5+fDx08aEaH7AqTfY02MBHY
         fwyD/Eic2PZq11b8OanRW5LdHb/AT+oA3VKDxbILPychrJ+D8MuFwi1dYyfZ7f76Rw
         pc5270W2z9lsZQwAyS50bNKebX23BBCVLpvqPDpo2EOao2ksv2v4Nr3TJT7PLrBdFG
         dnTAAAc5/QGbaUw+nGdLCH2OXTzAKRBMYce2I5h5thW4YY6x1PgkEcLMdn+L7hNXVp
         /SxmEAWiu6Fp+uctMwUBRgsJyq/yiThetzyhF3vYNGIysUzr6hFv7Ur28sk0N/85po
         fu3zWO3zcsEdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BB2DC561EE;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] riscv: Discard vector state on syscalls
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168860102256.23922.12744250095114433729.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:50:22 +0000
References: <20230629142228.1125715-1-bjorn@kernel.org>
In-Reply-To: <20230629142228.1125715-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, palmer@rivosinc.com, remi@remlab.net,
        darius@bluespec.com, conor.dooley@microchip.com
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 29 Jun 2023 16:22:28 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
> 
> The vector registers are set to all 1s, vill is set (invalid), and the
> vector status is set to Dirty.
> 
> [...]

Here is the summary with links:
  - [v4] riscv: Discard vector state on syscalls
    https://git.kernel.org/riscv/c/9657e9b7d253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


