Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE26CD51D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjC2Isg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjC2IsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE91995;
        Wed, 29 Mar 2023 01:48:22 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T7pQ93014165;
        Wed, 29 Mar 2023 08:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=+cbnzHmWawb9M5SXUjq4p4EOUoyZ+3nyqshEXpzNo8c=;
 b=pIltDS4bN6WNkShn6Wk8iINN7i37IG29niMwE7ldccpq4SqzVpP5wTiB29jl2PD+o7eu
 sY54tr+e2thoZqYLPcIogsAEwjpGXZPgoEuaSfVg6YNmtC8/ZP9+RQx8ZN2NMP796qkn
 XIDzbK3/rz51qVqmkA2IjuBguknMYCTChf56xHnKJsyTdwpxU16sMXbLRRuUJ+6sGDS4
 ZF2c7Xz8F/vEW8F7/x8wv0vOXGxCNPUTBQPKGpjU6a36+MSiJvBonuHUR87/JUJ4EmD5
 dGfvsrMygYFtlCtSfe/+0Sse6LsctyeEvNraBXhmxMPV9ec7HOlhenxck3VLHbbFGCRw xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmd6ugmar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8luff031335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:56 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:56 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 0/8] Add cmb dataset support for TPDM 
Date:   Wed, 29 Mar 2023 01:47:36 -0700
Message-ID: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cdO0FWSfDWIyi9HRh53yvrqhSoFkmXg6
X-Proofpoint-ORIG-GUID: cdO0FWSfDWIyi9HRh53yvrqhSoFkmXg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290071
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuous multi-bit (CMB) is responsible for collection of CMB data sets.
It monitors a bus of related signals (eg, a counter value) and an associated valid signal.

This patch series adds support to config of CMB registers.
Element Creation:
  CMB_CR.mode : Continuous mode or Trace on Change mode(cmb_mode)

Pattern Match Output (usually to CTI):
  CMB_XPR : Trigger pattern register value(cmb_trig_patt_val)
  CMB_XPMR : Trigger pattern mask register value(cmb_trig_patt_mask)

Timestamp Request Based on Input Pattern Match:
  CMB_TPR : Timestamp pattern register value(cmb_patt_val)
  CMB_TPMR : Timestamp pattern mask register value(cmb_patt_mask)
  CMB_TIER.patt_tsenab : Timestamps are requested upon CMB interface pattern match via
                         setting this bit to 1(cmb_patt_ts)

Timestamp Request Based on Input (usually from CTI):
  CMB_TIER.xtrig_tsenab : Timestamps are requested upon CMB cross trigger interface
                          timestamp request via setting this bit to 1(cmb_trig_ts)

Mux Select Registers:
  CMB_MSR : Configure Mux select registers(cmb_msr)

Once this series patches are applied properly, the new tpdm nodes should be observed at the tpdm path.
e.g.
/sys/devices/platform/soc@0/10c29000.tpdm/tpdm1 # ls -l | grep cmb

-rw-r--r--    1 root     0             4096 Jan  1 00:00 cmb_mode
-rw-r--r--    1 root     0             4096 Jan  1 00:00 cmb_msr
-rw-r--r--    1 root     0             4096 Jan  1 00:00 cmb_patt_mask
-rw-r--r--    1 root     0             4096 Jan  1 00:00 cmb_patt_ts
-rw-r--r--    1 root     0             4096 Jan  1 00:22 cmb_patt_val
-rw-r--r--    1 root     0             4096 Jan  1 00:59 cmb_trig_patt_mask
-rw-r--r--    1 root     0             4096 Jan  1 00:57 cmb_trig_patt_val
-rw-r--r--    1 root     0             4096 Jan  1 00:00 cmb_trig_ts
-rw-r--r--    1 root     0             4096 Jan  1 00:58 cmb_ts_all

This patch series depends on:
[v3,0/11] Add support to configure TPDM DSB subunit
https://patchwork.kernel.org/project/linux-arm-kernel/cover/1679551448-19160-1-git-send-email-quic_taozha@quicinc.com/

Codelinaro link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-cmb-v1

Mao Jinlong (8):
  coresight-tpdm: Add CMB dataset support
  coresight-tpdm: Add support to configure CMB collection mode
  coresight-tpdm: Add pattern registers support for CMB data set
  coresight-tpdm: Add timestamp control register support for the CMB
  coresight-tpdm: Add msr register support for CMB
  dt-bindings: arm: Add support for TPDM CMB MSR register
  coresight-tpda: Add support to configure CMB element size
  dt-bindings: arm: Add support for TPDM CMB element size

 .../testing/sysfs-bus-coresight-devices-tpdm  |  63 +++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  26 +
 drivers/hwtracing/coresight/coresight-tpda.c  |  33 +-
 drivers/hwtracing/coresight/coresight-tpda.h  |   4 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 447 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  |  60 +++
 6 files changed, 626 insertions(+), 7 deletions(-)

-- 
2.39.0

