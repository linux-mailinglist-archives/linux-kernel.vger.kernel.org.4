Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43766F9394
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEFSZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEFSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:25:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74981568E;
        Sat,  6 May 2023 11:25:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346IOk0u013538;
        Sat, 6 May 2023 18:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=vJjWjnBQhlj+a2mM7ckiLmU0Aw7eyqrO42qFOaohC50=;
 b=nCZLyLYkamp6FlOzsC4kLaL64hFwMM+FOS1zuT0MN00poes9LepGleS6FfsVI8ob28WB
 JRJ/qaPRsVwgoMFNjwM38MxydJGR7GWI/AtDB9lPyNBMmXZNIfgs55N0wER/tTpT860W
 4n3vhd6XnAYpjzXHaK4ZsPzwNYh0U8lrr/5jnpotbva7j3qm6L5Z3BSlu4tlhY3F8KM7
 iil1q0VSTmZI/I2Q2VbEJpX62lGh0cPUxtI5ZurQ8ezD6mT1taEiD9wsoRMR+CdaqCuG
 nUuyZUHiszo75PSqcBl/lilAONw45wxBax0VLFZj4ErOsSsMSMWDpVjWANKCbrb73iGO BQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qdc8xh0xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 May 2023 18:24:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 346IOjTL031658
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 18:24:45 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 6 May 2023 11:24:44 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v5 0/2] Allow parameter in smc/hvc calls
Date:   Sat, 6 May 2023 11:24:26 -0700
Message-ID: <20230506182428.25343-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lREG1CcS69taqg-2XwQFpcRSJfcgbfMu
X-Proofpoint-GUID: lREG1CcS69taqg-2XwQFpcRSJfcgbfMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=629
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305060144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with parameters set
to zeros. We are using multiple scmi instances within
a VM. We are sharing the same smc-id(func_id) with all
scmi instance. The hypervisor needs a way to distinguish
among hvc calls made from different instances.

This patch series introduces new compatible string which
can be used to pass shmem channel address as parameters
to smc/hvc calls.

---
v5 -> avoid computing page and offset in send function
Link: https://lore.kernel.org/all/20230418185659.29745-1-quic_nkela@quicinc.com/

v4 -> split shmem address into 4KB-pages and offset

v3 -> pass shmem channel address as parameter

v2 -> fix the compilation erros on 32bit platform(see below)
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/

v1 -> original patches

Nikunj Kela (2):
  dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
  firmware: arm_scmi: Augment SMC/HVC to allow optional parameters

 .../bindings/firmware/arm,scmi.yaml           |  8 ++++-
 drivers/firmware/arm_scmi/driver.c            |  1 +
 drivers/firmware/arm_scmi/smc.c               | 30 ++++++++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.17.1

