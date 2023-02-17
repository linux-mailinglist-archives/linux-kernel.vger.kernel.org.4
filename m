Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2569B22E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBQSL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:11:28 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11F93D8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676657483; bh=B1VmI+k4wIVX7khCOAIv+GNjdsvNDDHabRSUeTur1gA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Law7bSE6Glg0+9yG/HAooltXnzZ6dwxgwTYT8oHj/qfMR5xu9fQWY8jGmXEXg9BL4
         QBWpLTlAa5TNX2lIfN2pGuLlYzkM8cHJxq9DrDOjrG0nDDShGndLt0fspqfrv90qVq
         sx4XpEYmZ64P7JBJw0wJbSpJZ9e86UliEi2EUO7s=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 17 Feb 2023 19:11:23 +0100 (CET)
X-EA-Auth: 1k3b9EoeNntTY48xB+Me88rLNyQ3wA2W1Ud1IgEcZASYaFhVB1O10fXPILulqKxnzytB6riIxpGVFjeDWvy9fpAJMEJUdF3S
Date:   Fri, 17 Feb 2023 23:41:15 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] coccinelle: put_device: Include of_node_put to avoid false
 positives
Message-ID: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node reference increased by of_find_device_by_node() can also be
released by using a call to of_node_put(). Hence when this exists, the
script should not trigger a warning, which otherwise will be a false
positive.
Also, improve the warning message to include of_node_put too is missing.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 scripts/coccinelle/free/put_device.cocci | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
index f09f1e79bfa6..259195b501aa 100644
--- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -18,8 +18,10 @@ type T,T1,T2,T3;
 
 id = of_find_device_by_node@p1(x)
 ... when != e = id
+    when != of_node_put(x)
 if (id == NULL || ...) { ... return ...; }
 ... when != put_device(&id->dev)
+    when != of_node_put(x)
     when != platform_device_put(id)
     when != if (id) { ... put_device(&id->dev) ... }
     when != e1 = (T)id
@@ -42,7 +44,7 @@ p2 << search.p2;
 @@
 
 coccilib.report.print_report(p2[0],
-                             "ERROR: missing put_device; call of_find_device_by_node on line "
+                             "ERROR: missing put_device or of_node_put; call of_find_device_by_node on line "
                              + p1[0].line
                              + ", but without a corresponding object release within this function.")
 
-- 
2.34.1



