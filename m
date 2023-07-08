Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C168374BE74
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGHQ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:28:27 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D373CE50;
        Sat,  8 Jul 2023 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688833701;
        bh=x3AUoKcSqNhyarawC1JJjkAvdYYgLViPABTAWorkKAs=;
        h=From:To:Cc:Subject:Date;
        b=olWwJn9WTQk117RaZtS9TqYqreb++yJWa4QLLOyQrfxB5eiG7+Ni17VfRmRmPwyPA
         cMIR82t5q1gwbV4kmgp/jPLQA5FZs9nNRk12x/25yO1FTgGj4G/wDHeAvz2RA4e22J
         xC7PEE8Xno9UHJJP792XY+z++f1D0d9X40wVBF2c=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 7131229E; Sun, 09 Jul 2023 00:28:19 +0800
X-QQ-mid: xmsmtpt1688833699ti4upo64d
Message-ID: <tencent_C91402509924D86E026B3BB65AC0523D5609@qq.com>
X-QQ-XMAILINFO: Md8NwmqZYy3f5vKMkllD00Acay+fZZ/cWNLpWsleYb1Y/PbBxy//MxpKCeZWMq
         wdPVwWx/K/sp/drr4RbcKVN9fqllhk2kRKy/nqhOAmSXI6hLNSiPGqPp1VUXyV3joMYdlqOUIR41
         lNG1IWG3JPsMTJm0Xx2SIn7bu04LrHL6CkyIVMfDCpkcRmQT7vhgKwxtVzKzCaixlAtfc/lJETbi
         6SCWDFBnBlYDS9qAThsgmg31tSwAQ22ws+lnF59VG4xKAc+EGh04z7klr7/SXQDCcm/5w/GKTNEX
         B1HJNICyLHbP6JLROZGXoAXc9uPeUpsETgdDKZ90QxTooRTKsUWCnDe7LsiuVqyGbQwp6b00okef
         eMkkOCyHk6AFWu/7P+sjck0hD/hPL9PWPSrdgc1lneRGCauBr2YPfa+AgoKIFSokY1iBfN3Zqh3L
         8ZoZmg7rvrsYWzlG1BuHydNyrofcqNbAL/4HWQGmRSHs46NKIp8mmlMd3DzTV5ZmVZYB/U2tvWf5
         nbQetljIQeWbppmQfK564Jmxbdvlj24M3giJc2Ig3dFlXRfVEIV7gDtPwHQ+otpbxHSexCuQVkKS
         84mTwt1Ei1I0WyB1tKAwKOIdi4q7OhXRauw8vLjF2+vTVTT7IPMA+nwBIe9eGTxfQIqsKMYFrgN2
         tX15HQ3xW8/3s1wZvuEijMxH7/eRLjtlEmRlp/WEM5SFynajQewxidkM6VgIxnl9ttoBhpjrmf7L
         3pm23hrU1i2f62/8U6EFt57IkMbwr00FXM/1z5ug/BmhYzN1/hJ6gvQrGpRcBm9FVZqUkVxHAQ1s
         RiP6LLOuGv8L+ezkU5hpWYuW98XWIFun7fxJ45Z2MYujIM8mCJfrfEz57eeejx/hUgaYDXo18BJF
         J6QSQFRtzb1MziOyjjGyYzjZs6CkOSAFq4QFUXwa6cadMtukab0SIX20wJ95gUlHwsEb2pwK1Xib
         bTSDxnEGicX2L2Oz1/amnH47rZTn0ZsW6IXbOaPsFGblM8J52W4cjwyQRymniLaJPFQrRAdauQbF
         nlQ5W0qQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
Date:   Sun,  9 Jul 2023 00:28:17 +0800
X-OQ-MSGID: <20230708162817.3797791-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In az6007_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach az6007_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 2dcbb49d66da..2410054ddb2c 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -788,6 +788,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C W addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_WR;
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
@@ -802,6 +806,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C R addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_RD;
 			index = msgs[i].buf[0];
 			value = addr;
-- 
2.30.2


