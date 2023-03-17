Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8FC6BEE35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCQQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:28:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396884A1DC;
        Fri, 17 Mar 2023 09:28:28 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HEoEXK005697;
        Fri, 17 Mar 2023 16:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AlJK1BbSsS090U1G8HHps6U2JClnT8EAe006kptGfaY=;
 b=Nwsgu/2A/OA65NGtoMRbci+MV+mJuc0SgHyUcEY13u65dlwoEwiPo7OCs/HNxFczVmd5
 8cGMc0RTMhpIm150bycuyqdjPRzp0ISBC8Tsj7pJbwuLUhcqKf/WLDENmQtlGnr5vNY3
 gFjWr5YZTuuPZDFdXoTKRW7RnKxiTYu2Q1Ef1jU1D8drlFW6NUbkO87yA54tQyQ753Qj
 RKtTUQqNSaRulPCtJDKMOvj4+22Bz2dWYtskrx7Z1l77GRbFtWkUM4jDXUnmVAmLWUfV
 prp3zVfz5wBk7WpKMekl2lVVLQh2MPy20gRVc8oNYbCHhROU2UgCn41vPqd+kYvo8bvb /A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pctap8f1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HGSOFL001889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:24 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 09:28:21 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 0/5] Refactor to support multiple download mode 
Date:   Fri, 17 Mar 2023 21:57:57 +0530
Message-ID: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bobk-3pR82RrRdXpTU6E7gDWSLFXHhEg
X-Proofpoint-GUID: Bobk-3pR82RrRdXpTU6E7gDWSLFXHhEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intention of this series to support multiple download mode and
only modify the required bits during setting tcsr register.

Other download modes are minidump, bothdump (full dump + minidump).

Minidump kernel driver patches has been sent here
https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/

Changes in v3:
 - Removed [1] from the series and sent as a separate patch[2], although this series
   should be applied on top [2].
  [1] https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
  [2] https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
 - Introduce new exported symbol on suggestion from [srinivas.kandagatla]
 - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
 - Addressed comment given by [dmitry.baryshkov]
 - Converted non-standard Originally-by to Signed-off-by.

Changes in v2: https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
 - Addressed comment made by [bjorn]
 - Added download mask.
 - Passed download mode as parameter
 - Accept human accepatable download mode string.
 - enable = !!dload_mode
 - Shifted module param callback to somewhere down in
   the file so that it no longer need to know the
   prototype of qcom_scm_set_download_mode()
 - updated commit text.


Mukesh Ojha (5):
  firmware: qcom_scm: provide a read-modify-write function
  pinctrl: qcom: Use qcom_scm_io_update_field()
  firmware: scm: Modify only the download bits in TCSR register
  firmware: qcom_scm: Refactor code to support multiple download mode
  firmware: qcom_scm: Add multiple download mode support

 drivers/firmware/Kconfig               | 11 -----
 drivers/firmware/qcom_scm.c            | 88 ++++++++++++++++++++++++++++++----
 drivers/pinctrl/qcom/pinctrl-msm.c     | 15 +++---
 include/linux/firmware/qcom/qcom_scm.h |  2 +
 4 files changed, 89 insertions(+), 27 deletions(-)

-- 
2.7.4

