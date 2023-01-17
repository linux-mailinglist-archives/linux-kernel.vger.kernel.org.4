Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4366E180
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjAQO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAQO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:57:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD03E61D;
        Tue, 17 Jan 2023 06:57:38 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEf8r3015405;
        Tue, 17 Jan 2023 14:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=K/Sg7i2oDpFXGZ+Sbsjhr4UwMuOFMGT8YWkU+dkQAgQ=;
 b=Am7U5Q9szw993tu+8Sq2CMmRrhfmi48lFlcwpg+iHGy5XZFvN9bYTretw83ZLbzYg2UH
 frlwNfSfMltVTW/gMc4wdynLFUYdORJRKDsj9E99g4e1CxZV1bPzp70K/NdWtJztux/k
 zEv5lvXm1+aoTk/E5JqRFlRLjdonDJg4lYUii3v51VQcEI4V1ET+vk/B0HvU5vS0hOPT
 3RmbA3cpVHaeWFe+fRbvjNAhgqS0lOU/q6ljMCjGCLKSiKJUxQnlGTL4iAVSAGyjT6rl
 KLbwPzrf34iA8kW/Xo64d2QNWURW2MRKOnklG6KdoO1dSUljsM9pMYG3jfxu4HT9C3if WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npgdf8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HEvKfv012030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:20 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 06:57:19 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v17 0/9] Coresight: Add support for TPDM and TPDA
Date:   Tue, 17 Jan 2023 06:56:59 -0800
Message-ID: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kiwLuPHgtUEWjRHXI-xbewjXhRBEzf_d
X-Proofpoint-ORIG-GUID: kiwLuPHgtUEWjRHXI-xbewjXhRBEzf_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170121
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the trace performance monitoring and
diagnostics hardware (TPDM and TPDA). It is composed of two major
elements.
a) Changes for original coresight framework to support for TPDM and TPDA.
b) Add driver code for TPDM and TPDA.

Introduction of changes for original coresight framework
Support TPDM as new coresight source.
Since only STM and ETM are supported as coresight source originally.
TPDM is a newly added coresight source. We need to change
the original way of saving coresight path to support more types source
for coresight driver.
The following patch is to add support more coresight sources.
    coresight: core: Use IDR for non-cpu bound sources' paths.

Introduction of TPDM and TPDA
TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
short serves as data collection component for various dataset types
specified in the QPMDA(Qualcomm performance monitoring and diagnostics
architecture) spec. The primary use case of the TPDM is to collect data
from different data sources and send it to a TPDA for packetization,
timestamping and funneling.
     Coresight: Add coresight TPDM source driver
     dt-bindings: arm: Adds CoreSight TPDM hardware definitions
     coresight-tpdm: Add DSB dataset support
     coresight-tpdm: Add integration test support

TPDA - The trace performance monitoring and diagnostics aggregator or
TPDA in short serves as an arbitration and packetization engine for the
performance monitoring and diagnostics network as specified in the QPMDA
(Qualcomm performance monitoring and diagnostics architecture)
specification. The primary use case of the TPDA is to provide
packetization, funneling and timestamping of Monitor data as specified
in the QPMDA specification.
The following patch is to add driver for TPDA.
     Coresight: Add TPDA link driver
     dt-bindings: arm: Adds CoreSight TPDA hardware definitions

The last patch of this series is a device tree modification, which add
the TPDM and TPDA configuration to device tree for validating.
    ARM: dts: msm: Add tpdm mm/prng for sm8250

Once this series patches are applied properly, the tpdm and tpda nodes
should be observed at the coresight path /sys/bus/coresight/devices
e.g.
/sys/bus/coresight/devices # ls -l | grep tpd
tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0

We can use the commands are similar to the below to validate TPDMs.
Enable coresight sink first.

echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
The test data will be collected in the coresight sink which is enabled.
If rwp register of the sink is keeping updating when do
integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
generated from TPDM to sink.

There must be a tpda between tpdm and the sink. When there are some
other trace event hw components in the same HW block with tpdm, tpdm
and these hw components will connect to the coresight funnel. When
there is only tpdm trace hw in the HW block, tpdm will connect to
tpda directly.
  
    +---------------+                +-------------+
    |  tpdm@6c08000 |                |tpdm@684C000 |
    +-------|-------+                +------|------+
            |                               |
    +-------|-------+                       |
    | funnel@6c0b000|                       |
    +-------|-------+                       |
            |                               |
    +-------|-------+                       |
    |funnel@6c2d000 |                       |
    +-------|-------+                       |
            |                               |
            |    +---------------+          |
            +----- tpda@6004000  -----------+
                 +-------|-------+
                         |
                 +-------|-------+
                 |funnel@6005000 |
                 +---------------+

This patch series depends on patch series:
[v7,00/15] coresight: Add new API to allocate trace source ID values
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20230116124928.5440-1-mike.leach@linaro.org/

TPDM_TPDA commit tree:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-tpda-v17

Changes in V17:
1. Rebase changes on V7 coresight: Add new API to allocate trace source ID values
2. Add documentation for TPDA and TPDM under
Documentation/tracing/coresight/. (Suzuki K Poulose <suzuki.poulose@arm.com>)

Changes in V16:
1. Update device tree changes to match up with device tree bindings.
3. Update the copyright year to 2023.

Changes in V15:
1. coresight-tpda: Add more comments in trace id function.
2. qcom,coresight-tpdm.yaml: Add more comments in description.
3. Push "arm64: dts: qcom: sm8250: Add coresight components" out this series. 

Changes in V14:
rebase to "[v5,00/14] coresight: Add new API to allocate trace source ID values" and latest 6.x kernel

Changes in V13:
1. Fix the conflicts when apply patches to the latest base line.

Changes in V12:
1. Clear bits for atid before setting them and relese atid when tpda
remove. -- Suzuki K Poulose <suzuki.poulose@arm.com>

Changes in V11:
1. Change dev_info to dev_dbg in TPDM/TPDA drivers. -- Suzuki K Poulose <suzuki.poulose@arm.com>
2. Merge sysfs API change of integration_test to integration_test driver
change. -- Suzuki K Poulose <suzuki.poulose@arm.com>

Changes in V10:
1. Fix the error of TPDM yaml file. -- Rob Herring <robh@kernel.org>

Changes in V9:
1. Rename yaml file for TPDM/TPDA and fix the error for the yaml files.
-- Rob Herring <robh@kernel.org>

Changes in V8:
1. Use spinlock to protect drvdata of TPDM/TPDA -- Suzuki K Poulose <suzuki.poulose@arm.com>
2. Use CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS as source type for TPDM -- Suzuki K Poulose <suzuki.poulose@arm.com>
3. Fix the warning for yaml file of TPDM/TPDA -- Rob Herring <robh@kernel.org>

Changes in V7:
1. Update the commit title and move the changes to right place which
is sorted by address for dtsi changes. -- Konrad Dybcio <konrad.dybcio@somainline.org>

Changes in V6:
1. Update maintainers in tpdm/tpda yaml file. -- Mike Leach <mike.leach@linaro.org>
2. Set the .remove function pointer in the amba_driver structure
   of tpdm/tpda driver. Add tpda_remove function for tpda driver. -- Mike Leach <mike.leach@linaro.org>
3. Define datasets of tpdm as unsigned long. -- Mike Leach <mike.leach@linaro.org>
4. Move all coresight nodes to sm8250.dtsi.
   -- Mike Leach <mike.leach@linaro.org>;Konrad Dybcio <konrad.dybcio@somainline.org>
5. Remove CORESIGHT_TPDM_INTEGRATION_TEST config. -- Mike Leach <mike.leach@linaro.org>

Changes in V5:
1. Keep the ETM source paths per-CPU and use IDR for other sources'
paths. (Suzuki K Poulose <suzuki.poulose@arm.com>)

Changes in V4:
1. Drop trace id for tpdm source as its trace atid is defined by the tpda.
Allocate tpda's atid dynamically.  (Mike Leach)

Changes in V3:
1. Use bitmap to assign the trace id. (Mathieu Poirier)

Changes in V2:
1. Use IDR to store the path of sources. (Mathieu Poirier)
2. Only add integration_test/enable/disable for TPDM. No other configs.
(Mathieu Poirier)
3. Move coresight dtsi changes to sm8250.dtsi. (Suzuki K Poulose)

Mao Jinlong (9):
  coresight: core: Use IDR for non-cpu bound sources' paths.
  Coresight: Add coresight TPDM source driver
  dt-bindings: arm: Add CoreSight TPDM hardware
  coresight-tpdm: Add DSB dataset support
  coresight-tpdm: Add integration test support
  Coresight: Add TPDA link driver
  dt-bindings: arm: Adds CoreSight TPDA hardware definitions
  Documentation: trace: Add documentation for TPDM and TPDA
  arm64: dts: qcom: sm8250: Add tpdm mm/prng

 .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
 .../bindings/arm/qcom,coresight-tpda.yaml     | 129 +++++++++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++++++
 .../trace/coresight/coresight-tpda.rst        |  52 ++++
 .../trace/coresight/coresight-tpdm.rst        |  43 +++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 164 +++++++++++
 drivers/hwtracing/coresight/Kconfig           |  23 ++
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/coresight-core.c  |  42 ++-
 drivers/hwtracing/coresight/coresight-tpda.c  | 211 ++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  35 +++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 259 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  62 +++++
 include/linux/coresight.h                     |   1 +
 15 files changed, 1118 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
 create mode 100644 Documentation/trace/coresight/coresight-tpda.rst
 create mode 100644 Documentation/trace/coresight/coresight-tpdm.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h

-- 
2.39.0

