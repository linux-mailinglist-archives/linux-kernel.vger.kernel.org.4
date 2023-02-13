Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C8695121
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjBMTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBMTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:55:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E51C7FA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:55:48 -0800 (PST)
Received: from ipservice-092-217-079-080.092.217.pools.vodafone-ip.de ([92.217.79.80] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pRevM-0004Cb-81; Mon, 13 Feb 2023 20:55:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Revert "staging: r8188eu: simplify rtw_get_ff_hwaddr"
Date:   Mon, 13 Feb 2023 20:54:08 +0100
Message-Id: <20230213195407.15085-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230211183205.426820-1-martin@kaiser.cx>
References: <20230211183205.426820-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fd48124e0982 ("staging: r8188eu: simplify
rtw_get_ff_hwaddr").

The cleanup in this commit removes the qsel to addr mappings in
rtw_get_ff_hwaddr. The underlying assumption is that rtw_write_port
uses its addr parameter only for the high_queue check.

This is obviously incorrect as rtw_write_port calls
ffaddr2pipehdl(pdvobj, addr);
where addr is mapped to a usb bulk endpoint.

Unfortunately, testing did not show any problems. The Edimax V2 on which I
tested has two bulk out endpoints. I guess that with the incorrect patch,
addr could only be 0 (no high queue) or 6 (high queue), both of which were
mapped to the first bulk out endpoint. Data transfers did still work...

Fixes: fd48124e0982 ("staging: r8188eu: simplify rtw_get_ff_hwaddr")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - use correct patch prefix
 - add a Fixes tag
 - use 12-digit hash to refer to the reverted commit

 drivers/staging/r8188eu/core/rtw_xmit.c    | 32 +++++++++++++++++++++-
 drivers/staging/r8188eu/include/rtw_xmit.h |  7 +++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d0761ac2e695..df88b3e29e77 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1568,9 +1568,39 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 
 u32 rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe)
 {
+	u32 addr;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 
-	return pattrib->qsel == 0x11 ? HIGH_QUEUE_INX : 0;
+	switch (pattrib->qsel) {
+	case 0:
+	case 3:
+		addr = BE_QUEUE_INX;
+		break;
+	case 1:
+	case 2:
+		addr = BK_QUEUE_INX;
+		break;
+	case 4:
+	case 5:
+		addr = VI_QUEUE_INX;
+		break;
+	case 6:
+	case 7:
+		addr = VO_QUEUE_INX;
+		break;
+	case 0x10:
+		addr = BCN_QUEUE_INX;
+		break;
+	case 0x11:/* BC/MC in PS (HIQ) */
+		addr = HIGH_QUEUE_INX;
+		break;
+	case 0x12:
+	default:
+		addr = MGT_QUEUE_INX;
+		break;
+	}
+
+	return addr;
 }
 
 /*
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index e4e5af198eee..feeac85aedb0 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -26,7 +26,14 @@
 #define XMIT_BE_QUEUE		(2)
 #define XMIT_BK_QUEUE		(3)
 
+#define VO_QUEUE_INX		0
+#define VI_QUEUE_INX		1
+#define BE_QUEUE_INX		2
+#define BK_QUEUE_INX		3
+#define BCN_QUEUE_INX		4
+#define MGT_QUEUE_INX		5
 #define HIGH_QUEUE_INX		6
+#define TXCMD_QUEUE_INX		7
 
 #define HW_QUEUE_ENTRY		8
 
-- 
2.30.2

