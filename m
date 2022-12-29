Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FCD65908D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiL2SrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Sq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:46:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50727B1F1;
        Thu, 29 Dec 2022 10:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0050DB819F4;
        Thu, 29 Dec 2022 18:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19428C433F0;
        Thu, 29 Dec 2022 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672339615;
        bh=XOQsW+DZXIQo9uytvYtAfZGD0Mm2AhqT1JBHg6Va+/E=;
        h=From:To:Cc:Subject:Date:From;
        b=EqmI3pxhBh2x0FZGWx55JP/+6WMdH2eoXOBfaqMnEeJjD/iUHlZgprdebxo16zUsb
         vm9HlR5rPmPvewHwxjs1LFVfpCBbDaCTbZIu/3YX1ulYNJ88mfdB/3Tbl0R+2NUvVJ
         uEibJfi/8rSxU1F7jqFKzj6qdb0qPx2vPezZZRR8Qs3g5VhvVK57bnDCMbFgsVap1J
         RJx4M86ZpD8ZNUaIoQhfTMnFqouM1Zrq0ObgW6JmegoP7IzK+TLxM/ySef/OxuonsY
         a2ddsYXi9CKblCR6ul2/501YORyMtHFSjkettVz9VSpNB/t7cRETi4Z6kYF5eez6wg
         fYSydCJnn7avw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: unify cmd_dt_S_dtb and cmd_dt_S_dtbo
Date:   Fri, 30 Dec 2022 03:46:50 +0900
Message-Id: <20221229184650.1107463-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmd_dt_S_dtb and cmd_dt_S_dtbo are almost the same; the only differnce
is the prefix of the bein/end symbols. (__dtb vs __dtbo)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 45 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4a4a5f67c1a6..100a386fcd71 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -368,40 +368,25 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
 
 # Generate an assembly file to wrap the output of the device tree compiler
-quiet_cmd_dt_S_dtb= DTBS    $@
-cmd_dt_S_dtb=						\
-{							\
-	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
-	echo '.section .dtb.init.rodata,"a"';		\
-	echo '.balign STRUCT_ALIGNMENT';		\
-	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
-	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
-	echo '.incbin "$<" ';				\
-	echo '__dtb_$(subst -,_,$(*F))_end:';		\
-	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
-	echo '.balign STRUCT_ALIGNMENT'; 		\
-} > $@
+quiet_cmd_wrap_S_dtb = WRAP    $@
+      cmd_wrap_S_dtb = {								\
+		symbase=__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\
+		echo '\#include <asm-generic/vmlinux.lds.h>';				\
+		echo '.section .dtb.init.rodata,"a"';					\
+		echo '.balign STRUCT_ALIGNMENT';					\
+		echo ".global $${symbase}_begin";					\
+		echo "$${symbase}_begin:";						\
+		echo '.incbin "$<" ';							\
+		echo ".global $${symbase}_end";						\
+		echo "$${symbase}_end:";						\
+		echo '.balign STRUCT_ALIGNMENT';					\
+	} > $@
 
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
-	$(call if_changed,dt_S_dtb)
-
-# Generate an assembly file to wrap the output of the device tree compiler
-quiet_cmd_dt_S_dtbo= DTBOS   $@
-cmd_dt_S_dtbo=						\
-{							\
-	echo '\#include <asm-generic/vmlinux.lds.h>';	\
-	echo '.section .dtb.init.rodata,"a"';		\
-	echo '.balign STRUCT_ALIGNMENT';		\
-	echo '.global __dtbo_$(subst -,_,$(*F))_begin';	\
-	echo '__dtbo_$(subst -,_,$(*F))_begin:';	\
-	echo '.incbin "$<" ';				\
-	echo '__dtbo_$(subst -,_,$(*F))_end:';		\
-	echo '.global __dtbo_$(subst -,_,$(*F))_end';	\
-	echo '.balign STRUCT_ALIGNMENT';		\
-} > $@
+	$(call if_changed,wrap_S_dtb)
 
 $(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
-	$(call if_changed,dt_S_dtbo)
+	$(call if_changed,wrap_S_dtb)
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-- 
2.34.1

