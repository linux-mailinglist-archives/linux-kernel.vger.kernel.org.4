Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB6669D81
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAMQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAMQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:19:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4E38ACD;
        Fri, 13 Jan 2023 08:11:44 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DDtBYD015111;
        Fri, 13 Jan 2023 16:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=frbhSRH7sTGMepJakjC8EsOOV5J1rpbgwBjLx+QdLho=;
 b=pSIqLH6+f+QYXMMaXhwTQqqKeTFrcsnLmleAELhpnc8vWeFuWFgo2UHICvB+s3KmowxU
 ys+tQMrB6+lv93s782RCZt9OnWc5RRhroknG4U+RBGb3zLzB2Ok2s4l2pG+EBFR8drFw
 AMdPWvTnlx6QIAa1jhV/8aea3FCZJngkPV4qzDaBeXdWVbUbSWXoM63/gek2Rvwz9JPg
 FohZLJDB5wG+gjj/XpjHPv2uLPqW/yODes0UfLjGJWKMabiqLUiqlNHnX9v0wboglcbC
 wgblONBDvG9xvLuaqQjngENrbg+8/NNBDNTug7Apw/d5j1wu4KM4UmOzLtX22+SO/i80 1w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2jghu60q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:11:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DGBYQx026130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:11:34 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 08:11:31 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V10 0/2] SCM: Add support for wait-queue aware firmware
Date:   Fri, 13 Jan 2023 21:41:12 +0530
Message-ID: <20230113161114.22607-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LICtbALMUl7POUNo7c9ugIunbfFlk3FN
X-Proofpoint-ORIG-GUID: LICtbALMUl7POUNo7c9ugIunbfFlk3FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130108
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

V10:
- Drop unused flags variable in quirk_handle_waitq [kernel test bot]

V9:
- Drop unused complete_all [Srini]

v8:
- Rename qcom_scm_lookup_wq to qcom_scm_assert_valid_wq_ctx [Bjorn] 
- Document wq_ctx limitations [Guru]
- Drop dev check and add include completion header [Srini]
- Rename qcom_scm_lookup_completion to qcom_scm_wait_for_wq_completion.

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

Guru Das Srinagesh (2):
  dt-bindings: firmware: qcom,scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue handling logic

 .../bindings/firmware/qcom,scm.yaml           | 18 ++++
 drivers/firmware/qcom_scm-smc.c               | 86 ++++++++++++++++--
 drivers/firmware/qcom_scm.c                   | 90 ++++++++++++++++++-
 drivers/firmware/qcom_scm.h                   |  8 ++
 4 files changed, 194 insertions(+), 8 deletions(-)

-- 
2.17.1

