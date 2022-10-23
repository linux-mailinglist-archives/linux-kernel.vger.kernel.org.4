Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F0609500
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJWRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJWRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:08:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3B73305
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:08:23 -0700 (PDT)
Received: from ipservice-092-217-070-181.092.217.pools.vodafone-ip.de ([92.217.70.181] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omeSR-0000Rj-98; Sun, 23 Oct 2022 19:08:19 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: remove wait_ack param from _issue_probereq_p2p
Date:   Sun, 23 Oct 2022 19:08:07 +0200
Message-Id: <20221023170808.46233-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221023170808.46233-1-martin@kaiser.cx>
References: <20221023170808.46233-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of _issue_probereq_p2p sets wait_ack = false. Remove the
wait_ack parameter and the code that would run only if wait_ack == true.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 61d2680cbafc..d44e455f09ca 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3291,7 +3291,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	dump_mgntframe(padapter, pmgntframe);
 }
 
-static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
+static int _issue_probereq_p2p(struct adapter *padapter, u8 *da)
 {
 	int ret = _FAIL;
 	struct xmit_frame		*pmgntframe;
@@ -3564,12 +3564,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	if (wait_ack) {
-		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
-	} else {
-		dump_mgntframe(padapter, pmgntframe);
-		ret = _SUCCESS;
-	}
+	dump_mgntframe(padapter, pmgntframe);
+	ret = _SUCCESS;
 
 exit:
 	return ret;
@@ -3577,7 +3573,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 
 inline void issue_probereq_p2p(struct adapter *adapter, u8 *da)
 {
-	_issue_probereq_p2p(adapter, da, false);
+	_issue_probereq_p2p(adapter, da);
 }
 
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
-- 
2.30.2

