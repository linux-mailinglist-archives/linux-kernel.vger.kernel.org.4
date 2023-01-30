Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DEA681AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbjA3Txy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbjA3Txb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:31 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F04CDC2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:29 -0800 (PST)
Received: from dslb-188-097-040-029.188.097.pools.vodafone-ip.de ([188.97.40.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMaDS-0007S2-Q6; Mon, 30 Jan 2023 20:53:22 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 9/9] staging: r8188eu: replace switch-case with if
Date:   Mon, 30 Jan 2023 20:53:03 +0100
Message-Id: <20230130195303.138941-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230130195303.138941-1-martin@kaiser.cx>
References: <20230130195303.138941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a switch-case in rtw_write_port with an if statement and make the
code a bit shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index c9ee1173a1d6..48c96f731ce1 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -121,14 +121,8 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-
-		switch (status) {
-		case -ENODEV:
+		if (status == -ENODEV)
 			padapter->bDriverStopped = true;
-			break;
-		default:
-			break;
-		}
 		goto exit;
 	}
 
-- 
2.30.2

