Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A96FB325
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjEHOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjEHOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FC676A8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9E56405D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 618F9C43446;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556916;
        bh=koyU6f3xsH8g8EO1siPFgFEXlH+fNzXNitnViL5XzNI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=awCYICC4lIDTzYVocGfFrX/jwkzIAkAuoKj4ttekSJJBScN46uZ4EATtZdkVwHKNr
         r692NNQMV8jYTBt2HRgkrTvuKq8iJJy0jrP7P3tb6mHlcy6J3x+E1U4UtD4Gnruwz7
         G5oB8QXUaPWMQl1MBI8mpBQkjnIwT8OP0X9dpq+o8Hr5u29W2R+7TrBBvyHW16mBOd
         c/7nMViOblislpE1Nd/T01KqbKQhHkiUQHyycPVGuABpYmh5eWh3nO5GI8h2AvjEen
         CqrXkAh7bwmz9J/3qoLAxthul8kWIDhjNPhl9WCvvOFM4+bBGo3PR4xkbTqPw8bLbM
         z4eulBWBcSFjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 392C4E26D26;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: compat_syscall_table: Fixup compile warning
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168355691623.25692.1628612275748085711.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 14:41:56 +0000
References: <20230501223353.2833899-1-dfustini@baylibre.com>
In-Reply-To: <20230501223353.2833899-1-dfustini@baylibre.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        lizhengyu3@huawei.com, bjorn@rivosinc.com, heiko@sntech.de,
        liaochang1@huawei.com, masahiroy@kernel.org,
        alexghiti@rivosinc.com, jszhang@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        lkp@intel.com, guoren@linux.alibaba.com
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  1 May 2023 15:33:54 -0700 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> ../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
> field overwritten [-Woverride-init]
>    12 | #define __SYSCALL(nr, call)      [nr] = (call),
>       |                                         ^
> ../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
> '__SYSCALL'
>   567 | __SYSCALL(__NR_semget, sys_semget)
> 
> [...]

Here is the summary with links:
  - riscv: compat_syscall_table: Fixup compile warning
    https://git.kernel.org/riscv/c/f9c4bbddece7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


