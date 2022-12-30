Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C41659B47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiL3SIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiL3SHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68761C915
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:22 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmn-0004rR-6j; Fri, 30 Dec 2022 19:07:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 14/20] staging: r8188eu: bm_pending is not used
Date:   Fri, 30 Dec 2022 19:06:40 +0100
Message-Id: <20221230180646.91008-15-martin@kaiser.cx>
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

The bm_pending queue in struct xmit_priv is initialised but not used. It
can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index bf4bb1e66985..a3dccfa4d843 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -81,7 +81,6 @@ int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	rtw_init_queue(&pxmitpriv->bk_pending);
 	rtw_init_queue(&pxmitpriv->vi_pending);
 	rtw_init_queue(&pxmitpriv->vo_pending);
-	rtw_init_queue(&pxmitpriv->bm_pending);
 
 	rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 1c4fbdf97a12..83638dede6e7 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -262,7 +262,6 @@ struct	xmit_priv {
 	struct __queue bk_pending;
 	struct __queue vi_pending;
 	struct __queue vo_pending;
-	struct __queue bm_pending;
 	u8 *pallocated_frame_buf;
 	u8 *pxmit_frame_buf;
 	uint free_xmitframe_cnt;
-- 
2.30.2

