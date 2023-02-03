Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A596895CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBCKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjBCKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:19:44 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F4D8B7E6;
        Fri,  3 Feb 2023 02:19:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id BFC5F1863E8A;
        Fri,  3 Feb 2023 13:18:33 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hEE99ydb8xu4; Fri,  3 Feb 2023 13:18:33 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7014D1863BFD;
        Fri,  3 Feb 2023 13:18:33 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sntV4lUThDfK; Fri,  3 Feb 2023 13:18:33 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 018591862F44;
        Fri,  3 Feb 2023 13:18:32 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] goku_udc: Add check for NULL in goku_irq
Date:   Fri,  3 Feb 2023 13:18:28 +0300
Message-Id: <20230203101828.14799-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before dereferencing dev->driver check it for NULL.

If an interrupt handler is called after assigning
NULL to dev->driver, but before resetting dev->int_enable,
NULL-pointer will be dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/usb/gadget/udc/goku_udc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/g=
oku_udc.c
index bdc56b24b5c9..896bba8b47f1 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, void *_dev)
 pm_next:
 		if (stat & INT_USBRESET) {		/* hub reset done */
 			ACK(INT_USBRESET);
-			INFO(dev, "USB reset done, gadget %s\n",
-				dev->driver->driver.name);
+			if (dev->driver)
+				INFO(dev, "USB reset done, gadget %s\n",
+					dev->driver->driver.name);
 		}
 		// and INT_ERR on some endpoint's crc/bitstuff/... problem
 	}
--=20
2.30.2

