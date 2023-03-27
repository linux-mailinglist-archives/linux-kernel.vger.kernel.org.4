Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF216CA2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjC0MAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjC0MAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:00:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB2D1BE2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:00:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1154D4B3;
        Mon, 27 Mar 2023 05:01:03 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.19.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5897D3F663;
        Mon, 27 Mar 2023 05:00:16 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] cacheinfo: Correctly fallback to using clidr_el1's information
Date:   Mon, 27 Mar 2023 13:59:48 +0200
Message-Id: <20230327115953.788244-1-pierre.gondois@arm.com>
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

 arch/arm64/kernel/cacheinfo.c |  5 ++++
 drivers/base/cacheinfo.c      | 53 ++++++++++++++++++++++++++++++++---
 include/linux/cacheinfo.h     |  2 ++
 3 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.25.1

