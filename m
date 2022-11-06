Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74561E232
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKFMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKFMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:49:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF79364D7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:49:19 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orf5O-0008Dj-AB; Sun, 06 Nov 2022 13:49:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/9] staging: r8188eu: merge two rtw_free_network_nolock functions
Date:   Sun,  6 Nov 2022 13:49:00 +0100
Message-Id: <20221106124901.720785-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221106124901.720785-1-martin@kaiser.cx>
References: <20221106124901.720785-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _rtw_free_network_nolock function and merge it into
rtw_free_network_nolock, which is its only caller.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 23 ++++++++--------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 --
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index a47ae33454b3..b272123626ac 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -76,19 +76,6 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 	spin_unlock_bh(&free_queue->lock);
 }
 
-void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
-{
-	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
-
-	if (!pnetwork)
-		return;
-	if (pnetwork->fixed)
-		return;
-	list_del_init(&pnetwork->list);
-	list_add_tail(&pnetwork->list, get_list_head(free_queue));
-	pmlmepriv->num_of_scanned--;
-}
-
 /*
 	return the wlan_network with the matching addr
 
@@ -307,9 +294,15 @@ struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 static void rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
 				    struct wlan_network *pnetwork)
 {
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
-	_rtw_free_network_nolock(pmlmepriv, pnetwork);
-
+	if (!pnetwork)
+		return;
+	if (pnetwork->fixed)
+		return;
+	list_del_init(&pnetwork->list);
+	list_add_tail(&pnetwork->list, get_list_head(free_queue));
+	pmlmepriv->num_of_scanned--;
 }
 
 void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 268f898b151b..3ff653ff1d81 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -539,8 +539,6 @@ struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_network(struct mlme_priv *pmlmepriv,
 		       struct wlan_network *pnetwork, u8 isfreeall);
-void _rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
-			      struct wlan_network *pnetwork);
 
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr);
 
-- 
2.30.2

