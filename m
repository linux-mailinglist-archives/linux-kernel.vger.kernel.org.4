Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397E6C8B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCYGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCYGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:09:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A502B740;
        Fri, 24 Mar 2023 23:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A5DEB826F8;
        Sat, 25 Mar 2023 06:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F625C4339B;
        Sat, 25 Mar 2023 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724540;
        bh=AZxdkgPPk5uvF+BQxbM9LjXE7h2xyoTV5CHwXU/8HBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frI6wY/7y9Ugq/kDdNPQDTAIrUL1Ibp1tX6t7Wkvuc4peDLOUS0FLn14dUsWo/UVP
         KtNbpypjIDQfLX5Sa2evDMHXVx61HvtQHFOB9PKZEAXW6tzkIYZ7paJcUl7b6QDkDd
         XhemG7a6NpMMwzsAA5r8YA40P6xhw2fdg7YT8O/KlzdC1TBydkuv+gJo7kkTOrB7+s
         enMaqi5rZNqjbwsUTqTpvzzTnA0aG8BdvkEhvLbQnSOQX291OOqIQDs7NKNHFmtArR
         Nv401z48Zg8rkh8YIDSIShaFEhib6B5rPElKdicGjHXH6RCXcm7FcU+nr/k4vFBvHI
         +2xif/sknb2gQ==
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
Subject: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
Date:   Sat, 25 Mar 2023 09:08:16 +0300
Message-Id: <20230325060828.2662773-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230325060828.2662773-1-rppt@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
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

Drop ranges in definition of ARCH_FORCE_MAX_ORDER and make its prompt
visible only if EXPERT=y

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm64/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e60baf7859d1..7324032af859 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1487,11 +1487,9 @@ config XEN
 # 16K |       27          |      14      |       13        |         11         |
 # 64K |       29          |      16      |       13        |         13         |
 config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
+	int "Maximum zone order" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
 	default "13" if ARM64_64K_PAGES
-	range 11 13 if ARM64_16K_PAGES
 	default "11" if ARM64_16K_PAGES
-	range 10 15 if ARM64_4K_PAGES
 	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.35.1

