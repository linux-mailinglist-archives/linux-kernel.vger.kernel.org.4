Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF5628AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiKNVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiKNVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:00:26 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F07EE1E;
        Mon, 14 Nov 2022 13:00:23 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AEKxfvC089173;
        Mon, 14 Nov 2022 14:59:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668459581;
        bh=DPPvsaTx1ytVsTAVjXlYV7oje562yCBudMmuXP6Vp/Q=;
        h=From:To:CC:Subject:Date;
        b=w7yf/F0ZNVkcv+FFLivlt4FAiQESLJOHDVIa9bia9uMRSfG2u4F1ZbGzbUe5x3s18
         +pNYHQ5cIR7WFwySXwjJBzP9BsxfURAmzUtMU0Phzvr+ffeYc0UhvVC5wxHfZsEx8d
         ta6UQvt1eNIt7lYSifEr/+gDDdOiQ5VxCW1BkyfU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AEKxf84123487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 14:59:41 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 14
 Nov 2022 14:59:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 14 Nov 2022 14:59:40 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AEKxdbg054271;
        Mon, 14 Nov 2022 14:59:40 -0600
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
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] kbuild: Cleanup DT Overlay intermediate files as appropriate
Date:   Mon, 14 Nov 2022 14:59:39 -0600
Message-ID: <20221114205939.27994-1-afd@ti.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%.dtbo.o and %.dtbo.S files are used to build-in DT Overlay. They should
should not be removed by Make or the kernel will be needlessly rebuilt.

These should be removed by "clean" and ignored by git like other
intermediate files.

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 .gitignore             | 1 +
 Makefile               | 4 +++-
 scripts/Makefile.build | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 5da004814678d..3ec73ead6757e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 *.dtb
 *.dtbo
 *.dtb.S
+*.dtbo.S
 *.dwo
 *.elf
 *.gcno
diff --git a/Makefile b/Makefile
index 3735d5996c637..0dd7e8d022289 100644
--- a/Makefile
+++ b/Makefile
@@ -2003,7 +2003,9 @@ clean: $(clean-dirs)
 	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' \
-		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
+		-o -name '*.dtb' -o -name '*.dtbo' \
+		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
+		-o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 41f3602fc8de7..3ceab076127b7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -468,10 +468,12 @@ intermediate_targets = $(foreach sfx, $(2), \
 					$(filter %$(strip $(1)), $(targets))))
 # %.asn1.o <- %.asn1.[ch] <- %.asn1
 # %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
+# %.dtbo.o <- %.dtbo.S <- %.dtbo <- %.dtso
 # %.lex.o <- %.lex.c <- %.l
 # %.tab.o <- %.tab.[ch] <- %.y
 targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
+	   $(call intermediate_targets, .dtbo.o, .dtbo.S .dtbo) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
 
-- 
2.38.1

