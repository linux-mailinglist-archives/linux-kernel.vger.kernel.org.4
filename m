Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE26C01A6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCSMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:35:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1201B326
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:35:37 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E10BF1EC067D;
        Sun, 19 Mar 2023 13:35:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679229335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=eyaEB2KdmaExV+3fZ3dx11YTBavO8jrgST1ZjzsZgMg=;
        b=CMjWmL9Q/F/3Y8we9HVJSFsKjrPnMHEmJMjT05o+evFQbuzY61T40hX2AXtSTqNVVkzeES
        4C1Q6r20AEWpJd0UK2RqwrlKc9oSUuGQC38Od5gW4w5gqPsamwhkrrZUVWTBFhz568E10y
        ecUZ8GxO4wQfjXfm6SmTnOKA5VIFFws=
Date:   Sun, 19 Mar 2023 13:35:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.3-rc3
Message-ID: <20230319123528.GAZBcBkJKPZCwVKnBl@fat_crate.local>
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

please pull the urgent x86 lineup for 6.3. There's a little bit more
"movement" in there for my taste but it needs to happen and should make
the code better after it.

Thx.

---

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc3

for you to fetch changes up to cbebd68f59f03633469f3ecf9bea99cd6cce3854:

  x86/mm: Fix use of uninitialized buffer in sme_enable() (2023-03-16 12:22:25 +0100)

----------------------------------------------------------------
- Check cmdline_find_option()'s return value before further processing

- Clear temporary storage in the resctrl code to prevent access to an
  unexistent MSR

- Add a simple throttling mechanism to protect the hypervisor from potentially
  malicious SEV guests issuing requests in rapid succession.

  In order to not jeopardize the sanity of everyone involved in
  maintaining this code, the request issuing side has received
  a cleanup, split in more or less trivial, small and digestible pieces.
  Otherwise, the code was threatening to become an unmaintainable mess.

  Therefore, that cleanup is marked indirectly also for stable so that
  there's no differences between the upstream code and the stable
  variant when it comes down to backporting more there.

----------------------------------------------------------------
Borislav Petkov (AMD) (6):
      virt/coco/sev-guest: Check SEV_SNP attribute at probe time
      virt/coco/sev-guest: Simplify extended guest request handling
      virt/coco/sev-guest: Remove the disable_vmpck label in handle_guest_request()
      virt/coco/sev-guest: Carve out the request issuing logic into a helper
      virt/coco/sev-guest: Do some code style cleanups
      virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a switch-case

Dionna Glaze (1):
      virt/coco/sev-guest: Add throttling awareness

Nikita Zhandarovich (1):
      x86/mm: Fix use of uninitialized buffer in sme_enable()

Shawn Wang (1):
      x86/resctrl: Clear staged_config[] before and after it is used

 arch/x86/include/asm/sev-common.h         |   3 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   7 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |   1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  25 +++++-
 arch/x86/kernel/sev.c                     |  26 +++---
 arch/x86/mm/mem_encrypt_identity.c        |   3 +-
 drivers/virt/coco/sev-guest/sev-guest.c   | 128 ++++++++++++++++++------------
 7 files changed, 123 insertions(+), 70 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
