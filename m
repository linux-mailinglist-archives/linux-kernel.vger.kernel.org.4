Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3828774BD22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGHJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGHJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 05:38:47 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBA191;
        Sat,  8 Jul 2023 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688809121;
        bh=nVLtRRwwceh9fQVqJz+TakQQmvjBJzFSWM3aixOvYTk=;
        h=From:To:Cc:Subject:Date;
        b=S+i/ANwoT4jg/ciIhUsYfyjrd3Ub5toXBjQcGqzdU7P+7ncyiDmpHN55ZJcQNp4Cf
         mIEHNw6msGS1cyjG/4IufleJrrT1x5wCzhqRylkSvohTJScWV7420OswBLas8pE8Oa
         k3RXBYKm5d5sdz4kTCdc0RhTOzutCR1+tUSRykHE=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 77AA503A; Sat, 08 Jul 2023 17:29:58 +0800
X-QQ-mid: xmsmtpt1688808598tnbevog7l
Message-ID: <tencent_0CAE84EB4D452DD8560158AD0792021B6A06@qq.com>
X-QQ-XMAILINFO: NMmJpeSXIGQNlLllWTDWR6ktexkU6Mk4jyf+NPChqp8ijXM2pwsZEQq4jAlfFQ
         EBriLnLf9C0als78nFj6r3ofJzbc4CvZ+4Jp6jd3ZhU0tCjyPYtG+C/+kVWdOTKhdZKRvVF8o0Bc
         V6UCdaQlr7usVxhucKINM3q5Xc23v57N6xewsBKq+8InWvMeohRKB6uA0MPxXLBKWSghiTRih0z8
         aeAxxDV60UY1ripNsFqKWrm0IBnELqw5GsEH6nHBHBfgCsxjNapBM+bm/HwFu+3lJt/qyFs7dsk+
         T8vKgFA+z4dqOqwW/vZCX3Ja6KYSJswBm/o2bXDRbXUI+Mgb4W5a/gORBCxoSpP4KLxFdm3oIq5E
         vmg3Xo1dn2bjbIU3LqR2biuhQrnS2xeq1i6PWGQnRq4/5Xe3Eiuxe71UbnYbsd9Xk53qWpHmvm1i
         yZ67YC7XA56ddkKbTQvMHJnPBHo4ymNwboQ7+FP3maIqDmbmdqtzea3BVX6IK7XcOQaD7H38U1KO
         fmBw40wMFKNo81taefi7SiTqIjrXxq2bl8u+On4nqVMQR35JbIBII3OEjMItMLW8eCPvFDm9saK0
         1o86EFx3vD9sX79mLcKUgsNdWRjsdkWqFE4Rq0iZYxBpJzFlpyLaq5GFDwQz6geX5VDA99QLtCs7
         0WTsOkiIiygzLQhb+PQ0Gh+rPs1POCTnoaRsAVHn3PTO1cBT2pRgNzYgbXUzkdyWnj03JUd8GbdK
         n24QqB2A9qPk4jm8EIF4J0VkgiKNmu8v5UAR94FwVJrllxi4NJcBrhoSOTv4PVhbeYhJOl9GR2AV
         OdxHe+bucbywzV4A40WYkAPEdBpf3iiMBSxlmGkUwziTUyDpnkbovFl669kfAcPwM9GRuOCaPX1B
         /8RP8Af9Z3EkgDGw9Ge1W5u0mMDOgEeJqRmiRrrb+/xMpBEBpGWvv65FdqPyNOgy/jwh4voxxvrM
         A0thGkrRlxuEPUq5DTOhSwMeSBCnADCXfwKh2AtKAYQMrDbUq29g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer
Date:   Sat,  8 Jul 2023 17:29:57 +0800
X-OQ-MSGID: <20230708092957.3163837-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gl861_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach gl861_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/gl861.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-usb-v2/gl861.c
index 0c434259c36f..a552b646d407 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -97,7 +97,7 @@ static int gl861_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	/* XXX: I2C adapter maximum data lengths are not tested */
 	if (num == 1 && !(msg[0].flags & I2C_M_RD)) {
 		/* I2C write */
-		if (msg[0].len < 2 || msg[0].len > sizeof(ctx->buf)) {
+		if (msg[0].len == 0 || msg[0].len > sizeof(ctx->buf)) {
 			ret = -EOPNOTSUPP;
 			goto err;
 		}
@@ -120,7 +120,7 @@ static int gl861_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	} else if (num == 2 && !(msg[0].flags & I2C_M_RD) &&
 		   (msg[1].flags & I2C_M_RD)) {
 		/* I2C write + read */
-		if (msg[0].len > 1 || msg[1].len > sizeof(ctx->buf)) {
+		if (msg[0].len != 1 || msg[1].len > sizeof(ctx->buf)) {
 			ret = -EOPNOTSUPP;
 			goto err;
 		}
-- 
2.30.2

