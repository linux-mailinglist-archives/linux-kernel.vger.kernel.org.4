Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1E6E1DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDNIPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDNIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:15:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 509AF30EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:15:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B00B2F4;
        Fri, 14 Apr 2023 01:16:06 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.19.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B9553F6C4;
        Fri, 14 Apr 2023 01:15:17 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v4 0/4] cacheinfo: Correctly fallback to using clidr_el1's information
Date:   Fri, 14 Apr 2023 10:14:48 +0200
Message-Id: <20230414081453.244787-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
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

v4:
arch_topology: Remove early cacheinfo error message:
- Only remove the error message if the error code is -ENOENT
cacheinfo: Add use_arch[|_cache]_info field/function:
- Use a static variable instead of a per-leaf 'use_arch_info'
- Reformat the use_arch_cache_info() define

v3:
cacheinfo: Check sib_leaf in cache_leaves_are_shared():
- Reformulate commit message
- Fix rebase issue and move '&&' condition which was in the last patch
  to this patch.
cacheinfo: Add use_arch[|_cache]_info field/function:
- Put the function declaration in one line.
arch_topology: Remove early cacheinfo error message:
- New patch.

v2:
cacheinfo: Check sib_leaf in cache_leaves_are_shared()
- Reformulate commit message
- Add 'Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers [...]'
cacheinfo: Check cache properties are present in DT
- Use of_property_present()
- Add 'Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>'
cacheinfo: Add use_arch[|_cache]_info field/function:
- Make use_arch_cache_info() a static inline function

The cache information can be extracted from either a Device
Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
for arm64).

When the DT is used but no cache properties are advertised,
the current code doesn't correctly fallback to using arch information.

Correct this. Also use the assumption that L1 data/instruction caches
are private and L2/higher caches are shared when the cache information
is coming form clidr_el1.

As suggested by Alexandre, this serie should ideally go to 6.3 fixes.

Pierre Gondois (4):
  cacheinfo: Check sib_leaf in cache_leaves_are_shared()
  cacheinfo: Check cache properties are present in DT
  arch_topology: Remove early cacheinfo error message if -ENOENT
  cacheinfo: Add use_arch[|_cache]_info field/function

 drivers/base/arch_topology.c |  7 +++---
 drivers/base/cacheinfo.c     | 49 ++++++++++++++++++++++++++++++++----
 include/linux/cacheinfo.h    |  6 +++++
 3 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.25.1

