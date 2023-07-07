Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054CE74AA94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGGFdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGFdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:33:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86EBA171D;
        Thu,  6 Jul 2023 22:33:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE846D75;
        Thu,  6 Jul 2023 22:34:25 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B8CE3F740;
        Thu,  6 Jul 2023 22:33:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
Date:   Fri,  7 Jul 2023 11:03:27 +0530
Message-Id: <20230707053331.510041-1-anshuman.khandual@arm.com>
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

These pte_dirty() changes make things explicitly clear, while improving the
code readability. This optimizes HW dirty state transfer into SW dirty bit.
This also adds a new arm64 documentation explaining overall pte dirty state
management in detail. This series applies on the latest mainline kernel.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

Anshuman Khandual (4):
  arm64/mm: Add SW and HW dirty state helpers
  arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state
  arm64/mm: Add pte_preserve_hw_dirty()
  docs: arm64: Add help document for pte dirty state management

 Documentation/arch/arm64/index.rst     |  1 +
 Documentation/arch/arm64/pte-dirty.rst | 95 ++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h       | 66 ++++++++++++++----
 3 files changed, 147 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/arch/arm64/pte-dirty.rst

-- 
2.30.2

