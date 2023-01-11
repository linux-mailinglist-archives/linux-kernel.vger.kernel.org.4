Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE266643F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbjAKT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjAKT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:57:13 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9021C90D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:57:12 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDf-0005F2-Aj; Wed, 11 Jan 2023 20:57:07 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 18/20] staging: r8188eu: pass struct adapter to usb_write
Date:   Wed, 11 Jan 2023 20:56:38 +0100
Message-Id: <20230111195640.306748-19-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111195640.306748-1-martin@kaiser.cx>
References: <20230111195640.306748-1-martin@kaiser.cx>
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
index f8900b51d750..2784fc69f7d9 100644
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
@@ -131,49 +130,45 @@ int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 
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
 	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	ret = usb_write(intf, value, data, length);
+	ret = usb_write(adapter, value, data, length);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.30.2

