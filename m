Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B306BC4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCPDYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:24:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD8ABAC2;
        Wed, 15 Mar 2023 20:22:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G2UYXr001845;
        Thu, 16 Mar 2023 03:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=G2ndkKjTC7YndGTL160uD3YPfgNsKL4syB7064e2854=;
 b=o48t1EpQ2epfzZUHYmYU3YPjga6Slt739/5CEobatv/H0LvsgjDG7pcjZpTlFSzYMaUQ
 sMyT+07JZB4JtK0B/HeZSb1vqpvS4uX4LQPH83DXC2Hws/mRd0LUKIOGVZ+yr8GMRTXk
 w1B7uz4+6BOEdGoh+esjMHfY6JIg4Z6BNX6oTPguT/6vmSI1vKRLTx2akhTd+ziDPlQ8
 orzVmckfvY0oFQ9efdxQz2oQy39rCIRfuzJi9YnaDD3X5JDWJCXF4fia6B4uIaf0ATQb
 sscrWcWrk+f+jWX0DDgwQubYDnmEIBfOa2MUOR+dCBXSnwibaMfxDptELQcBdGhYcTXw HA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjrhhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 03:20:20 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G3KIXP003048;
        Thu, 16 Mar 2023 03:20:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqmp08r-1;
        Thu, 16 Mar 2023 03:20:18 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G3KItO003042;
        Thu, 16 Mar 2023 03:20:18 GMT
Received: from hazha-gv.ap.qualcomm.com (hazha-gv.qualcomm.com [10.239.105.144])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 32G3KHM2003039;
        Thu, 16 Mar 2023 03:20:18 +0000
Received: by hazha-gv.ap.qualcomm.com (Postfix, from userid 4083943)
        id 8A70F1200071; Thu, 16 Mar 2023 11:20:16 +0800 (CST)
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v1 0/3] Add support to configure Coresight Dummy subunit
Date:   Thu, 16 Mar 2023 11:20:02 +0800
Message-Id: <20230316032005.6509-1-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x6XpTLoB3IL6ofB8f4TW3KSqv9rXil8T
X-Proofpoint-ORIG-GUID: x6XpTLoB3IL6ofB8f4TW3KSqv9rXil8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=861 clxscore=1011 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160028
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of Coresight Dummy subunit
The Coresight Dummy subunit is for Coresight Dummy component, there are some
specific Coresight devices that HLOS don't have permission to access. Such as
some TPDMs, they would be configured in NON-HLOS side, but it's necessary to
build Coresight path for it to debug. So there need driver to register dummy
devices as Coresight devices.

Commit link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy

Hao Zhang (3):
  Coresight: Add coresight dummy driver
  dt-bindings: arm: Add Coresight Dummy Trace YAML schema
  Documentation: trace: Add documentation for Coresight Dummy Trace

 .../bindings/arm/qcom,coresight-dummy.yaml    | 129 +++++++++++++
 .../trace/coresight/coresight-dummy.rst       |  58 ++++++
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
 5 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

-- 
2.17.1

