Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76E0659B20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiL3RyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiL3Rx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:53:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEAF1C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:53:58 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJZp-0004hN-0t; Fri, 30 Dec 2022 18:53:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: remove intermediate pframe pointer
Date:   Fri, 30 Dec 2022 18:53:25 +0100
Message-Id: <20221230175326.90617-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230175326.90617-1-martin@kaiser.cx>
References: <20221230175326.90617-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pframe pointer in on_action_public is used only in the definition of
frame_body, which points to the payload of an incoming action frame.

We can use mgmt to locate the action payload and remove the pframe
pointer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0b2f5d6c1279..310e60c4b639 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3738,8 +3738,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 static void on_action_public(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
-	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
+	u8 *frame_body = (u8 *)&mgmt->u;
 	u8 token;
 
 	/* All members of the action enum start with action_code. */
-- 
2.30.2

