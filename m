Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7456F727F10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjFHLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbjFHLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:42:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A92709;
        Thu,  8 Jun 2023 04:42:22 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35838MFo023496;
        Thu, 8 Jun 2023 04:42:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=wcseGuDaoNRD1SW7h1dV0i2ofVn/Kiq/5Knj0cV+MkY=;
 b=IpB8ztal7RVMibujnI7AHyVEuSjOAxDOeTDqvHKBkveTLr6tkanjjj1/e8tmglXWSPIF
 b1mIOoEvrNYaK7Xkz+YOSkhRLUk6IeRKj1QEF7ajNXE0BLf6SjHIDPwyMZG2cpEu+6Iz
 J/z620RlIlsDI1PiUtxaGMlB0Ti2vMXVSFEfeDFsew0BxECBOQtMkxDd/zLwi6Wynw/7
 YzBkyb943nka92MSqGXXG6nFvgWsuJVsse1RmCPFM2peS/jWNEhJ4lxYNxzpkXgUcgwi
 7CgPGWdBnwfql6QGyrhQJ9q/icYfNjzOcQFOEinzuhC3ZBAbZGAn+ClDMd23zuirfyJp lw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r30eu2csh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 04:42:14 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Jun
 2023 04:42:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 8 Jun 2023 04:42:12 -0700
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
        by maili.marvell.com (Postfix) with ESMTP id 9898B3F703F;
        Thu,  8 Jun 2023 04:42:09 -0700 (PDT)
From:   Naveen Mamindlapalli <naveenm@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Nithin Dabilpuram <ndabilpuram@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [net PATCH 2/2] octeontx2-af: fix lbk link credits on cn10k
Date:   Thu, 8 Jun 2023 17:12:01 +0530
Message-ID: <20230608114201.31112-3-naveenm@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
In-Reply-To: <20230608114201.31112-1-naveenm@marvell.com>
References: <20230608114201.31112-1-naveenm@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6__liSOp03p0dUkP1E4Ix1FcIJpYZZQS
X-Proofpoint-GUID: 6__liSOp03p0dUkP1E4Ix1FcIJpYZZQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Fix LBK link credits on CN10K to be same as CN9K i.e
16 * MAX_LBK_DATA_RATE instead of current scheme of
calculation based on LBK buf length / FIFO size.

Fixes: 6e54e1c5399a ("octeontx2-af: cn10K: Add MTU configuration")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 967370c0a649..cbb6d7e62d90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4067,10 +4067,6 @@ int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
 
 static u64 rvu_get_lbk_link_credits(struct rvu *rvu, u16 lbk_max_frs)
 {
-	/* CN10k supports 72KB FIFO size and max packet size of 64k */
-	if (rvu->hw->lbk_bufsize == 0x12000)
-		return (rvu->hw->lbk_bufsize - lbk_max_frs) / 16;
-
 	return 1600; /* 16 * max LBK datarate = 16 * 100Gbps */
 }
 
-- 
2.39.0.198.ga38d39a4c5

