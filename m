Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBB6B9210
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCNLum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCNLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:50:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEFFF1814B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:50:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293AA4B3;
        Tue, 14 Mar 2023 04:51:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D30C3F67D;
        Tue, 14 Mar 2023 04:50:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com
Subject: [PATCH 0/4] usercopy: generic tests + arm64 fixes
Date:   Tue, 14 Mar 2023 11:50:26 +0000
Message-Id: <20230314115030.347976-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds tests for the usercopy functions, and fixes some
deficiencies on arm64.

This is a follow-up to Robin's earlier usercopy refresh [1], where we
found some issues and Will had asked for tests. In the process of
writing tests, I discovered arm64 had some latent issues, and running
the tests on other architectures, it looks like most have issues...

Al, I'd appreciate if you could take a look at the first couple of
patches and check if I've got the intended semantics correct. I think
I've got that right for __raw_copy_{to,from}_user(), but I'm not sure
whether clear_user() is expected to behave the same, and I may have
missed something or assumed something overly strong.

Catalin, Will, the last two patches fix arm64's implementation of
__raw_copy_to_user() and clear_user(), per the understanding above. I
believe these are correct (as they've passed exhaustive testing), and
benchmarking shows they're at least as good as the current
implementations. 

Thanks,
Mark.

[1] https://lore.kernel.org/linux-arm-kernel/cover.1664363162.git.robin.murphy@arm.com/

Mark Rutland (4):
  lib: test copy_{to,from}_user()
  lib: test clear_user()
  arm64: fix __raw_copy_to_user semantics
  arm64: fix clear_user() semantics

 arch/arm64/lib/clear_user.S   | 195 ++++++++++---
 arch/arm64/lib/copy_to_user.S | 203 ++++++++++---
 lib/Kconfig.debug             |   9 +
 lib/Makefile                  |   1 +
 lib/usercopy_kunit.c          | 520 ++++++++++++++++++++++++++++++++++
 5 files changed, 848 insertions(+), 80 deletions(-)
 create mode 100644 lib/usercopy_kunit.c

-- 
2.30.2

