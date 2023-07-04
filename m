Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BC74685A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGDE1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGDE1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:27:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54C107;
        Mon,  3 Jul 2023 21:27:07 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363Nn3Qj003044;
        Mon, 3 Jul 2023 21:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=SZd0IB0NpIrm/6zW9J7ZnFkHt59bmYQVt5I2cU0EAgI=;
 b=WX33rD+arvBVt4VKNYmQwcQlw+BxJxPn6rMeOctImrrFuMZXP3s3gMAuMQkuh766ZlN9
 Vj5P0zWswEBvR/ln8GerA8VTuTDEQgrfGphnnCqpwGlYpA6LYMbOU1JuSX5eQfQvqXcF
 8fqE4h3BZHbtRscciTzy4j1Na88sz7o/YxbBy8UPIQQ0oS20aypMiynjKaQ37N0ZREp6
 d3i1Erg2HZFdLvoKrhxa7YdjWNzUCkS3B3Z27BEmaPB4xuOOMMIrvHxA20OKbomnwatb
 +gAoqIykZs3SxBORgwytpBxLjSeCiEqEGm5gm7jdkf4EIrv2CzNykAT/HeJj0RxkTzpJ uA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rjknj6hf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 21:27:01 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 3 Jul
 2023 21:26:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 3 Jul 2023 21:26:58 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id F03B63F7040;
        Mon,  3 Jul 2023 21:26:54 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>, <richardcochran@gmail.com>
Subject: [net Patch v2] octeontx-af: fix hardware timestamp configuration
Date:   Tue, 4 Jul 2023 09:56:53 +0530
Message-ID: <20230704042653.11303-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: iPGDCSWAXf-LMuXdMd6HzOXsPAM7y5yh
X-Proofpoint-ORIG-GUID: iPGDCSWAXf-LMuXdMd6HzOXsPAM7y5yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_01,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAC block on CN10K (RPM) supports hardware timestamp configuration. The
previous patch which added timestamp configuration support has a bug.
Though the netdev driver requests to disable timestamp configuration,
the driver is always enabling it.

This patch fixes the same.

Fixes: d1489208681d ("octeontx2-af: cn10k: RPM hardware timestamp configuration")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
v2 * tag the patch to correct tree


 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4b8559ac0404..095b2cc4a699 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -763,7 +763,7 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);

 	mac_ops = get_mac_ops(cgxd);
-	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, true);
+	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, enable);
 	/* If PTP is enabled then inform NPC that packets to be
 	 * parsed by this PF will have their data shifted by 8 bytes
 	 * and if PTP is disabled then no shift is required
--
2.17.1
