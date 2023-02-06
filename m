Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9668C777
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBFUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBFUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:18:33 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880C2B09D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:18:15 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP7wG-0007ps-34; Mon, 06 Feb 2023 21:18:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/6] staging: r8188eu: pass a struct recv_buf to rtw_read_port
Date:   Mon,  6 Feb 2023 21:17:55 +0100
Message-Id: <20230206201800.139195-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230206201800.139195-1-martin@kaiser.cx>
References: <20230206201800.139195-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtw_read_port function needs a struct recv_buf for preparing the usb
transfer.

Replace its u8 *rmem parameter with a struct recv_buf pointer to avoid
casts in the caller and in rtw_read_port.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c   | 2 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 9 ++++-----
 drivers/staging/r8188eu/include/rtw_io.h    | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b7c9e5fd9a59..25fd6f8d814c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -860,7 +860,7 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (!rtw_read_port(Adapter, (unsigned char *)precvbuf)) {
+		if (!rtw_read_port(Adapter, precvbuf)) {
 			status = _FAIL;
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 9c940ab8fd41..225a422ede4f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -364,7 +364,7 @@ static void usb_read_port_complete(struct urb *purb)
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
 			precvbuf->reuse = true;
-			rtw_read_port(adapt, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, precvbuf);
 		} else {
 			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
 
@@ -376,7 +376,7 @@ static void usb_read_port_complete(struct urb *purb)
 
 			precvbuf->pskb = NULL;
 			precvbuf->reuse = false;
-			rtw_read_port(adapt, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, precvbuf);
 		}
 	} else {
 		skb_put(precvbuf->pskb, purb->actual_length);
@@ -396,7 +396,7 @@ static void usb_read_port_complete(struct urb *purb)
 		case -EPROTO:
 		case -EOVERFLOW:
 			precvbuf->reuse = true;
-			rtw_read_port(adapt, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, precvbuf);
 			break;
 		case -EINPROGRESS:
 			break;
@@ -406,10 +406,9 @@ static void usb_read_port_complete(struct urb *purb)
 	}
 }
 
-u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
+u32 rtw_read_port(struct adapter *adapter, struct recv_buf *precvbuf)
 {
 	struct urb *purb = NULL;
-	struct recv_buf	*precvbuf = (struct recv_buf *)rmem;
 	struct dvobj_priv	*pdvobj = adapter_to_dvobj(adapter);
 	struct recv_priv	*precvpriv = &adapter->recvpriv;
 	struct usb_device	*pusbd = pdvobj->pusbdev;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 090555f562f2..6b1de4f0e287 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -19,7 +19,7 @@
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
 int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data);
-u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
+u32 rtw_read_port(struct adapter *adapter, struct recv_buf *precvbuf);
 void rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
-- 
2.30.2

