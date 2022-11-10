Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289DF624CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiKJVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKJVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:12:09 -0500
Received: from mailfilter06-out40.webhostingserver.nl (mailfilter06-out40.webhostingserver.nl [195.211.73.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F652180B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=cdesS2DQFWedzwuFw/fxWGknLLF3dzMaZQT1dpDtHwc=;
        b=caJy+WdUvdRTLCqJVb6LWi2k99CSVAX9qHeRm4DPOqprEfR3XiMiCBE5DIiNwZl8o5XFGSGeA6qC9
         Eqp0ADROaIQLGDl3GrQIWo6MLEnpChexBXHJaALaxLkmeN0qvdWfYYmKQe2AyfzzE+BVLKHL2t3UUQ
         t+AVzLT/+l0RszEnu3EZ5XdbT+CUsQjztrk/oW2rToUEh/8MhxhqapOifrzqii+hrgg9A2Gm6RS9ME
         i+3iPpZTm1K/3Q0SlTdZ5ixIQzKbUVtaMe5/q28Xw7+CLwsVhWcTBKRa79HrAc+s2gsrLsBYKE6Vo4
         PVEtjZOy53fYf/CM8oGguQKP1Vvh19A==
X-Halon-ID: 5285229e-613c-11ed-837b-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
        id 5285229e-613c-11ed-837b-001a4a4cb958;
        Thu, 10 Nov 2022 22:12:03 +0100 (CET)
Received: from 2a02-a466-68ed-1-7ff6-3899-7171-85b5.fixed6.kpn.net ([2a02:a466:68ed:1:7ff6:3899:7171:85b5] helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1otEqA-005Dpg-28;
        Thu, 10 Nov 2022 22:12:02 +0100
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
Subject: [PATCH v2 1/2] usb: ulpi: defer ulpi_register on ulpi_read_id timeout
Date:   Thu, 10 Nov 2022 22:11:31 +0100
Message-Id: <20221110211132.297512-2-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110211132.297512-1-ftoth@exalondelft.nl>
References: <20221110211132.297512-1-ftoth@exalondelft.nl>
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
provide the phy. As a result usb probe completes without phy.

Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index d7c8461976ce..60e8174686a1 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -207,7 +207,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
 	/* Test the interface */
 	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	ret = ulpi_read(ulpi, ULPI_SCRATCH);
 	if (ret < 0)
-- 
2.34.1

