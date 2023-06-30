Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1659F7434F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF3G3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjF3G3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:29:04 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371272D63;
        Thu, 29 Jun 2023 23:29:03 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2ohTq000994;
        Thu, 29 Jun 2023 23:28:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7Sn/Y+AbUWE7dkM+A9+BIA9m6WqrGPdGyljUWLW3b+4=;
 b=hyZowN5qbBCxmtnErzTRsNyzahCyeUh6KDPzI0NPW5QyaT9+rPsZTXmjYzGhlWIDEGLY
 iH6TrjQ6+veRpVNl8cRy4p4D0dkuU7GCk7YeLR3ivFxjSCbugdASAVseoxrvK0jObaJu
 f9xTLt65K6Yf83PqVAPE0olsXv424/2JyQyFzGABeYy5mqyqmayF63tpSQZkk9Ny/H4u
 jQ5Y65XwBgpw0/7HA9Kycm7s8w3fvM20Z4TKULdc+PwRl7qHYKe/A2bk4caGAK5BfVdn
 ODvZ8SArFx24vA8gGDqMfGq8MK5oXCVz1XDPD49dGf/rfJSw/e2a8NHDHWAVlu+KsTma 5g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rgvpc58rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 23:28:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 23:28:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 29 Jun 2023 23:28:53 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 83ACE3F707D;
        Thu, 29 Jun 2023 23:28:49 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>
Subject: [net Patch 1/4] octeontx2-af: cn10kb: fix interrupt csr addresses
Date:   Fri, 30 Jun 2023 11:58:42 +0530
Message-ID: <20230630062845.26606-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630062845.26606-1-hkelam@marvell.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: mA6qFLl_vVdoBXgilk0OvOYgoaz0j_mE
X-Proofpoint-ORIG-GUID: mA6qFLl_vVdoBXgilk0OvOYgoaz0j_mE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current design is that, for asynchronous events like link_up and
link_down firmware raises the interrupt to kernel. The previous patch
which added RPM_USX driver has a bug where it uses old csr addresses
for configuring interrupts. Which is resulting in losing interrupts
from source firmware.

This patch fixes the issue by correcting csr addresses.

Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index de0d88dd10d6..a433f92c51ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -47,7 +47,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.int_set_reg    =       RPM2_CMRX_SW_INT_ENA_W1S,
 	.irq_offset     =       1,
 	.int_ena_bit    =       BIT_ULL(0),
-	.lmac_fwi	=	RPM_LMAC_FWI,
+	.lmac_fwi	=	RPM2_LMAC_FWI,
 	.non_contiguous_serdes_lane = true,
 	.rx_stats_cnt   =       43,
 	.tx_stats_cnt   =       34,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index 22147b4c2137..be294eebab26 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -94,7 +94,8 @@
 
 /* CN10KB CSR Declaration */
 #define  RPM2_CMRX_SW_INT				0x1b0
-#define  RPM2_CMRX_SW_INT_ENA_W1S			0x1b8
+#define  RPM2_CMRX_SW_INT_ENA_W1S			0x1c8
+#define  RPM2_LMAC_FWI					0x12
 #define  RPM2_CMR_CHAN_MSK_OR				0x3120
 #define  RPM2_CMR_RX_OVR_BP_EN				BIT_ULL(2)
 #define  RPM2_CMR_RX_OVR_BP_BP				BIT_ULL(1)
-- 
2.17.1

