Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F626258BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKKvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiKKKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:51:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4563CD8;
        Fri, 11 Nov 2022 02:51:35 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABA0Caf009559;
        Fri, 11 Nov 2022 10:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9YjwX6HAB8qRk4yw6Unb28pfB3G973abKNTYzULPKOk=;
 b=ENoePwztiYM0uj0RUXmW1Lq2RHgtWnfiilZZL9AmZUyTASiRveriP4XoAojIKDcvaHNd
 ytvRyLUxUZ025jkluBZWYDoFzANIEEaU7cknk5C3cmCsLWOLg3vOt7UvJokJZWrptcl1
 9P2iO2mobQU3AjMmPxhRJPL4FjYBmjOF9Sr/0y/0y0/i+p1hy0lJiby6ueZha+C7O78w
 kFuq9MmZ6okyWqfRqUbZB0A75g93Q5ftb2WqGHvw3/Gnr6y9fCjqMLh535hLX60STdoR
 LMqWNNMtIz1NexNOgrvgDdyG1pLyN+01AkdnuX8ojw0E4iH1M7yUNHAZ1RV8pfOPWkh+ eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksh42gvmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:51:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABApHNa002381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:51:17 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 11 Nov 2022 02:51:12 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V18 0/7] soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)
Date:   Fri, 11 Nov 2022 16:20:26 +0530
Message-ID: <cover.1668159970.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kA6od2sQQoi7tr7LHYbKSyxWEodxZWv_
X-Proofpoint-ORIG-GUID: kA6od2sQQoi7tr7LHYbKSyxWEodxZWv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.
In case of a system crash or manual software triggers by the user the DCC hardware
stores the value at the register addresses which can be used for debugging purposes.
The DCC driver provides the user with debugfs interface to configure the register
addresses. The options that the DCC hardware provides include reading from registers,
writing to registers, first reading and then writing to registers and looping
through the values of the same register.

In certain cases a register write needs to be executed for accessing the rest of the
registers, also the user might want to record the changing values of a register with
time for which he has the option to use the loop feature.

The options mentioned above are exposed to the user by debugfs files once the driver
is probed. The details and usage of this debugfs files are documented in
Documentation/ABI/testing/debugfs-driver-dcc.

As an example let us consider a couple of debug scenarios where DCC has been proved to be
effective for debugging purposes:-

i)TimeStamp Related Issue

On SC7180, there was a coresight timestamp issue where it would occasionally be all 0
instead of proper timestamp values.

Proper timestamp:
Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x13004d8f5b7aa; CC=0x9e

Zero timestamp:
Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2

Now this is a non-fatal issue and doesn't need a system reset, but still needs
to be rootcaused and fixed for those who do care about coresight etm traces.
Since this is a timestamp issue, we would be looking for any timestamp related
clocks and such.

We get all the clk register details from IP documentation and configure it
via DCC config_read debugfs node. Before that we set the current linked list.

/* Program the linked list with the addresses */
echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config
echo R 0x10c008 > /sys/kernel/debug/dcc/../3/config
echo R 0x10c00c > /sys/kernel/debug/dcc/../3/config
echo R 0x10c010 > /sys/kernel/debug/dcc/../3/config
..... and so on for other timestamp related clk registers

/* Other way of specifying is in "addr len" pair, in below case it
specifies to capture 4 words starting 0x10C004 */

echo R 0x10C004 4 > /sys/kernel/debug/dcc/../3/config_read

/* Enable DCC */
echo 1 > /sys/kernel/debug/dcc/../3/enable

/* Run the timestamp test for working case */

/* Send SW trigger */
echo 1 > /sys/kernel/debug/dcc/../trigger

/* Read SRAM */
cat /dev/dcc_sram > dcc_sram1.bin

/* Run the timestamp test for non-working case */

/* Send SW trigger */
echo 1 > /sys/kernel/debug/dcc/../trigger

/* Read SRAM */
cat /dev/dcc_sram > dcc_sram2.bin

Get the parser from [1] and checkout the latest branch.

/* Parse the SRAM bin */
python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
python dcc_parser.py -s dcc_sram2.bin --v2 -o output/

Sample parsed output of dcc_sram1.bin:

<hwioDump version="1">
        <timestamp>03/14/21</timestamp>
            <generator>Linux DCC Parser</generator>
                <chip name="None" version="None">
                <register address="0x0010c004" value="0x80000000" />
                <register address="0x0010c008" value="0x00000008" />
                <register address="0x0010c00c" value="0x80004220" />
                <register address="0x0010c010" value="0x80000000" />
            </chip>
    <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
</hwioDump>

ii)NOC register errors

A particular class of registers called NOC which are functional registers was reporting
errors while logging the values.To trace these errors the DCC has been used effectively.
The steps followed were similar to the ones mentioned above.
In addition to NOC registers a few other dependent registers were configured in DCC to
monitor it's values during a crash. A look at the dependent register values revealed that
the crash was happening due to a secured access to one of these dependent registers.
All these debugging activity and finding the root cause was achieved using DCC.

DCC parser is available at the following open source location

https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser

Changes in V18

*Implemented all the review comments in V17 of the patch

*As per discussion io-remapped the dcc_sram.

*Also enabled proper overflow protection for dcc_sram.

Souradeep Chowdhury (7):
  dt-bindings: Added the yaml bindings for DCC
  soc: qcom: dcc: Add driver support for Data Capture and Compare
    unit(DCC)
  MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
    support
  arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support
    node
  arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support
    node
  arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support
    node
  arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support
    node

 Documentation/ABI/testing/debugfs-driver-dcc       |   98 ++
 .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     |   44 +
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |    6 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |    6 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |    6 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +
 drivers/soc/qcom/Kconfig                           |    8 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/dcc.c                             | 1318 ++++++++++++++++++++
 10 files changed, 1501 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
 create mode 100644 drivers/soc/qcom/dcc.c

-- 
2.7.4

