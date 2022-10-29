Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E96124A4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJ2RYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJ2RYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:24:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42050BB5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:24:04 -0700 (PDT)
Received: from dslb-188-097-213-253.188.097.pools.vodafone-ip.de ([188.97.213.253] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oopYv-00074v-7z; Sat, 29 Oct 2022 19:24:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/13] staging: r8188eu: remove return value from on_action_public_vendor
Date:   Sat, 29 Oct 2022 19:23:34 +0200
Message-Id: <20221029172337.1574593-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221029172337.1574593-1-martin@kaiser.cx>
References: <20221029172337.1574593-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of on_action_public_vendor does not check the return
value. We can make it a void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b3cef3504ad3..b395457a6a60 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3779,17 +3779,13 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	return _SUCCESS;
 }
 
-static unsigned int on_action_public_vendor(struct recv_frame *precv_frame)
+static void on_action_public_vendor(struct recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	u8 *pframe = precv_frame->rx_data;
 	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
 
-	if (!memcmp(frame_body + 2, P2P_OUI, 4)) {
-		ret = on_action_public_p2p(precv_frame);
-	}
-
-	return ret;
+	if (!memcmp(frame_body + 2, P2P_OUI, 4))
+		on_action_public_p2p(precv_frame);
 }
 
 static unsigned int on_action_public_default(struct recv_frame *precv_frame)
-- 
2.30.2

