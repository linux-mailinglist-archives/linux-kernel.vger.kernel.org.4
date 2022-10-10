Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF125F977F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJJExl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJJExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:53:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA626566;
        Sun,  9 Oct 2022 21:53:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4Jvs9011448;
        Mon, 10 Oct 2022 04:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=1pH2kdAPH0hwBlu0cPw4KAR9YI8pgeeW3NM+jwlgFug=;
 b=l+qZQ50yp+pj4QATn9qgjCz9Edd8a/nnu5t9qo4yB18jvU6+av1KxBMTAH2+FRxQcMuv
 DmifOHZg5MDAUZoeuch+GjAN+BUmygM6Qb/BFdZRevVsRgwlXLmzCgUkjH7BMB3P728r
 X1v8O7cvSvnTCTWiY2hm9pi6marPkf9RbtsLUB8h/Je4omwgj6/ilTcg/TTilKDVlzII
 jSik2Qnt2jNmt11v72i2F0aujCqN+/2SAWrpwp7Xr5lmcHxfOot4LlMuz5a/xkWpt8iS
 63TVd7wVCHerVDoToJGEiNMCd+3KMnLuLAezQlRdRnHwCdf0rxuwNGEdmIHlS5WKGHH3 Jg== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31fa3b7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 04:53:18 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4rGph019916;
        Mon, 10 Oct 2022 04:53:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3k3jr33gx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 04:53:16 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29A4rFeB019911;
        Mon, 10 Oct 2022 04:53:15 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 29A4rFtf019910;
        Mon, 10 Oct 2022 04:53:15 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 5E4623494; Mon, 10 Oct 2022 12:53:14 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: host: Fix race between channel preparation and M0 event
Date:   Mon, 10 Oct 2022 12:53:13 +0800
Message-Id: <1665377593-45536-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _zkj6jOJvWNa3f2VImnPndaZc6NrVYQm
X-Proofpoint-ORIG-GUID: _zkj6jOJvWNa3f2VImnPndaZc6NrVYQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=984
 bulkscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210100028
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition where mhi_prepare_channel() updates the
read and write pointers as the base address and in parallel, if
an M0 transition occurs, the tasklet goes ahead and rings
doorbells for all channels with a delta in TRE rings assuming
they are already enabled. This causes a null pointer access. Fix
it by adding a channel enabled check before ringing channel
doorbells.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 4a42186..0834590 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -301,7 +301,8 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
 		read_lock_irq(&mhi_chan->lock);
 
 		/* Only ring DB if ring is not empty */
-		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
+		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
+		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
 			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 		read_unlock_irq(&mhi_chan->lock);
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

