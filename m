Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CA68AA92
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjBDO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBDO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:29:29 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452132D171
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675520946; bh=2Lsoj+6QlKMk1UqjeFpw397b0NezTsdFl+fpyrVASvQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=CmtlZ9fpuxsmM+ZuEofgcLNbPLjDd1ylDRuzLGDJKRD3pZvaZlORGkoGuMrHl8ume
         5UhQByxJ0tpBgGdy6/bdnVS+N3qcK8VrNCgMXnukRD2iTpwBdaQ19abMuovnKD16Nb
         qOtKjxLuOK4SY42pZiMwNu4rQ6ZfZl/5sdobT/Hg=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  4 Feb 2023 15:29:06 +0100 (CET)
X-EA-Auth: 6zhE2JyG1Uhz/yqA+AfRH14Bhmf+2kraZbSVASgvbX02iDQZRarIPoLaD6oEenVtiW2GS2/e3qgB21QfyqL/YTLfzrptcOs1
Date:   Sat, 4 Feb 2023 19:58:58 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] irqchip/irq-bcm7038-l1: Remove unreachable code
Message-ID: <Y95rqrQOVMRfxnn9@ubun2204.myguest.virtualbox.org>
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

The macro for_each_possible_cpu() is designed to execute only once,
when the index is zero. Hence the test condition for index value
other than zero will never be reached. Remove this unreachable code.
Issue identified using itnull.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index a62b96237b82..1b3ec4001356 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -410,8 +410,6 @@ static int __init bcm7038_l1_of_init(struct device_node *dn,
 	for_each_possible_cpu(idx) {
 		ret = bcm7038_l1_init_one(dn, idx, intc);
 		if (ret < 0) {
-			if (idx)
-				break;
 			pr_err("failed to remap intc L1 registers\n");
 			goto out_free;
 		}
-- 
2.34.1



