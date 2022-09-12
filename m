Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DF5B613B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiILSl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiILSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:41:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200262F6;
        Mon, 12 Sep 2022 11:41:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CHMHct024493;
        Mon, 12 Sep 2022 18:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=43JjC0YBej1FGdFc7M0Ue+ZVjqsU7JFMRiSvnj6ZZOw=;
 b=C93DR18xvvuXSMRXOzxSIeosBfi/D0uVJhbWTVSiMkJL6PQFtAnz3vXrrBC9dqZ/G0Ad
 qWgUf+W5nvgt4CZZVmV2eNYbyTJHy7K0iYih17Q5U8djmD+C41YM6+kBOwA8d1wUEHkn
 gc71faLOSpJhZdroD/h8NqL4MQwXXKEBIBeIhiWZgtoqvzV/0AFzju/2ui/UcFy9a17S
 BZC8pjEhFvLKb/Us6xbvAjwubO1JwUVp+yTpBlwPwH5L+1Z8YOTbW0vrkEApDjLtfEBI
 ZICC/4ArurX9J3R0Az1+DPqYC6NOIPriIzK/h0vQDJ+j6QNltpTl+JTpw9GNx1LIdV0z gQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6kd1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CIfcKP015370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:38 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 11:41:38 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 0/2] Memory allocation change in scm/mdt_loader
Date:   Mon, 12 Sep 2022 11:41:30 -0700
Message-ID: <cover.1663007783.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l0bXOk182Nm_KOjaY7_Fu-i0Fbe2SuTj
X-Proofpoint-ORIG-GUID: l0bXOk182Nm_KOjaY7_Fu-i0Fbe2SuTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=684 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to remove the memory allocation call for the
qcom_metadata from the scm driver and move it to mdt_loader.

Gokul krishna Krishnakumar (2):
  firmware: qcom_scm: Remove memory alloc call from
    qcom_scm_pas_init_image()
  soc: qcom: mdt_loader: Move the memory allocation into mdt loader

 drivers/firmware/qcom_scm.c         | 33 +++-------------------------
 drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
 drivers/soc/qcom/mdt_loader.c       | 44 +++++++++++++++++++++++++++----------
 include/linux/qcom_scm.h            |  4 +---
 include/linux/soc/qcom/mdt_loader.h |  5 +++--
 5 files changed, 41 insertions(+), 47 deletions(-)

-- 
2.7.4

