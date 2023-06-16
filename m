Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA915733433
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjFPPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjFPPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:06:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017AD1BD6;
        Fri, 16 Jun 2023 08:06:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AAD451F461;
        Fri, 16 Jun 2023 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686927997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qZ6VZQS2BN5LQfBVveeEUMRRjzGIEjqa48tMNDm1o3M=;
        b=NflyOErmcWSy+bqbtbwYQTBDVsUvpIBLG317dBlbNwgfNzOSCxizJowUuCAURsAnkD7DwK
        QoPX51bOLIvjmQTV4fFPPqGTczXM60o0DLmH1lfZlAyO1QpZtSAew7zY9nuuVJr4wdEqDU
        xURFTUWprpCM15XrbRool9W6zsGrsJ0=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 242E32C141;
        Fri, 16 Jun 2023 15:06:36 +0000 (UTC)
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
Subject: [PATCH v2 0/6] watchdog/hardlockup: Cleanup configuration of hardlockup detectors
Date:   Fri, 16 Jun 2023 17:06:12 +0200
Message-Id: <20230616150618.6073-1-pmladek@suse.com>
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

Changes against v1:

  + Better explained the C-like ordering in the 1st patch.

  + Squashed patches for splitting and renaming HAVE_NMI_WATCHDOG,
    updated commit message with the history and more facts.

  + Updated comments about the sparc64 variant. It is not handled together
    with the softlockup detector. In fact, it is always build. And it even
    used to be always enabled until the commit 7a5c8b57cec93196b ("sparc:
    implement watchdog_nmi_enable and watchdog_nmi_disable") added in
    v4.10-rc1.

    I realized this when updating the comment for the 4th patch. My original
    statement in v1 patchset was based on code reading. I looked at it from
    a bad side.

  + Removed superfluous "default n"
  + Fixed typos.

Petr Mladek (6):
  watchdog/hardlockup: Sort hardlockup detector related config values a
    logical way
  watchdog/hardlockup: Make the config checks more straightforward
  watchdog/hardlockup: Declare arch_touch_nmi_watchdog() only in
    linux/nmi.h
  watchdog/hardlockup:  Make HAVE_NMI_WATCHDOG sparc64-specific
  watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
  watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH

 arch/Kconfig                   |  17 ++---
 arch/powerpc/Kconfig           |   5 +-
 arch/powerpc/include/asm/nmi.h |   2 -
 arch/sparc/Kconfig             |   2 +-
 arch/sparc/Kconfig.debug       |  14 ++++
 arch/sparc/include/asm/nmi.h   |   1 -
 include/linux/nmi.h            |  14 ++--
 kernel/watchdog.c              |   2 +-
 lib/Kconfig.debug              | 114 ++++++++++++++++++---------------
 9 files changed, 97 insertions(+), 74 deletions(-)

-- 
2.35.3

