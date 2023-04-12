Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89C06DEC67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDLHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:18:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC75FF1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:18:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E49D75;
        Wed, 12 Apr 2023 00:19:10 -0700 (PDT)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7E273F73F;
        Wed, 12 Apr 2023 00:18:24 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v2 0/3] cacheinfo: Correctly fallback to using clidr_el1's information
Date:   Wed, 12 Apr 2023 09:18:03 +0200
Message-Id: <20230412071809.12670-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Pierre Gondois (3):
  cacheinfo: Check sib_leaf in cache_leaves_are_shared()
  cacheinfo: Check cache properties are present in DT
  cacheinfo: Add use_arch[|_cache]_info field/function

 drivers/base/cacheinfo.c  | 48 +++++++++++++++++++++++++++++++++++----
 include/linux/cacheinfo.h | 11 +++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.25.1

