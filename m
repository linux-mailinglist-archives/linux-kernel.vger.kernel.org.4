Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294227096BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjESLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjESLqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB399F7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 723A565700
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB586C433EF;
        Fri, 19 May 2023 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684496782;
        bh=Olt1PypmmQcb81fY2VtriBTxMJOSgK/JD0JGkP5i/rc=;
        h=Date:From:To:Cc:Subject:From;
        b=YIjKtCoFhvlHSELOlopkPLtiE/J4a05orC+WJRtd93nDUUIdb6W0w8eGv/kRCfd0r
         53NvlEaXld03f/6b49L179KOAMsnyYtm+QCCZUUhf5dvQQU5yLg4k+tS/hBZJM3t0c
         ckA1Tgfkue0i7LHAdKJPkbT6YXTlZQ9ElISAoETc3x6EaJ5IHW/YxuMnKl/Y/V0UM0
         AZBAS+uMTYmjpTMm8LRNELDif/CUwnGtE7BnbSHuCWV8xop3sK76009KHz/fTCCKkp
         hK4fRJ8UeAaHRbILJPIAArUViONUQIrQMu7oqBrLG6y97wI9D46XVr22ZNgfjINaJE
         nOnhYPeyblE1g==
Date:   Fri, 19 May 2023 12:46:18 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20230519114617.GA2588@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc3. Summary in the tag, but it's a
mixture of compiler/static checker resolutions and a couple of MTE fixes.

Cheers,

Will

--->8

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c4c597f1b367433c52c531dccd6859a39b4580fb:

  arm64: mte: Do not set PG_mte_tagged if tags were not initialized (2023-05-16 14:59:16 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Avoid erroneously marking untagged pages with PG_mte_tagged

- Always reset KASAN tags for destination page in copy_page()

- Mark PMU header functions 'static inline'

- Fix some sparse warnings due to missing casts

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: perf: Mark all accessor functions inline
      arm64: perf: Mark all accessor functions inline

Linus Walleij (1):
      arm64: vdso: Pass (void *) to virt_to_page()

Min-Hua Chen (1):
      arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Peter Collingbourne (2):
      arm64: Also reset KASAN tag if page is not PG_mte_tagged
      arm64: mte: Do not set PG_mte_tagged if tags were not initialized

 arch/arm/include/asm/arm_pmuv3.h   | 6 +++---
 arch/arm64/include/asm/arm_pmuv3.h | 6 +++---
 arch/arm64/kernel/mte.c            | 7 ++-----
 arch/arm64/kernel/vdso.c           | 2 +-
 arch/arm64/mm/copypage.c           | 5 +++--
 arch/arm64/mm/fault.c              | 4 ++--
 6 files changed, 14 insertions(+), 16 deletions(-)
