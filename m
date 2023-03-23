Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7A6C5F44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCWGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:01:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BEAD1040F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:01:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A474B3;
        Wed, 22 Mar 2023 23:02:18 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 091523F67D;
        Wed, 22 Mar 2023 23:01:31 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH V2 0/3] selftests/mm: Fix virtual address range for
Date:   Thu, 23 Mar 2023 11:31:18 +0530
Message-Id: <20230323060121.1175830-1-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the virtual address range selftest is run on arm64 and x86 platforms,
it is observed that both the low and high VA range iterations are skipped
when the MAP_CHUNK_SIZE is set to 16GB. The MAP_CHUNK_SIZE is changed to
1GB to resolve this issue, following which support for arm64 platform is
added by changing the NR_CHUNKS_HIGH for aarch64 to accommodate up to 4PB
of virtual address space allocation requests. Dynamic memory allocation
of array holding addresses is introduced to prevent overflow of the stack.
Finally, the overcommit_policy is set as OVERCOMMIT_ALWAYS to prevent the
kernel from denying a memory allocation request based on a platform's
physical memory availability.

This series has been tested on 6.3.0-rc1 mainline kernel, both on arm64
and x86 platforms.

Changes in V2:

- Changed subject line to start with "selftest/mm", to maintain
  specificity.

Changes in V1:

https://lore.kernel.org/all/20230314042351.13134-1-chaitanyas.prakash@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org> 
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
 
Chaitanya S Prakash (3):
  selftests/mm: Change MAP_CHUNK_SIZE
  selftests/mm: Change NR_CHUNKS_HIGH for aarch64
  selftests/mm: Set overcommit_policy as OVERCOMMIT_ALWAYS

 tools/testing/selftests/mm/run_vmtests.sh     |  8 +++++++
 .../selftests/mm/virtual_address_range.c      | 24 +++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.30.2

