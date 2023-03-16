Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F76BD07A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCPNMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCPNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:12:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34891C8892;
        Thu, 16 Mar 2023 06:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B75A9B82165;
        Thu, 16 Mar 2023 13:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E5C4339B;
        Thu, 16 Mar 2023 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678972358;
        bh=HL5dP7MWYjnhj6/1lI+kn8CzDcAzNvbbqdPcXur2MCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTXdqjQoiuRzU9sGCrP5pIDwZbI36MUvIl2syt78U8Q1x2dITlM6k6lIpq//C1r7L
         8Ax+afySJ4xU4jESkys0RreCRvk0hrRP2u7x7r6Y+znMTughoGvEAnElXfaTieSg8d
         mtX8OTTQJUHN7L3oskDeXqp9zMbW4R7AaTwAc6BUDeqTYQLi6782iUp92Z3ESQlqWC
         1xDhXj+bafQcZqfJAkwLEZ3dq42rtDOcQPWoMXDfx+AbR/kGE+zMujU9Ud7jm4N4lp
         O2Tcx6SLe9aTEWwPWt3RtcvJQgPPOUEhrd8QGjhzI50beb/I9Qd+F5ocTLTRpVsn/w
         JXyVJ5bneti/g==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/3] usb: dwc3-am62: Enable as a wakeup source by default
Date:   Thu, 16 Mar 2023 15:12:25 +0200
Message-Id: <20230316131226.89540-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316131226.89540-1-rogerq@kernel.org>
References: <20230316131226.89540-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB module can wakeup system. Enable it as a wakeup source
by default. Finer grain wakeup enable/disable can be done
from the power/wakeup system control file of the respective
USB device.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 867bfa1252b8..859b48279658 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -241,6 +241,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 
 	/* Device has capability to wakeup system from sleep */
 	device_set_wakeup_capable(dev, true);
+	ret = device_wakeup_enable(dev);
+	if (ret)
+		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
 
 	/* Setting up autosuspend */
 	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
-- 
2.34.1

