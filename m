Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7C68C77C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBFUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjBFUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:18:35 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F907A81
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:18:17 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP7wK-0007ps-53; Mon, 06 Feb 2023 21:18:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: r8188eu: remove intf_stop pointer
Date:   Mon,  6 Feb 2023 21:18:00 +0100
Message-Id: <20230206201800.139195-7-martin@kaiser.cx>
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

Remove the intf_stop pointer that points to a media-specific stop
function. The r8188eu driver supports only usb.

For usb drivers, intf_stop points to usb_intf_stop, which is only
two lines long.  We can remove intf_stop and usb_intf_stop and call
the two cancel functions directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c   |  4 ++--
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 18 +++---------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 40f13f185895..159990facb8a 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -171,7 +171,6 @@ struct adapter {
 	s8	signal_strength;
 
 	void *cmdThread;
-	void (*intf_stop)(struct adapter *adapter);
 	struct  net_device *pnetdev;
 
 	/*  used by rtw_rereg_nd_name related function */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index bd3c17f580c8..dc419fd1ffa5 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -761,8 +761,8 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 {
 	rtw_fifo_cleanup(padapter);
 
-	if (padapter->intf_stop)
-		padapter->intf_stop(padapter);
+	rtw_read_port_cancel(padapter);
+	rtw_write_port_cancel(padapter);
 
 	/* s5. */
 	if (!padapter->bSurpriseRemoved)
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index ca9a7c0e5159..74a16d1757ce 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -152,17 +152,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 
 }
 
-static void usb_intf_stop(struct adapter *padapter)
-{
-	/* cancel in irp */
-	rtw_read_port_cancel(padapter);
-
-	/* cancel out irp */
-	rtw_write_port_cancel(padapter);
-
-	/* todo:cancel other irps */
-}
-
 static void rtw_dev_unload(struct adapter *padapter)
 {
 	if (padapter->bup) {
@@ -170,8 +159,9 @@ static void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->xmitpriv.ack_tx)
 			rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_DRV_STOP);
 		/* s3. */
-		if (padapter->intf_stop)
-			padapter->intf_stop(padapter);
+		rtw_read_port_cancel(padapter);
+		rtw_write_port_cancel(padapter);
+
 		/* s4. */
 		rtw_stop_drv_threads(padapter);
 
@@ -308,8 +298,6 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 	padapter = rtw_netdev_priv(pnetdev);
 
-	padapter->intf_stop = &usb_intf_stop;
-
 	/* step read_chip_version */
 	rtl8188e_read_chip_version(padapter);
 
-- 
2.30.2

