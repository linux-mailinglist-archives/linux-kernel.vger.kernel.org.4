Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECD6C6363
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCWJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCWJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:24:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FDA3C3B;
        Thu, 23 Mar 2023 02:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB204B82025;
        Thu, 23 Mar 2023 09:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6048AC4339E;
        Thu, 23 Mar 2023 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563394;
        bh=jzZSH15gj6TUOIsTCrO5L+I5me/Mb74Nnyc5QzApf2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opvYt+M6nVWy83Z/VnNrEAxA7GcoGHzEz8QYyBOSThR1uJN44T0NbsszAVqRkmb9A
         SFPedINEgAbnyJ/AKydoamZjo3WlyOV/lqEJmXHsxX31FbqFPcrUSqmaQWw7/Lavv0
         pPumm6jkzkBxu2g5cEsCaVlcJS4bENKkkFc8Cz2Wz6eQKaxqTYIhIRxBQoMF2g89v5
         DZ2t+8xW5kCcFwoLehAHXimJZXVI3kEvMEYcvGsn+KOl1TSwgvlKsnJ9ypkWw+7GOc
         VfD+ftLkOkIQYp64EjA4dBOMp2fQX797VTwRK697fAL4dXiohtz60VzvDWHmWbnAxZ
         3F3FrUCphxRGg==
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
Subject: [PATCH 08/14] nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date:   Thu, 23 Mar 2023 11:21:50 +0200
Message-Id: <20230323092156.2545741-9-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230323092156.2545741-1-rppt@kernel.org>
References: <20230323092156.2545741-1-rppt@kernel.org>
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

nios2 defines range for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
up to 19, which implies maximal contiguous allocation size of 2^19
pages or 2GiB.

Drop bogus definition of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible default.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/nios2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index fcaa6bbda3fc..e5936417d3cd 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -46,7 +46,6 @@ source "kernel/Kconfig.hz"
 
 config ARCH_FORCE_MAX_ORDER
 	int "Order of maximal physically contiguous allocations"
-	range 8 19
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-- 
2.35.1

