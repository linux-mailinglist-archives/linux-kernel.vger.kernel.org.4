Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC468C77A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjBFUS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBFUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:18:34 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAC3A92
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:18:16 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP7wI-0007ps-EM; Mon, 06 Feb 2023 21:18:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] staging: r8188eu: remove intf_start pointer
Date:   Mon,  6 Feb 2023 21:17:58 +0100
Message-Id: <20230206201800.139195-5-martin@kaiser.cx>
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

Remove the intf_start pointer that points to a media-specific start
function (pci, usb, sdio, ...). The r8188eu driver supports only usb.

We could call usb_intf_start directly instead of going through the
function pointer. usb_intf_start is just a call to rtl8188eu_inirp_init so
we can directly replace the intf_start pointer with rtl8188eu_inirp_init.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 6 ++----
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 6 ------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 7b170eed66b3..40f13f185895 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -171,7 +171,6 @@ struct adapter {
 	s8	signal_strength;
 
 	void *cmdThread;
-	void (*intf_start)(struct adapter *adapter);
 	void (*intf_stop)(struct adapter *adapter);
 	struct  net_device *pnetdev;
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 4130e8fe2952..e48dbdfefedb 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -631,8 +631,7 @@ static int _netdev_open(struct net_device *pnetdev)
 			pr_info("can't init mlme_ext_priv\n");
 			goto netdev_open_error;
 		}
-		if (padapter->intf_start)
-			padapter->intf_start(padapter);
+		rtl8188eu_inirp_init(padapter);
 
 		rtw_led_control(padapter, LED_CTL_NO_LINK);
 
@@ -684,8 +683,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	if (status == _FAIL)
 		goto netdev_open_error;
 
-	if (padapter->intf_start)
-		padapter->intf_start(padapter);
+	rtl8188eu_inirp_init(padapter);
 
 	rtw_set_pwr_state_check_timer(&padapter->pwrctrlpriv);
 	_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 5000);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 1f114b1fc4d5..ca9a7c0e5159 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -152,11 +152,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 
 }
 
-static void usb_intf_start(struct adapter *padapter)
-{
-	rtl8188eu_inirp_init(padapter);
-}
-
 static void usb_intf_stop(struct adapter *padapter)
 {
 	/* cancel in irp */
@@ -313,7 +308,6 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 	padapter = rtw_netdev_priv(pnetdev);
 
-	padapter->intf_start = &usb_intf_start;
 	padapter->intf_stop = &usb_intf_stop;
 
 	/* step read_chip_version */
-- 
2.30.2

