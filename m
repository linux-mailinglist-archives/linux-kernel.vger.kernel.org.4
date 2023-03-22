Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766DE6C44AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCVIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCVIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6604057D03;
        Wed, 22 Mar 2023 01:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC1EE61ED0;
        Wed, 22 Mar 2023 08:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E366C433EF;
        Wed, 22 Mar 2023 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679472934;
        bh=8aB9JsR4x+4YOZELTOL8u+ID1lYD3Uivc3LtlNrOVcM=;
        h=From:To:Cc:Subject:Date:From;
        b=XYRff+A6NWpR1LCJrBdkefih2ejzbGyzba+yQU5u7itfVPhq3JWXY+knlS41jJJ+B
         8mjAgYA5TKDAxqukGBvSSSLfpkXsH127m42apyHEhbOQFXCH+rmfTxUG8l3FeEglzL
         Ure0yYnCOS3do8GPI/iyR5VCDazFc16VpprhLWljKe25WnDtsdB5vQJf9AAbPIPqdc
         Q8BpVGWHIuce5YuZtgPoXRKGrEeyt2H7ivwZ4KtBCvHGYiPZkxacJiL8YAzFGWihxy
         +F6uqz1CNJqH7Of3g8U0ygKJh6NbfuppbsRvzyEXcQ5OcPylo5xlJAADeDISVlLPcj
         8H65ie1J0FDSw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Subject: [PATCH] mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date:   Wed, 22 Mar 2023 10:15:20 +0200
Message-Id: <20230322081520.2516226-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

MIPS defines insane ranges for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
up to 63, which implies maximal contiguous allocation size of 2^63
pages.

Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible defaults.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/mips/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3e8b765b8c7b..a0f6e9d0a561 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2137,13 +2137,9 @@ endchoice
 
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 13 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
 	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
-	range 12 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
 	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
-	range 11 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
 	default "11" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
-	range 0 63
 	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.35.1

