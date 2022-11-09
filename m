Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0862366A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiKIWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:20:02 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 14:19:59 PST
Received: from mailfilter06-out40.webhostingserver.nl (mailfilter06-out40.webhostingserver.nl [195.211.73.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4BAF03D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=BwQD9pj5b/WWSsnWxPYCsQ/PgXjWas3i27VLj8Y6Clc=;
        b=ZkY8uv6/hN9/FoAwFfXnWm4GMQg7cJ1jSyMvQ7tJ+ilUOB7nPzqBfUU8u/Z2Snwf1/rbGnOPQvmRA
         x4K23/yrAMk6SoyyKB9dEolvHKnk0AHgF6bWTNPXFG7pjTfsyiyxWMOOec/B9KdKGtY+3oUTBdEQN0
         NSAp+DGOdSRPl3ctQAjzhVRqft37d73lqpX5/3cyuq1oTGW+JOPllcQb0MmM1CVOW9WZBJR2IFirVm
         aYBgmvkm/Low6Sf6QtTClCfZILKJWtJ+0ZmOqaPC/UQhOy0vULvq7pXS4KY/5Xn4b6sfod+Rhjgrdo
         HR8ICGNM9BzzHnCac3HStBcVZzQ+2rw==
X-Halon-ID: 7f4b7a72-607c-11ed-837b-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
        id 7f4b7a72-607c-11ed-837b-001a4a4cb958;
        Wed, 09 Nov 2022 23:18:54 +0100 (CET)
Received: from 2a02-a466-68ed-1-6127-ee99-b8c1-12c4.fixed6.kpn.net ([2a02:a466:68ed:1:6127:ee99:b8c1:12c4] helo=localhost.localdomain)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1ostPK-002HIn-0s;
        Wed, 09 Nov 2022 23:18:54 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id timeout
Date:   Wed,  9 Nov 2022 23:17:49 +0100
Message-Id: <20221109221749.8210-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0f010171
Dual Role support on Intel Merrifield platform broke due to rearranging
the call to dwc3_get_extcon().

It appears to be caused by ulpi_read_id() on the first test write failing
with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
DT when the test write fails and returns 0 in that case even if DT does not
provide the phy. Due to the timeout being masked dwc3 probe continues by
calling dwc3_core_soft_reset() followed by dwc3_get_extcon() which happens
to return -EPROBE_DEFER. On deferred probe ulpi_read_id() finally succeeds.

This patch changes ulpi_read_id() to return -ETIMEDOUT when it occurs and
catches the error in dwc3_core_init(). It handles the error by calling
dwc3_core_soft_reset() after which it requests -EPROBE_DEFER. On deferred
probe ulpi_read_id() again succeeds.

Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/usb/common/ulpi.c | 5 +++--
 drivers/usb/dwc3/core.c   | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index d7c8461976ce..d8f22bc2f9d0 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -206,8 +206,9 @@ static int ulpi_read_id(struct ulpi *ulpi)
 
 	/* Test the interface */
 	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		return ret;
+	}
 
 	ret = ulpi_read(ulpi, ULPI_SCRATCH);
 	if (ret < 0)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 648f1c570021..e293ef70039b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1106,8 +1106,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
-		if (ret)
+		if (ret) {
+			dwc3_core_soft_reset(dwc);
+			ret = -EPROBE_DEFER;
 			goto err0;
+		}
 		dwc->ulpi_ready = true;
 	}
 
-- 
2.34.1

