Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C874C108
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 07:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGIFEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 01:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGIFET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 01:04:19 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9FFE;
        Sat,  8 Jul 2023 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688879053;
        bh=2w9Ob3VPQ9Os5ZjD5baI+SINI6IqLXe9l6ekBIWOX74=;
        h=From:To:Cc:Subject:Date;
        b=q6vYX9LBGG98Ceo8dv2JLWHjRaa5igrg/ZYqY50QV6qhc765u2LUZDSXz3npaseAj
         2Wuu9D0VaeLkwj2xl9aIjrVjH5GghXU5vlI7FEG1osaWavQrcHHeXgpxyJoDIRj7gu
         tBRzeyen2Um8tGJlYI94y6kWQ8Q75ShOiRt+t9LQ=
Received: from KernelDevBox.byted.org ([180.184.84.173])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 10B11A2A; Sun, 09 Jul 2023 13:04:11 +0800
X-QQ-mid: xmsmtpt1688879051t9yovwwoe
Message-ID: <tencent_161EA00A19A8A6122237C3B5075B21606C08@qq.com>
X-QQ-XMAILINFO: N2/jAoEINgTTLn4HqVv2yRmX5fLfUezUspKpN+B5r0NLI3YPSFq7IcK0iQyY9W
         tdRJ6EMYsHTy/S+kAWQJnqXc/IUAKWHPxHGb4A2Gh1hpkEengPWb5pKbK2J8wiXCTvgVq351iM27
         Db5Ty3FfbKF21tn6sgkl3kMWi/nnlbGeVoqAJrxUVD0/fneLTf4VLWI1Hj6k1J/IpUzZ1oihLpM3
         +d6nLIxixXjC6iRaEQ8jTNlUdDpOHLHBGXrbcoxRxxngqZ5Q5NnVCWai/oqfpE6ut2P3Q1ewLwBD
         B4N+UOrHGT9gy9sJ5Stgcyb6paFu3eVXNBDl14XUZYHdppm6hm9RPJzOKnijyU5TxJQ2KbbV5rZp
         Pkr32sIfIx+saN4UU3bVI69xDgUoYBfX68sh0deHYqYIDrO9hjgaNEPMOFNo3GCAkYwAjECUtydH
         F4UXNyZXaW8py7MfVzCIGJdwyTzs539vTgHlJ4C4iW+dJHaqB6A99nO1gApzhy1RUsD0WxJZSWzU
         j1kB0cJqGoVx0howdEXw8rmmydNJcjLRdjgIHaXLWqRN8veDJ7SOSqEqHIn/JOSjyTNxUCffqMT5
         tE4Ht6j+ZcmYsA153evQOevnRt3c4/sqWFftQMNqraw17QRMNJtysrES3WKPhXiXJRg0wGphIKLT
         hrVjz7zOJL8yYvOU8OaDLjgVHnWbM/VV4GGOoNq86kLmRY81B4YHj2uG5ZHO3ulO5BqdI8xlnwtv
         heC4b9JGehXT0nbUWqSi8nNOkSRv16TeWemI7REhmvqez43abJpDIiV3yxd63cD8Hua3Greun6a6
         rbbtDrREBXEDp6cWqNAA+Jc+FHqQfovsR2TSbFO3PI2/IA1F2t1EUB2eM/XWR2Yo0F90AziXH18N
         y64Z8SV2rsOW0OE872e7dp+zmlk8Q+lEIGwJ4nnQSj97qbcIQfWCjfkexggLPypNsPt1ca2zzfGZ
         RGHYO7eTFEKDz1HRZwrnWMo/9hXY1C8p2VFJ/p+vDtSdohOkNSHwRpbsSYUCaE
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: dvb-usb: opera1: fix uninit-value in dvb_usb_adapter_dvb_init
Date:   Sun,  9 Jul 2023 13:04:09 +0800
X-OQ-MSGID: <20230709050409.717720-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If opera1_xilinx_rw fails, the mac address is not initialized.
And opera1_read_mac_address does not handle this failure, which leads to
the uninit-value in dvb_usb_adapter_dvb_init.

Fix this by handling the failure of opera1_xilinx_rw.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb/opera1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/opera1.c b/drivers/media/usb/dvb-usb/opera1.c
index 98b2177667d2..d269f8bb2dee 100644
--- a/drivers/media/usb/dvb-usb/opera1.c
+++ b/drivers/media/usb/dvb-usb/opera1.c
@@ -439,9 +439,14 @@ MODULE_DEVICE_TABLE(usb, opera1_table);
 
 static int opera1_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 {
+	int ret;
 	u8 command[] = { READ_MAC_ADDR };
-	opera1_xilinx_rw(d->udev, 0xb1, 0xa0, command, 1, OPERA_WRITE_MSG);
-	opera1_xilinx_rw(d->udev, 0xb1, 0xa1, mac, 6, OPERA_READ_MSG);
+	ret = opera1_xilinx_rw(d->udev, 0xb1, 0xa0, command, 1, OPERA_WRITE_MSG);
+	if (ret)
+		return ret;
+	ret = opera1_xilinx_rw(d->udev, 0xb1, 0xa1, mac, 6, OPERA_READ_MSG);
+	if (ret)
+		return ret;
 	return 0;
 }
 static int opera1_xilinx_load_firmware(struct usb_device *dev,
-- 
2.30.2

