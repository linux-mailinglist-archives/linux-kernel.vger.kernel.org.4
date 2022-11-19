Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2C63108C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiKSTyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 14:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKSTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 14:54:34 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85765165A7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668887665; bh=ZzvCx/aKQd3EBJiLy/UGUsE7vHM6TVSTh1wAr6CeKRc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=lCSzw6arnyhsMU2jhj2JAJ6v39ZZEghds1jmihmrtdDk48TvXpqDehIjAkkHJ+eLv
         GcQyQoD2ej/wsYB+lhFC1qcmNTW+Qg7dk+nrtfxBq0PBmng7uHifQU6pDSCts7EemG
         8B4DY8kWoQCpYQnScxRg/5TD2MfIDkjIOP1awN0c=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 19 Nov 2022 20:54:25 +0100 (CET)
X-EA-Auth: YoniFlBPfdtLBBKBkWGtb73v/GdX0sJh9s2NeO1AaQWeVUawd3H2BKTvclMzz/T07W55oJrfEUk89QEC2n3jFxzh/Throbsk
Date:   Sun, 20 Nov 2022 01:24:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     drv@mailo.com
Subject: [PATCH] staging: pi433: set DCC setting to spec recommended value
Message-ID: <Y3k0bbM2/5jXfNKQ@qemulion>
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

The DCCFreq value is used to obtain the DC offset canceller cut-off
frequency. Upon device power reset, the bits 7-5 of the RegRxBw register
that represent the DCCFreq setting are set to 0x4, which evaluates the
cut-off frequency to be 1% of RxBw.

In the current implementation, first, there is no configuration variable
defined in the struct pi433_rx_cfg for the user to set this value as
part of the UAPI. Second, the code simply ignores the value of DCC
setting and allows it to never change.

As per the RFM69HCW tech specs, the default value for DCC frequency is
recommended to be 4% of the RxBw; which requires the DCC setting bits
to be set to 010. So allow the DCC setting to change to recommended /
default value for improved rx sensitivity.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Please Note: The proposed change is compile tested only. I am unable to perform
device based testing in the absence of the hardware, both the RasPi board and the
Pi433 device. Please let me know if it is necessary for me to test such patches
on the real device myself. I will stop sending the patches till I have the hardware
to test them. Thanks.



 drivers/staging/pi433/rf69.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..8468d4717dd0 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -465,6 +465,13 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
 	// read old value
 	bandwidth = rf69_read_reg(spi, reg);

+	/* DCC setting bits [7-5] are set to 0x4 on reset. Since there is no user
+	 * input available in the rx config struct, we should set it to default
+	 * or the recommended value as per the technical specification.
+	 */
+	if ((bandwidth >> 5) == 0x4)
+		bandwidth = bandwidth & BW_DCC_4_PERCENT;
+
 	// "delete" mantisse and exponent = just keep the DCC setting
 	bandwidth = bandwidth & MASK_BW_DCC_FREQ;

--
2.34.1



