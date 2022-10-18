Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF1602085
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJRBlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJRBlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:41:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227821094;
        Mon, 17 Oct 2022 18:40:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I1BYkr017364;
        Tue, 18 Oct 2022 01:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=SKLSM59/eOS6EjNhUYkLkSLyFACNjSC2GV9fFZqV7IY=;
 b=n7i2ViJP1SHCtUWyRxy2mwDRyl24m8ZjJ17XnYKgky/K5Mw9qorhmxNBctwroAbJw8ZY
 CsihiITlsoHRjod2oXdDBP7EHA/MnVVKz3q8nuc2pynPHrOTYG1Id0mMPW74I4qLtUk2
 KAJxKK0rNdjRDwruuokqaVhdWS06qBIumW9XMdOEB5J0XtLkPrMJu5EfLP/+0u0tDWhE
 PyowcT/qt4xzlWwOk6omj63JamE41uswF6VYw+9WD/SgnsM4dnKw/VFjgGVOV/2mdrKP
 YZwDhaMSSNcrP9NJoTvJNa6169jl6DFwWrBcZb12nlR06F6PSLpPY0sRE1ACDz6HaNQN bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9gwe886e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 01:40:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I1et16019270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 01:40:55 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 18:40:53 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v3 0/2] Add LED driver for flash module in QCOM PMICs
Date:   Tue, 18 Oct 2022 09:40:22 +0800
Message-ID: <20221018014024.948731-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d_WHMbT5qb3ClNkCUVD7B-O3ri4UUFiE
X-Proofpoint-ORIG-GUID: d_WHMbT5qb3ClNkCUVD7B-O3ri4UUFiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=663 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial driver and binding document changes for supporting flash LED
module in Qualcomm Technologies, Inc. PMICs.

Changes in V3:
  1. Updated the driver to use regmap_field for register access.
  2. Adressed the review comments in binding document change.

Changes in V2:
  1. Addressed review comments in binding change, thanks Krzysztof!
  2. Updated driver to address the compilation issue reported by
     kernel test robot.


Fenglin Wu (2):
  leds: flash: add driver to support flash LED module in QCOM PMICs
  dt-bindings: add bindings for QCOM flash LED

 .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 +++
 drivers/leds/flash/Kconfig                    |  15 +
 drivers/leds/flash/Makefile                   |   1 +
 drivers/leds/flash/leds-qcom-flash.c          | 700 ++++++++++++++++++
 4 files changed, 832 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
 create mode 100644 drivers/leds/flash/leds-qcom-flash.c

-- 
2.25.1

