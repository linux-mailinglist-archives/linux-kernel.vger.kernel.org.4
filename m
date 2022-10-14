Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89C5FF53E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJNVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:22:58 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AE1D375E;
        Fri, 14 Oct 2022 14:22:50 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 15 Oct
 2022 00:22:41 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <openrisc@lists.librecores.org>,
        <sparclinux@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <lvc-patches@linuxtesting.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 00/13] Make user_regset_copyin_ignore() *void*
Date:   Sat, 15 Oct 2022 00:22:22 +0300
Message-ID: <20221014212235.10770-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.75.138]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/14/2022 21:00:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 173137 [Oct 14 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 500 500 6cc86d8f5638d79810308830d98d6b6279998c49
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/14/2022 21:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/14/2022 3:23:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 13 patches against the 'next-20221014' tag of the 'linux-next.git'
repo.  I'm not sure how this cross-arch series should be merged -- perhaps
thru Andrew Morton's tree?

user_regset_copyin_ignore() apparently cannot fail and so always returns 0.
Let's first remove the result checks in several architectures that call this
function and then make user_regset_copyin_ignore() return *void* instead of
*int*...

Sergey Shtylyov (13):
  arc: ptrace: user_regset_copyin_ignore() always returns 0
  arm: ptrace: user_regset_copyin_ignore() always returns 0
  arm64: ptrace: user_regset_copyin_ignore() always returns 0
  hexagon: ptrace: user_regset_copyin_ignore() always returns 0
  ia64: ptrace: user_regset_copyin_ignore() always returns 0
  mips: ptrace: user_regset_copyin_ignore() always returns 0
  nios2: ptrace: user_regset_copyin_ignore() always returns 0
  openrisc: ptrace: user_regset_copyin_ignore() always returns 0
  parisc: ptrace: user_regset_copyin_ignore() always returns 0
  powerpc: ptrace: user_regset_copyin_ignore() always returns 0
  sh: ptrace: user_regset_copyin_ignore() always returns 0
  sparc: ptrace: user_regset_copyin_ignore() always returns 0
  regset: make user_regset_copyin_ignore() *void*

 arch/arc/kernel/ptrace.c                 |  2 +-
 arch/arm/kernel/ptrace.c                 |  8 +++-----
 arch/arm64/kernel/ptrace.c               | 16 ++++------------
 arch/hexagon/kernel/ptrace.c             |  7 +++----
 arch/ia64/kernel/ptrace.c                | 20 +++++++++-----------
 arch/mips/kernel/ptrace.c                |  9 +++++----
 arch/nios2/kernel/ptrace.c               |  6 +++---
 arch/openrisc/kernel/ptrace.c            |  8 +++-----
 arch/parisc/kernel/ptrace.c              | 15 +++++++++------
 arch/powerpc/kernel/ptrace/ptrace-tm.c   | 10 +++++-----
 arch/powerpc/kernel/ptrace/ptrace-view.c | 10 +++++-----
 arch/sh/kernel/ptrace_32.c               |  8 ++++----
 arch/sparc/kernel/ptrace_32.c            |  9 +++++----
 arch/sparc/kernel/ptrace_64.c            | 23 +++++++++++------------
 include/linux/regset.h                   | 15 +++++++--------
 15 files changed, 77 insertions(+), 89 deletions(-)

-- 
2.26.3

