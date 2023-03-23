Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057366C637A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCWJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCWJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87340227A0;
        Thu, 23 Mar 2023 02:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E24B8202F;
        Thu, 23 Mar 2023 09:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD746C4339C;
        Thu, 23 Mar 2023 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563424;
        bh=99+9gRXuNZGZrnvJd+Y1nZy5usyv3NMBBGlXNWMVJhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSSowVKku6I+4khALqKcaWeFjf1TxQwq6N17YCC7lSQQq1PMKZNZXR6Amg8KHBCln
         8D1+czeovKFYgk9ba7AwrEOWdx4T4TvSidUG4w0oEnP7Ux2idkiveTG5RuhNH001uj
         ZH2wbqVR6pwA72IlRr0A0Vm+Px75ZhuzsapmFJ4MJUx20c6j0uj+d4nkaYltR2HdGP
         LBmRDMYlYeROh4iX+5zaZEFyfMPZyDOym4GBzHOPHNe4Rg7MF0KLgYOBU/kY0U7tEp
         2qhz4vjT8nOntJZetWtWrbF6J0wrO+fnxdSyIdjlEGw6E/HBeJt9B+RUXXoHM7dYWp
         7S274GLZIA5Jg==
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
Subject: [PATCH 12/14] sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date:   Thu, 23 Mar 2023 11:21:54 +0200
Message-Id: <20230323092156.2545741-13-rppt@kernel.org>
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

sh defines insane ranges for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
up to 63, which implies maximal contiguous allocation size of 2^63
pages.

Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible defaults.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/mm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index fb15ba1052ba..511c17aede4a 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -21,9 +21,7 @@ config PAGE_OFFSET
 config ARCH_FORCE_MAX_ORDER
 	int "Order of maximal physically contiguous allocations"
 	default "8" if PAGE_SIZE_16KB
-	range 6 63 if PAGE_SIZE_64KB
 	default "6" if PAGE_SIZE_64KB
-	range 10 63
 	default "13" if !MMU
 	default "10"
 	help
-- 
2.35.1

