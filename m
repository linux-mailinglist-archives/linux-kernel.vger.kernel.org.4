Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2072646E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbjFGP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjFGP0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:26:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7892699;
        Wed,  7 Jun 2023 08:25:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 764C421A0A;
        Wed,  7 Jun 2023 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686151501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3dXGf7k+4oTYlBaWumJNU4jR3nmmEHJWtnu0vSLVKpY=;
        b=B+PBZJXThYIOntzOMYJN1M7HOWKlcyfHTjqwYAzKeYBeg7N4H53o02U8FpcHbdfxQS/12F
        pD2SxjHz7edW0+GtChSdSrs+u54G5UDKluEkn024K10JO0UxcGtR6rRHIiyWQ7rmD6W5Wk
        GvOPqUkg6P2Kqu+RevoP90n3lOrnJZQ=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 6C3A12C141;
        Wed,  7 Jun 2023 15:24:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/7] watchdog/hardlockup: Cleanup configuration of hardlockup detectors
Date:   Wed,  7 Jun 2023 17:24:25 +0200
Message-Id: <20230607152432.5435-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset is supposed to replace the last patch in the patchset cleaning
up after introducing the buddy detector, see
https://lore.kernel.org/r/20230526184139.10.I821fe7609e57608913fe05abd8f35b343e7a9aae@changeid

There are four possible variants of hardlockup detectors:

  + buddy: available when SMP is set.

  + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.

  + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.

  + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
	and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.

Only one hardlockup detector can be compiled in. The selection is done
using quite complex dependencies between several CONFIG variables.
The following patches will try to make it more straightforward.

Before, the decision was done using the following variables:

	+ HAVE_HARDLOCKUP_DETECTOR_PERF
	+ HAVE_HARDLOCKUP_DETECTOR_BUDDY
	+ HAVE_HARDLOCKUP_DETECTOR_ARCH
	+ HAVE_NMI_WATCHDOG
 
	+ HARDLOCKUP_DETECTOR
	+ HARDLOCKUP_DETECTOR_PREFER_BUDDY

	+ HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
	+ HARDLOCKUP_DETECTOR_NON_ARCH

	+ HARDLOCKUP_DETECTOR_PERF
	+ HARDLOCKUP_DETECTOR_BUDDY

   and the particular watchdog was used when the following variables were set:

	+ perf:		 HARDLOCKUP_DETECTOR_PERF
	+ buddy:	 HARDLOCKUP_DETECTOR_BUDDY
	+ arch-specific: HAVE_HARDLOCKUP_DETECTOR_ARCH
	+ sparc64:	 HAVE_NMI_WATCHDOG && !HAVE_HARDLOCKUP_DETECTOR_ARCH


After, the decision is done using the following variables:

	+ HAVE_HARDLOCKUP_DETECTOR_PERF
	+ HAVE_HARDLOCKUP_DETECTOR_BUDDY
	+ HAVE_HARDLOCKUP_DETECTOR_ARCH
	+ HAVE_HARDLOCKUP_DETECTOR_SPARC64
 
	+ HARDLOCKUP_DETECTOR
	+ HARDLOCKUP_DETECTOR_PREFER_BUDDY

	+ HARDLOCKUP_DETECTOR_PERF
	+ HARDLOCKUP_DETECTOR_BUDDY
	+ HARDLOCKUP_DETECTOR_ARCH
	+ HARDLOCKUP_DETECTOR_SPARC64

   and the particular watchdog is used when one of these variables is set:

	+ perf:		 HARDLOCKUP_DETECTOR_PERF
	+ buddy:	 HARDLOCKUP_DETECTOR_BUDDY
	+ arch-specific: HARDLOCKUP_DETECTOR_ARCH
	+ sparc64:	 HARDLOCKUP_DETECTOR_SPARC64


Plus, many checks are more straightforward and even self-explanatory.

I build and run tested it on x86_64. I only checked the generated
.config after using sparc_defconfig, sparc64_defconfig, ppc64_defconfig,
and ppc40x_defconfig.

Best Regards,
Petr

Petr Mladek (7):
  watchdog/hardlockup: Sort hardlockup detector related config values a
    logical way
  watchdog/hardlockup: Make the config checks more straightforward
  watchdog/hardlockup: Declare arch_touch_nmi_watchdog() only in
    linux/nmi.h
  watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only on sparc64
  watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to
    HAVE_HARDLOCKUP_WATCHDOG_SPARC64
  watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
  watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH

 arch/Kconfig                   |  17 ++---
 arch/powerpc/Kconfig           |   5 +-
 arch/powerpc/include/asm/nmi.h |   2 -
 arch/sparc/Kconfig             |   2 +-
 arch/sparc/Kconfig.debug       |  20 ++++++
 arch/sparc/include/asm/nmi.h   |   1 -
 include/linux/nmi.h            |  14 ++--
 kernel/watchdog.c              |   2 +-
 lib/Kconfig.debug              | 115 +++++++++++++++++++--------------
 9 files changed, 104 insertions(+), 74 deletions(-)

-- 
2.35.3

