Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43726663C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAJJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbjAJJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:10:27 -0500
Received: from mail.ivk.ru (mail.ivk.ru [185.6.174.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77735929;
        Tue, 10 Jan 2023 01:10:05 -0800 (PST)
Received: from localhost.localdomain (unknown [91.190.239.60])
        by mail.ivk.ru (Postfix) with ESMTPA id 397B720002;
        Tue, 10 Jan 2023 12:10:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ivk.ru;
        s=FFC20516-06DA-11EA-9F07-2A32BFAFF1B3; t=1673341802;
        bh=Uaa8ydfdH50Mrg+5T2G6vFiAUTpufESssojUSDw6bSg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=CYqza1ARoudArJ3HIujfN1KHJjwAXH5PaaRXd/+v9PtxoTo+sGGqrVxB34nMJIjMx
         +XneZdWE5rXIbD/GPiwXONGcEDxCzhZ73L6Gv2W0WfRgssN9wpQ9nUOUKU4eY3E9HU
         uh9K6Bt+QnjF95UelZq6tidZij0zlWab+IcoLh7QjKJZ94Z/H3W26w8+0o5eNdrEjf
         ZWjo+o+xJSppiWoR0WpMgl/N1MBCiX/FRC8RJCzJEhuGFejhuAtFezYvgyr9kdCCnO
         pmpgV/MqoWgSbbhXEYCuqg4HCzdnW2BoEyEr0n1XcFETEsz2bsVX0SIJTKlrrncM9D
         j1EufscfxmALBiGd/QKiuzZ6v05Bgedy/Jj3e59G79aPPMmj+kqBHW6oH0kADvJu4l
         tQFFriMIYaKgSLFah2e+zkEFlACoH3Vx40hY0+qIebEbziIXK9aXP1oJr8zxD0B44H
         aVpjFbOrCOA11fe3Wop5e70pSp3lfhVGwWxXMhV88+dh14ysn0COQVhGEboVWdlLjy
         7FaFmG2jeEumYllKOAluooTarRAZhnzMDTY7aOEjfaa1sR7wQ/sXoCDGqa2W9xyux/
         o1Xg6UpnQQ2Am6/AVMp6OuSFk9wIyBY8EmpdAl1HSzhUlFw/KSJ3ghr9Bi3Z3g64Sh
         ARfdCxA1ySL+4xst7rADlr5A=
From:   Nikolay Burykin <burikin@ivk.ru>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Nikolay Burykin <burikin@ivk.ru>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        khoroshilov@ispras.ru
Subject: [PATCH] media: pci: cx23885: fix error handling for cx23885 ATSC boards
Date:   Tue, 10 Jan 2023 12:09:00 +0300
Message-Id: <20230110090900.25907-1-burikin@ivk.ru>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having been assigned to NULL value at cx23885-dvb.c:1202,
pointer '0' is dereferenced at cx23885-dvb.c:2469.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikolay Burykin <burikin@ivk.ru>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 45c2f4afceb8..9b437faf2c3f 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -2459,16 +2459,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
@@ -2505,16 +2499,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
-- 
2.39.0

