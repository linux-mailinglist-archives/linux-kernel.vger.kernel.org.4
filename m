Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36F665894
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjAKKGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAKKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:05:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A54BCBD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:02:17 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFXvu-0000gP-3P; Wed, 11 Jan 2023 11:02:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove NULL check for usb_kill_urb
Date:   Wed, 11 Jan 2023 11:02:01 +0100
Message-Id: <20230111100201.251905-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_kill_urb handles a NULL parameter. There's no need for NULL checks
before we call usb_kill_urb.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 62106d2f82ad..583533631133 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -29,8 +29,7 @@ void rtw_read_port_cancel(struct adapter *padapter)
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
 		precvbuf->reuse = true;
-		if (precvbuf->purb)
-			usb_kill_urb(precvbuf->purb);
+		usb_kill_urb(precvbuf->purb);
 		precvbuf++;
 	}
 }
@@ -153,15 +152,13 @@ void rtw_write_port_cancel(struct adapter *padapter)
 	padapter->bWritePortCancel = true;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
-		if (pxmitbuf->pxmit_urb)
-			usb_kill_urb(pxmitbuf->pxmit_urb);
+		usb_kill_urb(pxmitbuf->pxmit_urb);
 		pxmitbuf++;
 	}
 
 	pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmit_extbuf;
 	for (i = 0; i < NR_XMIT_EXTBUFF; i++) {
-		if (pxmitbuf->pxmit_urb)
-			usb_kill_urb(pxmitbuf->pxmit_urb);
+		usb_kill_urb(pxmitbuf->pxmit_urb);
 		pxmitbuf++;
 	}
 }
-- 
2.30.2

