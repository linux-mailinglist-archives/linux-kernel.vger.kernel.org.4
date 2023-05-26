Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D17129A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjEZPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEZPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:35:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5ECF3;
        Fri, 26 May 2023 08:35:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QDVgN0001308;
        Fri, 26 May 2023 15:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=I/yJNJ8Tx5koKovC6ZBuTwfjqydZGhxxnpU/ilMbykE=;
 b=FZCYGuTSD6I9TZcj4MINaBwt+KONWXifSNnd0YeeLgZnp7rW8wGIBjxlFlovTnI7wpmX
 NB0QpiAMsttSbiiAbPA9M4iTyd5gpyBgiskmtDXxiWp2H9Ftc76fhcNg0LRVjek1sLV6
 2mkPZ6EV5q6XYKJ98hh6Qa2iqtIM5W3P+0L6KI7XfCXPiJsXlStMp8ShnFH4dJmZdFoa
 O1a/ygr2LZyaitib1YgvqqUgVSsr9ZV4rpgOOgUy2OJqBCR0Iqg8JQECkxFXp8VlPa31
 Tnvrjbp2Az98w7VWlTdZJBEQ0umShHiKjCI2Ut7OEM1E0PsaWjnkAxZFP9T2tBo9cIhz CQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtu0u0nx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFZTnQ011790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:29 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:35:25 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 0/3] Add support for a streaming interface for TMC ETR
Date:   Fri, 26 May 2023 23:35:05 +0800
Message-ID: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ym7BB_2UHm6UfdoDfRa9EaziNYBAU0Pa
X-Proofpoint-GUID: Ym7BB_2UHm6UfdoDfRa9EaziNYBAU0Pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=642
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to add support for a streaming interface for
TMC ETR to allow for continuous log collection to secondary storage.
An interrupt based mechanism is used to stream out the data from the device.

QDSS_CS_QDSSCSR_ETRIRQCTRL register is used to set the IRQ byte counter
value. The value of this registers defines the number of bytes that when moved by
the ETR AXI interface. It will casues an interrupt which can be used by an
userspace program to know how much data is present in memory requiring copy to some
other location. A zero setting disables the interrupt.A one setting
means 8 bytes, two 16 bytes, etc. In other words, the value in this
register is the interrupt threshold times 8 bytes. ETR must be enabled
when use this interrupt function.

Sample:
echo 4096 > /sys/bus/coresight/devices/tmc_etr0/block_size
echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/stm0/enabl_source

cat /dev/byte-cntr > /data/qdss_etr.bin &

The log collection will stop after disabling the ETR.

Commit link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/coresight-byte-cntr-v1

Mao Jinlong (3):
  Coresight: Add driver to support for CSR
  coresight-tmc: byte-cntr: Add support for streaming interface for ETR
  dt-bindings: arm: Adds CoreSight CSR hardware definitions

 .../testing/sysfs-bus-coresight-devices-tmc   |   7 +
 .../bindings/arm/qcom,coresight-csr.yaml      |  62 ++++
 drivers/hwtracing/coresight/Kconfig           |  12 +
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../hwtracing/coresight/coresight-byte-cntr.c | 304 ++++++++++++++++++
 .../hwtracing/coresight/coresight-byte-cntr.h |  49 +++
 drivers/hwtracing/coresight/coresight-csr.c   | 168 ++++++++++
 drivers/hwtracing/coresight/coresight-csr.h   |  59 ++++
 .../hwtracing/coresight/coresight-tmc-core.c  |  66 ++++
 .../hwtracing/coresight/coresight-tmc-etr.c   |   8 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |  12 +-
 11 files changed, 745 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.h
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.h

-- 
2.17.1

