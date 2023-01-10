Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B866396C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjAJGir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjAJGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:38:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FD165AF;
        Mon,  9 Jan 2023 22:38:42 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A6VVT6011032;
        Tue, 10 Jan 2023 06:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=qiLqfpggTCS7u/2muZH/fEzHWPSU9gD+b7PmRdpdG5o=;
 b=f4n543tu/4WPYfETAHIg0+qUBxd2Yukld5vmVUBXMDQJ9A4SREmVIYXEFxPjqyh3Ojd9
 uwD5y9Vz5rERm9bXJ2RKG66k94aCXeDPdoN26UWEigo7KToRzAwmt9dLIspX2sWGSNWE
 RbYBzzW1PGCH320ar+K0c7Pj4zqySGY5fjI7b7nj3lVJWYH1oX/3+e75zdkKPFcrK+K5
 oMAM3OY9E+1syCPGwLOuj3YEgQjnZngPEsPWl9PyQkxganyLEKcuR/zM5mMldIFjT9m/
 5GxMUwskNKqL8hhrMYFIvUV3ICZB2F/X8lY8khL4A1Qf3/LrpXt/J6bP+zpL1Pw5WPlf Ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0ssh8ycn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:38:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A6cSK4001063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:38:28 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 22:38:25 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V7 0/2] SCM: Add support for wait-queue aware firmware
Date:   Tue, 10 Jan 2023 12:07:43 +0530
Message-ID: <20230110063745.16739-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ygyxmg1URTKbv1uEF24K-fWBzk0KyTUs
X-Proofpoint-ORIG-GUID: ygyxmg1URTKbv1uEF24K-fWBzk0KyTUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100042
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

v7:
- Move lookup + wait_for_completion into a single function in qcom_scm [Bjorn]
- Simplify completion retrieval [Bjorn]

v6:
- Fix subject of bindings [Krzysztof]
- Update commit message to include the SoC supporting the feature [Krzysztof]
- Make the interrupt property valid on SM8450 SoC [Krzysztof]
- Fix misc. nits in the scm driver [Krzysztof]
- Rebased on Krzysztof's narrow clocks and interconnect series.

v5:
- Pick up R-b
- Handle the wake_one/wake_all flags [Guru]
- Rename flag handler to qcom_scm_waitq_wakeup [Bjorn]
- Resume scm call can return ebusy as well handle that scenario by retrying
  the original smc call and not the resume call

v4:
- platform_set_drvdata will be used by __scm_smc_do_quirk_handle_waitq to
  get access to scm struct from device so retain it
- Use a single completion as it satisfies all of the current usecases [Bjorn]
- Inline scm_get_wq_ctx [Bjorn]
- Convert all pr_err to dev_err [Bjorn]
- Handle idr_destroy in a thread safe manner [Bjorn]
- Misc. Style fixes [Bjorn]
- Qualify bindings [Krzysztoff]

v3:
- Drop allow-multi-call property since HLOS doesn't completely support it
  yet.
- Fixup irq handling so as not to affect SoCs without the interrupt.
- Fix warnings reported by kernel test-bot.

v2:
- Changes made to patches 4 and 5 are listed therein.
- Rebased dt-bindings on top of the YAML conversion patch [1].

Depends on Krzysztof's narrow clocks and interconnect series:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20221122092345.44369-1-krzysztof.kozlowski@linaro.org/
https://patchwork.kernel.org/project/linux-arm-msm/patch/20221122092345.44369-2-krzysztof.kozlowski@linaro.org/

Guru Das Srinagesh (2):
  dt-bindings: firmware: qcom,scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue handling logic

 .../bindings/firmware/qcom,scm.yaml           | 18 ++++
 drivers/firmware/qcom_scm-smc.c               | 90 +++++++++++++++++--
 drivers/firmware/qcom_scm.c                   | 89 +++++++++++++++++-
 drivers/firmware/qcom_scm.h                   |  8 ++
 4 files changed, 197 insertions(+), 8 deletions(-)

-- 
2.17.1

