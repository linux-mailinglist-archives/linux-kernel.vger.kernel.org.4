Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6B69E281
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjBUOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjBUOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:39:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A126CC4;
        Tue, 21 Feb 2023 06:39:57 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDPke1024990;
        Tue, 21 Feb 2023 14:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EQeSRGp7/ByWGQn2aX55X5ktztuq7absJNhYqt94Db8=;
 b=MhoKeNUWk5PsXk0BH0PfUP6cKwoJT68vc1CA4Ozh+1L3u12RhdJvkHbW+nuV3rknhIaM
 rQHdXlEpVrYmn+0ECg8WZ3PULrn8HCZXIPfi/+MmwGDZNctWqwplD+kX+UoVIRZct941
 ce7rYig49crxRN5MHwmr+Ag2aVon3dVp+I3CQJNgWmQR3RePrmIwG1ovtmkIoGFLIQsT
 SbM/+knQ/E8PIbq+K03KE31X8udojoG7AIrfznGEeGbjMuZ6oJ2DuQUHa0hNEmRIu2hX
 oO+qjTBhL2F6MNHqk+iWlOJW3XPzNznT+IsHc6wGNdjJw74iJzjYrEwg57U+8G57uI4A mw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntpw9qqte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:39:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LEdrH2021168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:39:53 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 06:39:51 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH 0/4] Refactor to support multiple download mode
Date:   Tue, 21 Feb 2023 20:09:37 +0530
Message-ID: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HIGLVHPAzb7N4GGwJF1bou6jz7mU7arh
X-Proofpoint-GUID: HIGLVHPAzb7N4GGwJF1bou6jz7mU7arh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=853 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While 1/4 and 2/4 are the fixes and 3/4 and 4/4 are trying to
support multiple download mode like full/mini/both dump.

4/4 will help to enable minidump mode for Qualcomm SoC.

Minidump kernel driver patches has been sent here
https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/

Mukesh Ojha (4):
  firmware: qcom_scm: Clear download bit during reboot
  firmware: scm: Modify only the DLOAD bit in TCSR register for download
    mode
  firmware: qcom_scm: Refactor code to support multiple download mode
  firmware: qcom_scm: Add multiple download mode support

 drivers/firmware/Kconfig    | 11 ---------
 drivers/firmware/qcom_scm.c | 60 +++++++++++++++++++++++++++++++++++++++------
 include/linux/qcom_scm.h    |  6 +++++
 3 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.7.4

