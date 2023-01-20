Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F7675376
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjATLeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjATLeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:34:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ADE1350E;
        Fri, 20 Jan 2023 03:34:08 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7KfmE018346;
        Fri, 20 Jan 2023 11:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4x+oveN5HSksH5HXR9dvZkMFaJRvR4Um/DT6EgamFRE=;
 b=C1/6P6iYV8sBAwf60S2A2OibvYbnKgcubuGk30OV9dKqob5fBgkMsWhOk+0npHPZ1BPH
 DsuEkuazKbdikWnytKD6WFT4ny27TvgBpTlyntDedzeB/cQ/JuDpgzxIHr7R+xBsuFLd
 RYu0N7xnQYHXVyEUmJwjR3/5tQy0kt9+bgunVtqK2NHf/QzdYLebt60WPIo/P+R7bRAY
 6d1znnLbYrR4mhfnoadR1AqFGKH/aNBA3mGAzfrmjQfTShYJa3LWHo3w7/tlOLSOurqY
 l6wqmwjKpquUtp3nNZKB/Noa+g3JrbdRexKsGKguOiaCCkOYNEie26vdP7QEsouiwSaw rQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktknjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:33:47 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KBXkIY004701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:33:46 GMT
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 03:33:42 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v3 0/1]  scsi: ufs: Add hibernation callbacks
Date:   Fri, 20 Jan 2023 17:03:20 +0530
Message-ID: <20230120113321.30433-1-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pPzugPF_ZSI9f9VfafREhOIy7XfMfcOC
X-Proofpoint-GUID: pPzugPF_ZSI9f9VfafREhOIy7XfMfcOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_07,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=640 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds hibernation callbacks in UFS driver.
Please take a look and let us know your thoughts.

v3:
 -Address compilation issues

v2:
 - Addressed Bart's comments
 - Moved core and host related changes to single patch
 - Note to Bart: Regrading the comment to pass "restore" as an
 argument instead of adding a new member to ufs_hba structure, adding
 new function argument in core file (ufshcd.c) is forcing us to make
 changes to other vendor files to fix the compilation errors. Hence
 we have retained our original change. Please let us know your inputs
 on this.

Initial version:
 - Adds hibernation callbacks - freeze, restore and thaw,
 required for suspend to disk feature.


Anjana Hari (1):
  scsi: ufs: Add hibernation callbacks

 drivers/ufs/core/ufshcd.c   | 62 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  6 +++-
 include/ufs/ufshcd.h        |  8 +++++
 3 files changed, 75 insertions(+), 1 deletion(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

