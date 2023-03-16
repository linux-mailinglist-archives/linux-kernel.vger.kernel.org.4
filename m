Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F76BC7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCPH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCPH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:57:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C86132EB;
        Thu, 16 Mar 2023 00:57:43 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G24cjl000491;
        Thu, 16 Mar 2023 07:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=uJBkTVB/qMYD3rMXdeVOUZkqEDDNGkvOqOFrgMSqryU=;
 b=aMD3JfdY8pUOc+87HMJWYtBHc06eDztoFYHbBc8IGU/dE/h1ol0iujJQ75jxrdUFFk4x
 ic8cTfL/u9dRseGjJFWNBawzlwuXESW50Jit7NtIkuOGY9Y2XWesnFMwoYKPdvaNEltN
 ZTNThnrRRIi0IW3pmCUbe3UgFDb8E0JbmlbQJ1vEV3uE5ghK1JfFq3t5aJiftTtD8/xv
 yOgGH7pFj84i1iTKdKuzNcsZ3ThTXEAatw5l8J+k4GOuqeisYTvzEl3qkbt4KETCleBr
 bkIYN+/GCHKBNAa1rLK2agJGgq52Ij25LuD/lBspdY0Wphj2Hkimtp0Q/gLE3wSKJAnr 1g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy3h44p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 07:57:39 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G7vZ22025598;
        Thu, 16 Mar 2023 07:57:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqkry4b-1;
        Thu, 16 Mar 2023 07:57:35 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G7vZG0025593;
        Thu, 16 Mar 2023 07:57:35 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32G7vZr1025592;
        Thu, 16 Mar 2023 07:57:35 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 7E4DA900889; Thu, 16 Mar 2023 13:27:34 +0530 (IST)
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
Subject: [[v1]PATCH 0/1] Fix for H265 decoding failure .
Date:   Thu, 16 Mar 2023 13:27:28 +0530
Message-Id: <20230316075729.4052-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115121004.28197-2-quic_vboma@quicinc.com>
References: <20221115121004.28197-2-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e763z1WReHf7bQVDnne6e6w_WwyMgW7a
X-Proofpoint-ORIG-GUID: e763z1WReHf7bQVDnne6e6w_WwyMgW7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=768 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160066
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Fixed strict patch warnings and ensured rebase.

Fixed the buffer size calculation mismatch with firmware requirements.
Tested  on v5.15  kernel.
For testing utilised the chrome utilities .


Viswanath Boma (1):
  venus : Fix for H265 decoding failure.

 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

