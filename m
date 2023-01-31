Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A8682809
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjAaJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjAaJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:04:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46E4ED32
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:01:11 -0800 (PST)
Received: from dslb-188-096-143-205.188.096.pools.vodafone-ip.de ([188.96.143.205] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMmVh-00052y-H3; Tue, 31 Jan 2023 10:01:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: fix NULL check for rcu pointer
Date:   Tue, 31 Jan 2023 10:00:57 +0100
Message-Id: <20230131090057.241779-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the NULL check for padapter->pnetdev->rx_handler_data.

The current code calls rcu_dereference while it holds the rcu read lock
and checks the pointer after releasing the lock. An rcu pointer may only be
used between calls to rcu_read_lock and rcu_read_unlock.

Replace the check with rcu_access_pointer. My understanding is that this
function returns the value of the pointer and needs no locking. We can
then check the pointer but we must not dereference it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 91f92ec5ef69..18941320e70e 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1631,18 +1631,14 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct xmit_frame *pxmitframe = NULL;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	void *br_port = NULL;
 	s32 res;
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pxmitframe)
 		return -1;
 
-	rcu_read_lock();
-	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
-	rcu_read_unlock();
-
-	if (br_port && check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE)) {
+	if (rcu_access_pointer(padapter->pnetdev->rx_handler_data) &&
+	    check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE)) {
 		res = rtw_br_client_tx(padapter, ppkt);
 		if (res == -1) {
 			rtw_free_xmitframe(pxmitpriv, pxmitframe);
-- 
2.30.2

