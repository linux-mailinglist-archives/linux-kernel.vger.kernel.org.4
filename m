Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E416A7418
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCATOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCATOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:14:05 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63534015
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677698016; bh=eiqwtvnYck/1m0Yt7lMi6q3bdq0fyTlM8ZfdFltVRKE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=CZLsHMAvNLBb93M64IRDSf/cIlL4QL96uIS2CGixwUwaJGSu011oomSy5JdyIn/0U
         YlKL1Mmgv/cbOEksgYf98K+5V53GuJwqy6DmSR1fEc5yzGPxgbFkmG+6m4jOYg0rTd
         xAnwRD4bEELhbIYlIv2K+IIiwn6mRdCBDQqSD64E=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:13:36 +0100 (CET)
X-EA-Auth: TSRsA2wbeBLpAiKN+cBrdG6+KjuRR4juq/RVwwPYl8JecVpgVWmrqxQWw9+/Q/F6wEJuDNSSKxR6LQt6f1rC4tfBn71YFHgx
Date:   Thu, 2 Mar 2023 00:43:31 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        pk.drv@ubun2204.myguest.virtualbox.org
Subject: [PATCH RESEND] EDAC/altera: Remove redundant error logging
Message-ID: <Y/+j27kqdhflPtaj@ubun2204.myguest.virtualbox.org>
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

A call to platform_get_irq() already prints an error on failure within
its own implementation. So printing another error based on its return
value in the caller is redundant and should be removed. The clean up
also makes if condition block braces unnecessary. Remove that as well.

Issue identified using platform_get_irq.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note:
   The change was compile tested only.
   Resending the patch for a review and feedback.
     
 drivers/edac/altera_edac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..72fa49c44360 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2149,10 +2149,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+	if (edac->sb_irq < 0)
 		return edac->sb_irq;
-	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2184,10 +2182,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+	if (edac->db_irq < 0)
 		return edac->db_irq;
-	}
+
 	irq_set_chained_handler_and_data(edac->db_irq,
 					 altr_edac_a10_irq_handler, edac);
 #endif
-- 
2.34.1



