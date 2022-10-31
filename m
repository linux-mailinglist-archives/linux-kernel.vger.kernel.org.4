Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BF613F42
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJaUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJaUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:52:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC87213FB6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:52:09 -0700 (PDT)
Received: from dslb-084-059-234-234.084.059.pools.vodafone-ip.de ([84.59.234.234] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1opblL-0006y5-FT; Mon, 31 Oct 2022 21:52:03 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>, Joe Perches <joe@perches.com>
Subject: [PATCH] staging: r8188eu: use ether_addr_equal in OnAction
Date:   Mon, 31 Oct 2022 21:51:41 +0100
Message-Id: <20221031205140.124682-1-martin@kaiser.cx>
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

Use ether_addr_equal to compare two mac addresses in OnAction.

Both struct ieee80211_mgmt and struct eeprom_priv's mac_addr component
are 2-byte aligned.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index e985fc5fc575..6679d4037d6b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3823,7 +3823,7 @@ static void OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 
-	if (memcmp(myid(&padapter->eeprompriv), mgmt->da, ETH_ALEN))
+	if (!ether_addr_equal(myid(&padapter->eeprompriv), mgmt->da))
 		return;
 
 	switch (mgmt->u.action.category) {
-- 
2.30.2

