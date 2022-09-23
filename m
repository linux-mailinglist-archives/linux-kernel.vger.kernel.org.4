Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E675E81BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiIWS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIWS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C59121E78
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D2BC60C57
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B75C433D7;
        Fri, 23 Sep 2022 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663957686;
        bh=Opz/7r0SUy+0MNOC7qnejzZyfq4ZUB/NOOirey7c37E=;
        h=Date:From:To:Cc:Subject:From;
        b=pDXBrSQclTGqFFCYFWcjfWY0LsEIpdSbShCDzL0KjjMnxT4iCn8x0l/A6AXDvUfWm
         xfxBvDZcLZsmJQStexwiPO61vIVqDnbVwBZFIaE2EJPqGzyThWQhFgStogxqfW9W5F
         aQP7OeoPaPapZmogS4gfGfXM0SdSdVLDdmiL0tqOVrv+F3kAKZ8DDiabe/FQ7DOPCg
         H28FVdHEP0hy8o9mIj1x33wZSXAuI200tisj74agLry5v+V4NGFWj6kw64WSZtMMs8
         eJ9mUxFj18Fi7FumUCYVAYLUK2UqqG9xQ/v0/Pcpy3NeOJmQLkndNrL8dTi6RuOIEY
         DBu+0kKcLxCMw==
Date:   Fri, 23 Sep 2022 19:28:00 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20220923182800.GA14450@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc7. They're all very simple and
self-contained, although the CFI jump-table fix touches the generic
linker script as that's where the problematic macro lives.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 3fe3fd5f30720b4afd3345cc186808125e7f5848:

  arm64: mm: fix resume for 52-bit enabled builds (2022-09-10 14:46:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 13b0566962914e167cb3238fbe29ced618f07a27:

  vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment (2022-09-23 13:39:01 +0100)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix false positive "sleeping while atomic" warning resulting from
  the kPTI rework taking a mutex too early.

- Fix possible overflow in AMU frequency calculation

- Fix incorrect shift in CMN PMU driver which causes problems with
  newer versions of the IP

- Reduce alignment of the CFI jump table to avoid huge kernel images
  and link errors with !4KiB page size configurations

----------------------------------------------------------------
Ilkka Koskinen (1):
      perf/arm-cmn: Add more bits to child node address offset field

Mark Rutland (1):
      arm64: mm: don't acquire mutex when rewriting swapper

Sergey Shtylyov (1):
      arm64: topology: fix possible overflow in amu_fie_setup()

Will Deacon (1):
      vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment

 arch/arm64/kernel/topology.c      |  2 +-
 arch/arm64/mm/mmu.c               | 32 ++++++++++++++++++--------------
 drivers/perf/arm-cmn.c            |  2 +-
 include/asm-generic/vmlinux.lds.h |  3 +--
 4 files changed, 21 insertions(+), 18 deletions(-)
