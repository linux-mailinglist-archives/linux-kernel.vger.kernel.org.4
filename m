Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56308624CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKJVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiKJVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:13:21 -0500
Received: from mailfilter05-out40.webhostingserver.nl (mailfilter05-out40.webhostingserver.nl [195.211.74.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F885E3DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=A4MtRV/Oz/92ZR5qGyeTjm00+NMx36cJ5lbhoagSP70=;
        b=Mv7dlS1SmB5BpnCMLPauvzc5SGhClRH8tqUa1YhqKZsA9nFJTZk6I5VX/EcvmTFDsEo9BBEAiC+sB
         eCjKeZr8JwGdRLXgtoDNe6HSZFOxP9bjE8BAobx94xsx5KJV0dnPAFnEp90Xd2snK4xRdBWL3tRBH4
         XHj3yDb3ahhc8f3UTUhA8uqvDKG+wQHnIox56svGnnPmGOTyuwQBAgjltW96d0LP7R6tEdS0luUeFZ
         SSzeqipG02o+WRR+ZoE/vZ7oitBhMTlxjkHRb8eGO1urOXGY24CF7Z1CHoaHHo4u4YO5POtlF1bcn8
         yKtsUCgu0viJsXgB4oRgSk/Rfx+pJmg==
X-Halon-ID: 580cd1a3-613c-11ed-9686-001a4a4cb933
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter05.webhostingserver.nl (Halon) with ESMTPSA
        id 580cd1a3-613c-11ed-9686-001a4a4cb933;
        Thu, 10 Nov 2022 22:12:12 +0100 (CET)
Received: from 2a02-a466-68ed-1-7ff6-3899-7171-85b5.fixed6.kpn.net ([2a02:a466:68ed:1:7ff6:3899:7171:85b5] helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1otEqJ-005Dpg-3B;
        Thu, 10 Nov 2022 22:12:12 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Ferry Toth <fntoth@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v2 2/2] usb: dwc3: core: defer probe on ulpi_read_id timeout
Date:   Thu, 10 Nov 2022 22:11:32 +0100
Message-Id: <20221110211132.297512-3-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110211132.297512-1-ftoth@exalondelft.nl>
References: <20221110211132.297512-1-ftoth@exalondelft.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0f010171
Dual Role support on Intel Merrifield platform broke due to rearranging
the call to dwc3_get_extcon().

It appears to be caused by ulpi_read_id() masking the timeout on the first
test write. In the past dwc3 probe continued by calling dwc3_core_soft_reset()
followed by dwc3_get_extcon() which happend to return -EPROBE_DEFER.
On deferred probe ulpi_read_id() finally succeeded.

As we now changed ulpi_read_id() to return -ETIMEDOUT in this case, we
need to handle the error by calling dwc3_core_soft_reset() and request
-EPROBE_DEFER. On deferred probe ulpi_read_id() is retried and succeeds.

Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/usb/dwc3/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 648f1c570021..2779f17bffaf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1106,8 +1106,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
-		if (ret)
+		if (ret) {
+			if (ret == -ETIMEDOUT) {
+				dwc3_core_soft_reset(dwc);
+				ret = -EPROBE_DEFER;
+			}
 			goto err0;
+		}
 		dwc->ulpi_ready = true;
 	}
 
-- 
2.34.1

