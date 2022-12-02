Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4180640348
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiLBJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLBJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:25:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9B5FAB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:25:36 -0800 (PST)
Received: from ipservice-092-217-087-074.092.217.pools.vodafone-ip.de ([92.217.87.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p12IU-0001tn-8N; Fri, 02 Dec 2022 10:25:30 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: merge two probereq_p2p functions
Date:   Fri,  2 Dec 2022 10:25:24 +0100
Message-Id: <20221202092525.403887-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202092525.403887-1-martin@kaiser.cx>
References: <20221202092525.403887-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_issue_probereq_p2p is called only by issue_probereq_p2p. Merge the two
functions and remove the unused return value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 49e0b50b1243..cf7b39cfb8f4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3183,9 +3183,8 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	dump_mgntframe(padapter, pmgntframe);
 }
 
-static int _issue_probereq_p2p(struct adapter *padapter, u8 *da)
+inline void issue_probereq_p2p(struct adapter *padapter, u8 *da)
 {
-	int ret = _FAIL;
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
 	unsigned char			*pframe;
@@ -3201,7 +3200,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da)
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
-		goto exit;
+		return;
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3457,15 +3456,6 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da)
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-	ret = _SUCCESS;
-
-exit:
-	return ret;
-}
-
-inline void issue_probereq_p2p(struct adapter *adapter, u8 *da)
-{
-	_issue_probereq_p2p(adapter, da);
 }
 
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, u8 token)
-- 
2.30.2

