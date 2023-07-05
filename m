Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16A67488EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGEQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:10:33 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4310A;
        Wed,  5 Jul 2023 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688573428;
        bh=hkhS7BUga7h0dP+oGQFEB4g0rF6DTzRYaizAPZ1aOoY=;
        h=From:To:Cc:Subject:Date;
        b=WWxTgZaetbUGO0QdlIGnbk6Y4noqS/9ky6Kt9sjtheE/I8TVrBKN16uS8oA3ODlr9
         aesZqaDxcxgkmJFTOQ44NGFbpb22DQ/wYzaWRlhpn72MyAD9z4MQl//q/IFCy0U+yH
         VV7/rItr1rRnth6IsOp9ZiLW0lGwc5ScLs9eCyGk=
Received: from KernelDevBox.byted.org ([180.184.51.40])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 1B89EC61; Thu, 06 Jul 2023 00:06:56 +0800
X-QQ-mid: xmsmtpt1688573216tm6i9hixm
Message-ID: <tencent_F09F5B5160131E350A90A8E5124E3709B508@qq.com>
X-QQ-XMAILINFO: OHNqCmPDT5DPHqy/g8rj3ZsUy3DDAT820YPAinLRcDOxZBFNA6J65WP2J56A6e
         zCMZP/0BubvZWvgLWngkfp95YQa3lTn8RAx1cvkAX2DSwzyDj4SkBa6MLiCN5wDZFU9a62CYpViH
         nvCRhO6VhE+6Pnvo+bh1iReV9x9SrWdLucwdw1rC+TImvO8esTW/xTxcgZ7AwJVsf7MQC2nDcVwU
         kMdLzdgDsekQRDVLAwfEm4gMq/3RzcxHg3B907DBHiKeSrxtoS2908r2P6A56mYl58WDrH+chnHc
         1w+vksSCk9Uof+VVPccXJQizBhMA8YqsuLHMGODwNrRSR8chJSICk1GLU9J3RXJ6QO22rbt8B22a
         iKUyvErn73YvGMSg/hkqHgfFZ97cD08E1l7iVkoTEKB94lSZJDQ5I/b4i8LMcOXH+PJ0yygkgsyz
         CSQlLD9bkkAZufduJNqcZgkh0WthgNpsCIswMVp5dnf+Q2Zy5l8wkJ5gFUeZjECqEgCu9A1UVVUS
         As4Mq7oWL7yPD+GgfxXtpAeQZa6P1miEdm54byji7RC+TZV8RPwaIVMA50lpai2215xzDMdHknZo
         nTIfCVSycbQOWIhkI+uD2bJqp9tKKvQMTynd8tJZKljIZkSDivPmYXHzynIVrLKwZUFB0CgXpPp1
         6NtRgR6kavJU0Ko/aqNHeEWrylTQhDJL07OukY7tlGg+hjN4krn8syMquV9ulNoR3hA3o7/EKKYK
         0Gv3KnL7SBj4A6TgjotwmqcK1ydhwcILgOykt+U6UqbTpGrjE5/ZaEoGqIsm6LQPNx+x6kM/vqaq
         aJsjfANR8wwIac1f74Wx3rDwccYqM0QfgxYrIHJlvPgzlejrmFcmuUx+6PDgwvQsMY/BeCcJHF7S
         qO5yL+u97FvQhBKIv5LR6hLmCaZJWL+rXMtYA+SuLSAg6VZdfMb/FSwxTV8LnDnNlDMeljR3VBu+
         dERFqU53MABy48sIZyBsG9KWa+vLASTRIH+fBynM+8cUz6L6YNMA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
Date:   Thu,  6 Jul 2023 00:06:54 +0800
X-OQ-MSGID: <20230705160654.1347223-1-zhang_shurong@foxmail.com>
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

In af9035_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach af9035_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 1e9c8d01523b..33a2aa8907e6 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -322,6 +322,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3 || msg[1].len < 1)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -381,6 +383,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -388,10 +392,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
 
-			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
-							         &msg[0].buf[3],
-							         msg[0].len - 3)
-					        : -EOPNOTSUPP;
+			ret = af9035_wr_regs(d, reg, &msg[0].buf[3], msg[0].len - 3);
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];
-- 
2.30.2

