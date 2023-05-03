Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A356F50D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjECHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:11:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CA46A8;
        Wed,  3 May 2023 00:11:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3436ACT0003519;
        Wed, 3 May 2023 00:10:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=twsPib4scJxgTJGR3BfshOH9AmiqKYWWC6vegve+jxE=;
 b=PCv1IGAPYRSra/Ya78e2yJTN5rnAyMYT5qPWwAcS+25JFKrNfbPvZWBAvdy9+0js7Fbh
 jeH9IBmFuB9/s12z5Q0XqAfyf0oPSfJnNB+He34i9ghYdKuwspIizYtzlrVwvErujaTj
 7ORqhGc9NDs1zQr0vnq+3qIfOTSrarBWN0iyjShwRuV8WHgoyQGx3ImQVh9wRDKTJavV
 eqUcPpiDnhga+VcIDTR+ZpCOb0ijdsABNPsj61JBVmsNYdeSUNHGjKmWoW33mPromi87
 Zv8BIuOpXtlJbepzROC2ygVjoph1TwZdWSkd7WCKZK0rvVdt3t2Lnq1L7CbP4jzy/rvq eA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q92rp3m9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 00:10:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 May
 2023 00:10:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 May 2023 00:10:39 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
        by maili.marvell.com (Postfix) with ESMTP id 855583F7075;
        Wed,  3 May 2023 00:10:35 -0700 (PDT)
From:   Sai Krishna <saikrishnag@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <simon.horman@corigine.com>,
        <leon@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>
CC:     Sai Krishna <saikrishnag@marvell.com>
Subject: [net PATCH v5 10/11] octeontx2-pf: Disable packet I/O for graceful exit
Date:   Wed, 3 May 2023 12:39:43 +0530
Message-ID: <20230503070944.960190-11-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503070944.960190-1-saikrishnag@marvell.com>
References: <20230503070944.960190-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3uLSDk6Ny9uxY9ZHzgQWmTRROiJZ0rpz
X-Proofpoint-GUID: 3uLSDk6Ny9uxY9ZHzgQWmTRROiJZ0rpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

At the stage of enabling packet I/O in otx2_open, If mailbox
timeout occurs then interface ends up in down state where as
hardware packet I/O is enabled. Hence disable packet I/O also
before bailing out.

Fixes: 1ea0166da050 ("octeontx2-pf: Fix the device state on error")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a75c944cc739..18284ad75157 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1835,13 +1835,22 @@ int otx2_open(struct net_device *netdev)
 		otx2_dmacflt_reinstall_flows(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	otx2_do_set_rx_mode(pf);
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
-- 
2.25.1

