Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EED6A239C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBXVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBXVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:18:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050AB17CD0;
        Fri, 24 Feb 2023 13:17:27 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OLA165016576;
        Fri, 24 Feb 2023 21:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=j5KCVpEd+ZBO66GbCWEgXteYq8VuhHbqP+aNM/lamPI=;
 b=Ry4Y7DdtZ7DhUoESJpgUsUHcSH6Mcv6OggJl1xGMl0LEX9EzY+EH33Yyex6WX2zXSB2j
 aC5PMHIkAihYGoNAsMlO9qzCj6U4rru6lRZ47VcVVOLUJbicyk14CusQoPnd3lTRR2fO
 DOpx2x4AuFF4rKExFBUDsxDeP7Dqysds6gmOb8tIvf1YMy2Ru6jnhWsv3yffoW4V7gos
 JcHMN12ISWe0X30CHhL4n3+5/Zw8p+J2brc6YgBEQJj9COBk9jswzjFeuqH8dOWoiUp2
 A52vzNQfAXzyYdb1WxiTXJlR8Aca8CKLAqzHHJ1HlqaYqVNO9iXNG15mhFdoI8ganV2H Mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxsxr2220-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:17:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OLHK3u031484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:17:20 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 24 Feb 2023 13:17:19 -0800
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v5 0/2] Fallback to full coredump
Date:   Fri, 24 Feb 2023 13:17:05 -0800
Message-ID: <20230224211707.30916-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ww9HIEK-PLI8V3p8ry_fjxT2SIxQq0Ny
X-Proofpoint-ORIG-GUID: Ww9HIEK-PLI8V3p8ry_fjxT2SIxQq0Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=487 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for full coredump as a fallback mechanism in
absence of minidump support.

Siddharth Gupta (2):
  remoteproc: core: Export the rproc coredump APIs
  remoteproc: qcom: Add full coredump fallback mechanism

 drivers/remoteproc/qcom_common.c         | 13 +++++++++++--
 drivers/remoteproc/qcom_q6v5_pas.c       |  1 +
 drivers/remoteproc/remoteproc_coredump.c |  2 ++
 drivers/remoteproc/remoteproc_internal.h |  4 ----
 include/linux/remoteproc.h               |  4 ++++
 5 files changed, 18 insertions(+), 6 deletions(-)


base-commit: 7c855ef7137a67bcff0e039691b969428dd8ef6a
prerequisite-patch-id: e536336b8482ec63dac942663168e8437d59e250
prerequisite-patch-id: 3f021e6eb809f76cd989c6151437838cda16dd7d
prerequisite-patch-id: 78c3fd76f0fc0c6c016cd343afae65f60e6769dd
prerequisite-patch-id: 9157843370eb8a77d1c533a69a6ee061478dc11b
prerequisite-patch-id: 4ad66d124fd8370f9a443d726cb79e491cead691
prerequisite-patch-id: 226e1fb9cef4107698b0f15591aeca57025ff2d6
prerequisite-patch-id: a2fd45558397fc752b0e4f49305cdbe856747c30
prerequisite-patch-id: 45c6493f77babc82f66600b8914bfa46378e71e8
prerequisite-patch-id: d401dd88b3b36b67a0295a7b212e9a6902881930
prerequisite-patch-id: f494d0c370cae200c6af5bb3d6e784e3102b31b1
prerequisite-patch-id: c2192102ca8edd39defda07aa70fd484082adda8
prerequisite-patch-id: 2c4a3d89099cf154956088be6a30f1eeea131d8c
prerequisite-patch-id: 86ed20751124c24999c16289ba87d562c9000a31
prerequisite-patch-id: 1a8773faff744dafed185d8a55bb8f0840854220
prerequisite-patch-id: 9019e5c8c02d424787be016388c78fc612f0a94a
prerequisite-patch-id: c81d93897349887e70614cf628a8b72f6fedb52a
prerequisite-patch-id: 05e64f10cfd8ad329f583a2badde29a9424e4f0d
prerequisite-patch-id: 92276f31af93078364eac07142e45ef3cde3a1c9
prerequisite-patch-id: d40cb6cbde3f8e8385e7d79755a412d01994ec53
-- 
2.39.2

