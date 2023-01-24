Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900D967A480
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjAXVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjAXVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:01:33 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A141B43
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:01:32 -0800 (PST)
Received: from dslb-188-096-139-204.188.096.pools.vodafone-ip.de ([188.96.139.204] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pKQQ3-0001xR-Hz; Tue, 24 Jan 2023 22:01:27 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: remove usb_ops_linux.h
Date:   Tue, 24 Jan 2023 22:01:08 +0100
Message-Id: <20230124210108.62170-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230124210108.62170-1-martin@kaiser.cx>
References: <20230124210108.62170-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only two defines left in usb_ops_linux.h. Move those defines to
usb_ops_linux.c, where they are used.

Remove the now empty file usb_ops_linux.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  4 ++++
 drivers/staging/r8188eu/include/usb_ops.h       |  2 --
 drivers/staging/r8188eu/include/usb_ops_linux.h | 11 -----------
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  |  1 -
 4 files changed, 4 insertions(+), 14 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 0f789d5250db..9c940ab8fd41 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -7,6 +7,10 @@
 #include "../include/usb_ops.h"
 #include "../include/rtl8188e_hal.h"
 
+#define VENDOR_CMD_MAX_DATA_LEN	254
+
+#define RTW_USB_CONTROL_MSG_TIMEOUT	500/* ms */
+
 static int usb_read(struct adapter *adapt, u16 value, void *data, u8 size)
 {
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index ddc46cb44358..5bd8ce37aebf 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -17,8 +17,6 @@
 #define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
 #define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
 
-#include "usb_ops_linux.h"
-
 /*
  * Increase and check if the continual_urb_error of this @param dvobjprivei
  * is larger than MAX_CONTINUAL_URB_ERR
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
deleted file mode 100644
index b149df7957dd..000000000000
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __USB_OPS_LINUX_H__
-#define __USB_OPS_LINUX_H__
-
-#define VENDOR_CMD_MAX_DATA_LEN	254
-
-#define RTW_USB_CONTROL_MSG_TIMEOUT	500/* ms */
-
-#endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 583533631133..c9ee1173a1d6 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -4,7 +4,6 @@
 #define _USB_OPS_LINUX_C_
 
 #include "../include/drv_types.h"
-#include "../include/usb_ops_linux.h"
 #include "../include/rtl8188e_recv.h"
 
 static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
-- 
2.30.2

