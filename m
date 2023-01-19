Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A16732C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjASHnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjASHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:42:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8862D34;
        Wed, 18 Jan 2023 23:42:33 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5SQlU031409;
        Thu, 19 Jan 2023 07:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FLex8zjT9VRXnhsIj4ub4wUARNM1CTDIwV/nmvMUcPI=;
 b=ViTNFEAkwuLjLDkyJkjNIiwKAazu7uXgoFHvlSdDdrEZtxebtuiemlUoCQ/+ilUTZETr
 fAKlhmG2wbzg8WtVZxxfDNWJ5oN5GOj7hoMI6di83DrZqIqeRx3Gs5W2zv9px7937hZQ
 PBe6sPNwAPNy822D1QpaDiIH2gukFQef4H1yAAIpRNe2F6fIQowfShctOnoGWlI3B13H
 WlYB2rctVx7FgoTcUBmbjHtCfrpFX7ukfoNlDowl0uvJsh48tDogl3SpZGOpGVjOHcJV
 HERiTow/JSWmZQS3S8NyX2pzSMqb7XyrP9SAT1VzUb8qCAK+FrtPg7WNcfHSnjwa+iW6 sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6ya2re1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J7gBKH022007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:11 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 23:42:05 -0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <taozha@qti.qualcomm.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH v2 0/9] Add support to configure TPDM DSB subunit
Date:   Thu, 19 Jan 2023 15:41:36 +0800
Message-ID: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OoHMFfpzOiFXu4GnXKkkxvINInSTKcpH
X-Proofpoint-GUID: OoHMFfpzOiFXu4GnXKkkxvINInSTKcpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Zhang <taozha@qti.qualcomm.com>

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

This patch series depends on patch series "[v17,0/9] Coresight: Add
support for TPDM and TPDA"
https://patchwork.kernel.org/project/linux-arm-msm/cover/20230117145708.16739-1-quic_jinlmao@quicinc.com/

TPDM_DSB commit tree:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/tpdm-dsb-v2
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-dsb-v2

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

Tao Zhang (9):
  dt-bindings: arm: Add support for DSB element
  coresight-tpda: Add DSB dataset support
  coresight-tpdm: Initialize DSB subunit configuration
  coresight-tpdm: Add reset node to TPDM node
  coresight-tpdm: Add nodes to set trigger timestamp and type
  coresight-tpdm: Add node to set dsb programming mode
  coresight-tpdm: Add nodes for dsb element creation
  coresight-tpdm: Add nodes to configure pattern match output
  coresight-tpdm: Add nodes for timestamp request

 .../bindings/arm/qcom,coresight-tpda.yaml          |  22 +
 drivers/hwtracing/coresight/coresight-tpda.c       |  62 ++
 drivers/hwtracing/coresight/coresight-tpda.h       |   4 +
 drivers/hwtracing/coresight/coresight-tpdm.c       | 630 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  65 +++
 5 files changed, 778 insertions(+), 5 deletions(-)

-- 
2.7.4

