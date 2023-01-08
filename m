Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE90466186F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjAHS6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjAHS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:58:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51601E00C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:58:02 -0800 (PST)
Received: from dslb-188-096-147-053.188.096.pools.vodafone-ip.de ([188.96.147.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEari-0003b8-UQ; Sun, 08 Jan 2023 19:57:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/13] staging: r8188eu: make rtl8188eu_inirp_init a void function
Date:   Sun,  8 Jan 2023 19:57:31 +0100
Message-Id: <20230108185738.597105-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108185738.597105-1-martin@kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8188eu_inirp_init's return value is not checked by its caller. Make
rtl8188eu_inirp_init a void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 14 +++-----------
 drivers/staging/r8188eu/include/hal_intf.h |  2 +-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d28b4dc2a767..afa24a59fbb3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -851,29 +851,21 @@ u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 	return _SUCCESS;
  }
 
-unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
+void rtl8188eu_inirp_init(struct adapter *Adapter)
 {
 	u8 i;
 	struct recv_buf *precvbuf;
-	uint	status;
 	struct recv_priv *precvpriv = &Adapter->recvpriv;
 
-	status = _SUCCESS;
-
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (!rtw_read_port(Adapter, (unsigned char *)precvbuf)) {
-			status = _FAIL;
-			goto exit;
-		}
+		if (!rtw_read_port(Adapter, (unsigned char *)precvbuf))
+			return;
 
 		precvbuf++;
 		precvpriv->free_recv_buf_queue_cnt--;
 	}
-
-exit:
-	return status;
 }
 
 /*  */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index ac6e3f95c5b7..767f97c5f85d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -26,7 +26,7 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
-unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
+void rtl8188eu_inirp_init(struct adapter *Adapter);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
-- 
2.30.2

