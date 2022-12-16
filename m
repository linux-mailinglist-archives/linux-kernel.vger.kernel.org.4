Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732C64EE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiLPPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiLPPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:51:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30536C4C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D1D6214F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD177C433F0;
        Fri, 16 Dec 2022 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671205878;
        bh=OCPpXdHlgFzdWE7+Wzzjx744Kv6sP4H4C1kVeRSTqZ4=;
        h=Date:From:To:Cc:Subject:From;
        b=XLFP09xq8GDceLpSXzG9ByZtmF/MCvorOgdORK55Q51Tnie/AXhyLBgcMaynYy5qc
         NRkW5DEMg2f/Jw6n7YkA28cacQEknwoVtVn3lqDaEG3mmgLDDqZX5tlHnihwNymdaE
         567H11vzCX0aaYmGCM/lLF+4VxTgG61L8J+tDsMJPJ4wGVoJM2gxd3jVklgh1lWyDx
         eRg4vtljZu46gikd2AjN0KzmRPvSeur0pwTzCnHgC/wjBNRpCgH9CORebKTCtq9mRc
         coct1Uq+JTH6dkgwotqkLVTYMG7ksZWdySg/JkEsKWH0DebzkuQIcivr43gCrtTl3I
         5HTEOEbIZUyuA==
Date:   Fri, 16 Dec 2022 15:51:13 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20221216155111.GA8949@willie-the-truck>
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

Please pull these two arm64 fixes for -rc1, fixing issues introduced by
the recent pull for 6.2. They're both straightforward: a Kconfig tweak
and a revert. Summary in the tag.

There are some other fixes kicking around, but they're not urgent at all
(things like benign sparse warnings) so I'll get back to them in the new
year.

Cheers,

Will

--->8

The following changes since commit 5f4c374760b031f06c69c2fdad1b0e981a1ad42f:

  Merge branch 'for-next/undef-traps' into for-next/core (2022-12-06 11:34:25 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c0cd1d541704c45030cbb2031612fdd68e8e15d5:

  Revert "arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption" (2022-12-15 17:59:12 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix Kconfig dependencies to re-allow the enabling of function graph
  tracer and shadow call stacks at the same time.

- Revert the workaround for CPU erratum #2645198 since the CONFIG_
  guards were incorrect and the code has therefore not seen any real
  exposure in -next.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ftrace: Allow WITH_ARGS flavour of graph tracer with shadow call stack

Will Deacon (1):
      Revert "arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption"

 Documentation/arm64/silicon-errata.rst |  2 --
 arch/Kconfig                           |  2 +-
 arch/arm64/Kconfig                     | 16 ----------------
 arch/arm64/include/asm/hugetlb.h       |  9 ---------
 arch/arm64/include/asm/pgtable.h       |  9 ---------
 arch/arm64/kernel/cpu_errata.c         |  7 -------
 arch/arm64/mm/hugetlbpage.c            | 21 ---------------------
 arch/arm64/mm/mmu.c                    | 21 ---------------------
 arch/arm64/tools/cpucaps               |  1 -
 9 files changed, 1 insertion(+), 87 deletions(-)
