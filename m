Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E82659B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiL3SH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiL3SHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:15 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B505C60E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:14 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmf-0004rR-Ve; Fri, 30 Dec 2022 19:07:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/20] staging: r8188eu: remove unused parameter
Date:   Fri, 30 Dec 2022 19:06:31 +0100
Message-Id: <20221230180646.91008-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230180646.91008-1-martin@kaiser.cx>
References: <20221230180646.91008-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of rtl8188eu_xmitframe_complete set the pxmitbuf parameter to
NULL, in which case rtl8188eu_xmitframe_complete allocates another
xmit_buf internally.

Remove the pxmitbuf parameter and resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 12 +++++-------
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  2 +-
 drivers/staging/r8188eu/include/rtl8188e_xmit.h |  3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 6d1f56d1f9d7..cca74cf28915 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -375,11 +375,12 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 	return len;
 }
 
-bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
+bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
 	struct xmit_frame *pxmitframe = NULL;
 	struct xmit_frame *pfirstframe = NULL;
+	struct xmit_buf *pxmitbuf;
 
 	/*  aggregate variable */
 	struct hw_xmit *phwxmit;
@@ -403,12 +404,9 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 	else
 		bulksize = USB_FULL_SPEED_BULK_SIZE;
 
-	/*  check xmitbuffer is ok */
-	if (!pxmitbuf) {
-		pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-		if (!pxmitbuf)
-			return false;
-	}
+	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
+	if (!pxmitbuf)
+		return false;
 
 	/* 3 1. pick up first frame */
 	rtw_free_xmitframe(pxmitpriv, pxmitframe);
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 7c72f5e04d9b..c51f860d3527 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -494,7 +494,7 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
 		    (adapt->bWritePortCancel))
 			break;
 
-		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv, NULL);
+		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv);
 
 		if (!ret)
 			break;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index 6db7fabebea9..865468d6b922 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -138,7 +138,6 @@ s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
 #define hal_xmit_handler rtl8188eu_xmit_buf_handler
 void rtl8188eu_xmit_tasklet(unsigned long priv);
 bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
-				 struct xmit_priv *pxmitpriv,
-				 struct xmit_buf *pxmitbuf);
+				 struct xmit_priv *pxmitpriv);
 
 #endif /* __RTL8188E_XMIT_H__ */
-- 
2.30.2

