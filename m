Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184536FC44A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjEIKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjEIKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:53:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9473A98;
        Tue,  9 May 2023 03:53:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3498KAos023478;
        Tue, 9 May 2023 10:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=imTFoMbEbV8QAXicdsE9c4KO2oktsb6s1YI3AMZ8m5I=;
 b=DgjqZPd9yzuKQ0QfjeHlDBDjPiiGb2av6HQ8FTWlmgwscqVCaw4hdWwC7lrCChZkNno2
 lBcKrqjIyfMexwdtDRVIZCs1Av0mBdjraIcQnhczzmFZhopWsl83yEhdmgy34u6lnzCp
 WgMYSFnJ73zSQFsohvRaAxlPDLxig3yVoi5YDEHro5EZZqZ1qFX72qaGqsuBn9cyFDnj
 2AIWmEi+M5G1euVmC0/JsgZoaqLfkSRmpm3CYJdv5JA2csIAVcEMrj7pP4zr7GTIn/k/
 VNfcu1rhch/33wLAW3ThwXqTR+pann4pzKskGEFD1Ct9vfxL/RcAJFytqxBJNA1mzh9H PQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77f1g7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 10:53:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349Ar2OT026670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 10:53:02 GMT
Received: from hu-schowdhu-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 03:53:02 -0700
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
Subject: [PATCH V6 0/3] soc: qcom: boot_stats: Add driver support for boot_stats
Date:   Tue, 9 May 2023 03:52:20 -0700
Message-ID: <cover.1683628357.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8l59SEyQ6FYiENZXHJzb0b_p5aIBZ6pF
X-Proofpoint-GUID: 8l59SEyQ6FYiENZXHJzb0b_p5aIBZ6pF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=987 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
members of the structure to log the information in a debugfs file.
This information is useful in verifying if existing boot KPIs have
regressed or not.

A sample log in SM8450(waipio) device is as follows:-

/sys/kernel/debug/qcom_boot_stats # cat abl_time
17898 ms
/sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
2879 ms

The Module Power Manager(MPM) sleep counter starts ticking at the PBL
stage and the timestamp generated by the sleep counter is logged by
the Qualcomm proprietary bootloader(ABL) at two points-> First when it
starts execution which is logged here as "pre_abl_time" and the second
when it is about to load the kernel logged as "abl_time". Both these
values are read up by the driver from IMEM region and printed as above.

Changes in V6

*Implemented the comments on V4 and V5 of the patch

Souradeep Chowdhury (3):
  dt-bindings: sram: qcom,imem: Add Boot Stat region within IMEM
  soc: qcom: boot_stat: Add Driver Support for Boot Stats
  MAINTAINERS: Add the entry for boot_stats driver support

 .../ABI/testing/debugfs-driver-bootstat       |  17 +++
 .../devicetree/bindings/sram/qcom,imem.yaml   |  22 ++++
 MAINTAINERS                                   |   7 ++
 drivers/soc/qcom/Kconfig                      |  10 ++
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/boot_stats.c                 | 100 ++++++++++++++++++
 6 files changed, 157 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
 create mode 100644 drivers/soc/qcom/boot_stats.c

-- 
2.17.1

