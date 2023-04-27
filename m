Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514456F02EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbjD0JBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbjD0JBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:01:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33D4422A;
        Thu, 27 Apr 2023 02:01:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R5G7O3007470;
        Thu, 27 Apr 2023 09:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=2qK8C5sd7x967v/OmMj9kzglsUDUERIIX1n3oPWCF44=;
 b=Mi1MZjj+XqWeRm+8liqgxscgOhwLk4yy7aOC6/J7V3TNwz+uiZb2EItmOPXKUQP7PF6U
 LZCug1Y7Y48uRc317UYHTNcSgqgzjfK24T/yAnkeMovmwPZ0uEKyft2T65valkmHRgBJ
 HkQtUjLWj6FFKgksbwMSLc7dGmWTJAROYd67+FZnna03FlqUnK14UOw24poDX8R2/qBo
 Y/2KWbFm7htcxvRHiGuZFQL2KlOMpntVO5zDpNSs2HQIbNRichrDxAiwdX5oqsbYra7F
 wOzhRF7zqkwASATjJaXSx/b0VUmvKzBcmQhG1KTUOYaHi8yv2nylF5lHOps7U89MhjSn NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7j4ergv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:00:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R90ttd012731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:00:55 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 02:00:50 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v4 00/11] Add support to configure TPDM DSB subunit
Date:   Thu, 27 Apr 2023 17:00:26 +0800
Message-ID: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -BAwMFAMiPoCD76Sn0CnuynyNDfktnSz
X-Proofpoint-GUID: -BAwMFAMiPoCD76Sn0CnuynyNDfktnSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of TPDM DSB subunit
DSB subunit is responsible for creating a dataset element, and is also
optionally responsible for packing it to fit multiple elements on a
single ATB transfer if possible in the configuration. The TPDM Core
Datapath requests timestamps be stored by the TPDA and then delivering
ATB sized data (depending on ATB width and element size, this could
be smaller or larger than a dataset element) to the ATB Mast FSM.

The DSB subunit must be configured prior to enablement. This series
adds support for TPDM to configure the configure DSB subunit.

Once this series patches are applied properly, the new tpdm nodes for
should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
which supports DSB subunit.
e.g.
/sys/devices/platform/soc@0/69d0000.tpdm/tpdm0#ls -l | grep dsb
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl_mask
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_mode
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_mask
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_ts
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_type
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_val
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_mask
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_val
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_ts
-rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_type

We can use the commands are similar to the below to configure the
TPDMs which support DSB subunit. Enable coresight sink first.
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/reset
echo 0x3 0x3 0x1 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl_mask
echo 0x6d 0x6d 0 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl
echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_ts
echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_type
echo 0 > /sys/bus/coresight/devices/tpdm0/dsb_trig_ts
echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_patt_mask
echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_trig_patt_val

This patch series depends on patch series "[PATCH v2 0/9] coresight:
Fix CTI module refcount leak by making it a helper device"
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230425143542.2305069-14-james.clark@arm.com/

TPDM_DSB commit tree:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/tpdm-dsb-v4
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-dsb-v4

Changes in V4:
1. Change the range of the property "qcom,dsb-element-size", and
change the type to enumeration.
-- Suzuki K Poulose, Krzysztof Kozlowski
2. Change dsb_esize from 32 bits to 8 bits.
-- Suzuki K Poulose
3. Update the function tpda_set_element_size since James has
updated the dependency series. Meanwhile, it will send out a
warning if it detects more than one TPDM from the same TPDA
input port.
-- Suzuki K Poulose
4. Add a source_sub_type for TPDM to distinguish TPDM from
the other coresight source.
-- Suzuki K Poulose
5. Return error if the element size is not configured on
devicetree in TPDA enablement.
-- Suzuki K Poulose
6. Move memory allocation from "tpdm_init_datasets" to
"tpdm_datasets_setup". Rename "tpdm_init_datasets" as
"tpdm_reset_datasets".
-- Suzuki K Poulose
7. Replace "coresight_disable" with "coresight_disable_source"
to disable the TPDM in resetting.
-- Suzuki K Poulose
8. Make sure "drvdata" is not NULL pointer before using it.
-- Suzuki K Poulose
9. Change "set_dsb_cycacc_mode" to "set_dsb_test_mode" since
cycle accurate mode is not supported on the current targets.
It is replaced by test mode.
10. Document the value of "dsb_mode".
-- Suzuki K Poulose
11. Macros are used to replace the formulas on dsb edge control
nodes.
-- Suzuki K Poulose
12. Document the values of "dsb_trig_patt_val" and
"dsb_trig_patt_mask".
-- Suzuki K Poulose
13. Combine two pattern related loops to one. And move DSB TIER
register configurations to the new function "set_dsb_tier".
-- Suzuki K Poulose
14. Rename the property "qcom,dsb_msr_num" to "qcom,dsb-msrs-num".
-- Suzuki K Poulose, Krzysztof Kozlowski

Changes in V3:
1. Move the property "qcom,dsb-element-size" to TPDM
devicetree and update the TPDM yaml file for this item.
-- Suzuki K Poulose
2. Add the error message when the DSB element size is not set to
32-bit or 64-bit. -- Suzuki K Poulose
3. Add more information to the comments of patch #3
-- Suzuki K Poulose
4. Combine the value updates to the TPDM_DSB_CR for TPDM.
-- Suzuki K Poulose
5. Remove the function "tpdm_datasets_alloc", and fold its code
to a new function "tpdm_init_datasets". It will complete the
initialization of TPDM.  -- Suzuki K Poulose
6. Change the method of qualifying input values.
-- Suzuki K Poulose
7. Add the documentation of the new sysfs handles.
-- Suzuki K Poulose
8. Provide the separate handles for the "mode bits".
-- Suzuki K Poulose

Changes in V2:
1. Change the name of the property "qcom,dsb-elem-size" to
"qcom,dsb-element-size" -- Suzuki K Poulose
2. Update the TPDA yaml file for the item "qcom,dsb-elem-size".
-- Krzysztof Kozlowski
3. Add the full name of DSB in the description of the item
"qcom,dsb-elem-size". -- Rob Herring

Changes in V1:
1. Change the definition of the property "qcom,dsb-elem-size" from
"uint32-array" to "uint32-matrix". -- Krzysztof Kozlowski
2. Add the full name of DSB. -- Rob Herring
3. Deal with 2 entries in an iteration in TPDA driver. -- Suzuki K Poulose
4. Divide the function "tpdm_datasets_alloc" into two functions,
"tpdm_datasets_setup" and "tpdm_datasets_alloc".
5. Detecte the input string with the conventional semantics automatically,
and constrain the size of the input value. -- Suzuki K Poulose
6. Use the hook function "is_visible()" to hide the DSB related knobs if
the data sets are missing. -- Suzuki K Poulose
7. Use the macros "FIELD_GET" and "FIELD_PREP" to set the values.
-- Suzuki K Poulose
8. Update the definition of the macros in TPDM driver.
9. Update the comments of the values for the nodes which are for DSB
element creation and onfigure pattern match output. -- Suzuki K Poulose
10. Use API "sysfs_emit" to "replace scnprintf". -- Suzuki K Poulose

Tao Zhang (11):
  dt-bindings: arm: Add support for DSB element size
  coresight-tpda: Add DSB dataset support
  coresight-tpdm: Initialize DSB subunit configuration
  coresight-tpdm: Add reset node to TPDM node
  coresight-tpdm: Add nodes to set trigger timestamp and type
  coresight-tpdm: Add node to set dsb programming mode
  coresight-tpdm: Add nodes for dsb edge control
  coresight-tpdm: Add nodes to configure pattern match output
  coresight-tpdm: Add nodes for timestamp request
  dt-bindings: arm: Add support for DSB MSR register
  coresight-tpdm: Add nodes for dsb msr support

 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 174 ++++++
 .../bindings/arm/qcom,coresight-tpdm.yaml          |  19 +
 drivers/hwtracing/coresight/coresight-core.c       |   1 +
 drivers/hwtracing/coresight/coresight-tpda.c       |  92 ++-
 drivers/hwtracing/coresight/coresight-tpda.h       |   4 +
 drivers/hwtracing/coresight/coresight-tpdm.c       | 691 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  79 +++
 include/linux/coresight.h                          |   1 +
 8 files changed, 1045 insertions(+), 16 deletions(-)

-- 
2.7.4

