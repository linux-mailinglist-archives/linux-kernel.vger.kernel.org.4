Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90F634F66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiKWFNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiKWFNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:13:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 904DF8F3E4;
        Tue, 22 Nov 2022 21:13:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF33F1FB;
        Tue, 22 Nov 2022 21:13:37 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 737CC3F73B;
        Tue, 22 Nov 2022 21:13:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] documentation/mm: Update pmd_present() in arch_pgtable_helpers.rst
Date:   Wed, 23 Nov 2022 10:43:19 +0530
Message-Id: <20221123051319.1312582-1-anshuman.khandual@arm.com>
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

Although pmd_present() might seem to indicate a valid and mapped pmd entry,
in reality it returns true when pmd_page() points to a valid page in memory
, regardless whether the pmd entry is mapped or not. Andrea Arcangeli had
earlier explained [1] the required semantics for pmd_present(). This just
updates the documentation for pmd_present() as required.

[1] https://lore.kernel.org/lkml/20181017020930.GN30832@redhat.com/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6

The latest trigger was from an earlier discussion here.

https://lore.kernel.org/all/53c0c955-7afe-905b-468a-cd7ac81238c5@arm.com/

 Documentation/mm/arch_pgtable_helpers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index cbaee9e59241..fd2a19df884e 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -94,7 +94,7 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
 +---------------------------+--------------------------------------------------+
-| pmd_present               | Tests a valid mapped PMD                         |
+| pmd_present               | Tests whether pmd_page() points to valid memory  |
 +---------------------------+--------------------------------------------------+
 | pmd_young                 | Tests a young PMD                                |
 +---------------------------+--------------------------------------------------+
-- 
2.25.1

