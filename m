Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D466643E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjAKT7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjAKT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:57:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4DB73
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:57:15 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDe-0005F2-IF; Wed, 11 Jan 2023 20:57:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 17/20] staging: r8188eu: pass struct adapter to usb_read
Date:   Wed, 11 Jan 2023 20:56:37 +0100
Message-Id: <20230111195640.306748-18-martin@kaiser.cx>
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

The usb_read function takes a struct intf_hdl only to extract the struct
adapter from it. We can pass struct adapter directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 0deaa5c24ab2..f8900b51d750 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -7,9 +7,8 @@
 #include "../include/usb_ops.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
+static int usb_read(struct adapter *adapt, u16 value, void *data, u8 size)
 {
-	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	int status;
@@ -95,20 +94,18 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 
-	return usb_read(intf, value, data, 1);
+	return usb_read(adapter, value, data, 1);
 }
 
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le16 le_data;
 	int res;
 
-	res = usb_read(intf, value, &le_data, 2);
+	res = usb_read(adapter, value, &le_data, 2);
 	if (res)
 		return res;
 
@@ -119,12 +116,11 @@ int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 
 int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 {
-	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le32 le_data;
 	int res;
 
-	res = usb_read(intf, value, &le_data, 4);
+	res = usb_read(adapter, value, &le_data, 4);
 	if (res)
 		return res;
 
-- 
2.30.2

