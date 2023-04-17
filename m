Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B16E4FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDQSP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjDQSPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:15:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5910110D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:15:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8083F4B3;
        Mon, 17 Apr 2023 11:16:35 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD3BA3F5A1;
        Mon, 17 Apr 2023 11:15:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org, Radu Rendec <rrendec@redhat.com>
Subject: [GIT PULL] cacheinfo/arch_topology: Updates for v6.4
Date:   Mon, 17 Apr 2023 19:15:40 +0100
Message-Id: <20230417181540.1926349-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Couple of the patches are fixes but I wanted them to be in the next for some
time to get better testing. Few others are addressing issues in RT kernel.

Please pull !

Regards,
Sudeep

-->8

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/cacheinfo-updates-6.4

for you to fetch changes up to ef9f643a9f8b62bcbcc51f0e0af8599adc2e17ed:

  cacheinfo: Add use_arch[|_cache]_info field/function (2023-04-14 10:13:39 +0100)

----------------------------------------------------------------
cacheinfo and arch_topology updates for v6.4

The cache information can be extracted from either a Device Tree(DT),
the PPTT ACPI table, or arch registers (clidr_el1 for arm64).

When the DT is used but no cache properties are advertised, the current
code doesn't correctly fallback to using arch information. The changes
fixes the same and also assuse the that L1 data/instruction caches
are private and L2/higher caches are shared when the cache information
is missing in DT/ACPI and is derived form clidr_el1/arch registers.

Currently the cacheinfo is built from the primary CPU prior to secondary
CPUs boot, if the DT/ACPI description contains cache information.
However, if not present, it still reverts to the old behavior, which
allocates the cacheinfo memory on each secondary CPUs which causes
RT kernels to triggers a "BUG: sleeping function called from invalid
context".

The changes here attempts to enable automatic detection for RT kernels
when no DT/ACPI cache information is available, by pre-allocating
cacheinfo memory on the primary CPU.

----------------------------------------------------------------
Pierre Gondois (4):
      cacheinfo: Check sib_leaf in cache_leaves_are_shared()
      cacheinfo: Check cache properties are present in DT
      arch_topology: Remove early cacheinfo error message if -ENOENT
      cacheinfo: Add use_arch[|_cache]_info field/function

Radu Rendec (3):
      cacheinfo: Add arch specific early level initializer
      cacheinfo: Add arm64 early level initializer implementation
      cacheinfo: Allow early level detection when DT/ACPI info is missing/broken

 arch/arm64/kernel/cacheinfo.c |  25 ++++++++-
 drivers/base/arch_topology.c  |  11 ++--
 drivers/base/cacheinfo.c      | 124 +++++++++++++++++++++++++++++++++---------
 include/linux/cacheinfo.h     |   8 +++
 4 files changed, 133 insertions(+), 35 deletions(-)
