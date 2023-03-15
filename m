Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723776BA529
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCOCVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCOCU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:20:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094FB32E45
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D641B81C54
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C0C6C4339E;
        Wed, 15 Mar 2023 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678846818;
        bh=TEopD/Ndpni6SyAjb9ptFAsLvmC33E1XWhm2iz4z8wQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GxHjJDwgr8J25w5BuRR9I6JZxa64YOnHr5Q+7LlHK9QAuznb2t+gzXyys4q8GeNYQ
         jPEt6W8nqluVGV7X/Yl2omcTVBB9TpoCToe6RndKxy3Uo4IbnBXUESF1T9z0UOD7Gq
         6cXTWj8Sa8Tjh7eTWb6pdPJKW7EYp98/z6Hc01t6UpLuvBSHRXK13eu/hXe//090xD
         3NnfhbWX+txIwKMQI1+HDsJ3jA/b/S9bgB0yz8Q4JDtY1a01BtHL9KfU4fa5rrYwSg
         gAX7v83eyK2uAhwHiSccgSp8VAzT1vHNDsbTUMwiVwwpa0d+JQJdKV5vXVsAjAGNjH
         kUVqGMm9S/zMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30B6DE524FD;
        Wed, 15 Mar 2023 02:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] RISC-V: mm: Support huge page in vmalloc_fault()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167884681819.17018.8848137969847408206.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Mar 2023 02:20:18 +0000
References: <20230310075021.3919290-1-dylan@andestech.com>
In-Reply-To: <20230310075021.3919290-1-dylan@andestech.com>
To:     Dylan Jhong <dylan@andestech.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, x5710999x@gmail.com, bjorn@rivosinc.com,
        abrestic@rivosinc.com, peterx@redhat.com, hanchuanhua@oppo.com,
        apopple@nvidia.com, hca@linux.ibm.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tim609@andestech.com,
        peterlin@andestech.com, ycliang@andestech.com,
        alexghiti@rivosinc.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 10 Mar 2023 15:50:21 +0800 you wrote:
> Since RISC-V supports ioremap() with huge page (pud/pmd) mapping,
> However, vmalloc_fault() assumes that the vmalloc range is limited
> to pte mappings. To complete the vmalloc_fault() function by adding
> huge page support.
> 
> Fixes: 310f541a027b ("riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] RISC-V: mm: Support huge page in vmalloc_fault()
    https://git.kernel.org/riscv/c/47dd902aaee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


