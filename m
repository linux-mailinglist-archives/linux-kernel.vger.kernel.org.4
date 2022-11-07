Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAE61F224
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKGLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiKGLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:47:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46159167F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:47:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1os0at-00025I-Fz; Mon, 07 Nov 2022 12:47:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os0ar-002qN3-5E; Mon, 07 Nov 2022 12:47:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os0ar-00ExHH-Gw; Mon, 07 Nov 2022 12:47:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr, kernel@pengutronix.de
Subject: [PATCH v1] coccinelle: api: Don't use devm_platform_get_and_ioremap_resource with res==NULL
Date:   Mon,  7 Nov 2022 12:47:02 +0100
Message-Id: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
the shorter devm_platform_ioremap_resource(pdev, index).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

a potential improvement is to check for invocations of
devm_platform_get_and_ioremap_resource() where the res parameter isn't
used afterwards, but my coccinelle foo isn't strong enough for that.

Best regards
Uwe

 .../api/devm_platform_ioremap_resource.cocci  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..401610b9a17d
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Don't use devm_platform_get_and_ioremap_resource with NULL as third parameter
+// Confidence: High
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r1@
+position p;
+@@
+ devm_platform_ioremap_resource(...) {
+	...
+	devm_platform_get_and_ioremap_resource@p(...)
+	...
+ }
+
+@depends on patch@
+expression pdev,index;
+position p != r1.p;
+@@
+
+-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
++  devm_platform_ioremap_resource(pdev, index)
+
+@r2 depends on !patch exists@
+expression pdev,index;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
+
+@script:python depends on org@
+p << r2.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource", p)
+
+@script:python depends on report@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_ioremap_resource")
-- 
2.38.1

