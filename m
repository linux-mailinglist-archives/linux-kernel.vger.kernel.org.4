Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA26F6DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEDOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958DC5BBD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3A161615
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656EAC433D2;
        Thu,  4 May 2023 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683210173;
        bh=aTlmKJAGliNf+OHG1wwQzfSu4PjeBqLDaw2f4M51h1M=;
        h=Date:From:To:Cc:Subject:From;
        b=ds1Nk6Ur0LjWal2Ldw/KMHjiNe9TahEiIwolF3qEPTcHPsDbQ+CCvhiGHd0rMCJu3
         YydyBX57HUFxxnagnKTGRvmhzjdNEVegPg7p09Sp+WHkZW5FBVdQ+GFfktUQoe2V2r
         gdj+IsR/NYtk3aoC+caxwArz2Ki7r/B4laHrgdD3mTJ/s7W/tUCpvoZoBreW3F6oj+
         x5NFE9uxXRC0iUrfq70xJH1dcsctCkeydW5/aGFqzIjU8IKT52Cb8RFDiRspUi9q+j
         6ThNvn7TI/hnF/hJ/dT6Z+h8cgO6EnYesQcc5Ws4REE/CQ5E+v9nWOKBComwFyo4PN
         9Nm26YK2/rVwg==
Date:   Thu, 4 May 2023 15:22:48 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20230504142247.GA18895@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these few arm64 fixes that came in during the merge window for
-rc1. The main thing is restoring the pointer authentication hwcaps, which
disappeared during some recent refactoring.

Thanks,

Will

--->8

The following changes since commit eeb3557cc188e42ae7f7bef2d6dc5bf0e078412e:

  Merge branch 'for-next/sysreg' into for-next/core (2023-04-20 18:03:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0fddb79bf283a561eb81f09d01f5ac8f61bf8966:

  arm64: lds: move .got section out of .text (2023-05-02 13:12:45 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix regression in CPU erratum workaround when disabling the MMU

- Fix detection of pointer authentication hwcaps

- Avoid writeable, executable ELF sections in vmlinux

----------------------------------------------------------------
Fangrui Song (1):
      arm64: lds: move .got section out of .text

Kristina Martsenko (1):
      arm64: cpufeature: Fix pointer auth hwcaps

Neeraj Upadhyay (1):
      arm64: Fix label placement in record_mmu_state()

ndesaulniers@google.com (1):
      arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text

 arch/arm64/kernel/cpu-reset.S   |  2 +-
 arch/arm64/kernel/cpufeature.c  | 12 ++++++------
 arch/arm64/kernel/head.S        |  4 ++--
 arch/arm64/kernel/sleep.S       |  2 +-
 arch/arm64/kernel/vmlinux.lds.S | 19 +++++++++----------
 arch/arm64/mm/proc.S            |  6 +++---
 6 files changed, 22 insertions(+), 23 deletions(-)
