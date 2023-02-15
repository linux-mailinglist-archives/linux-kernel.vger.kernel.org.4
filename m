Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374A7697969
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjBOKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjBOKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:00:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EC3644F;
        Wed, 15 Feb 2023 02:00:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E99261AF0;
        Wed, 15 Feb 2023 10:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FDAC4339E;
        Wed, 15 Feb 2023 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676455231;
        bh=C15uYtz4pZdXfSypYWn3wicrlV0zKFGCriKqmyfcvsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pj/xui6CUzWU2xF670+AuM84Wo7J6B4Sce6UuBljB0vgAZ6J7zp+2a/NSuZZU/lzU
         frlrrYC6O08mUltDyHRHiXBpWwHwJa3aRvFmW2EQrSB6Jo5zT+q7EWlNa9k3Em8iZP
         j7XfdJ5N+jy2XbPnfvoOpIgPCApde6qlkpbiGCq2yfmnAET9T727zUqhJAqCmEiLfJ
         C/MVn0FygjADO4xZSnZYnYAlu+y/ellpiCvEA7HoJGVZZzB6gCycwTCSMm4ibSjeSL
         KW8i7utis9sSUfgvRY/F4dhVb2A1+INFaPJveKYjJ/HFLpq/Jpwxh4CjkC7knBA6fJ
         4CYHe0VzSwjqQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH 4/5] lib/raid6: Drop IA64 support
Date:   Wed, 15 Feb 2023 11:00:07 +0100
Message-Id: <20230215100008.2565237-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=ardb@kernel.org; h=from:subject; bh=C15uYtz4pZdXfSypYWn3wicrlV0zKFGCriKqmyfcvsU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj7K0XIsw2wEC+0p8NwpSbVu7LXWTfmgjbTKlpd tgDnnQ/gCmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+ytFwAKCRDDTyI5ktmP JMbNDADISfi8KE74p1pVVWdTlIvkj6/h16W1jh300SlljLc1ODgaDGNk30blM3VZaRy09weF1m+ CQymsjDazD7fv2hALVnzgu4zJhAD3soKBEeGANspw2UlzlomLTvVnPuldNo0Gj3pZFhoY+d5vhi aOCu5bN4PpHniSNf0CAW9p9q9vF7fs86GhOxd7aoiklOBjSJAn2H+UMa7B7ZtD0rqsFGj/I0zXS qIi3z72gSLw9VStFWmVjNcHrFrryPP3ZPhmYbHjWnwS950YzefJ+mvn5yAY55wpADCoSGxgzQ9h l0R+cLH9kMXhb0FljT07a9q+d2kjr6Mg1R+Jd7Y6i8paNEwRk0Fve2G/o2+fDt2dEX7ZUIcVSMX Gz7M1KSHUYQ6PcaQ7Vl0ZltYUwFLJwxzYso/XTd5JhG1sYkTI+38OkVU1VXa+COTNtpxWAzdpLw 2G+ZbOrIv3Tw1vWnCsZ2Cy+nQMaCFoldD7KD6GuCjfciV8Bcj2xucZPB13eso2CZpJTdk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Itanium support from the RAID6 code, and along with it, the 16x and
32x unrolled versions, which were only used by IA64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/raid/pq.h | 2 --
 lib/raid6/Makefile      | 4 ++--
 lib/raid6/algos.c       | 4 ----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index f29aaaf2eb21e9bd..f2536c99141aad77 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -84,8 +84,6 @@ extern const struct raid6_calls raid6_intx1;
 extern const struct raid6_calls raid6_intx2;
 extern const struct raid6_calls raid6_intx4;
 extern const struct raid6_calls raid6_intx8;
-extern const struct raid6_calls raid6_intx16;
-extern const struct raid6_calls raid6_intx32;
 extern const struct raid6_calls raid6_mmxx1;
 extern const struct raid6_calls raid6_mmxx2;
 extern const struct raid6_calls raid6_sse1x1;
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 45e17619422b4ef4..065a31e8f71df898 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_RAID6_PQ)	+= raid6_pq.o
 
 raid6_pq-y	+= algos.o recov.o tables.o int1.o int2.o int4.o \
-		   int8.o int16.o int32.o
+		   int8.o
 
 raid6_pq-$(CONFIG_X86) += recov_ssse3.o recov_avx2.o mmx.o sse1.o sse2.o avx2.o avx512.o recov_avx512.o
 raid6_pq-$(CONFIG_ALTIVEC) += altivec1.o altivec2.o altivec4.o altivec8.o \
@@ -54,7 +54,7 @@ endif
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(AWK) -v N=$* -f $(srctree)/$(src)/unroll.awk < $< > $@
 
-targets += int1.c int2.c int4.c int8.c int16.c int32.c
+targets += int1.c int2.c int4.c int8.c
 $(obj)/int%.c: $(src)/int.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index a22a05c9af8a3a75..fd1e699fa5fc19ae 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -72,10 +72,6 @@ const struct raid6_calls * const raid6_algos[] = {
 	&raid6_neonx4,
 	&raid6_neonx2,
 	&raid6_neonx1,
-#endif
-#if defined(__ia64__)
-	&raid6_intx32,
-	&raid6_intx16,
 #endif
 	&raid6_intx8,
 	&raid6_intx4,
-- 
2.39.1

