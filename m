Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B96028AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJRJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJRJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:47:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358259E689;
        Tue, 18 Oct 2022 02:47:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I75HPK002285;
        Tue, 18 Oct 2022 09:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=amlqMKTV6n+Mwr6Kr0ex/PU4p5+azvXSx5leivwm0pA=;
 b=Zx2OIpBZkoGNbjQRQlLRmHGpbQrZjM5lqQFe1xpiaXGq12XNFO48jCFnGdEXI/sioTVm
 YiV/5gf7Og6Yeppyp5w6XWd/u871Sdof6sq/a8rzZXqc8uQKn/v/LfpFpl8OoCHpG5mb
 3p3EM/OVVro4879F3Mup970zz9DfBTtB6KJeBXgR1rUz+HuwyRzju54BhDPY/lpm7+cL
 UQ2MYCTiJhC0fTFZVfmH84n8qIO9/Kf9uA1nYgUJy7FEkbzhlTuXaefVIqb8P7ubS25g
 50btaUz2QJ1cZFSek0coyphhKlD1sZwM9pkYsWRkiJqbL45SCOSeyBRe+oBJmoJowctZ Fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9gwe9ayy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 09:47:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I9l92a013786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 09:47:09 GMT
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 02:47:05 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 0/2] SCM: Add support for wait-queue aware firmware
Date:   Tue, 18 Oct 2022 15:16:44 +0530
Message-ID: <1666086406-5452-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kw8OjKg_m3INRbwPkIWTcaYzB-DnGUjT
X-Proofpoint-ORIG-GUID: kw8OjKg_m3INRbwPkIWTcaYzB-DnGUjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_03,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the QCOM SCM driver to support firmware (FW) versions
that expect the high-level OS (HLOS) to be tolerant of SCM call requests not
being processed right away and, instead, being placed on a wait-queue in FW and
processed accordingly.

The problem this feature is fixing is as follows. In a scenario where there is
a VM in addition to HLOS (and an underlying hypervisor):

1. HLOS makes an SMC call on core 5
2. The hypervisor scheduling interrupt interrupts this SMC call.
3. The hypervisor schedules the VM on core 5.
4. The VM makes an SMC call on core 5.
5. The SMC call is non-interruptibly stuck on FW spinlock on core 5.
6. HLOS cannot reschedule since core 5 is not responding to Reschedule IPIs.
7. Watchdog timer expires waiting for core 5.

This problem is solved by FW returning a new return code SCM_WAITQ_SLEEP to
HLOS right away when it is overwhelmed by the VM's SMC call. HLOS then places
the call on a wait-queue and wakes it up when it receives an interrupt that
signifies "all-clear".

There are two new SMC calls also being defined in this design that, together
with one new return code, form the handshake protocol between Linux and FW.

This design is also backwards-compatible with existing firmware versions that
do not support this feature.

v3:
- Drop allow-multi-call property since HLOS doesn't completely support it
  yet.
- Fixup irq handling so as not to affect SoCs without the interrupt.
- Fix warnings reported by kernel test-bot.

v2:
- Changes made to patches 4 and 5 are listed therein.
- Rebased dt-bindings on top of the YAML conversion patch [1].

Older version of the series:
[v2] https://patchwork.kernel.org/project/linux-arm-msm/cover/1661898311-30126-1-git-send-email-quic_gurus@quicinc.com/
[v1] https://patchwork.kernel.org/project/linux-arm-msm/cover/1656359076-13018-1-git-send-email-quic_gurus@quicinc.com/

Guru Das Srinagesh (2):
  dt-bindings: firmware: qcom-scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue handling logic

 .../devicetree/bindings/firmware/qcom,scm.yaml     |   5 +
 drivers/firmware/qcom_scm-smc.c                    | 108 +++++++++++++++++--
 drivers/firmware/qcom_scm.c                        | 120 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  10 ++
 4 files changed, 234 insertions(+), 9 deletions(-)

-- 
2.7.4

