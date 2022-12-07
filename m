Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A74645C99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiLGO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiLGO2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:28:43 -0500
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 06:28:33 PST
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC6326F9;
        Wed,  7 Dec 2022 06:28:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 728FC5D88BFE;
        Wed,  7 Dec 2022 17:17:03 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QonOtwzX_AXI; Wed,  7 Dec 2022 17:17:03 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 40D4D5DA93A0;
        Wed,  7 Dec 2022 17:17:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 40D4D5DA93A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1670422623;
        bh=w/yclODkCgJWPfVa/yWAmC2/lYgiHSNRxjwj97Pe/0M=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=hbLN8cD5C+k+gvhwBaPqC/QawC/Hsmh/Xljnq2w6WC9xGtixO/dbbkcQhZaB6jjb0
         j2/f3B6Bo8BGNOw+/8dCnd/yw+jtNWtiP7b1b1MhLsu48N3PO1RbnCjLfrGlTQnGgp
         30XP8l7NNt2YjLfhmYMAMQ6c8dy82xnqtWGMlwhC2BbknTU7SiQOT90o3dmLHeWyA6
         fymtzJnpx/0EwvVRvbdPMP2LmHnoBc2vV37I+/auIHQM1SCsisRwLiv5x/k6rdpf9h
         8aCv+TbTii02CXyVRBk60PoXuFRc6oWs8UGzuh/EFdQZu3xA/LM9s3NOfbJeyiftk5
         NPsHEepkGBVIA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V30dyoE9cVKj; Wed,  7 Dec 2022 17:17:03 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 00F055D88BFE;
        Wed,  7 Dec 2022 17:17:02 +0300 (MSK)
From:   Aleksandr Burakov <a.burakov@rosalinux.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Aleksandr Burakov <a.burakov@rosalinux.ru>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] media: v4l2-flash: fix NULL dereference in v4l2_flash_s_ctrl()
Date:   Wed,  7 Dec 2022 17:18:07 +0300
Message-Id: <20221207141808.22922-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL check added for fled_cdev before dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Fixes: 42bd6f59ae90 ("media: Add registration helpers for V4L2 flash sub-=
devices")
---
 drivers/media/v4l2-core/v4l2-flash-led-class.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/med=
ia/v4l2-core/v4l2-flash-led-class.c
index 355595a0fefa..36cc46e80eea 100644
--- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
+++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
@@ -291,12 +291,16 @@ static int v4l2_flash_s_ctrl(struct v4l2_ctrl *c)
 		 * No conversion is needed as LED Flash class also uses
 		 * microseconds for flash timeout units.
 		 */
+		if (!fled_cdev)
+			return -EINVAL;
 		return led_set_flash_timeout(fled_cdev, c->val);
 	case V4L2_CID_FLASH_INTENSITY:
 		/*
 		 * No conversion is needed as LED Flash class also uses
 		 * microamperes for flash intensity units.
 		 */
+		if (!fled_cdev)
+			return -EINVAL;
 		return led_set_flash_brightness(fled_cdev, c->val);
 	}
=20
--=20
2.25.1


