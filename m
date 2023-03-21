Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC826C335E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCUNxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCUNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:53:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B448E29;
        Tue, 21 Mar 2023 06:53:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LAL17U023402;
        Tue, 21 Mar 2023 13:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CZ5IUOIM+6Nj1yrJM1EOzdYAdH912N3pQCkds+1bKvQ=;
 b=lu/pPiF4AY4StyhIlR0sPXKCVNXS8mUcidUvg7zzV0EodzVfaHXUauI2iIC19LmTOiWH
 D59cEp7Gq0brpO/6/7uxywKKAiaRL8A8YwdSRcA+oYVObwts8HY9u7v800YRPFC7m18A
 JMiDqQuTELdWYO/wwuWfIAZltjeh9gC7DG6h95BWnLNZY1vpxAvijRgZLwMu6LZkZJB5
 xQV7YEXTqyiWV7VsIglupdzYE3Jh36bp75h67Fesfzk/3oCK5aG4Pkt0ZF8RqPKmPtc+
 C2l+wCrKF2vWHcumBB7e+pGA3M0lkhB3Vuu+ysoGQhj9Lcyu7+8L9TT1+Cr3qc5zRe9P Dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pf41vsnve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:52:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LDqsF5015312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:52:54 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 06:52:50 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 0/4] soc: qcom: boot_stats: Add driver support for boot_stats
Date:   Tue, 21 Mar 2023 19:21:47 +0530
Message-ID: <cover.1679403696.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6TGQosM47Pkw6twuqmlW-6F23xmBE4AQ
X-Proofpoint-GUID: 6TGQosM47Pkw6twuqmlW-6F23xmBE4AQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's proprietary Android boot-loaders capture boot time
stats, like the time when the bootloader started execution and at what
point the bootloader handed over control to the kernel etc. in the IMEM
region. This information is captured in a specific format by this driver
by mapping a structure to the IMEM memory region and then accessing the
members of the structure to print the information. This information is
useful in verifying if existing boot KPIs have regressed or not.
A sample log in SM8450(waipio) device is as follows:-

KPI: Pre ABL Time = 3s
KPI: ABL Time = 14s
KPI: Kernel MPM timestamp = 890206

The Module Power Manager(MPM) sleep counter starts ticking at the PBL
stage and the timestamp generated by the sleep counter is logged by
the Qualcomm proprietary bootloader(ABL) at two points-> First when it
starts execution which is logged here as "Pre ABL Time" and the second
when it is about to load the kernel logged as "ABL Time". Both these
values are read up by the driver from IMEM region and printed as above.
The current sleep counter timestamp is also logged by the driver.

Souradeep Chowdhury (4):
  dt-bindings: sram: qcom,imem: Add Boot Stat region within IMEM
  dt-bindings: soc: qcom,mpm-sleep-counter: Add the dtschema
  soc: qcom: boot_stat: Add Driver Support for Boot Stats
  MAINTAINERS: Add the entry for boot_stats driver support

 .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  |  40 ++++++++
 .../devicetree/bindings/sram/qcom,imem.yaml        |  20 ++++
 MAINTAINERS                                        |   7 ++
 drivers/soc/qcom/Kconfig                           |   7 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/boot_stats.c                      | 108 +++++++++++++++++++++
 6 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
 create mode 100644 drivers/soc/qcom/boot_stats.c

-- 
2.7.4

