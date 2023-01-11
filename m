Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C3666436
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAKT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAKT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:57:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08C1789D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:56:57 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDQ-0005F2-Hi; Wed, 11 Jan 2023 20:56:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/20] staging: r8188eu: remove struct io_priv
Date:   Wed, 11 Jan 2023 20:56:21 +0100
Message-Id: <20230111195640.306748-2-martin@kaiser.cx>
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

struct io_priv has only one member (and a pointer to the enclosing struct
adapter). We can remove struct io_priv and move its member directly into
struct adapter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 21 +++++++--------------
 drivers/staging/r8188eu/include/drv_types.h |  2 +-
 drivers/staging/r8188eu/include/rtw_io.h    |  5 -----
 drivers/staging/r8188eu/os_dep/usb_intf.c   |  5 +----
 4 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a238d29a3a46..0deaa5c24ab2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -95,8 +95,7 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 
 	return usb_read(intf, value, data, 1);
@@ -104,8 +103,7 @@ int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le16 le_data;
 	int res;
@@ -121,8 +119,7 @@ int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 
 int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le32 le_data;
 	int res;
@@ -138,8 +135,7 @@ int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	int ret;
 
@@ -150,8 +146,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le16 data = cpu_to_le16(val);
 	int ret;
@@ -163,8 +158,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val);
 	int ret;
@@ -176,8 +170,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 
 int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
-	struct io_priv *io_priv = &adapter->iopriv;
-	struct intf_hdl *intf = &io_priv->intf;
+	struct intf_hdl *intf = &adapter->intf;
 	u16 value = addr & 0xffff;
 	int ret;
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 4803d0c77d70..614673902377 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -152,7 +152,7 @@ struct adapter {
 	struct	mlme_ext_priv mlmeextpriv;
 	struct	cmd_priv	cmdpriv;
 	struct	evt_priv	evtpriv;
-	struct	io_priv	iopriv;
+	struct	intf_hdl	intf;
 	struct	xmit_priv	xmitpriv;
 	struct	recv_priv	recvpriv;
 	struct	sta_priv	stapriv;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index e9744694204b..c15b2e873fd5 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -203,11 +203,6 @@ struct io_queue {
 	struct	intf_hdl	intf;
 };
 
-struct io_priv {
-	struct adapter *padapter;
-	struct intf_hdl intf;
-};
-
 uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
 void sync_ioreq_enqueue(struct io_req *preq, struct io_queue *ioqueue);
 uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 5fbfbcd95de2..1f70e5fee1b2 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -290,7 +290,6 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 {
 	struct adapter *padapter = NULL;
 	struct net_device *pnetdev = NULL;
-	struct io_priv *piopriv;
 	struct intf_hdl *pintf;
 	int ret;
 
@@ -319,9 +318,7 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 	padapter->intf_stop = &usb_intf_stop;
 
 	/* step init_io_priv */
-	piopriv = &padapter->iopriv;
-	pintf = &piopriv->intf;
-	piopriv->padapter = padapter;
+	pintf = &padapter->intf;
 	pintf->padapter = padapter;
 	pintf->pintf_dev = adapter_to_dvobj(padapter);
 
-- 
2.30.2

