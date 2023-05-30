Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CD715742
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjE3HnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjE3HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4991BD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685432555; x=1716968555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=abTEt8MT54+VSoQvOPiB4OxGZUy2+4IKzxvnOb4KoPk=;
  b=cR4v1vBRM7MciPFcApXaG3vwc49n/TVy5kk2Bis34TRcHOAOyocEOMfZ
   950/AGJDE8/a00YHAqGO6wBFfSCqku2WCiCEW5bVX9BbJpVzBNL158H18
   SSXeSdaWro0Tx9YLmzC/RruTMt9m0QYz/Z4EFMcqtkHB6zOuh710i8T9P
   tQ/s6vd+8Z/N/MwTB62dr25tz8LyY8UmYcUx0AG8RXUOidr4Me2n09beN
   8wI6L9JtDF5Y+ea76bQ/RpwGb2LM5qpVNuEIKr9dn2d+LdJmUBRAXqcWY
   C+oEmwLqe5CISasEtr8Vmuzfucge9fco1Del1HDBIDJSLBbHOmQmTmOiv
   g==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="215991659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 00:41:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 00:41:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 00:41:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>
CC:     <cocci@inria.fr>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] Coccinelle: kmerr: increase check list
Date:   Tue, 30 May 2023 10:40:44 +0300
Message-ID: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are other functions allocating memory who's return value could
be NULL in case allocation fails. Update the list with these.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 scripts/coccinelle/null/kmerr.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/null/kmerr.cocci b/scripts/coccinelle/null/kmerr.cocci
index 68db20de62eb..db1387f1938a 100644
--- a/scripts/coccinelle/null/kmerr.cocci
+++ b/scripts/coccinelle/null/kmerr.cocci
@@ -35,7 +35,7 @@ position any withtest.p;
 identifier f;
 @@
 
-*x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
+*x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
 ...
 *x1@p = f(...);
 if (!x1) S
@@ -51,7 +51,7 @@ position any withtest.p;
 identifier f;
 @@
 
-x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
+x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
 ...
 x1@p = f@p2(...);
 if (!x1) S
-- 
2.34.1

