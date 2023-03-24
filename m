Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175A6C7713
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCXFXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCXFXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64281A65E;
        Thu, 23 Mar 2023 22:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B346295B;
        Fri, 24 Mar 2023 05:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF65CC433EF;
        Fri, 24 Mar 2023 05:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679635400;
        bh=LeuV23DH0esmotNA2QlUjum35xKgU+8zbcmhGeC5TeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mrbi/dJOtzaHgUiVL6QgdFc+kWlVrRKxGkCrNKJ0d1YIPw/3/evFLS/HHQ3psMOAH
         g1W3YYeg3M8dZx/uIirKdmBNpJT/KKM40fWcK1ZgrnOjerfxRIfSD9MYqUVGMg99pT
         ZJLSaBF4mwowIdE+5Dax3W0pqpyOqiGomjRLmihUtgrfpg0guPJO4WOUpiTQBwKCDU
         a0AM0PtMtMYiyp6e298B4MR0/VCNihR56/I+CKVI7d3wK3rIuc8en7Uz8PegvCRN5d
         kwj//m/F+5wNDBtWdUtQuBkSPTMzlj5xAG91xj//nXn+uGHI2yM594pHZAftDp2s0N
         hyaYR2lpyMSgg==
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
Subject: [PATCH v2 04/14] csky: drop ARCH_FORCE_MAX_ORDER
Date:   Fri, 24 Mar 2023 08:22:23 +0300
Message-Id: <20230324052233.2654090-5-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230324052233.2654090-1-rppt@kernel.org>
References: <20230324052233.2654090-1-rppt@kernel.org>
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

The default value of ARCH_FORCE_MAX_ORDER matches the generic default
defined in the MM code, the architecture does not support huge pages, so
there is no need to keep ARCH_FORCE_MAX_ORDER option available.

Drop it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/csky/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c694fac43bed..00379a843c37 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -332,10 +332,6 @@ config HIGHMEM
 	select KMAP_LOCAL
 	default y
 
-config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order"
-	default "10"
-
 config DRAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
 	default 0x0
-- 
2.35.1

