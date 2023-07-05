Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07DD7487B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjGEPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGEPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:19:12 -0400
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BD170B;
        Wed,  5 Jul 2023 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688570346;
        bh=2d4C37vHOrdi0OO9Rhqhynwy01/E8ygnR5bhbW9of4c=;
        h=From:To:Cc:Subject:Date;
        b=J3bPwYiuTNcKrv9uudBp97Hli+sKQ10EQ2BsQzdwHC6pay5LMfCGvH+6rrP4Yp6ZE
         SzCOgADoygFJXmf4/RwqqgwbqoqOY4kurzmP1VQFpnU2TEpIarX2Qq4QTjIeJa6QZP
         cN1FU5JqURzpQI4OzcFSNv8IKBmIYoh4YPC5jYqs=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 2AE37A77; Wed, 05 Jul 2023 23:10:46 +0800
X-QQ-mid: xmsmtpt1688569846t1sorvnm6
Message-ID: <tencent_D74C0118F55D22E6A6B1767CCB01CCC1E305@qq.com>
X-QQ-XMAILINFO: NMmJpeSXIGQNty4hmHbo9gpwyyQqd59lGplGiTGUNZ6P7tsjc5H4PcG+vnZ16o
         XXVuWcXfP9ovPspBmVHpO3C48L2vfODSOXaD3SOhqTzhE6teaCQq1LcbFVVpj6URmrtjKLbfgqmi
         sZZfHQSsGlYWrTlvuZszL3r+Cfj1/HuwCv7gHvuXrPEAiudIElwgQrGg94ESE1iWTiOYDf8lZ+oi
         /GXmOxV+xQvZ87O4vJbJNqz7Bj2Bz6yIXA8Jh0XGcEU4rLrrp8yDFaoKf73PqMxhi/18kxW41fv2
         kUhkTPljwHhfD3tPOvA3flK/2HnzXwUpQl72xS5KCBjjxAplaC2B7pVA2Ef3qeZQmJJ2YGFbnUse
         RnLCJ5by1aSiFpINk1fG/9OnYO0RgghRUTdFjhazTzq6ckjsinqAWWmsomYQOvMhvNF528sTKA5e
         F5fYeAmNdWtTb/ico6yF4Rgvx7nkfH+XbqhYBR7gGBxnco/qU2wlKZULBMg1w2vmPq6sYmNkHp5/
         jy+v66k2WpyNmiiiLnbpoNCmZqSJ8ata6weAY3pZcNrZHu+MW/NDFdJ1qEWf0yVLyeEoII7sBkOa
         okUcHsB/rdU2UBgO5IB22SME6jUxS3ZEb5WG0NfpI7pMzveiLAzTGNIUtIsTO36TpAsUFdpclxYZ
         IuSpQK54C0st0wPxsLsc0Nkw6+7cp11rg2Y7jMEbIKpFUPsGluPoKsB0z/O5dsRC8KCcvbP6+JqD
         t9oF7haTqxQSzUuDbfCTvLnQwxL0c/36zfO71WShmUtEOca87jyxBsJsXXtISXyipwl++Sb5my7s
         ibMig+SWQ5MeUgS38aKIbUZz3JucedqeyLYAqNMZ+jTq8IxiuCA4mGSL8JeGcprFjMnTttCa0b3j
         2GA3yoWaHzoJdcefwY3UXC7iN/V/kTBKSCsGlX8yWYMOcI95sJ/5roUYW6IwPsfI7ofw2Cozbxz6
         2D9QnLhenWOHN3WcTko1YBBN+DuTzvTlHD0PEsg4V+hHrvraA2AOlmrOt3T8gETi1JjIUPoAs=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v3] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Date:   Wed,  5 Jul 2023 23:10:44 +0800
X-OQ-MSGID: <20230705151044.1159881-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
should return negative error code instead of a positive value count.
Fix this bug by returning correct error code.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
- fixed compile error
Changes in v3:
- Corrected the annotation of this patch
- Used variable ret instead of err
---
 drivers/net/wireless/realtek/rtw89/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1db2d59d33ff..a4bbac916e22 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3026,17 +3026,18 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	u8 *h2c;
+	int ret;
 	u16 h2c_len = count / 2;
 
 	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
-	rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
+	ret = rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
 
 	kfree(h2c);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static int
-- 
2.30.2

