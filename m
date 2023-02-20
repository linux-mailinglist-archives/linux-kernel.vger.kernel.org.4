Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C765D69D112
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjBTQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjBTQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:06:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76341E9D0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:06:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A43E61EC04DA;
        Mon, 20 Feb 2023 17:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676909185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/8phSmJ+zfHQ4P4WcehWrw04sHB2nwS3D9rezDdWpnk=;
        b=SuW1XJUQS0O5FMcdCQZIJPH1YxTmGmZOmjOgUBmW9cebRbIrtuLuREcAKHaPliOIU27ccB
        ZVFf1gpKPvAvyIyXN9x8GqSCiK+JZcz6+RlHtQh3ANcMOWMCQwHcBb5ktTL5ALhUvpBD4Y
        2OK8zTi1Z0/jw/Am64EX8HLWnsB5UxU=
Date:   Mon, 20 Feb 2023 17:06:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.3-rc1
Message-ID: <Y/OafaXrqkAhaurS@zn.tnic>
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

please pull the new pile of x86 resource control updates for 6.3.

Thx.

---

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.3_rc1

for you to fetch changes up to 793207bad71c5339c614d12ac21d627da7bf771d:

  x86/resctrl: Fix a silly -Wunused-but-set-variable warning (2023-01-26 11:15:20 +0100)

----------------------------------------------------------------
- Add support for a new AMD feature called slow memory bandwidth
allocation.  Its goal is to control resource allocation in external slow
memory which is connected to the machine like for example through CXL devices,
accelerators etc

----------------------------------------------------------------
Babu Moger (13):
      x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
      x86/resctrl: Include new features in command line options
      x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation
      x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()
      x86/resctrl: Support monitor configuration
      x86/resctrl: Add interface to read mbm_total_bytes_config
      x86/resctrl: Add interface to read mbm_local_bytes_config
      x86/resctrl: Add interface to write mbm_total_bytes_config
      x86/resctrl: Add interface to write mbm_local_bytes_config
      Documentation/x86: Update resctrl.rst for new features

Borislav Petkov (AMD) (1):
      x86/resctrl: Fix a silly -Wunused-but-set-variable warning

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 Documentation/x86/resctrl.rst                   | 147 +++++++++++-
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/msr-index.h                |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c                |   2 +
 arch/x86/kernel/cpu/resctrl/core.c              |  54 ++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c       |  13 +-
 arch/x86/kernel/cpu/resctrl/internal.h          |  28 +++
 arch/x86/kernel/cpu/resctrl/monitor.c           |  30 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c          | 307 ++++++++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c                 |   2 +
 include/linux/resctrl.h                         |  11 +
 12 files changed, 559 insertions(+), 41 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
