Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67FB74BE5A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGHQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:02:27 -0400
X-Greylist: delayed 2289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Jul 2023 09:02:25 PDT
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F08A1B9;
        Sat,  8 Jul 2023 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688832143;
        bh=BA1iN7Rl5xAhdeMCiTPReGHnDwGFaZmO5OqvBbRDsxI=;
        h=From:To:Cc:Subject:Date;
        b=wFQ9PKVMQx+QvQAmdMiOOdf0ZI4CG934RALerVBXY7b4hXODaoOHQr4BlEa0R4CjE
         ZhIsSGOZLPS05Kq1ttSqeV5CKjv8W2q/OlPyhpstFtJnPC9WDxFj7YIUHpHf06Q+2d
         FxQHKQmyQ7J+OdhjGfpoYPiP5F68mpdU+Bz5BWOg=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 95158D3; Sun, 09 Jul 2023 00:02:21 +0800
X-QQ-mid: xmsmtpt1688832141te6iu6c0r
Message-ID: <tencent_9B1C89E61B915A91AD05B04A0F5D8501D407@qq.com>
X-QQ-XMAILINFO: NyLRYIXSGAqGzyNnM29h6/WWpJgiSe9Ht2gWehetzXiYJcJxUGmXv9yel3OgVy
         bR9ZXjMFM3D+pWxCCkWCYEiknfYZ7ByTrwZAffuBwb6cOIPl5AK9gGG3Yq51VFWwy6BVyjs6V1qC
         3ZlJu/8NYO8lL3GQQSIUwRiKJTNgfsQeWGbP6nhT++qkehKrvdz4SvSvEkcLrajli4xPhZx13u2b
         hZwwaDP0Y7QUXX+zeDBFzo+n5+qoOubGuxeewMmsA3L7FQggELWxAqH2eR8vVOPiey4XKibbnA3O
         Eao1YpETOeuSzeCEcpcYMqaPI/bSTaqZsgCCVHOT/rML575iU0UasoyGeOrAzBwUCwJy2HjFY+gA
         LvJSlX+blVIHea1OROkmoUJvKqddaMevSMUvhUadj90CPKQe8y2TKIyfrCTbdWCRXli7wa4EBLhy
         FbBjs9yfdcqgcxW0/MmpW+pZW2JBg/Ma6BGpqqYzDiu7Zwyms7uERoEd4r6Y5TAb1SZ+qW1+7lGn
         FlGaONnAMvKodUIKbZFoDt8Gceou8MOHtr8D8r1hUr3QWKaMhLCfPbp/Dvry2twMKaay3tlbBB0R
         Bwh1MwpF+HxBo27tMcgGuRu3ZDio0h4HD6wwlK58bC+4FBSik3NS4gUWG4gefkAFb+x+XXy6m8PK
         Q0bl6WzZVTG5mL35gFgU3aTsG+2FOtuS8dzj6QxwGAWDjKfCvoibd4YpE7ytToiWv6aVsQKCcQWa
         erFzHQ+wkt9n1jCzXhllWSJbOKgtOAn9/mW1XIxc2PQ2lYEn3zzqoYPNpQuXLG0pj/FdqYtTWV7w
         b+CRarbdmDbXxFA54SnauRxrHfpICJee7jWQetjPr6dBxysLZ5lz0P9xa0ZZhhHwondDvS9DcyQt
         vRkOdbSZArK8a8yyDsf1aS54g8dH+kL4WVECZj89Z7gQZJDHmdBMycoHH/pBRWfhLzABEM6bpONl
         yZ8jiZ6Ccix6Rs2H2ayW0k7Dfu9xEO21b6MFM/kVQTgxXNgngzpQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH]  media: anysee: fix null-ptr-deref in anysee_master_xfer
Date:   Sun,  9 Jul 2023 00:02:20 +0800
X-OQ-MSGID: <20230708160220.3755131-1-zhang_shurong@foxmail.com>
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

In anysee_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach anysee_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/anysee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index aa45b5d263f6..12c16f09a808 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -202,7 +202,7 @@ static int anysee_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
-			if (msg[i].len > 2 || msg[i+1].len > 60) {
+			if (msg[i].len != 2 || msg[i+1].len > 60) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
-- 
2.30.2

