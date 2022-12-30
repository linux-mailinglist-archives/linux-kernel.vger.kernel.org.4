Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2136659B49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiL3SIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiL3SHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1B1C920
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:25 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmp-0004rR-Lg; Fri, 30 Dec 2022 19:07:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 17/20] staging: r8188eu: remove unnecessary rtw_free_xmitframe call
Date:   Fri, 30 Dec 2022 19:06:43 +0100
Message-Id: <20221230180646.91008-18-martin@kaiser.cx>
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

There's no need to call rtw_free_xmitframe before we dequeue the first
frame. pxmitframe is always NULL at this point, rtw_free_xmitframe will do
nothing in this case.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index cf9779b86b9c..d1af76cc2091 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -398,9 +398,6 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 	if (!pxmitbuf)
 		return false;
 
-	/* 3 1. pick up first frame */
-	rtw_free_xmitframe(pxmitpriv, pxmitframe);
-
 	pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	if (!pxmitframe) {
 		/*  no more xmit frame, release xmit buffer */
-- 
2.30.2

