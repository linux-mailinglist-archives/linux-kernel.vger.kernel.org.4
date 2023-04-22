Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4D6EB7DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDVHiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDVHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:38:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67C19BD;
        Sat, 22 Apr 2023 00:38:06 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M7am7D004091;
        Sat, 22 Apr 2023 07:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bqmpcV1FW2534rLqe62Avhyw9LZvOgM2eG8jaM97ys4=;
 b=e02W+m6IVfZKaoOVLG5RsELCeRljSvwbBJjSV8IK4PDgEzttc21Y24cS9LbQa3tFWlnT
 lLPjV88FKeivPCxIa5E2HKYzrYluG3HTMnn2l50QRtGpfAceeBU6oPfqSsDdM1KZBiP5
 IlN0xzxJF8m8zYVEgtE8iAU//JFfAFTox23MMwvdZ5mJf0PD4YmOdMJ9iyPpLwkBRh5k
 8+aA0ecA0PA82fOK5t2DJwG5YXBf+gWOJzju5oMAS90IosX0TezQ54YAWqH4fPhRcR3S
 mssOUAp1N3J/U9AQO5663FigROmJ3WHU1IszQSXV8IpWTCfVLhud6Pfh72M+rcyOkwW3 qQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48vf84w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33M7baM2000578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:36 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 22 Apr 2023 00:37:30 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v3 0/3] Add support to configure Coresight Dummy subunit
Date:   Sat, 22 Apr 2023 15:37:11 +0800
Message-ID: <20230422073714.38844-1-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R8ytd7KAOx5pcdJt_QHO2IZG7sbLm9x8
X-Proofpoint-ORIG-GUID: R8ytd7KAOx5pcdJt_QHO2IZG7sbLm9x8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304220064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of Coresight Dummy subunit
The Coresight Dummy subunit is for Coresight Dummy component, there are
some specific Coresight devices that HLOS don't have permission to access.
Such as some TPDMs, they would be configured in NON-HLOS side, but it's
necessary to build Coresight path for it to debug. So there need driver
to register dummy devices as Coresight devices.

Commit link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy-v3

changes in V3:
1. Use API "dev_dbg" to replace "dev_info". -- Suzuki K Poulose
2. Drop "qcom" property and take it as a dummy framework.
-- Suzuki K Poulose
3. Add new sub-type "CORESIGHT_DEV_SUBTYPE_SINK_DUMMY" to support
coresight dummy module -- Mike Leach
4. Use compatibles "arm,coresight-dummy-source" and
"arm,coresight-dummy-sink" to replace property "qcom,dummy-source" and
"qcom,dummy-sink". -- Mike Leach
5. Define source_devs and sink_devs DEVLIST to replace dummy_devs, make
it clear at the first level. -- Mike Leach
6. Modify subject of YAML patch, drop "YAML schema". -- Krzysztof Kozlowski
7. Drop some redundant items and correct syntax errors in yaml file.
-- Krzysztof Kozlowski/Rob Herring
8. Correct required property of yaml file, constrain out ports to
dummy-source and in ports to dummy-sink. -- Mike Leach
9. Drop "Sysfs files and directories" contents of coresight-dummy.rst.
-- Suzuki K Poulose/Greg Kroah-Hartman
10.Correct syntax errors of coresight-dummy.rst. -- Bagas Sanjaya

Changes in V2:
1. Declare dummy_init and dummy_exit as static to fix missing-prototypes
warnings. -- kernel test robot
2. Fix the errors of coresight-dummy yaml file. -- Rob Herring

Hao Zhang (3):
  Coresight: Add coresight dummy driver
  dt-bindings: arm: Add Coresight Dummy Trace
  Documentation: trace: Add documentation for Coresight Dummy Trace

 .../bindings/arm/arm,coresight-dummy.yaml     | 101 ++++++++++
 .../trace/coresight/coresight-dummy.rst       |  34 ++++
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 179 ++++++++++++++++++
 include/linux/coresight.h                     |   1 +
 6 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

-- 
2.17.1

