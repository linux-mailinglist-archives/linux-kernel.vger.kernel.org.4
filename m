Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C55B4E79
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIKLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIKLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2107F36DC0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B34D860E9B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5DCC433D6;
        Sun, 11 Sep 2022 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662896252;
        bh=csZ/jPvWDw1YIi3MWBz7R54yOulFDj016aE61Oqqpz0=;
        h=Date:From:To:Cc:Subject:From;
        b=gbjhLGqRuEyjqFOPMugmxqF7qBw+oxmTUeLy4LOxl1RzyDKu6F+UdMBq9UB/c0+5W
         zwMaM8ouoN74xDwQHt9i2aRKr5Xhm/IUcE4y/rNx1wLMFShXhIh8CfC0dJk/npn7aM
         kVDzVTOjbz5yrcKIBfWPJ30uRVCQo/0o8Vz/+11HH939Yu8itnvhMJjrhxw7ksjaLR
         bVp7Blv+Xtsgsi+t46rsa58NmgaVLJ0N/rAwMTLwjpnWONbGfn87al55NyipagIZ4D
         H/iBGwCi164BoE5qATF2a/Eo79htK25X+I+P7YYajDDMwybzN4YxULyTyXqYNfywwW
         7eIUr1SopKDLw==
Date:   Sun, 11 Sep 2022 12:37:27 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20220911113725.GA2070@willie-the-truck>
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

When you get a moment, please can you pull these three small arm64 fixes?
They're all related to optional architecture extensions: BTI, SME and
52-bit virtual addressing.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 5fbc49cef91916140a305f22f7430e9a7ea0c6b4:

  arm64: mm: Reserve enough pages for the initial ID map (2022-09-01 12:02:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3fe3fd5f30720b4afd3345cc186808125e7f5848:

  arm64: mm: fix resume for 52-bit enabled builds (2022-09-10 14:46:28 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Disable in-kernel BTI when compiling with GCC, as it makes invalid
  assumptions about the distance between functions which has led to
  crashes when calling modules on a CPU with BTI support.

- Remove bogus TIF_SME flag management if memory allocation fails in the
  ptrace code.

- Fix the resume path when configured for 52-bit virtual addressing.

----------------------------------------------------------------
Joey Gouly (1):
      arm64: mm: fix resume for 52-bit enabled builds

Mark Brown (2):
      arm64/bti: Disable in kernel BTI when cross section thunks are broken
      arm64/ptrace: Don't clear calling process' TIF_SME on OOM

 arch/arm64/Kconfig         | 2 ++
 arch/arm64/kernel/ptrace.c | 2 --
 arch/arm64/kernel/sleep.S  | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)
