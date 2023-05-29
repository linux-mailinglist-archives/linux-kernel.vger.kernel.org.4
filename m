Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9D7143D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjE2F6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjE2F6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:58:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7FEA8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:58:41 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3Vttql3Hd0h9k3VtuqAkIU; Mon, 29 May 2023 07:58:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685339918;
        bh=1rNNsFbbX0pydEx0mfhXKwzskrBT02Ah6NfUorn4NeY=;
        h=From:To:Cc:Subject:Date;
        b=m22bL7laIJJVRSQwFiUatK4yYzwyY7/QY5ntEj/WJmyb9T36Sofu5xbL354cKIcrV
         Vu4TynZuBvsyP0E+GGvhVO0L9vrOo5xYhX/pvH6QXRVfcHQQImV9XMYk5S+GKBz9kG
         wTu7pEiykUX6on/HFKp9UrKsnvCfkRn38lzeTXufcb0LZsmFkZ8LWPW8uPkgWzXKCC
         5XcgFDQg/z4yBZj1RFfQmGUh0eP/oAofgunMYxKFPiTJhyPhbwszpRBQ+2As+qA7oE
         r96t4CztFPEuJsJ+Qc1snC5ztx3dOtja/EjEWab4SAgaTNrrFhkNIC/CuFBcQvW3eO
         CPWkG3fUDxH3A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 07:58:38 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()
Date:   Mon, 29 May 2023 07:58:36 +0200
Message-Id: <1881e72f963ec25e35b34f3a0b4f3962681eb7ca.1685339897.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'read' is freed when it is known to be NULL, but not when a read error
occurs.

Revert the logic to avoid a small leak, should a m920x_read() call fail.

Fixes: a2ab06d7c4d6 ("media: m920x: don't use stack on USB reads")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/usb/dvb-usb/m920x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index fea5bcf72a31..c88a202daf5f 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -277,7 +277,6 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 			char *read = kmalloc(1, GFP_KERNEL);
 			if (!read) {
 				ret = -ENOMEM;
-				kfree(read);
 				goto unlock;
 			}
 
@@ -288,8 +287,10 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 
 				if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      read, 1)) != 0)
+						      read, 1)) != 0) {
+					kfree(read);
 					goto unlock;
+				}
 				msg[i].buf[j] = read[0];
 			}
 
-- 
2.34.1

