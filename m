Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8C69D26D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBTR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBTR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:57:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8E171C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:57:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D7EA1EC04CC;
        Mon, 20 Feb 2023 18:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676915870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=mORGDLVM32u7DFqNXhEj5IDv4kDeywSrPQIxWwHMvLg=;
        b=mcDHNaNQ6GDpQBLP22kbfLbRwfRXkcrrqeRwDY/hwIlu+aX+kITH9Eor7YrExD8SbOWZ/j
        lOs3FG091ULfK6tryQeAciVxuVQ4sd2fwkNeQYTlIm4sgY2NQiSf8c57pQuu5bpxqjX0E8
        GoHxEQBjhrhmhyboLuqeuZeXnaltBwE=
Date:   Mon, 20 Feb 2023 18:57:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.3-rc1
Message-ID: <Y/O0nWz6/zDIxp7z@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of x86 microcode loader updates and fixes for 6.3.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.3_rc1

for you to fetch changes up to f33e0c893b22bf94d7985f1f2aa3872237560c74:

  x86/microcode/core: Return an error only when necessary (2023-02-06 13:41:31 +0100)

----------------------------------------------------------------
- Fix mixed steppings support on AMD which got broken somewhere along
  the way

- Improve revision reporting

- Properly check CPUID capabilities after late microcode upgrade to
  avoid false positives

- A garden variety of other small fixes

----------------------------------------------------------------
Ashok Raj (6):
      x86/microcode: Add a parameter to microcode_check() to store CPU capabilities
      x86/microcode: Check CPU capabilities after late microcode update correctly
      x86/microcode: Adjust late loading result reporting message
      x86/microcode/intel: Pass the microcode revision to print_ucode_info() directly
      x86/microcode/intel: Print old and new revision during early boot
      x86/microcode: Allow only "1" as a late reload trigger value

Borislav Petkov (2):
      x86/microcode/AMD: Rename a couple of functions
      x86/microcode/AMD: Handle multiple glued containers properly

Borislav Petkov (AMD) (4):
      x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter
      x86/microcode/AMD: Add a @cpu parameter to the reloading functions
      x86/microcode/AMD: Fix mixed steppings support
      x86/microcode/core: Return an error only when necessary

Guangju Wang[baidu] (1):
      x86/microcode: Use the DEVICE_ATTR_RO() macro

 arch/x86/include/asm/microcode.h      |  4 +-
 arch/x86/include/asm/microcode_amd.h  |  4 +-
 arch/x86/include/asm/processor.h      |  3 +-
 arch/x86/kernel/cpu/common.c          | 45 ++++++++++++++-------
 arch/x86/kernel/cpu/microcode/amd.c   | 76 +++++++++++++++++------------------
 arch/x86/kernel/cpu/microcode/core.c  | 45 ++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c | 44 +++++++++-----------
 7 files changed, 117 insertions(+), 104 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
