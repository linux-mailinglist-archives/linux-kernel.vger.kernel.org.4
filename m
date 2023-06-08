Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74716728260
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjFHOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjFHOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CA2D6D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FBF764DFB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB23C433D2;
        Thu,  8 Jun 2023 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686233421;
        bh=UuSTUIAPSAYL95ZEDOcNCVrYvfTlSpIeyLDoZK+9CwU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eFxcodm+bFSXdjMlZECpgQdrrROS64IKqOvbbI1BIs9QbUHnRMtCiJDH++uLwPg4u
         ai8zUkDXOVlgzA0tRTM5z5CrBgUZGLUDU+sg5VR4jRp4DFOLpSDzCK3eBjUJqW5T+d
         S3zfvku1uHTio6baDhkK1N9KEWp2z8m96E06dhq9rxi3FlXSIY8CKLa6yuARkpYkkR
         HsXH1i/DU+Li+F5HsLjggFomuu+OxNjafQZMBEmVokHNgnM/wvB4osDBDu/08l2M9d
         ckjLCkTnf/P3ju5VOuxSOybBiHVOWm1qUG2TgThI3rZx0v+AkiI57WXTdLUyIAGYIE
         fgDo7FQmCiJLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AACFE451B4;
        Thu,  8 Jun 2023 14:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix kfence now that the linear mapping can be backed
 by PUD/P4D/PGD
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168623342136.30670.5165804559719545344.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 14:10:21 +0000
References: <20230606130444.25090-1-alexghiti@rivosinc.com>
In-Reply-To: <20230606130444.25090-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, glider@google.com,
        elver@google.com, dvyukov@google.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, robh@kernel.org,
        anup@brainfault.org, ajones@ventanamicro.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+a74d57bddabbedd75135@syzkaller.appspotmail.com
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

On Tue,  6 Jun 2023 15:04:44 +0200 you wrote:
> RISC-V Kfence implementation used to rely on the fact the linear mapping
> was backed by at most PMD hugepages, which is not true anymore since
> commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
> mapping").
> 
> Instead of splitting PUD/P4D/PGD mappings afterwards, directly map the
> kfence pool region using PTE mappings by allocating this region before
> setup_vm_final().
> 
> [...]

Here is the summary with links:
  - riscv: Fix kfence now that the linear mapping can be backed by PUD/P4D/PGD
    https://git.kernel.org/riscv/c/25abe0db9243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


