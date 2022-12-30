Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E576F659B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiL3SHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiL3SHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:17 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1E13F05
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:16 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmg-0004rR-Oj; Fri, 30 Dec 2022 19:07:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/20] staging: r8188eu: simplify rtl8188eu_xmit_tasklet
Date:   Fri, 30 Dec 2022 19:06:32 +0100
Message-Id: <20221230180646.91008-7-martin@kaiser.cx>
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

Simplify the rtl8188eu_xmit_tasklet function. Remove an unnecessary
temporary variable and reformat the code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index c51f860d3527..a238d29a3a46 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -481,22 +481,14 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 
 void rtl8188eu_xmit_tasklet(unsigned long priv)
 {
-	int ret = false;
 	struct adapter *adapt = (struct adapter *)priv;
 	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
 
 	if (check_fwstate(&adapt->mlmepriv, _FW_UNDER_SURVEY))
 		return;
 
-	while (1) {
-		if ((adapt->bDriverStopped) ||
-		    (adapt->bSurpriseRemoved) ||
-		    (adapt->bWritePortCancel))
-			break;
-
-		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv);
-
-		if (!ret)
+	do {
+		if (adapt->bDriverStopped || adapt->bSurpriseRemoved || adapt->bWritePortCancel)
 			break;
-	}
+	} while (rtl8188eu_xmitframe_complete(adapt, pxmitpriv));
 }
-- 
2.30.2

