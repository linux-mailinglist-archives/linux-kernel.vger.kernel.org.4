Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB606CC6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjC1Pla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjC1PlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:41:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8A10433;
        Tue, 28 Mar 2023 08:40:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S9W1On031489;
        Tue, 28 Mar 2023 15:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ldxbnuXDAc2aJqsCTg/uUzaOXQoqv6aMvjoc8Wq2yhs=;
 b=S1topEUL0hnbjNqGO9jSHt3rd6RjW33dI/pm1p8NnnopJj3jif41+tI+Oh2Dqh6X9Rr3
 LyalySQipI+pP/ITWOim37jcbyrsCvw12rrZHTed2MbAHNGRwwSSJX0Ll++3yRVuGnBJ
 KHJSgLLgcq+lU5tr35uSVa9J04w8ONowgKzqaqIfSnWZl0Pq07vhRmN6lfNQCZykfEQ0
 Cw/6GLRBz5WT2jA3X6e0fqkbWtGTmkZSuLtslZqrCiP2Cl3Y4wJ7x6HW2va6kYxMvBqG
 P8GzvgGItVgl4yiGCDoLj+7x2wyCUae9EXUBl4O4iCGxoE1DbxAJnsSsmblq20aI+/pV kQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk8pvkyu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 15:39:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SFdjhO022832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 15:39:45 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 28 Mar 2023 08:39:42 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v5 0/5] Refactor to support multiple download mode
Date:   Tue, 28 Mar 2023 21:07:44 +0530
Message-ID: <1680017869-22421-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0UDEPJweerPwFiA_mow5ILMBtNazk7m
X-Proofpoint-ORIG-GUID: Y0UDEPJweerPwFiA_mow5ILMBtNazk7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280122
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intention of this series to support multiple download mode and
only modify the required bits during setting tcsr register.

Other download modes are minidump, bothdump (full dump + minidump).

Latest minidump kernel driver patches has been sent here
https://lore.kernel.org/lkml/1679491817-2498-1-git-send-email-quic_mojha@quicinc.com/

Also, this series should be applied on
https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/

Changes in v5:
  - Tried to fix the issue reported by kernel test robot
    https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/

  - Applied some of the improvement suggested by [Bjorn.andersson]
 
    . Dropped 'both' instead support full,mini or mini,full for setting download
    mode to collect both minidump and full dump.
    
    . logging improvement.
    

Changes in v4: https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
  - val should be shifted within the function [srinivas.kandagatla]
    i.e new = (old & ~mask) | (val << ffs(mask) - 1);
  - Added Acked-by [linus.walleij] on pinctrl change.

Changes in v3 : https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
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
 drivers/firmware/qcom_scm.c            | 89 +++++++++++++++++++++++++++++++---
 drivers/pinctrl/qcom/pinctrl-msm.c     | 11 ++---
 include/linux/firmware/qcom/qcom_scm.h |  2 +
 4 files changed, 87 insertions(+), 26 deletions(-)

-- 
2.7.4

