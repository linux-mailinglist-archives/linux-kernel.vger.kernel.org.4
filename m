Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D446E61E3F7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKFRGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKFRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:05:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E93FFAFF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:05:03 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orj4u-0001KU-8f; Sun, 06 Nov 2022 18:05:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: use a qos_hdr in validate_recv_data_frame
Date:   Sun,  6 Nov 2022 18:04:53 +0100
Message-Id: <20221106170455.743058-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221106170455.743058-1-martin@kaiser.cx>
References: <20221106170455.743058-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a struct ieee80211_qos_hdr in the validate_recv_data_frame
function. Use this struct to replace some numeric offsets and make the
code easier to understand.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index cb0f35d7ab98..245b931c483d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1032,7 +1032,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 				    struct recv_frame *precv_frame)
 {
 	struct sta_info *psta = NULL;
-	u8 *ptr = precv_frame->rx_data;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct rx_pkt_attrib	*pattrib = &precv_frame->attrib;
 	struct security_priv	*psecuritypriv = &adapter->securitypriv;
@@ -1071,10 +1070,12 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	pattrib->ack_policy = 0;
 	/* parsing QC field */
 	if (pattrib->qos) {
+		struct ieee80211_qos_hdr *qos_hdr = (struct ieee80211_qos_hdr *)hdr;
+
 		pattrib->priority = ieee80211_get_tid(hdr);
-		pattrib->ack_policy = GetAckpolicy((ptr + 24));
-		pattrib->amsdu = GetAMsdu((ptr + 24));
-		pattrib->hdrlen = 26;
+		pattrib->ack_policy = GetAckpolicy(&qos_hdr->qos_ctrl);
+		pattrib->amsdu = GetAMsdu(&qos_hdr->qos_ctrl);
+		pattrib->hdrlen += sizeof(*qos_hdr);
 
 		if (pattrib->priority != 0 && pattrib->priority != 3)
 			adapter->recvpriv.bIsAnyNonBEPkts = true;
-- 
2.30.2

