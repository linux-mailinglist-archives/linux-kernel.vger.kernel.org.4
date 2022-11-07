Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5411961FF85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKGU2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKGU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:28:46 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4C3201A2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:28:46 -0800 (PST)
Received: from ipservice-092-217-067-198.092.217.pools.vodafone-ip.de ([92.217.67.198] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1os8jZ-0004bP-6j; Mon, 07 Nov 2022 21:28:41 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 3/3] staging: r8188eu: drop removal/stop check in dump_mgntframe_and_wait_ack
Date:   Mon,  7 Nov 2022 21:28:24 +0100
Message-Id: <20221107202824.61431-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221107202824.61431-1-martin@kaiser.cx>
References: <20221107202824.61431-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can remove the checks for bDriverStopped and bSurpriseRemoved in
dump_mgntframe_and_wait_ack.

The code path from this function looks like

dump_mgntframe_and_wait_ack
   rtl8188eu_mgnt_xmit
      rtw_dump_xframe
         loop over all fragments

rtw_write_port is called for each fragment. bSurpriseRemoved and
bDriverStopped are checked in rtw_write_port.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index bfd6afd7266e..be33489d3dfd 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3988,9 +3988,6 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	u32 timeout_ms = 500;/*   500ms */
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 
-	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
-		return -1;
-
 	mutex_lock(&pxmitpriv->ack_tx_mutex);
 	pxmitpriv->ack_tx = true;
 
-- 
2.30.2

