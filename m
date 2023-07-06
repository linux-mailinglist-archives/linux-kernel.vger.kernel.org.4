Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A447493D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjGFCpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjGFCpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:45:07 -0400
X-Greylist: delayed 41655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 19:45:05 PDT
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80110E;
        Wed,  5 Jul 2023 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688611503;
        bh=JnNzgLB8w6Q6LeQnG1yQwzv12sGbVpzF8oRa8zl++vM=;
        h=From:To:Cc:Subject:Date;
        b=md02HigfCnNlJgh8qtv48CQ5FDlSDY6wDLTggo4T+A7O1HVIawrXaZ8RnZSJippEq
         FnquL8tLNfY0fmNHA/HhbbzPV9eCstAv01xM4ka9fW1sBzkbrju26yFsUSev9ccP+2
         9HHXBPKLkGcybijzqAbv76zJvgAzsExaj81WUMt4=
Received: from KernelDevBox.byted.org ([180.184.84.173])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id B4116088; Thu, 06 Jul 2023 10:45:01 +0800
X-QQ-mid: xmsmtpt1688611501tlubcxggu
Message-ID: <tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com>
X-QQ-XMAILINFO: OWMEtJ003gYqj833DT3+8qFsKE/UfM710NqcxQf71diz6j8S4yyrBbZl1lgOW5
         kluNJ5h2fK888imIlRAZgnnisogMP/WNaRMMrboNI1gkuPqRkid+rufedl9zXqYWqL1ZG8TcphHO
         G2UABFKwmrUT6iyZphZPtkmm5YAWUBKS0n9DXw+01qBwyYuGGoc9cCaANtssPaYczfwRL62YGwnQ
         F1pu6p6ENZJbavbY/o+Bsenr26KMFxtq/ylyzQfAC4z+ad1OkqYjMStr1yaxTzG8UMF2u8i7vivG
         w7RwxoRgkwh/H3OnCgVZzLUS42QZvJXRqFGwL8wdnH7Fy14GNs3L6gGgZcHF9XnTrT7681g09AXp
         MTkJjJ8N5GahoWdTab1CxE/2NJCe1hZaKs8esJb9MvcdaYWnMfz1cIFADMdBWn9njvbrCmDApLKU
         /CmfLKkDQxpesX2rAQ40zgVOCbUzTSPovkcQBJWdaJWnKwupGVoaxH4pPnko271nJfLcl8ZFFlUe
         sy0OD7jwUhBXi4bBD5NspwgmBkmGtRB7I5ZGPHqF212Cc9yaUyfr2m8vVn7RQC1RTiYikdid2+k+
         p9jzODb1DYEaMVIM8b1WqPTgbggLH0ZErzx5aAjm6bkvJPj3q0oiEviu6sQqXfK4k1jslNuqhDzp
         nGwtcOCGckXybakoTmCH2CsDSbuvIl89C1Ae7841jIoT+CLlZNZ/BvC4+tVOupjGrHqUhJ0yYGdH
         LbaQLl7EDfThDO5I2r2nBHz1eXgXM7mP3TnUQLl4R1g3p3lohR+EcjMt8WUBa7f+K+DAASOlLRfX
         no0t6M8noMdZf4BqPbGEWKPXyElRV18/H2ZUOLCZznlOVpC74OPmuXCSCqHV0l03lVVi5sQDU9rZ
         WyBgla9Yx2PK/TF08nVhG5b/6/j+k/KWvQdJBx7LgqhMS+AU3JYh+rf3d81IBSfjtPercJmzNZuf
         v3+AuYs1UfL2RgFd4g6z66xMCIyh/PknHNtEmoEtr9EH7bZ3f2pSMtmKb8NDmo
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v4] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Date:   Thu,  6 Jul 2023 10:45:00 +0800
X-OQ-MSGID: <20230706024500.2285151-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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
Changes in v4:
- Corrected thr format of this patch
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

