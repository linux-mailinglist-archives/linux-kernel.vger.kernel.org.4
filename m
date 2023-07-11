Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C393874EA77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGKJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGKJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:27:35 -0400
X-Greylist: delayed 1197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 02:25:23 PDT
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82044170B;
        Tue, 11 Jul 2023 02:25:23 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4R0ZHG0d6Pz9xg11;
        Tue, 11 Jul 2023 16:46:50 +0800 (CST)
Received: from fedora (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 16:47:31 +0800
Date:   Tue, 11 Jul 2023 16:47:30 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [PATCH] scsi: aic7xxx: fix firmware build fatal error
Message-ID: <ZK0XIj6XzY5MCvtd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_AIC7XXX_BUILD_FIRMWARE=y, two fatal errors
are reported as shown below:
> aicasm_gram.tab.c:203:10: fatal error: aicasm_gram.tab.h:
> No such file or directory
> aicasm_macro_gram.tab.c:167:10: fatal error: aicasm_macro_gram.tab.h:
> No such file or directory
Fix these issues to make randconfig builds more reliable.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 drivers/scsi/aic7xxx/aicasm/Makefile | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/Makefile b/drivers/scsi/aic7xxx/aicasm/Makefile
index 243adb0a38d1..a3f2357a3f08 100644
--- a/drivers/scsi/aic7xxx/aicasm/Makefile
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile
@@ -61,23 +61,11 @@ $(OUTDIR)/aicdb.h:
 clean:
 	rm -f $(clean-files)
 
-# Create a dependency chain in generated files
-# to avoid concurrent invocations of the single
-# rule that builds them all.
-$(OUTDIR)/aicasm_gram.c: $(OUTDIR)/aicasm_gram.h
 $(OUTDIR)/aicasm_gram.c $(OUTDIR)/aicasm_gram.h: aicasm_gram.y
-	$(YACC) $(YFLAGS) -b $(<:.y=) $<
-	mv $(<:.y=).tab.c $(OUTDIR)/$(<:.y=.c)
-	mv $(<:.y=).tab.h $(OUTDIR)/$(<:.y=.h)
-
-# Create a dependency chain in generated files
-# to avoid concurrent invocations of the single
-# rule that builds them all.
-$(OUTDIR)/aicasm_macro_gram.c: $(OUTDIR)/aicasm_macro_gram.h
+	$(YACC) $(YFLAGS) -b $(<:.y=) $< -o $(OUTDIR)/$(<:.y=.c)
+
 $(OUTDIR)/aicasm_macro_gram.c $(OUTDIR)/aicasm_macro_gram.h: aicasm_macro_gram.y
-	$(YACC) $(YFLAGS) -b $(<:.y=) -p mm $<
-	mv $(<:.y=).tab.c $(OUTDIR)/$(<:.y=.c)
-	mv $(<:.y=).tab.h $(OUTDIR)/$(<:.y=.h)
+	$(YACC) $(YFLAGS) -b $(<:.y=) -p mm $< -o $(OUTDIR)/$(<:.y=.c)
 
 $(OUTDIR)/aicasm_scan.c: aicasm_scan.l
 	$(LEX) $(LFLAGS) -o $@ $<
-- 
2.40.0

