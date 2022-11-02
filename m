Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0D615F96
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKBJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKBJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C8764D;
        Wed,  2 Nov 2022 02:20:20 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A298csu021765;
        Wed, 2 Nov 2022 09:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0/vDPVhD2Rgveo2IYVqbxRKtAEhtJuBueK6ChXN5Ofw=;
 b=T247qdZnxwBFwxvUdyWZc7Kb5l+CXGV7B4dMdf48NQHuPp+Ph/NaoP6e0AOL5cfL7Pbp
 r0aG7xx5yLQuImql2d1KtIwdkuF/tIwmqQx5blktZ8SBgjulxBCU5t9GEsckttQwHA3o
 P1hOw+4F/L1bzJlm5LnsbiiTtl9j+iwQDUXM80UL7oPvADi6cMSYxdMWFORZRvMX2Lbv
 0Xq2EDxqW7/0pOLvm05iRVl4yX5S9Ac2VlbanTv+I6MtYztA1zIoi/K2XX5YIQA+2ydf
 +YV+o66mGYA1/oHxUVN42c+92QystRUMaFROg0mmMHyu9ogGsQRIEj5CelT4iqd+TRYF Gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj8x8f50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:19:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29Jaq9021641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:19:36 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 02:19:31 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v14 0/9] Coresight: Add support for TPDM and TPDA 
Date:   Wed, 2 Nov 2022 17:19:06 +0800
Message-ID: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HtFB8DpwtBSSNxpg1tfLiPvRAcIujf-F
X-Proofpoint-ORIG-GUID: HtFB8DpwtBSSNxpg1tfLiPvRAcIujf-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
     docs: sysfs: coresight: Add sysfs ABI documentation for TPDM

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
    ARM: dts: msm: Add coresight components for SM8250
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
"[v5,00/14] coresight: Add new API to allocate trace source ID values"
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20221101163103.17921-1-mike.leach@linaro.org/

Mao Jinlong (9):
  coresight: core: Use IDR for non-cpu bound sources' paths.
  Coresight: Add coresight TPDM source driver
  dt-bindings: arm: Adds CoreSight TPDM hardware
  coresight-tpdm: Add DSB dataset support
  coresight-tpdm: Add integration test support
  Coresight: Add TPDA link driver
  dt-bindings: arm: Adds CoreSight TPDA hardware definitions
  arm64: dts: qcom: sm8250: Add coresight components
  arm64: dts: qcom: sm8250: Add tpdm mm/prng

 .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
 .../bindings/arm/qcom,coresight-tpda.yaml     | 111 +++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 671 ++++++++++++++++++
 drivers/hwtracing/coresight/Kconfig           |  23 +
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/coresight-core.c  |  42 +-
 drivers/hwtracing/coresight/coresight-tpda.c  | 208 ++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  35 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 259 +++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  62 ++
 include/linux/coresight.h                     |   1 +
 13 files changed, 1509 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h

-- 
2.17.1

