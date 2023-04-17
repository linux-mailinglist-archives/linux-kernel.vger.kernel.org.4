Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D786E4F88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDQRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDQRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:44:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E247D98;
        Mon, 17 Apr 2023 10:44:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HHgviG006123;
        Mon, 17 Apr 2023 17:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Lk2dtssckoYP0BgRrMxw79+JnQVqwyfxtEsTiEbqgYg=;
 b=j3eb1O+TLZkAxZKHigX6MwPlbS7GtyBM7tEb6s1esYh97vdWxi4KEGRvi777oqf+8N70
 YhH8wJidLxlN3+/rTJBzltMws00Qdkfr1McGSG5uB18+AJO/gA4Adc5OuENPETvkO64Q
 RnSSw/yoL7UUBGIMnXE51UPsAuRz+M1CJcIo1KByd3SylQKjDX7tpgqsyhCZZT69LYLk
 7GRrPn7l2x/UFqfGo41GW9ZjsEfsyKS2ifpSVGXddxESRW0jDBdgmXQkN3yPRyBG1fTR
 R0oyEHOza68TnuOrr+CQtYpbo5p41F+g+nY1z+78T22VuNoUn1EeuDBQqTiNXkfHhzwp hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171ggq8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HHiJpC018668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:19 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 10:44:19 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 0/2] Allow parameter in smc/hvc calls
Date:   Mon, 17 Apr 2023 10:43:59 -0700
Message-ID: <20230417174401.19563-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230409181918.29270-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WG00_snvTZPzi4a-_Kqr4-Vbp7Db03Xj
X-Proofpoint-ORIG-GUID: WG00_snvTZPzi4a-_Kqr4-Vbp7Db03Xj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_12,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=556 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
can be used to pass shmem channel address as a parameter
to smc/hvc calls.

---
v3 -> pass shmem channel address as parameter

v2 -> fix the compilation erros on 32bit platform(see below)
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/

v1 -> original patches

Nikunj Kela (2):
  dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
  firmware: arm_scmi: Augment SMC/HVC to allow optional parameter

 .../bindings/firmware/arm,scmi.yaml           |  4 +++
 drivers/firmware/arm_scmi/driver.c            |  1 +
 drivers/firmware/arm_scmi/smc.c               | 25 ++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1

