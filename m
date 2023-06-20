Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99291736CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjFTNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjFTNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:04:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F1185
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:04:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35KD3UkY008726;
        Tue, 20 Jun 2023 08:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687266210;
        bh=lOohF/4VM+eFrmrPcZ0O/ue0k19af+jE8f7CIJ3N1vY=;
        h=From:To:CC:Subject:Date;
        b=nhbEHbHXqUqKLzEOz8N8SS2gsfCxK0KfqO6RHU/PnOE+uVnu7z830/zaOsN5VtXyf
         nyqfaVpCOBNGd3KxEwfJJVSCMoLCB/pPRX3OkiGG61xfvaPRZoaj+lSUvOxgFErdCG
         XgC4g97ePB9/GYZLPd02tVpswB2+K2tFo3ACZL7w=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35KD3UHX031613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 08:03:30 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 08:03:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 08:03:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35KD3TFa050929;
        Tue, 20 Jun 2023 08:03:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Wadim Egorov <w.egorov@phytec.de>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH V2] firmware: ti_sci: Use system_state to determine polling
Date:   Tue, 20 Jun 2023 08:03:29 -0500
Message-ID: <20230620130329.4120443-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled
mode during system suspend") aims to resolve issues with tisci
operations during system suspend operation. However, the system may
enter a no_irq stage in various other usage modes, including power-off
and restart. To determine if polling mode is appropriate, use the
system_state instead.

While at this, drop the unused is_suspending state variable and
related helpers.

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Reported-by: Wadim Egorov <w.egorov@phytec.de>
Closes: https://lore.kernel.org/all/ZGeHMjlnob2GFyHF@francesco-nb.int.toradex.com/
Fixes: b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled mode during system suspend")
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since V1:
* Fixed up comments from Francesco:
  * Fat fingered miss part of the change causing a build break
  * Added Fixes, s/Link/Closes
* Picked up Tested-by

Note: there are two reported by, and a closes link - which confuses
checkpatch a little, but I am going to assume it is ok.

V1: https://lore.kernel.org/all/20230619131236.3285069-1-nm@ti.com/

 drivers/firmware/ti_sci.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 039d92a595ec..91aaa0ca9bde 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -97,7 +97,6 @@ struct ti_sci_desc {
  * @node:	list head
  * @host_id:	Host ID
  * @users:	Number of users of this instance
- * @is_suspending: Flag set to indicate in suspend path.
  */
 struct ti_sci_info {
 	struct device *dev;
@@ -116,7 +115,6 @@ struct ti_sci_info {
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
-	bool is_suspending;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -418,14 +416,14 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (!info->is_suspending) {
+	if (system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
 	} else {
 		/*
-		 * If we are suspending, we cannot use wait_for_completion_timeout
+		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.
 		 */
 		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
@@ -3281,35 +3279,6 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
-static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspending)
-{
-	info->is_suspending = is_suspending;
-}
-
-static int ti_sci_suspend(struct device *dev)
-{
-	struct ti_sci_info *info = dev_get_drvdata(dev);
-	/*
-	 * We must switch operation to polled mode now as drivers and the genpd
-	 * layer may make late TI SCI calls to change clock and device states
-	 * from the noirq phase of suspend.
-	 */
-	ti_sci_set_is_suspending(info, true);
-
-	return 0;
-}
-
-static int ti_sci_resume(struct device *dev)
-{
-	struct ti_sci_info *info = dev_get_drvdata(dev);
-
-	ti_sci_set_is_suspending(info, false);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
-
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3516,7 +3485,6 @@ static struct platform_driver ti_sci_driver = {
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
-		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.40.0

