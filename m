Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71186636B80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiKWUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKWUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:46:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09511839;
        Wed, 23 Nov 2022 12:46:51 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANK312A028394;
        Wed, 23 Nov 2022 20:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=lZwKNy2RjPoW4och06PHs0tav/u1JOyun1/SQsJeP6U=;
 b=ZhAGvTv/ZY7JTl/wRbvJrR8tDgdDEeHtv2cQY9hEmEhurF9idBQw0oRIJz63yqBR0Tjv
 ttRALevRF0mw0G4sH8Y1qFHopctf0FXB+OiOvGRzdF8unfdMEyPLenjvF8iEooogwQkX
 PvmX1SoeEdqOs5+CdHakYv7BuHYaHD1ekC5248isGTKurK1+pkGPTvyI0Wx03iutI3P4
 8abDpyZmXBsobZMKm027YrBNpz2M8sk0QMI9pRWr9PIFvJ9ZeoOwdBfknZWsNwEi8Mbx
 RK0unlqjgxxhYxqdmo/8Dcz6Cqqr36QuSdH3dFdmLpTAVv48S+vZpEoQU7iMIfaEo5SS kA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m11bu411v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 20:46:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ANKkcJt007409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 20:46:38 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 12:46:34 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V5 0/2] SCM: Add support for wait-queue aware firmware
Date:   Thu, 24 Nov 2022 02:16:13 +0530
Message-ID: <20221123204615.25358-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4vgdRdJGW3BhKBr421x-rsifCJRo-1yt
X-Proofpoint-ORIG-GUID: 4vgdRdJGW3BhKBr421x-rsifCJRo-1yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Older version of the series:
[v4] https://patchwork.kernel.org/project/linux-arm-msm/cover/20221114082644.28739-1-quic_sibis@quicinc.com/
[v3] https://patchwork.kernel.org/project/linux-arm-msm/cover/1666086406-5452-1-git-send-email-quic_sibis@quicinc.com/ 
[v2] https://patchwork.kernel.org/project/linux-arm-msm/cover/1661898311-30126-1-git-send-email-quic_gurus@quicinc.com/
[v1] https://patchwork.kernel.org/project/linux-arm-msm/cover/1656359076-13018-1-git-send-email-quic_gurus@quicinc.com/


Guru Das Srinagesh (2):
  dt-bindings: firmware: qcom-scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue handling logic

 .../bindings/firmware/qcom,scm.yaml           |   6 +
 drivers/firmware/qcom_scm-smc.c               |  97 +++++++++++++--
 drivers/firmware/qcom_scm.c                   | 115 +++++++++++++++++-
 drivers/firmware/qcom_scm.h                   |   9 ++
 4 files changed, 219 insertions(+), 8 deletions(-)

-- 
2.17.1

