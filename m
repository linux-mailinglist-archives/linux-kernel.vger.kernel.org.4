Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F066788B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAWUyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBD7DB5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:01 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pE-0000Lk-TD; Mon, 23 Jan 2023 21:53:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/23] staging: r8188eu: pass struct adapter to usb_write
Date:   Mon, 23 Jan 2023 21:53:21 +0100
Message-Id: <20230123205342.229589-3-martin@kaiser.cx>
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

The usb_write function takes a struct intf_hdl only to extract the struct
adapter from it. We can pass struct adapter directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index d82abfcd91f3..9f008e61a6f2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -49,9 +49,8 @@ static int usb_read(struct adapter *adapt, u16 value, void *data, u8 size)
 	return status;
 }
 
-static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
+static int usb_write(struct adapter *adapt, u16 value, void *data, u8 size)
 {
-	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	int status;
@@ -131,48 +130,44 @@ int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	int ret;
 
-	ret = usb_write(intf, value, &val, 1);
+	ret = usb_write(adapter, value, &val, 1);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le16 data = cpu_to_le16(val);
 	int ret;
 
-	ret = usb_write(intf, value, &data, 2);
+	ret = usb_write(adapter, value, &data, 2);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
-	ret = usb_write(intf, value, &data, 4);
+	ret = usb_write(adapter, value, &data, 4);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return -EINVAL;
 
-	return usb_write(intf, value, data, length);
+	return usb_write(adapter, value, data, length);
 }
 
 static void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
-- 
2.30.2

