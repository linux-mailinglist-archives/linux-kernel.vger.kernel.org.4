Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863C5F3DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJDIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDILi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D14F1A9;
        Tue,  4 Oct 2022 01:10:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B8D4219BF;
        Tue,  4 Oct 2022 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8+qYaAMEoPETRr5UAyzz/JjfFWwyODNuWxyPFnBC0Ug=;
        b=CJt7el3Zwv+Y0dhdPJuvZguCa1aPwOlAyfaNkxTbCYua5wduQLcN9twvuiQAQUbMLgmit5
        lYPYZm75lqHBC3sPUf6/DRyg+YZpduohgmSLm1zwLS4Fj/UnM6Rdi3kZ7vAk0JYe4befIe
        tcTdogEDt36xCj6f5IX8Vu2jy/48Np8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6CC313AB3;
        Tue,  4 Oct 2022 08:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oWzzKnLqO2MYSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:10:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 00/16] x86: make pat and mtrr independent from each other
Date:   Tue,  4 Oct 2022 10:10:07 +0200
Message-Id: <20221004081023.32402-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today PAT can't be used without MTRR being available, unless MTRR is at
least configured via CONFIG_MTRR and the system is running as Xen PV
guest. In this case PAT is automatically available via the hypervisor,
but the PAT MSR can't be modified by the kernel and MTRR is disabled.

The same applies to a kernel built with no MTRR support: it won't
allow to use the PAT MSR, even if there is no technical reason for
that, other than setting up PAT on all cpus the same way (which is a
requirement of the processor's cache management) is relying on some
MTRR specific code.

Fix all of that by:

- moving the function needed by PAT from MTRR specific code one level
  up
- reworking the init sequences of MTRR and PAT to be more similar to
  each other without calling PAT from MTRR code
- removing the dependency of PAT on MTRR

While working on that I discovered two minor bugs in MTRR code, which
are fixed, too.

There is some more cleanup done reducing code size.

Changes in V4:
- new patches 10, 14, 15, 16
- split up old patch 4 into 3 patches
- addressed comments

Changes in V3:
- replace patch 1 by just adding a comment

Changes in V2:
- complete rework of the patches based on comments by Boris Petkov
- added several patches to the series

Juergen Gross (16):
  x86/mtrr: add comment for set_mtrr_state() serialization
  x86/mtrr: remove unused cyrix_set_all() function
  x86/mtrr: replace use_intel() with a local flag
  x86/mtrr: rename prepare_set() and post_set()
  x86/mtrr: split MTRR specific handling from cache dis/enabling
  x86: move some code out of arch/x86/kernel/cpu/mtrr
  x86/mtrr: split generic_set_all()
  x86/mtrr: remove set_all callback from struct mtrr_ops
  x86/mtrr: simplify mtrr_bp_init()
  x86/mtrr: get rid of mtrr_enabled bool
  x86/mtrr: let cache_aps_delayed_init replace mtrr_aps_delayed_init
  x86/mtrr: add a stop_machine() handler calling only cache_cpu_init()
  x86: decouple pat and mtrr handling
  x86: switch cache_ap_init() to hotplug callback
  x86: do MTRR/PAT setup on all secondary CPUs in parallel
  x86/mtrr: simplify mtrr_ops initialization

 arch/x86/include/asm/cacheinfo.h   |  18 +++
 arch/x86/include/asm/memtype.h     |   5 +-
 arch/x86/include/asm/mtrr.h        |  13 +-
 arch/x86/kernel/cpu/cacheinfo.c    | 168 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c       |   2 +-
 arch/x86/kernel/cpu/mtrr/amd.c     |   8 +-
 arch/x86/kernel/cpu/mtrr/centaur.c |   8 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c   |  42 +------
 arch/x86/kernel/cpu/mtrr/generic.c | 127 +++-----------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 185 ++++-------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  20 ++--
 arch/x86/kernel/setup.c            |  14 +--
 arch/x86/kernel/smpboot.c          |   9 +-
 arch/x86/mm/pat/memtype.c          | 127 ++++++--------------
 arch/x86/power/cpu.c               |   3 +-
 include/linux/cpuhotplug.h         |   1 +
 16 files changed, 298 insertions(+), 452 deletions(-)

-- 
2.35.3

