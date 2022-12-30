Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C4659B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiL3SIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiL3SHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C41C92A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:27 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmr-0004rR-91; Fri, 30 Dec 2022 19:07:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 19/20] staging: r8188eu: rtw_init_hwxmits is not needed
Date:   Fri, 30 Dec 2022 19:06:45 +0100
Message-Id: <20221230180646.91008-20-martin@kaiser.cx>
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

The _rtw_init_xmit_priv function calls rtw_alloc_hwxmits to allocate
memory for pxmitpriv->hwxmits (this is an array of struct hw_xmit). This
allocation uses kzalloc, the allocated memory is initialised with 0.

After the allocation, _rtw_init_xmit_priv calls rtw_init_hwxmits to set an
element of each hw_xmit to 0. This is not necessary, we can remove the
rtw_init_hwxmits call and the now unused function rtw_init_hwxmits.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 10 ----------
 drivers/staging/r8188eu/include/rtw_xmit.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 347f06f48a37..76b0839ca19d 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -189,8 +189,6 @@ int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	if (rtw_alloc_hwxmits(padapter))
 		goto free_xmit_extbuf;
 
-	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
-
 	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = i;
 
@@ -1570,14 +1568,6 @@ void rtw_free_hwxmits(struct adapter *padapter)
 	kfree(hwxmits);
 }
 
-void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry)
-{
-	int i;
-
-	for (i = 0; i < entry; i++, phwxmit++)
-		phwxmit->accnt = 0;
-}
-
 static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 719424dd8a49..eafa693efc2f 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -345,7 +345,6 @@ void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv);
 s32 rtw_txframes_pending(struct adapter *padapter);
 s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 				struct pkt_attrib *pattrib);
-void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
 int rtw_alloc_hwxmits(struct adapter *padapter);
-- 
2.30.2

