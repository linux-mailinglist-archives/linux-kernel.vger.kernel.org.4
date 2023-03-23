Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E576C5F56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCWGE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:04:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BE25BAC;
        Wed, 22 Mar 2023 23:04:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5PZMq015007;
        Thu, 23 Mar 2023 06:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=iH+9mnvSh+F/rHGBS/5AFKvxJhH6od4M86/YnQsibJ0=;
 b=c1zJIpwxQ28g9wYIJ8s0ayO3HvM9tfnBnUpZO4EUzYqYyqlBf6zhYbeqW5HcXGSDmMp5
 kKeKkuwLnsu3d/oWkc+1bDe4xju5tp363mqd+/xGQt+WyUKQaOgLnJehc87kwqVqmiFo
 v2hzGxE/GdOp6pGMOA6Wl0maALmMXubjOsKBa91r7nHYu5smEci6mp3RPl6iJCggLBgo
 39Fr/LgnU3fbfNi9DkFX6E4y9i6op41VctNRYgHIIQp30sfTsVTxyuqOLJX8QZAdLYrF
 AC6bQKXemAiWkClL46VYQ88UjwF2Z4b936cHAUs9r19BdkTOwXqsQWNrJLGmo6CNLNhR dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgfaxg70b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N64Yfs031677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:34 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:04:29 -0700
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH v3 0/11] Add support to configure TPDM DSB subunit
Date:   Thu, 23 Mar 2023 14:03:57 +0800
Message-ID: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ug4DPc13WtGeISPDDxm6rnVfgh3H255j
X-Proofpoint-ORIG-GUID: ug4DPc13WtGeISPDDxm6rnVfgh3H255j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230046
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20230310160610.742382-1-james.clark@arm.com/

TPDM_DSB commit tree:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/tpdm-dsb-v3
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-dsb-v3

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

Tao Zhang (10):
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

 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 144 +++++
 .../bindings/arm/qcom,coresight-tpdm.yaml          |  21 +
 drivers/hwtracing/coresight/coresight-tpda.c       |  58 ++
 drivers/hwtracing/coresight/coresight-tpda.h       |   4 +
 drivers/hwtracing/coresight/coresight-tpdm.c       | 694 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  69 ++
 6 files changed, 984 insertions(+), 6 deletions(-)

-- 
2.7.4

