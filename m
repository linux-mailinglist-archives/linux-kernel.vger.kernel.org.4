Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0A5FF0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJNPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJNPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:13:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1311D3EB2;
        Fri, 14 Oct 2022 08:13:27 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29EFD45g044306;
        Fri, 14 Oct 2022 10:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665760384;
        bh=jqhPCw7ZEkH514g5BHN5Rr9q9FrHZsnVbp3y+FTxKLA=;
        h=From:To:CC:Subject:Date;
        b=gZdT1rENET1nxNqFqybOuhSOKfe+WJBT4B51lc/PCVJ3pVP4f/jvvQqld4lOaMyg3
         BCdns4+us0Y6bm98d1JI1LXtvhRvPsnjkY9eWtqfzRkwhx107Efk8MzhvpuVFFQnci
         rxpHsuwdx8emIqPVtR09CTccgnFj15T1x25O+9KU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29EFD4ap019525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Oct 2022 10:13:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 14
 Oct 2022 10:13:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 14 Oct 2022 10:13:04 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29EFD3wI004407;
        Fri, 14 Oct 2022 10:13:03 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH] kbuild: Allow DTB overlays to built from .dtso named source files
Date:   Fri, 14 Oct 2022 10:13:02 -0500
Message-ID: <20221014151302.27641-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
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
index 3aa384cec76b..0376a6f18bfb 100644
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

