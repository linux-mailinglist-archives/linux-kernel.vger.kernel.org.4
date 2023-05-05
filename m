Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA96F7D02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjEEGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEEGhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:37:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE19ED8;
        Thu,  4 May 2023 23:37:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3455PHrL027684;
        Fri, 5 May 2023 06:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dxOB1odZqFKrhagzqZ8KJ+oLXGpFNY/hGhvyFR++l/s=;
 b=ElxIOTE6RAto/UUvhdNpMLcUyqeCgsK2ei5QwIeHomCS4Vk/V1sF11p5TFfnXHSoaJZW
 TKzhh68g2xY6Zdb93rGFkiH8VDi3sMjEcCMnndbt9Z5BCVFsaE928N03QYqAUK/aV8ZV
 AHenP40bd8TzAEcTaUIUjmsGjLCGpmqcM+TrHP2TlFroaflzCHo45YC65zPXhpUNUQwN
 r5MusSfJnXyOeEwjrYVwcDDHLXJqpl7AISgPgfywcMXB23gKtzVGcG4mFiy5zhVvAnaz
 63NGsIa8fLVmRxo7XKTvLp8YOtXgrMi17JdCYm3hMTEqkf0Xxf46TxqMr9WJ7nRkoviG bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcumk84sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 06:36:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3456auoV009480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 06:36:56 GMT
Received: from hu-schowdhu-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 23:36:55 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V23 0/3] misc: Add driver support for Data Capture and Compare unit(DCC)
Date:   Thu, 4 May 2023 23:36:20 -0700
Message-ID: <cover.1683265984.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9js7TwbCASGjqgl8XfMZwTOgAPFxw53U
X-Proofpoint-ORIG-GUID: 9js7TwbCASGjqgl8XfMZwTOgAPFxw53U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
echo R 0x10c004 > /sys/kernel/debug/qcom-dcc/../3/config
echo R 0x10c008 > /sys/kernel/debug/qcom-dcc/../3/config
echo R 0x10c00c > /sys/kernel/debug/qcom-dcc/../3/config
echo R 0x10c010 > /sys/kernel/debug/qcom-dcc/../3/config
..... and so on for other timestamp related clk registers

/* Other way of specifying is in "addr len" pair, in below case it
specifies to capture 4 words starting 0x10C004 */

echo R 0x10C004 4 > /sys/kernel/debug/qcom-dcc/../3/config_read

/* Enable DCC */
echo 1 > /sys/kernel/debug/qcom-dcc/../3/enable

/* Run the timestamp test for working case */

/* Send SW trigger */
echo 1 > /sys/kernel/debug/qcom-dcc/../trigger

/* Read SRAM */
cat /dev/dcc_sram > dcc_sram1.bin

/* Run the timestamp test for non-working case */

/* Send SW trigger */
echo 1 > /sys/kernel/debug/qcom-dcc/../trigger

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

https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser

Souradeep Chowdhury (3):
  dt-bindings: misc: qcom,dcc: Add the dtschema
  misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
  MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
    support

 Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
 .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
 MAINTAINERS                                   |    8 +
 drivers/misc/Kconfig                          |    9 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/qcom-dcc.c                       | 1325 +++++++++++++++++
 6 files changed, 1392 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
 create mode 100644 drivers/misc/qcom-dcc.c

-- 
2.17.1

