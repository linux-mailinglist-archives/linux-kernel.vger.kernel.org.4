Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B8737059
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjFTPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjFTPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A31733
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8374612D0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A3EC433C9;
        Tue, 20 Jun 2023 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687274420;
        bh=2k98mMgOMgUh8cLLc+tlihNRAWbOo5x8TfgYwQ3JGX4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qgybfX2wCwdbHduQ5+Ea1UCHKTz9CvouMTUwP9qSWHEe816u1/L2Z07zUJLF5Y0Nn
         a3u6TqI2aWwZDqUS9bs3dYHAsUe4vq4HiElqQ1uMUYRQp+51xiI5Gs8CTT4ZlH5yzS
         3TVKbA3disNOuG/c6dwfPfBTRLVTrrcjhlnu09+Z2BhXHNHcJlBZCb7NNYg24OT08W
         foACLLFhrMCdGcJ+2NeSaOTkfM0wn3bm8YnZkf3hCpcp5QosC7y7SPrf3pXF7oIbY7
         7ORc8vgG8M+U+9JOGext6/YVi77I8vYhvjII2mn+gcS0woY+nwasvvETYzBIyfkkk1
         4EjybJHbaVWcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C82CE21EDB;
        Tue, 20 Jun 2023 15:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: Pre-allocate PGD entries for vmalloc/modules
 area
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168727442024.569.16572247474971535604.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 15:20:20 +0000
References: <20230531093817.665799-1-bjorn@kernel.org>
In-Reply-To: <20230531093817.665799-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, alexghiti@rivosinc.com, joro@8bytes.org
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

On Wed, 31 May 2023 11:38:17 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V port requires that kernel PGD entries are to be
> synchronized between MMs. This is done via the vmalloc_fault()
> function, that simply copies the PGD entries from init_mm to the
> faulting one.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: Pre-allocate PGD entries for vmalloc/modules area
    https://git.kernel.org/riscv/c/7d3332be011e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


