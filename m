Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF86C8B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYGLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCYGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:10:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB21A95B;
        Fri, 24 Mar 2023 23:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EC8DB82639;
        Sat, 25 Mar 2023 06:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2DCC433AC;
        Sat, 25 Mar 2023 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724597;
        bh=o3v/f0seGdAieP7M24caD3rUrneRSNKMDfhKZvhr+c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlZIqcoyznkL1BKobFMvbQv37dL3Y5n/pYQmixa6V5wHpLEZoZh7mKIP/w+WaDln3
         7F9U/KGc4cypsnTvMy9oSSfrgGALo8ZRsy0CCO2wxsn95KZUH66WMSYPrH+A1vRo8P
         m5DIfRaoJFsfaXsZDqqnvVk3vN8n6JycwxsVP5EnCJ1i3wogM96inqe6yhZ2OVDVv9
         F03Fni6dt1PZR+WBmmBLf0bzz/xS7McoVuWqshVPeq2wPkPrNFx8Ge1eAY26HJlYt7
         OejyqoLf5fINt0J1L8kMmt6aLbRSB4HCcXQtM1HnqsNGL1FZ8n1jBcAfRC50m+1miH
         orub55FmXGAyA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 10/14] powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date:   Sat, 25 Mar 2023 09:08:24 +0300
Message-Id: <20230325060828.2662773-11-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230325060828.2662773-1-rppt@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

PowerPC defines ranges for ARCH_FORCE_MAX_ORDER some of which are
insanely allowing MAX_ORDER up to 63, which implies maximal contiguous
allocation size of 2^63 pages.

Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible defaults.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/powerpc/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c0095bf795ca..419be4a71004 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -897,17 +897,11 @@ config DATA_SHIFT
 
 config ARCH_FORCE_MAX_ORDER
 	int "Order of maximal physically contiguous allocations"
-	range 7 8 if PPC64 && PPC_64K_PAGES
 	default "8" if PPC64 && PPC_64K_PAGES
-	range 12 12 if PPC64 && !PPC_64K_PAGES
 	default "12" if PPC64 && !PPC_64K_PAGES
-	range 8 63 if PPC32 && PPC_16K_PAGES
 	default "8" if PPC32 && PPC_16K_PAGES
-	range 6 63 if PPC32 && PPC_64K_PAGES
 	default "6" if PPC32 && PPC_64K_PAGES
-	range 4 63 if PPC32 && PPC_256K_PAGES
 	default "4" if PPC32 && PPC_256K_PAGES
-	range 10 63
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-- 
2.35.1

