Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1226C634C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCWJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjCWJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7A21A01;
        Thu, 23 Mar 2023 02:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7FC5B8201C;
        Thu, 23 Mar 2023 09:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E1C433AE;
        Thu, 23 Mar 2023 09:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563371;
        bh=Taw/mVGmMzfFA4/zjWlz+sOR+xqfdhkwF0DQ85nhoys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRT1J299K8QpI00sxZv59CyczO6p0SWP1wcHAQk8mghcdKjhLznndromKwnUtlkrM
         SRWyev3rVk+6CoxTsdqVockaQN2ib+Nl4FHOvmR+E/SjJe1acNEz6Z4GFuyF6GLjfd
         NuLmQu+LCOGDTIOxUdJKu3y2Kol4WBMAdYu5dp+Zj49J79N9Gzs8fUFCVhMdAWtkR8
         Ee5XTvH/Aq3cY4DQROJ2COFMOABNcorPOEkkywcg034jyqoHf/3OREMiGZ7q6+/cP7
         pO8gCgPnpv6P2h41m6iFg7ve1OatfexcxvMd110cY4RS/B3xhHDbjx1NZErU4piC14
         QCF+7aV9m+NqQ==
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
Subject: [PATCH 05/14] ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
Date:   Thu, 23 Mar 2023 11:21:47 +0200
Message-Id: <20230323092156.2545741-6-rppt@kernel.org>
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

It is enough to keep default values for base and huge pages without
letting users to override ARCH_FORCE_MAX_ORDER.

Drop the prompt to make the option unvisible in *config.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/ia64/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0d2f41fa56ee..b61437cae162 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -202,8 +202,7 @@ config IA64_CYCLONE
 	  If you're unsure, answer N.
 
 config ARCH_FORCE_MAX_ORDER
-	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
-	range 10 16  if !HUGETLB_PAGE
+	int
 	default "16" if HUGETLB_PAGE
 	default "10"
 
-- 
2.35.1

