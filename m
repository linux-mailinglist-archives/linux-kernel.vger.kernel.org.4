Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC068760B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:47:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956079CA9;
        Wed,  1 Feb 2023 22:47:29 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3126fRNg026644;
        Thu, 2 Feb 2023 06:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=R88EbT68+7UR1uAi8Q3mMqFRv8TswXBJFJhjw4XIK8c=;
 b=n1Uqb9WusDABE+CCW/rSMPyX9kbVfcjWksib/rRBQy3Fb3ZrPK3yJSBI7s3mXJ9vO71r
 OmewPnTrKLsjvwKGeqRQlkB8zWnDYWJkZ/Kjdb0p65Lo5wLOwrVIi4jin4nA1VfxacoV
 N8+QJhuEQSeiXWCHePTRA2SyeegsUdRYVcMN8RpJdu5ZVNxUrrV8PAIxvQc34AXMYDZL
 wq/ncDYdLnapVRpeCFoodUPfRMYbWe9/cx+dlS+z/HWfl9NWOjpd7BLgsb12hn08ZHk2
 j84iyxwUYDTsGWQ92JHSggSXaub8dDLFLgGNHpEdv3gqMVly1KFfcmeeklvQm8g1Ru6w sg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkj4ag95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 06:47:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3126lLlb009766;
        Thu, 2 Feb 2023 06:47:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ncvskpdgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 02 Feb 2023 06:47:21 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3126lLN5009760;
        Thu, 2 Feb 2023 06:47:21 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3126lL1D009758;
        Thu, 02 Feb 2023 06:47:21 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 4A7ED9008B9; Thu,  2 Feb 2023 12:17:20 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/1] Fix for VP9 DRC and Decoder STOP issue.
Date:   Thu,  2 Feb 2023 12:17:11 +0530
Message-Id: <20230202064712.5804-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115121237.28361-2-quic_vboma@quicinc.com>
References: <20221115121237.28361-2-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dfVWPgE_VAX7WUvGfnMU8BvxRQWYD6jd
X-Proofpoint-ORIG-GUID: dfVWPgE_VAX7WUvGfnMU8BvxRQWYD6jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=883 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020063
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Tested the changes on v5.15 and v5.4 kernels .
For testing Chrome Utilities were used .

Viswanath Boma (1):
  venus: Enable sufficient sequence change support for sc7180 and fix
    for Decoder STOP command issue.

 drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.17.1

