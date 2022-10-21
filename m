Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD512607E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJUS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:57:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1E28F261
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:57:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29LIvEfA080810;
        Fri, 21 Oct 2022 13:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666378634;
        bh=Epgs+uOv2ELm6Mf+YTk8ZSnbWg4aQ6L4EqMd6fPM2LY=;
        h=From:To:CC:Subject:Date;
        b=rjCPjN1FWOrvMMyBQp/pDjnXXH74zGuXgbxiQYoMt5HoXVyUFpjz2yV9Idd8RHlWm
         gzAJdfwkWhB39BonDloavBNK5LGtXfD9gIbMWcncJJkSVM2QONmi6bIDqCql5AUiQx
         TYwcP7rNzqMn9AhXnlWiXYz2H45vr1vlavE2rwKE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29LIvEUu122818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Oct 2022 13:57:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 21
 Oct 2022 13:57:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 21 Oct 2022 13:57:14 -0500
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29LIv7Uw001227;
        Fri, 21 Oct 2022 13:57:09 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Georgi Vlaev <g-vlaev@ti.com>
Subject: [RESEND PATCH] firmware: ti_sci: Fix polled mode during system suspend
Date:   Fri, 21 Oct 2022 21:57:04 +0300
Message-ID: <20221021185704.181316-1-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled
mode during system suspend") uses read_poll_timeout_atomic() macro
in ti_sci_do_xfer() to wait for completion when the system is
suspending. The break condition of the macro is set to "true" which
will cause it break immediately when evaluated, likely before the
TISCI xfer is completed, and always return 0. We want to poll here
until "done_state == true".

1) Change the break condition of read_poll_timeout_atomic() to
the bool variable "done_state".

2) The read_poll_timeout_atomic() returns 0 if the break condition
is met or -ETIMEDOUT if not. Since our break condition has changed
to "done_state", we also don't have to check for "!done_state" when
evaluating the return value.

Fixes: b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled mode during system suspend")

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
 drivers/firmware/ti_sci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ebc32bbd9b83..6281e7153b47 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -429,15 +429,14 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 		 * during noirq phase, so we must manually poll the completion.
 		 */
 		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
-					       true, 1,
+					       done_state, 1,
 					       info->desc->max_rx_timeout_ms * 1000,
 					       false, &xfer->done);
 	}
 
-	if (ret == -ETIMEDOUT || !done_state) {
+	if (ret == -ETIMEDOUT)
 		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
 			(void *)_RET_IP_);
-	}
 
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the

base-commit: 4d48f589d294ddc5e01d3b0dc7cecc55324c05ca
-- 
2.30.2

