Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC56274BD3E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGHKXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 06:23:03 -0400
X-Greylist: delayed 3178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Jul 2023 03:23:00 PDT
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C619B2;
        Sat,  8 Jul 2023 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688811776;
        bh=Zft3275R/gNEdDogJR51f0Rv9SoehN12HICcmax7j+E=;
        h=From:To:Cc:Subject:Date;
        b=DYTDspOtmffw+3/LKB6On7F5OBX2ZTAV6iFLVZ43MewUjZAVI68UNKZsu2x2W6wW2
         UcUCpDrjzYKqSS5Uzd7/AUgd6OteEQoQqyIaiWG/4yWbRQlvHieYAX959xnvIOz7xB
         nbcP+Pus2vpz5NLzTzj8utRZAGnRPibY0pI4ZvFA=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 5B61BA07; Sat, 08 Jul 2023 18:22:54 +0800
X-QQ-mid: xmsmtpt1688811774th5kfjqu3
Message-ID: <tencent_1E374BB54B5BE160B01E9C0A4DA85E123608@qq.com>
X-QQ-XMAILINFO: Mee1Vp/QiDAWYUL9X/K7f2IQyL+ysc2nxidvE0II+oq+1GpCmtcB4XJbBPApUI
         GhydNrfsUks8ZF3r/hdTAljA+MNZm5t+PfD3typDKhpbQyxWa3c73NcrZq0Q2tlFiSCpqn2IxFM1
         ZiyLFg1yZY+PvRRPK2GmBL/GomqRyDSItDQa/FimchFpcLH2VyVB8zuy+vJ7t2xcOFTo6M0Mzwk8
         9PjPzZXdb9P6ErruAJ3vJzUBh++aSqM7kVR/a54XpEG/ikdwmiiw4ci/205Hw7EzDm6aPgf3IdCL
         OWwxVY7ifGojRGD1tapptIlCzzQpPoyCezSKj9zenl4Fnay5fOS9ifliZP85GVA13pReogSB2t9Q
         n3Ex5YVHGs4mmWqMjDCY3uUgBc74ybCe4dUowY13XFjp0wNO0BPs4fr4HPMAzU+n3q5ZhBQJ9DWg
         IemVCZiDJ2qS9xcVAxmywEbcOuUz5Mt+PCBPEYmo5GX/cLZBaiulxWja2s9BcBAI8UE+FsG23Eg/
         pXKRBIzC+RVYNTWjVtLLIoyHkDby07mT4Cf7mJA6Uor8wfZ3GGOCdAud8CPP4L25Oc802UzB2mKH
         Q4JUKxbOLtCpRQmpa7DS0u1pGn70o+vgVBdeJfRbcmMRANtS5qXPjeT5LgCO5vaseOUqPgfGXJu0
         2IJ9VRl2q2Oku7JAH8nXVtdXzML94ZVi3mPvHV0ZiMqGHnirapKiEp2tjERz+YYwG5yD1+t11LRk
         ks7HGnkfTlT0ha6sSqzvmP6l9TtwH4JOinlPJMa4g+t6J8NeVDyzEZ/zgH27ULiLDNTqs7jUvKgU
         TkaJtHgS5X3alSsUpIJEXx0pGhrqMDsbqN601SnSg9W4W94hxTSscHjZHmGkuJXfR9RKpq7FRsWn
         2egc88J/2cbUjuORczILYKC2YPl9u/NaXErkC1yIxKTGTZAfudntEaNrWfv5uNoxOnhP6+CMwIfQ
         d8JxOx45XCQAm4SRt1v6j/p3mn95v8NnaNm/M6BGIDVVruyYad0A4Y5j9fB+03sZ/zFpjswRPjHv
         HVyY9uaA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     mchehab@kernel.org
Cc:     yuzhe@nfschina.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
Date:   Sat,  8 Jul 2023 18:22:52 +0800
X-OQ-MSGID: <20230708102252.3250422-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dw2102_i2c_transfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach dw2102_i2c_transfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 950e252cb469
("[media] dw2102: limit messages to buffer size")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb/dw2102.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 970b84c3f0b5..b3bb1805829a 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -128,6 +128,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 	switch (num) {
 	case 2:
+		if (msg[0].len < 1) {
+			num = -EOPNOTSUPP;
+			break;
+		}
 		/* read stv0299 register */
 		value = msg[0].buf[0];/* register */
 		for (i = 0; i < msg[1].len; i++) {
@@ -139,6 +143,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	case 1:
 		switch (msg[0].addr) {
 		case 0x68:
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			/* write to stv0299 register */
 			buf6[0] = 0x2a;
 			buf6[1] = msg[0].buf[0];
@@ -148,6 +156,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			break;
 		case 0x60:
 			if (msg[0].flags == 0) {
+				if (msg[0].len < 4) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* write to tuner pll */
 				buf6[0] = 0x2c;
 				buf6[1] = 5;
@@ -159,6 +171,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				dw210x_op_rw(d->udev, 0xb2, 0, 0,
 						buf6, 7, DW210X_WRITE_MSG);
 			} else {
+				if (msg[0].len < 1) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* read from tuner */
 				dw210x_op_rw(d->udev, 0xb5, 0, 0,
 						buf6, 1, DW210X_READ_MSG);
@@ -166,12 +182,20 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 			break;
 		case (DW2102_RC_QUERY):
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
 					buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
 		case (DW2102_VOLTAGE_CTRL):
+			if (msg[0].len < 1) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-- 
2.30.2

