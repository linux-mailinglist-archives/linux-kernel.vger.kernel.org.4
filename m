Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D15F2EE3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJCKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJCKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFF3FEEB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E10C61030
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EABC433C1;
        Mon,  3 Oct 2022 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664793532;
        bh=Wb5QlCQoIluCSve+kPlO0WTb8M6wqUHapBeGAV6z1uE=;
        h=From:To:Cc:Subject:Date:From;
        b=phnvPVGFboLC5HzqCpDPnTuFsS12xHr9qtLxkOWEvZTu3vcr+agYAGQlSmQoYxkLg
         oDNJI8rnRDDttB4nHGWUg+5QMhzc30gnKDqPWT3hdU6sCWGNAwEw4+EKC5LhjM3kts
         Hjfo73Val8taCpK2rJiICeq3sZxDygN0qYMTdG0kKA7Y41QSdZYRkZ3LH/NZlDegE2
         3JhmPSzfhxSfGowBGJ4N4gx9dKjCrrCzsnQQfjim0dI91WcYtDpbtmKLT4MsMRg+86
         zDo7rPxQaLCwCP0dX3VpOXRmGuBNIE73elot4s0Mtb1yfJGpr6t6baaRJl/Y2KYSBz
         RIHAgP9oslN6Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] riscv: entry: further clean up and VMAP_STACK fix
Date:   Mon,  3 Oct 2022 18:29:17 +0800
Message-Id: <20221003102921.3973-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I planed to do similar generic entry transaction as Guo Ren did[1], and
I had some commits in local. Since Guo has sent out the series, I
dropped my version and just provide those in my local repo but missing
in Guo's series. However, this doesn't mean this series depends on
Guo's series, in fact except the first one, the remaining three patches
are independent on generic entry.

Since v2:
  - the patch of removing wrappers of trace_hardirqs_{on,off} is in
    Guo's v6 generic entry series[2], so remove it.
  - add a new patch to fix kernel info leakage.
  - collect Acked-by tag.
  - the GP saving and restoring macros range from x5 to x31 now per
    Guo's suggestion.

Since v1:
  - consolidate gp saving/restoring in mcount-dyn.S as well
  - avoid non-trival memory waste if NR_CPUs is large
  - collect Reviewed-by tag.

[1]https://lore.kernel.org/linux-riscv/20220918155246.1203293-1-guoren@kernel.org/T/#t
[2]https://lore.kernel.org/linux-riscv/20221002012451.2351127-1-guoren@kernel.org/T/#t

Jisheng Zhang (4):
  riscv: process: fix kernel info leakage
  riscv: consolidate ret_from_kernel_thread into ret_from_fork
  riscv: fix race when vmap stack overflow and remove shadow_stack
  riscv: entry: consolidate general regs saving/restoring

 arch/riscv/include/asm/asm-prototypes.h |   1 -
 arch/riscv/include/asm/asm.h            |  63 ++++++++++
 arch/riscv/include/asm/thread_info.h    |   3 -
 arch/riscv/kernel/asm-offsets.c         |   1 +
 arch/riscv/kernel/entry.S               | 151 +++---------------------
 arch/riscv/kernel/mcount-dyn.S          |  56 +--------
 arch/riscv/kernel/process.c             |   7 +-
 arch/riscv/kernel/traps.c               |  32 ++---
 8 files changed, 103 insertions(+), 211 deletions(-)

-- 
2.37.2

