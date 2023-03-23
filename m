Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B076C634B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCWJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjCWJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65BB20D22;
        Thu, 23 Mar 2023 02:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A3A3B82021;
        Thu, 23 Mar 2023 09:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E437BC433B0;
        Thu, 23 Mar 2023 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563363;
        bh=VIGq21IucJ5jyDrKWO8wDSFXKn1G4gpham/RhLaDiSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfDyZKg6ubB3qVtTlpxKobEqRtwno61zPFlP3g3EIvlplSklLsZdZgd8QI++nKp4n
         qq2mJOxPwHzVhgTFzEAiFOfx+KPDLDwoJMzXey52ho+6XByzyjn3T3ZCKD4VZYT3kU
         cESe0WRXj+emYBHu833Ie/zYH4UBgDHJ3GJ5ePxM/uO1muD+DtVkdjQAf9ziZXzj+H
         4+VX6vYZgHgBasWaay2Yvm3hUg76YEqRuvUFK4EUvPHEx5XhVCKEKGRBPfWgR5WtWO
         dU4L0e/mgCXn8RbvJfFELuUfLqP+eE794rhQOoRiuNs4FEE1ZnaNqR/QYUnj3nqRee
         MRKQtDiPgSwZg==
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
Subject: [PATCH 04/14] csky: drop ARCH_FORCE_MAX_ORDER
Date:   Thu, 23 Mar 2023 11:21:46 +0200
Message-Id: <20230323092156.2545741-5-rppt@kernel.org>
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

The default value of ARCH_FORCE_MAX_ORDER matches the generic default
defined in the MM code, the architecture does not support huge pages, so
there is no need to keep ARCH_FORCE_MAX_ORDER option available.

Drop it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
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

