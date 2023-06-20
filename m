Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5357360F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFTBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFTBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2FE7F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53E860F66
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193F8C433CD;
        Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687222824;
        bh=mGh3gLTaDGrGvROv15Q2QfAPdhKQZa/YqomrnytzirA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GTqaVbN+vWc84aq5GCPqfy/3EydClkGdysSoEmktHg7l/RGSGh6L0JzrUfa4O1zG2
         MoE/t8FezR91D3eXtYjgxxys36CM4HWAxL1Q2xj97rdJkW5+s8mEPUMybwjCA64gzq
         yV1qY+fJQOCmc8T4H4SuEEKNwM7OQe3x5+WEZBlOGahlYqLf7Avux3sPUpUBuZTOMQ
         cph985S8072ydSIOaOS4f2cwK1yEyBy+57M58SbXSOEvwZEKQK9nMXPH0ecXz0gC3B
         vtYSJdDeSQdXqr16Q82KceI41/p7kKiQqkM1ahOunannVRgqrpK5vwqQRvCGbNBxm+
         cUwmgKCk4A9yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC158C4316A;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168722282396.22807.1023067349151086213.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 01:00:23 +0000
References: <20230522025020.285042-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230522025020.285042-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, suagrfillet@gmail.com,
        mason.huo@starfivetech.com, leyfoon.tan@starfivetech.com,
        ajones@ventanamicro.com, jeeheng.sia@starfivetech.com,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com
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

On Mon, 22 May 2023 10:50:20 +0800 you wrote:
> The suspend_restore_csrs is called in both __hibernate_cpu_resume
> and the `else` of subsequent swsusp_arch_suspend.
> 
> Removing the first call makes both suspend_{save,restore}_csrs
> left in swsusp_arch_suspend for clean code.
> 
> Fixes: c0317210012e ("RISC-V: Add arch functions to support hibernation/suspend-to-disk")
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> 
> [...]

Here is the summary with links:
  - [V2] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
    https://git.kernel.org/riscv/c/c6399b893043

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


