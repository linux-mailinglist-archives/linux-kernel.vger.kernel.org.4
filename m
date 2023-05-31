Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046C77185C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjEaPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjEaPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F37C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9154763D19
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D5EC433D2;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685545822;
        bh=pL4sre/8I+lAJhI65dVhLrNVbXbcple+qv/qIynQKwk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IaeeWc9hF4u/krb4rVlynNldh5n74wLIBCm7e57SCXt9rvaIZPoGOIqX+07gBi5gW
         +Loemm5FJflzXLSe03XSsKn439lbLMH82yykl6EcLfY79+oST7hD+HiQtlGpQPeeGQ
         aVOHgPVxbjv4w+PTXwSV7Z/n8jms0yZ37a0pWVsOxr3DgWMajZpPNvBmirOTWcvnkb
         RrXG22AR7/1RBH8f6rdPaFkWZ8qAKWPh020qY2QmoDVEH4OKR+FpkC9Q2KsmwKpXJb
         5T9f9dXfNb1/9vVE46eZgNaWhTem4oNGgDIDRdNhY+avb7pfSUqHuZ7XhW0GT85nKX
         UhDsy6b9THQbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA578E21EC7;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] RISC-V: mark hibernation as nonportable
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168554582182.8247.5723560098196678790.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 15:10:21 +0000
References: <20230526-astride-detonator-9ae120051159@wendy>
In-Reply-To: <20230526-astride-detonator-9ae120051159@wendy>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        alex@ghiti.fr, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, suagrfillet@gmail.com,
        jeeheng.sia@starfivetech.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Fri, 26 May 2023 11:59:08 +0100 you wrote:
> Hibernation support depends on firmware marking its reserved/PMP
> protected regions as not accessible from Linux.
> The latest versions of the de-facto SBI implementation (OpenSBI) do
> not do this, having dropped the no-map property to enable 1 GiB huge
> page mappings by the kernel.
> This was exposed by commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
> for the linear mapping"), which made the first 2 MiB of DRAM (where SBI
> typically resides) accessible by the kernel.
> Attempting to hibernate with either OpenSBI, or other implementations
> following its lead, will lead to a kernel panic ([1], [2]) as the
> hibernation process will attempt to save/restore any mapped regions,
> including the PMP protected regions in use by the SBI implementation.
> 
> [...]

Here is the summary with links:
  - [v1] RISC-V: mark hibernation as nonportable
    https://git.kernel.org/riscv/c/ed309ce52218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


