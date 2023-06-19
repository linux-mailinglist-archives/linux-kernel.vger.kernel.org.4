Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88673582B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFSNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFSNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:13:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E6E65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:12:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35JDCeC3059237;
        Mon, 19 Jun 2023 08:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687180360;
        bh=FJIIHAmXoaiCGIqcuKuUJxhCHTFzaAGVbgF4ezSG05U=;
        h=From:To:CC:Subject:Date;
        b=m9sn3eY717GVxrmLn77PYIuoh+QWrRTjbDJDxTX0Cy4bQQgjvfN/1bDUHi1ZK7yWh
         dT9OHW+UgkmNo05zq86mthBEdiuLMXuFGcxYhT2b+H0PUKTiE3qOIJOnZ+KM0ION6F
         4H6utzCVeYRXHsRTnvZq6iFGmmR/iCYzR4EpmQqg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35JDCedP130672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jun 2023 08:12:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Jun 2023 08:12:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Jun 2023 08:12:39 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35JDCeJG001213;
        Mon, 19 Jun 2023 08:12:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Wadim Egorov <w.egorov@phytec.de>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gole@ti.com>
Subject: [PATCH] firmware: ti_sci: Use system_state to determine polling
Date:   Mon, 19 Jun 2023 08:12:36 -0500
Message-ID: <20230619131236.3285069-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/all/ZGeHMjlnob2GFyHF@francesco-nb.int.toradex.com/
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/firmware/ti_sci.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 039d92a595ec..dc7906e38f09 100644
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
-- 
2.40.0

