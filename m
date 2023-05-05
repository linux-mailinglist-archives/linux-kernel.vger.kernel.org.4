Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4940C6F7FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjEEJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjEEJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:25:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867416352;
        Fri,  5 May 2023 02:25:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3457mti2003654;
        Fri, 5 May 2023 09:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cHgpn3zmgeovZWHA0ggniye2Vvck1BmbZKAg1bPKHEU=;
 b=SbB7s1QH3wc2yvov94ccljxhrQ5sk1NgN4whmQXq+rg3ySTk/lZrjhUK4DETxx91z3bV
 MBgYqzLVCGeceuM96DuW8IJDySg9veA2UWjWvxM4CRpevtxMhjAlSBtIaX3wMyvBz6TM
 RfXJlpnSpTo4XbxzlxheIi1ZwPs6VcGmHwjwPv1/4QxSg74eXkMIdIKYqD1a2Cvc44d0
 nbI82SUifkHO/PpIqtG7YTGTj3E4e/pS2z80UnjGCH7EtSOg5uGEE4wruorjdVky2YIY
 MxRkk9AmOZ1LPNbmGdpCyZEwV5iZq0TWNSbBqbBoafzlUsZBtrHarDEZSKHJI2quksqc 2A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qctfq0jqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 09:25:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3459P15K018078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 09:25:01 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 02:24:55 -0700
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
Subject: [PATCH v4 0/3] Add support to configure Coresight Dummy subunit
Date:   Fri, 5 May 2023 17:24:19 +0800
Message-ID: <20230505092422.32217-1-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6qrGeOjJe8yVBDwRNITQ1ByDYvDU54RJ
X-Proofpoint-ORIG-GUID: 6qrGeOjJe8yVBDwRNITQ1ByDYvDU54RJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy-v4

Changes in V4:
1. Remove traceid allocation in dummy_probe function since it is
currently not in use, will upstream it as the part of ATID filtering
in the further.  -- Suzuki K Poulose
2. Remove 'oneOf' as there is only one entry. -- Rob Herring

Changes in V3:
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

 .../bindings/arm/arm,coresight-dummy.yaml     | 102 +++++++++++
 .../trace/coresight/coresight-dummy.rst       |  34 ++++
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 171 ++++++++++++++++++
 include/linux/coresight.h                     |   1 +
 6 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

-- 
2.17.1

