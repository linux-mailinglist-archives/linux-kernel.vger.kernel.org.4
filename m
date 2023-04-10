Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1C46DC8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDJP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDJP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:59:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA56191;
        Mon, 10 Apr 2023 08:58:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AAmwJb011837;
        Mon, 10 Apr 2023 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=gMyUa43ZmGQPWQRxir7TkMfOZGY7VIn1gBWyvYFKDe8=;
 b=BXWn1WCv8penptuuXdZ7jZGK8KZ5FCm0G7jkvP47CPhiwc5kEsPoRxI5PBWCequKdBD/
 e9TiRg3QQbXZCkfwCN4vsEo6ih0j/dXIC+fgz098qB34W8RFPP4BcKwzJ6PJl84QUMVP
 51oWwZ26ZSn4/tz8aVgJNX2YLjE+2S8sK074PW8C+XGr40/gXIGdmPO5SBbUNi6vGMS0
 wtEhsQTZ4Y36EsfgysE4DTgqjlzJhYbp0nvB3KS4azVGOcpiGmsCbpuV9+mJTpC4qSt+
 9mCS4r2I1QrteihYosqjaw8mScQGBf2vMEC08Nwm+LphWdPIAtnwMDzxwWAglG5yOWmA JA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu1f4380a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 15:58:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AFwUqQ015400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 15:58:30 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 08:58:29 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2 0/2] MHI host syserr fixes
Date:   Mon, 10 Apr 2023 09:58:10 -0600
Message-ID: <1681142292-27571-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zt6cEzft6_VGL3f8Nj-2BkVoKcBpcZxj
X-Proofpoint-ORIG-GUID: Zt6cEzft6_VGL3f8Nj-2BkVoKcBpcZxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=930
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100135
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small fixes that address an issue where it is observed in stress
testing that a MHI device could appear to enter a bad state and be unable
to recover unless the module is removed and re-added which should not be
necessary.

v2:
-Add fixes tags and cc stable.  Fixes tag is expected to give suitable
indication for backporting.

Jeffrey Hugo (2):
  bus: mhi: host: Remove duplicate ee check for syserr
  bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state

 drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
 drivers/bus/mhi/host/main.c |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.7.4

