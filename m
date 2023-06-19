Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735D07359C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjFSOhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjFSOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E376E68;
        Mon, 19 Jun 2023 07:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC3360CA5;
        Mon, 19 Jun 2023 14:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BD1C433C0;
        Mon, 19 Jun 2023 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687185451;
        bh=cKXZj60yRSK1IRgf3ZaAN3xJcXaOIkypoexKrxHMOhs=;
        h=From:To:Cc:Subject:Date:From;
        b=QH0bwh7t/Urer7GKMlsBQid+Lf8kVUaQTAtIDH76W4UJYv1gGjxTg2yNqLDo4zKnz
         ToVQqgo1qSFzOkQNm5YHLgf/0lrDc1nZdm/XZ7NNiFHck64gJC98ol21RnDSTu2I7k
         9Fw3L5OVAk68dKIr1AB5nxJEB+/70lbS9KUQdz+MpacjJz0uZ1WKiHVt2vsv/p1hwF
         S0IM1Pbh+CgIaC0SupzbmqAHH6pz5mhSZ7B/+snZsvIdSTdSnvlKz36n31ILHDk4GS
         2ZoY5kBKGu5kpL6ANlRpeJ1V48gghKpjehS27GNYhxmgp/rx3dPYqNPP1blHJjeUrM
         wtpYhJa6QQk8w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] ARM: change link order of $(mmy-y) to avoid veneers
Date:   Mon, 19 Jun 2023 23:37:25 +0900
Message-Id: <20230619143725.57967-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel compiled with multi_v7_defconfig + CONFIG_KASAN=y +
CONFIG_KASAN_INLINE=y does not boot.

I do not think KASAN is the direct reason of the boot failure.
CONFIG_KASAN_INLINE is just one example configuration that grows the
image size significantly and makes a big distance between function
callers and callees.

I see some veneers for __get_user_* in the bad kernel image. I am
not perfectly clear, but __get_user_* may not work with veneers for
some reasons.

If I move the link order of arch/arm/lib/getuser.S, the veneers are
gone, and the kernel gets working again.

I do not see a good reason that $(mmu-y) must be added to lib-y because
all the code in $(mmu-y) is mandatory. Add it to obj-y to move the code
to lower address.

[1] multi_v7_defconfig (works)

 $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
 c072a450 T __get_user_1
 c17ea033 r __kstrtab___get_user_1
 c18119fe r __kstrtabns___get_user_1
 c17c4878 r __ksymtab___get_user_1

[2] multi_v7_defconfig + CONFIG_KASAN_INLINE (does not work)

 $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
 c341ec2c T __get_user_1
 c06e3580 t ____get_user_1_veneer
 c0adc6c0 t ____get_user_1_veneer
 c12cf054 t ____get_user_1_veneer
 c43f42cc r __kstrtab___get_user_1
 c441c128 r __kstrtabns___get_user_1
 c43cead8 r __ksymtab___get_user_1

[3] multi_v7_defconfig + CONFIG_KASAN_INLINE + this patch (works)

 $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
 c10975b0 T __get_user_1
 c43f42cc r __kstrtab___get_user_1
 c441c128 r __kstrtabns___get_user_1
 c43cead8 r __ksymtab___get_user_1

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..4d092ef87a1d 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -28,7 +28,7 @@ endif
 # using lib_ here won't override already available weak symbols
 obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
 
-lib-$(CONFIG_MMU) += $(mmu-y)
+obj-$(CONFIG_MMU) += $(mmu-y)
 
 ifeq ($(CONFIG_CPU_32v3),y)
   lib-y	+= io-readsw-armv3.o io-writesw-armv3.o
-- 
2.39.2

