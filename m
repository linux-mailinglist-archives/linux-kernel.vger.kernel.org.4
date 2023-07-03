Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD47461A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:58:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C05DE42;
        Mon,  3 Jul 2023 10:58:16 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363HTxu4007963;
        Mon, 3 Jul 2023 10:58:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=rO9msHe5GoTW/2jab/WC344uV+LBik+7BQx9cJi4P2c=;
 b=W7L+6k0speInyUMuaedP8ILsSVTjcEhHLo3iswMTABzBr1aLmKcISn2Y2zMx07JTtkHM
 6sjJfs9X9TeENbFE/E97R5l1PTa/EYlr2CS/3ZZs4heAbY2DoY5+oaEaK3xw6Stv3V4p
 otZe8m9szpFltf3RzJ380a9aanrMErXfgioOtblKQfMABrJQnmjYZ1HAW9DOxtAW0i7q
 GLUBF4HNyuqI0gsk3NH7Snz7bN09JPVJA/BEHnRSeCv5WemaGMcSBsD/5HRTODyYU7zB
 I2rV/hq/Yw1ydrYHRnSNHsjBfxJ9h+uTe89iU+Kv34qbl4V9Xg2cQpmrsuzYP8pMZY+L Dw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rjknj5fuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 10:58:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 3 Jul
 2023 10:58:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 3 Jul 2023 10:58:07 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 0AC0F3F7433;
        Mon,  3 Jul 2023 10:31:16 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>
Subject: [PATCH] octeontx-af: fix hardware timestamp configuration
Date:   Mon, 3 Jul 2023 23:01:16 +0530
Message-ID: <20230703173116.5093-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ggcPEox8V5fvdzvTPHmYRj-nvSW53row
X-Proofpoint-ORIG-GUID: ggcPEox8V5fvdzvTPHmYRj-nvSW53row
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

