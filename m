Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673771FC45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjFBImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjFBImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:42:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831418C;
        Fri,  2 Jun 2023 01:42:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527bmsa009596;
        Fri, 2 Jun 2023 08:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Yuyzww3sdMGOmbW5o70KBnUQRZsPdJjQHaIqj7dzKJE=;
 b=AO8R5z3GvYq4RorgUpbsCQubFsANrXdizPeZejZqn6x+SY6496/Ran9zK7dxUK3svbbJ
 nbkx69L99Fm4hvOmJtz6wzJBOwkiyWI6vCxAvMEUAx/x7jDEXurRrOjkhbR328kok35c
 lgrxxCY3ULLCNUS2lfnw08UdOXXpv4BzndQKfg44A6t6hEDpghRlwTEKIg9JaW/BfENZ
 R6y/3YSVFq2A1IBjKeG/Gi6Pk0IqcXDS1HuCl+XyaaPqb8P9C6Qz4mSa30wanvNq6QOd
 YUM2qrmQmnkFAzJZJ1v/KxokxcwvW2En0sF5eK9oTjpn/BpywgEEkhViCrX0s14nM38p eQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugra5nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:42:26 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528gQTH023962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:42:26 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 01:42:19 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
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
Subject: [PATCH v6 0/3] Add support to configure Coresight Dummy subunit
Date:   Fri, 2 Jun 2023 16:41:46 +0800
Message-ID: <20230602084149.40031-1-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L3UKo3oKKWBUsjMeLjabN2e24cvgW01M
X-Proofpoint-ORIG-GUID: L3UKo3oKKWBUsjMeLjabN2e24cvgW01M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_05,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020064
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
necessary to build Coresight path for it to debug. So there need driver to
register dummy devices as Coresight devices.

Commit link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy-v6

Changes in V6:
1. Add the missing information and update the patch version.

Changes in V5:
1. Follow the alphabetical order for the header files in
coresight-dummy.c. -- Suzuki K Poulose
2. Update the maintainers.
3. Split the Coresight Dummy YAML to 2 schema files. 
-- Rob Herring & Krzysztof Kozlowski
4. Update the coresight-dummy.rst file. -- Bagas Sanjaya

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
-- Krzysztof Kozlowski & Rob Herring
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
  dt-bindings: arm: Add support for Coresight dummy trace
  Documentation: trace: Add documentation for Coresight Dummy Trace

 .../arm/arm,coresight-dummy-sink.yaml         |  73 ++++++++
 .../arm/arm,coresight-dummy-source.yaml       |  71 ++++++++
 .../trace/coresight/coresight-dummy.rst       |  32 ++++
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 163 ++++++++++++++++++
 include/linux/coresight.h                     |   1 +
 7 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

-- 
2.17.1

