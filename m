Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169D750173
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGLI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjGLI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:28:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79659422B;
        Wed, 12 Jul 2023 01:23:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C1RvVn014752;
        Wed, 12 Jul 2023 08:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=aTLQpedi2LvXzzjoGzLBOF15YzPK0gUSq9WXyYp39F8=;
 b=aAldiDb16RIS/Lm/CaT5mfOtGoGY+9MkFeHgICINBVV65z+V8aW7UDWkR2Gkw6MPieh3
 S5od0sGfCY7PMCRqWc3I/pUmqdxispxWozM7oPhexiIzygnokvAvvM4zkHriP+jOZlwq
 CFDb1fW/q98y0EKOrQi9Nqz312/nSCdfV21WzOjH4z+YUzahVFbXj2yv0GFAvXLOlbmH
 BCC9slgopsYkp8q37qDFfKbqFi1+fE9EvgiSn6CB9yt7ZCTlxoZSvu/lEE7Im7HlVSem
 4p4eMAdvIVa6HYVp0UlYQkftRtrHA1O0Gq792yqq1hX8BTeReF/m2d3GiN/Ma7AmniNM xA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf4s8yuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:23:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C8Mxn5014175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:22:59 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 01:22:55 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 0/3] Add notifier call chain to Embedded USB Debug(EUD) driver
Date:   Wed, 12 Jul 2023 13:52:37 +0530
Message-ID: <cover.1689148711.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m0v9ANWWf2pAAeQT65KBvNd6-fGMuUxk
X-Proofpoint-ORIG-GUID: m0v9ANWWf2pAAeQT65KBvNd6-fGMuUxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=320 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the notifier chain to the Embedded USB Debug(EUD) driver.
The notifier chain is used to check the role switch status of EUD. Since EUD can
function only in device mode, other modules trying to do role-switch on the same
port have to first check the EUD status by calling this notifier chain and based
on the status proceed or block their role-switching step. The modules can call
the notifier through the call eud_notifier_call_chain and pass their own
role switch state as the argument. This chain will also be able to handle the
scenario of multiple modules switching roles on the same port since this can
create a priority and ordering among them for conflict resolution.

Souradeep Chowdhury (3):
  usb: misc: Add the interface for notifier call for Embedded USB
    Debugger(EUD)
  usb: misc: Add notifier call chain to Embedded USB Debug(EUD) driver
  MAINTAINERS: Add the header file entry for Embedded USB debugger(EUD)

 MAINTAINERS                          |  1 +
 drivers/usb/misc/qcom_eud.c          | 52 ++++++++++++++++++++++++++--
 drivers/usb/misc/qcom_eud_notifier.h | 10 ++++++
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/misc/qcom_eud_notifier.h

--
2.17.1

