Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C974CC37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGJFcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGJFcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:32:22 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77325CE;
        Sun,  9 Jul 2023 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688967137;
        bh=WJHvz5QCeL90mPeuiGPZf7IOaS3JVSfc/j9Z8sS/Wfw=;
        h=From:To:Cc:Subject:Date;
        b=I/uwn//iyyIkVQ1uHOln3g40X8ATnmucGavwvZ5ErwwZnr7bb8LZOf6sD1AmdwOA0
         sYp3jBd2Uf/2+rEjiuaGjmEBX645SdqXLxvlo2mrVOCZaAFbiE+Ik7MTMLvVGJRRnr
         JT09C5cabaCweL8emuhf+ByJmJlbuAoL6BEuWw3k=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 80EA1640; Mon, 10 Jul 2023 13:32:14 +0800
X-QQ-mid: xmsmtpt1688967134tv154i24q
Message-ID: <tencent_B9CA519324166FA06A13B786C0123C7A1409@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No4WL3Z6h1jSLIguU5igTiZNAJlMNnsgcxuDuwZn7nFQnXgW6/N3
         a9gtk0I8Cc/9F+RwZfUOKXSfWD822s3tZWbAsljBrobGlEvi+8olrvSqtymbLNm9shg2uK2UygBW
         5IV9KKeXG5zhx7x4gJTYyasTWy6py2EtmzFl0tBvs6kMdI2LHepZLhtxsEkNrgbz1Wa4b7/K5mFo
         oGI5RMSdVV/7a6mP44SzvKyxDxPQ06ud1DxJi8wqOm66MTaJbgPt0BLJWJCtwmXIMozdNa43nGNV
         I6b6zL3bxoKvKkJgRDwYpPcfh2kv9F5q32Mjfb1lZRLNFElxqRs/FN0UGvQNNsdiIE5s5t5bla7d
         XIVp/MS3PoYOkISvjpt6aYOJixbNomDOJiUzpZaXk30SgxcR97K0VDQLxE7m6dLZg/yBQ/MpoE81
         zdOwYm3L9SjizA82gDs+vGzY+StC9+HMoh4ySgAVbsGDZJqp/nPI6SJ5PoZ0EeT6BtPJlCVFJi5+
         /gIhVjwVIvJQvrJUhMqCVW//othyG2Lv2AWVRBpbyn4L2FGy6mH49HdXK0fhIy8Z2BGOwPePlQKe
         cxdXVeJM4GJq7HBZdYxEHRKfjaUr16O8F4BN+yLzAs6rC5ZwjJ9FVplUMTE32Di/xhISQa1T1bcz
         mlIMq5t7cqLQJ8xEzNX1UZrpwq1azFdd0ImlXB9vmSWBKN2o3FnZLlIND5P+elnS+TnDdOGwLnOg
         BbiOp8FMQi5r4Qr4BJv53PkKG5+pQTJYgfxvujCa9lO4f1tLyMEOuq8F+CGfaLmO6ra3S2daXMYn
         YdLUbVNRQzlIlAtHsxuN3m0JoRl3PQ0nYSYsngvMYlvD0zSNbv30Jo0jBZhh1z6yZpLnlm+MZJa+
         VPBBgO7uXPlVnR3DVoMMa+CBr5rLrew+rw360mxdMIqhXVV7NcHfnoB5UBbsWL1zFOQre0mIHUFu
         9GluurSGaSa411+3YvHF9W4pme91SVfgMO11m3FjZuZlq4LNdbUA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, tskd08@gmail.com,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer
Date:   Mon, 10 Jul 2023 13:32:13 +0800
X-OQ-MSGID: <20230710053213.2884871-1-zhang_shurong@foxmail.com>
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
Changes in v2:
- remove useless check statement

 drivers/media/usb/dvb-usb-v2/gl861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-usb-v2/gl861.c
index 0c434259c36f..c71e7b93476d 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
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

