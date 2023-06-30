Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1D7434FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjF3G3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF3G3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:29:09 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5E30C5;
        Thu, 29 Jun 2023 23:29:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CEYA013691;
        Thu, 29 Jun 2023 23:29:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=rWyzZqcmXgpWtJawATcjZRNO+M4ovmpNa6UwHV2ObrQ=;
 b=b7JXoL8B81QbYKXBfWLGenN1N9vFsjzCNyf7gXGBqvXnafMDiOTtO3W3Y4uJ/oDFVQYw
 u1gxkeLO6zR0yXnebDRxxYtBk1RYKvJF6PRMbBAZo1T/NFsTHvGiEuGMVTk1m84YWfcH
 x+1ArVT7ZM0ttiQ7jU/XtnogTjRE9vJDUpkuhojRRlDrEDhPWiEB+jJQRHvZhxy/cEEB
 RSiog1XjAS7uIrkr1csMaRuYHwklOWnqi6yyguLBSE6HBNlehaJRKpiHmHu/efGi7Xju
 DwMqsuLk7GKD0RZOHfioptyBRNO2PnFHY7gvdNDeI6Ho8vy56jJHHShQuG/HhZjf5ba8 Ug== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2egqtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 23:29:02 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 23:29:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 29 Jun 2023 23:29:00 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id E96FA3F707D;
        Thu, 29 Jun 2023 23:28:56 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>
Subject: [net Patch 3/4] octeontx2-af: Add validation before accessing cgx and lmac
Date:   Fri, 30 Jun 2023 11:58:44 +0530
Message-ID: <20230630062845.26606-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630062845.26606-1-hkelam@marvell.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KihpqnPpPuci-9vTPrLmHMojzsG8Mxhj
X-Proofpoint-GUID: KihpqnPpPuci-9vTPrLmHMojzsG8Mxhj
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

with the addition of new MAC blocks like CN10K RPM and CN10KB
RPM_USX, LMACs are noncontiguous and CGX blocks are also
noncontiguous. But during RVU driver initialization, the driver
is assuming they are contiguous and trying to access
cgx or lmac with their id which is resulting in kernel panic.

This patch fixes the issue by adding proper checks.

[   23.219150] pc : cgx_lmac_read+0x38/0x70
[   23.219154] lr : rvu_program_channels+0x3f0/0x498
[   23.223852] sp : ffff000100d6fc80
[   23.227158] x29: ffff000100d6fc80 x28: ffff00010009f880 x27:
000000000000005a
[   23.234288] x26: ffff000102586768 x25: 0000000000002500 x24:
fffffffffff0f000

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index bd77152bb8d7..f4bdca662d61 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -169,6 +169,9 @@ void cgx_lmac_write(int cgx_id, int lmac_id, u64 offset, u64 val)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
 
+	/* Software must not access disabled LMAC registers */
+	if (!is_lmac_valid(cgx_dev, lmac_id))
+		return;
 	cgx_write(cgx_dev, lmac_id, offset, val);
 }
 
@@ -176,6 +179,10 @@ u64 cgx_lmac_read(int cgx_id, int lmac_id, u64 offset)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
 
+	/* Software must not access disabled LMAC registers */
+	if (!is_lmac_valid(cgx_dev, lmac_id))
+		return 0;
+
 	return cgx_read(cgx_dev, lmac_id, offset);
 }
 
-- 
2.17.1

