Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFA6DAE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjDGOGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjDGOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:06:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCE5B92;
        Fri,  7 Apr 2023 07:06:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337DO2nN022516;
        Fri, 7 Apr 2023 14:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dgzja32tSZAozj9BTnV0hjMIc33oPjZpYMlOPC+EW3w=;
 b=h30meFpCInX4qEpoZB8pDr+iE6fa0w+SjccVj/dqNDQs7gotP7vArzLi8dqLSuDebPGh
 RHxuqcGiQdcaM8i2LK+8k3YwLAimSSDKLOrwDN8+09+YrMwJcwGHJtWn0dU3olTtRIKV
 RtQ7RGAe2migZ3xDMREutH2+C6lCjaKSQr1x16IYRVqJlgsPotmmSueAHUQzjxhJ+eJu
 0IIe19VCe4WkYiD1HanZz9VdPkPIk3RucbMfq0UGiW6CAtQPc6FKcS3f8Y5J7DsA5O7w
 YQ88kJCFTGyzNOfslSWs/jybnBnEwBAZwXUE+sG0m3++rmMkUCW/SIpALDBmq6tZr9uY +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pt8t59anp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:06:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337E6WfV019689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:06:32 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 07:06:28 -0700
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
Subject: [PATCH V2 0/3] soc: qcom: boot_stats: Add driver support for boot_stats
Date:   Fri, 7 Apr 2023 19:34:34 +0530
Message-ID: <cover.1680874520.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K4HGntmr4X5Vov_0mgNBH3T664OGby-I
X-Proofpoint-GUID: K4HGntmr4X5Vov_0mgNBH3T664OGby-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070129
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes in V2

*Implemented comments on version 1 of the patch

*Changed the boot_stats driver to module_platform_driver

*Dropped the DT binding for mpm sleep counter

Souradeep Chowdhury (3):
  dt-bindings: sram: qcom,imem: Add Boot Stat region within IMEM
  soc: qcom: boot_stat: Add Driver Support for Boot Stats
  MAINTAINERS: Add the entry for boot_stats driver support

 .../devicetree/bindings/sram/qcom,imem.yaml        | 21 +++++
 MAINTAINERS                                        |  6 ++
 drivers/soc/qcom/Kconfig                           |  7 ++
 drivers/soc/qcom/Makefile                          |  1 +
 drivers/soc/qcom/boot_stats.c                      | 95 ++++++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 drivers/soc/qcom/boot_stats.c

-- 
2.7.4

