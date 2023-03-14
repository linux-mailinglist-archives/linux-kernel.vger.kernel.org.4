Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A296B8C21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCNHoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427DF96B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB26DB81887
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50748C433EF;
        Tue, 14 Mar 2023 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678779838;
        bh=dOECTpwTzkX6vMrRENSU3oFMVXyJLNoi6M7bhCTSr7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=s2vPz83Q2f6bH4X3RkJvqnDUhk9ewaSU0P/NNXnqDPyuD7rIlsX4rEtlgWKTZVRSr
         5ZnPz8rHJWsKeyNaQHcA9AGfE+33m3SeFLDueX2jrbT4IiPXr9BSXedUz/Ras5yEUR
         Im/uyFz1nCDFOlnKYL/992W+Ogf/EldPmzezP+6pXkP0rmOBvhKwrZQJKDyc+npbs6
         4A6x2mbQmmoDVLWUC9gHAek3TPhnvh5VHcY9iqQTvkytap8b4gnfXMRRNM9xYLUXLX
         GXHevhSaIC7btEvUNKUHAAj8bl3auwVo3qRF/dtDZguC9Y9nmJdNIdygT7buIWk3ED
         qhlsEYVcE1u0Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: decompressor: simplify the path to the top vmlinux
Date:   Tue, 14 Mar 2023 16:43:51 +0900
Message-Id: <20230314074351.1181502-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 8debed3efe3a ("kbuild: export top-level LDFLAGS_vmlinux
only to scripts/Makefile.vmlinux") applied, we no longer see the error
message while building the ARM zImage, but we do not have a good reason
to complicate the file path either.

'$(obj)/../../../../vmlinux' is canonicalized to 'vmlinux'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.3-rc1

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2ef651a78fa2..726ecabcef09 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -107,7 +107,7 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
+KBSS_SZ = $(shell echo $$(($$($(NM) vmlinux | \
 		sed -n -e 's/^\([^ ]*\) [ABD] __bss_start$$/-0x\1/p' \
 		       -e 's/^\([^ ]*\) [ABD] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
-- 
2.34.1

