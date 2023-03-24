Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB776C77BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCXGQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:16:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA528D32;
        Thu, 23 Mar 2023 23:16:47 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O4JN1f005878;
        Fri, 24 Mar 2023 06:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=binmqssIOH8RRHmzcq2GvEcacH7/g6cim/PVJXyXtqE=;
 b=ev5V4zVctWJ/2G7y8t9UE+7YX+lSsLirMZDIgtZrtC6mMTFQZZp8aM2SrX+PC+xPDTma
 kCMrjw8htXQcMZ8pR70PT3uPoXzlxoUbeBqQ3KVSB4S9LyArZoRD+Myf3YcLfFXmJ2Kn
 Ml/7Rs15VWzQwvPHB80k0O1qie2uXBBlmoIKouysK+ish8B6YsBrwzM0NUg5449T0G86
 MAvF5VAfmCsDNGhG3qbdkfr6ZRTaARK4uQ6OIGpv3oEnzYaVr/PU7vGRCQPyYg2O9fsQ
 dZ3YR9tbrBsW9zVRF2XWjnxKAUNGlbuYvoRFj/JbitCc4z2wyf+N0zN3IIoiVGH7PSWi mA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgyee8uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:29 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32O6GShd023727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:28 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 23:16:22 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/3] Add support to configure Coresight Dummy subunit
Date:   Fri, 24 Mar 2023 14:16:05 +0800
Message-ID: <20230324061608.33609-1-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lta3x1h8TvZ0PQVBKPAZ1Lr7xe20DlQn
X-Proofpoint-ORIG-GUID: Lta3x1h8TvZ0PQVBKPAZ1Lr7xe20DlQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240049
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of Coresight Dummy subunit
The Coresight Dummy subunit is for Coresight Dummy component, there are some
specific Coresight devices that HLOS don't have permission to access. Such as
some TPDMs, they would be configured in NON-HLOS side, but it's necessary to
build Coresight path for it to debug. So there need driver to register dummy
devices as Coresight devices.

Commit link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy-v2

Changes in V2:
1. Declare dummy_init and dummy_exit as static to fix missing-prototypes
warnings. -- kernel test robot <lkp@intel.com>
2. Fix the errors of coresight-dummy yaml file. -- Rob Herring <robh@kernel.org>

Hao Zhang (3):
  Coresight: Add coresight dummy driver
  dt-bindings: arm: Add Coresight Dummy Trace YAML schema
  Documentation: trace: Add documentation for Coresight Dummy Trace

 .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++
 .../trace/coresight/coresight-dummy.rst       |  58 ++++++
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

-- 
2.17.1

