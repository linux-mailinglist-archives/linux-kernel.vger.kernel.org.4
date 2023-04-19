Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575536E7CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjDSOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjDSOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F455B445;
        Wed, 19 Apr 2023 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21A97637F6;
        Wed, 19 Apr 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF4FC433A1;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914622;
        bh=/WREqY3wIE/Cwcop8rOx7h8eVLYcI+oeYzjU0KDvjMY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kfyEyDqGSGWDILwqsq2ctLK3EZM2bZ4vZFeMgVRkuLOP6MPZW4UEnnomPqxGgzizX
         WEPGPPdfxhQr43w4QFfI1aditmhq0pJM2KBo9QA3hFKu+MKh+4nz1JKOEQSfv3RQbV
         7X8tAgKs/CaCVhNVJS5ol3beEGqPZ/wVy9CF1fGZlIEv6pbrWEUOKnUEcBO52+lTFB
         oYdinORWPGtUVeKhUhs9hTtulZ+qgc6qI3UGFV82j/ZTXFremSHNYvhv8ERlMEtFp3
         fE4VakNx61y24mXN7s9vheifazf39brUGSlgXwuGC7jLz0tSZnMyNtxOQ1pq1HdEa3
         2iBBFfPL2oDfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53D20E270E5;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168191462233.22791.1513309055394935140.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 14:30:22 +0000
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
In-Reply-To: <20230324155421.271544-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org,
        frowand.list@gmail.com, ajones@ventanamicro.com,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Fri, 24 Mar 2023 16:54:18 +0100 you wrote:
> This patchset intends to improve tlb utilization by using hugepages for
> the linear mapping.
> 
> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> take care of isolating the kernel text and rodata so that they are not
> mapped with a PUD mapping which would then assign wrong permissions to
> the whole region: it is achieved the same way as arm64 by using the
> memblock nomap API which isolates those regions and re-merge them afterwards
> thus avoiding any issue with the system resources tree creation.
> 
> [...]

Here is the summary with links:
  - [v9,1/3] riscv: Get rid of riscv_pfn_base variable
    https://git.kernel.org/riscv/c/a7407a1318a9
  - [v9,2/3] riscv: Move the linear mapping creation in its own function
    https://git.kernel.org/riscv/c/8589e346bbb6
  - [v9,3/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
    https://git.kernel.org/riscv/c/3335068f8721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


