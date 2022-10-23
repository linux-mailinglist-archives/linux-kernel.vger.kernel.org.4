Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8218609586
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJWSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJWSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:25:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A3481F1;
        Sun, 23 Oct 2022 11:25:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29NIOef4128785;
        Sun, 23 Oct 2022 13:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666549480;
        bh=Eszw1jdJn4j8v1iKIorlGb7DTe56ZXAST+TiCWofrWI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wjLZNsPNIXscu4GFpLzxocu/4VNwM6O/J+MddjyqqCWbMq7nnWx0nTQMCEUXOmW9j
         bckwGTXlxOG348Al/4/wZASqw902djwVvLzL2vmxPhXsBBy1nO/K5DE0EIVAOgCJPh
         QjJ07uod2WbuwFupBJfras6r5qXpwl9Vudl0PMXo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29NIOeh0043386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Oct 2022 13:24:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 23
 Oct 2022 13:24:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 23 Oct 2022 13:24:39 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29NIObVY042708;
        Sun, 23 Oct 2022 13:24:38 -0500
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
Subject: [PATCH 1/6] kbuild: Allow DTB overlays to built from .dtso named source files
Date:   Sun, 23 Oct 2022 13:24:32 -0500
Message-ID: <20221023182437.15263-2-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221023182437.15263-1-afd@ti.com>
References: <20221023182437.15263-1-afd@ti.com>
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

Currently DTB Overlays (.dtbo) are build from source files with the same
extension (.dts) as the base DTs (.dtb). This may become confusing and
even lead to wrong results. For example, a composite DTB (created from a
base DTB and a set of overlays) might have the same name as one of the
overlays that create it.

Different files should be generated from differently named sources.
 .dtb  <-> .dts
 .dtbo <-> .dtso

We do not remove the ability to compile DTBO files from .dts files here,
only add a new rule allowing the .dtso file name. The current .dts named
overlays can be renamed with time. After all have been renamed we can
remove the other rule.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 scripts/Makefile.lib | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b8..0376a6f18bfb1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -408,6 +408,9 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
2.37.3

