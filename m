Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E660BD95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiJXWkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiJXWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:39:07 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5752BC853;
        Mon, 24 Oct 2022 14:02:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYbA5050121;
        Mon, 24 Oct 2022 12:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632877;
        bh=0Wv3kxu1zrI9I3zQ+/ntswY76RUlx98SfDnQU2HARwY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hXT8UWk0aIiJTHKS33cig5CCvhV3QV4PYwjWxDEnmd+IOSxTNQo46NtchRmE6eEu3
         nUQ06Qxeng6BL21C3rF26Ho6nEl1BvfCYSdmZ1WG3KKBAmZYYRm6f1GH8zeqdRXy9s
         ysP3dKBVjHR+Zx4ZzIjlZJ9hJ74sqXEGYZujQPgc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYbbv122837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:36 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYJ0039154;
        Mon, 24 Oct 2022 12:34:36 -0500
From:   Andrew Davis <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/7] kbuild: Allow DTB overlays to built into .dtso.S files
Date:   Mon, 24 Oct 2022 12:34:29 -0500
Message-ID: <20221024173434.32518-3-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024173434.32518-1-afd@ti.com>
References: <20221024173434.32518-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DTB files can be built into the kernel by converting them to assembly
files then assembling them into object files. We extend this here
for DTB overlays with the .dtso extensions.

We change the start and end delimiting tag prefix to make it clear that
this data came from overlay files.

[Based on patch by Frank Rowand <frank.rowand@sony.com>]
Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/Makefile.lib | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0376a6f18bfb1..250b9fd73f6d2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -358,7 +358,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
 
 # Generate an assembly file to wrap the output of the device tree compiler
-quiet_cmd_dt_S_dtb= DTB     $@
+quiet_cmd_dt_S_dtb= DTBS    $@
 cmd_dt_S_dtb=						\
 {							\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
@@ -375,6 +375,24 @@ cmd_dt_S_dtb=						\
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,dt_S_dtb)
 
+# Generate an assembly file to wrap the output of the device tree compiler
+quiet_cmd_dt_S_dtbo= DTBOS   $@
+cmd_dt_S_dtbo=						\
+{							\
+	echo '\#include <asm-generic/vmlinux.lds.h>';	\
+	echo '.section .dtb.init.rodata,"a"';		\
+	echo '.balign STRUCT_ALIGNMENT';		\
+	echo '.global __dtbo_$(subst -,_,$(*F))_begin';	\
+	echo '__dtbo_$(subst -,_,$(*F))_begin:';	\
+	echo '.incbin "$<" ';				\
+	echo '__dtbo_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtbo_$(subst -,_,$(*F))_end';	\
+	echo '.balign STRUCT_ALIGNMENT';		\
+} > $@
+
+$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
+	$(call if_changed,dt_S_dtbo)
+
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -o $@ -b 0 \
-- 
2.37.3

