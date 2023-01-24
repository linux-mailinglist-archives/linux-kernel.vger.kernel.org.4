Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B601767A547
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjAXV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAXV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:57:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79394A223;
        Tue, 24 Jan 2023 13:57:52 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OKYCaE022236;
        Tue, 24 Jan 2023 21:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/3t6Ul43D/U4MVqFsDlfvNyuYMKr31kFdBiILMCnGfo=;
 b=YHbwAywxZue/HLZ2vZ8oY06ARTeSZQH0vMgCbmTrO7O3UtfVweFnqeDiyfCjIipntie6
 qo8WRX9YxCLdN2RylCcLvjGp1oH+b9VWAhH+yAF520lRo+7KlFpo0T0G3SOxoAkNuW1b
 UvANy5c7Q6TgHN5BATQRBGnVw8G0wx20u09DKJYRYFIaenTR/LAm+d/zP7xLvOG6dd2f
 9Vi8Hq6EWZT3pMdDC1tPS0mmmS+bXHDbQZzqmhI9+hj1LRNYHGdd2ooSN24TJSsmCbAv
 QyHJg/A+8rOCwh+vlE5PVBiM5qcL2ua7ivmqjVe9uZdK3aaFwQR2MUlt7tNLwtMuAMCm pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dndxjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 21:57:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30OLveCq026026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 21:57:40 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 13:57:39 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 0/2] MHI host syserr fixes
Date:   Tue, 24 Jan 2023 14:57:22 -0700
Message-ID: <1674597444-24543-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ATm4WQtwur1H_c10HPMZWOqm2_icacje
X-Proofpoint-ORIG-GUID: ATm4WQtwur1H_c10HPMZWOqm2_icacje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_16,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=991 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small fixes that address an issue where it is observed in stress
testing that a MHI device could appear to enter a bad state and be unable
to recover unless the module is removed and re-added which should not be
necessary.

Jeffrey Hugo (2):
  bus: mhi: host: Remove duplicate ee check for syserr
  bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state

 drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
 drivers/bus/mhi/host/main.c |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.7.4

