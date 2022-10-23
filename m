Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1426094FD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJWRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJWRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:08:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9273305
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:08:20 -0700 (PDT)
Received: from ipservice-092-217-070-181.092.217.pools.vodafone-ip.de ([92.217.70.181] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omeSO-0000Rj-Pc; Sun, 23 Oct 2022 19:08:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: use standard multicast addr check
Date:   Sun, 23 Oct 2022 19:08:04 +0200
Message-Id: <20221023170808.46233-2-martin@kaiser.cx>
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

Use is_multicast_ether_addr to check for a multicast address instead of
reimplementing this check in the driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h     | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index bbde5c03f9ae..51324e708697 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -404,7 +404,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	if (!hwaddr)
 		return NULL;
 
-	if (IS_MCAST(hwaddr))
+	if (is_multicast_ether_addr(hwaddr))
 		addr = bc_addr;
 	else
 		addr = hwaddr;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 381385a7e118..fdb7c1bf3573 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -236,11 +236,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline bool IS_MCAST(unsigned char *da)
-{
-	return (*da) & 0x01;
-}
-
 static inline unsigned char *get_da(unsigned char *pframe)
 {
 	unsigned char	*da;
-- 
2.30.2

