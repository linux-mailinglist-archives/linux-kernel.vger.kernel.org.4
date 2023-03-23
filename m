Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC56C6335
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCWJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjCWJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF71F4BE;
        Thu, 23 Mar 2023 02:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02287B8201C;
        Thu, 23 Mar 2023 09:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3258C433AA;
        Thu, 23 Mar 2023 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563348;
        bh=1wuMjPglrXxylZYRQp9g6PBGTaQCsIyJmL4MjyDfkT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZZcT6du5dwua6qJE5uCEiu3Bbh3Q97TquC+/sYNXkmdypc+bsLGDW93XoYEnZ4mH
         MSoFTjH6bKTl3fsgQ4Bc3SK5VaWp9pBpu5SvZo1sRyf7bml4ql3CzkUro6OsghW0vc
         Oy90Vtp+PuM+H/Fs7+pOeFq6VXb7ExvoCICIAZhSBN3LP0NP130lo2YGBKKTONyDoH
         O4a++hJhMH5PNPPUpgd9/coAlzQjl3AYohwmcVJY6mAnGbnI5g5nhBGeR+cfm7Ukr1
         7eEmM1z6tUZiEn08emyl+wuY10m5eYRrfMvZd2JFyNi2MsejH2NoIL8GFXLAlQ90D9
         npeRgo88+OTgg==
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
Subject: [PATCH 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
Date:   Thu, 23 Mar 2023 11:21:44 +0200
Message-Id: <20230323092156.2545741-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230323092156.2545741-1-rppt@kernel.org>
References: <20230323092156.2545741-1-rppt@kernel.org>
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

It is not a good idea to change fundamental parameters of core memory
management. Having predefined ranges suggests that the values within
those ranges are sensible, but one has to *really* understand
implications of changing MAX_ORDER before actually amending it and
ranges don't help here.

Drop ranges in definition of ARCH_FORCE_MAX_ORDER

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e60baf7859d1..bab6483e4317 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1489,9 +1489,7 @@ config XEN
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
 	default "13" if ARM64_64K_PAGES
-	range 11 13 if ARM64_16K_PAGES
 	default "11" if ARM64_16K_PAGES
-	range 10 15 if ARM64_4K_PAGES
 	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.35.1

