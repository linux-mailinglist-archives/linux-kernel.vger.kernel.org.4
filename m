Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E46D58A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjDDGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjDDGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:18:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6DF1BD7;
        Mon,  3 Apr 2023 23:17:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333ATM9X029579;
        Tue, 4 Apr 2023 06:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=dOcWD7hwOiecoarohEbN981aTy62qme7WLPGbsPkvIY=;
 b=X2vJAaqOHgwYJ80O3MvPFAqd5yMlSwNGSDk3fv8WB8CXjrpXpcLkNGpqGUJffFgmf7Ve
 mA9WTcbDfrDEVNZfKhtpnhCqWRqYRbsJxytrKbf3lIpBEn0x609I4jNqJ1kX4is3MTUR
 ozr4eieEU2YbiBGjGWzglIvGzsdGxF+Jo5sCxKqEb26kmavpfN/RaZYV2+piNYPLdVsJ
 htzHCIR101uOJDfjZENBB30WelRorLsx+mcKXezobQCcKHSVckvjEXHBVY6884Flih/X
 Tm4uzj1KVSfkzpWqb41KE4c6BXVsxblZi04fY6UHAaEDH9IlRLQre1nlDP8lpMThazKY RQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqw36tetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 06:17:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3346HF5J025295;
        Tue, 4 Apr 2023 06:17:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpkhu3g-1;
        Tue, 04 Apr 2023 06:17:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3346HFWI025190;
        Tue, 4 Apr 2023 06:17:15 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3346HFhr025188;
        Tue, 04 Apr 2023 06:17:15 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 9519632EE; Tue,  4 Apr 2023 11:47:14 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 0/3] fix decoder issues with firmware version check
Date:   Tue,  4 Apr 2023 11:47:09 +0530
Message-Id: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0ftWUsmWInntVOaIrzhF3do2H3vksrzX
X-Proofpoint-GUID: 0ftWUsmWInntVOaIrzhF3do2H3vksrzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=792 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040057
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the changes to
  - add firmware version based check to enable/disable some feature.
  - add support of new HFI to notify sequence change event to
    driver during resolution change at interframe.
  - use firmware version based check to fix EOS handling for different
    firmware versions.

With this series, divided the previous version [1] into
multiple patches as suggested in review comments.

[1] https://patchwork.kernel.org/project/linux-media/list/?series=733169

Dikshita Agarwal (3):
  venus: add firmware version based check
  venus: enable sufficient sequence change support for vp9
  venus: fix EOS handling in decoder stop command

 drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 10 +++++++++-
 5 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.7.4

