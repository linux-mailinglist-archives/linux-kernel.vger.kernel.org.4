Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813B06788B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjAWUyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAWUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:03 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755B11654
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:02 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pF-0000Lk-NR; Mon, 23 Jan 2023 21:53:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/23] staging: r8188eu: remove struct intf_hdl
Date:   Mon, 23 Jan 2023 21:53:22 +0100
Message-Id: <20230123205342.229589-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123205342.229589-1-martin@kaiser.cx>
References: <20230123205342.229589-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users of struct intf_hdl in the r8188eu driver. We can
now remove this struct.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/include/rtw_io.h    | 6 ------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 6 ------
 3 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 614673902377..7b170eed66b3 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -152,7 +152,6 @@ struct adapter {
 	struct	mlme_ext_priv mlmeextpriv;
 	struct	cmd_priv	cmdpriv;
 	struct	evt_priv	evtpriv;
-	struct	intf_hdl	intf;
 	struct	xmit_priv	xmitpriv;
 	struct	recv_priv	recvpriv;
 	struct	sta_priv	stapriv;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 0d2aa432f88d..033ea7146861 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -17,12 +17,6 @@
 #include <linux/usb/ch9.h>
 
 struct intf_priv;
-struct intf_hdl;
-
-struct	intf_hdl {
-	struct adapter *padapter;
-	struct dvobj_priv *pintf_dev;
-};
 
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 1f70e5fee1b2..1f114b1fc4d5 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -290,7 +290,6 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 {
 	struct adapter *padapter = NULL;
 	struct net_device *pnetdev = NULL;
-	struct intf_hdl *pintf;
 	int ret;
 
 	padapter = vzalloc(sizeof(*padapter));
@@ -317,11 +316,6 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 	padapter->intf_start = &usb_intf_start;
 	padapter->intf_stop = &usb_intf_stop;
 
-	/* step init_io_priv */
-	pintf = &padapter->intf;
-	pintf->padapter = padapter;
-	pintf->pintf_dev = adapter_to_dvobj(padapter);
-
 	/* step read_chip_version */
 	rtl8188e_read_chip_version(padapter);
 
-- 
2.30.2

