Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A386E6C79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDRS5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDRS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:57:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDC18E;
        Tue, 18 Apr 2023 11:57:34 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IBjCEa013085;
        Tue, 18 Apr 2023 18:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sg667oIlIEBEWckeWdNBRjxrMjaC/X10PCBBfquvCe8=;
 b=E7pCv1dEUG9jPANaSDXPDZhhbaYokeuLyoxV7WkJkf2a50aI/tHSiuoGbJl+aBx/ulCT
 p0b4wiFG2k84qqLjv/SWCbTZy62huyPskHD1bdy2HUv5CA4lzc+HG33YfQf0mGoRnz18
 km9XIfqW5B3BEjAxyVx5k8r1mCiZZdBjzfvW5a/cyPYPE9shgP5ejg8AK+uZbeOLrO1D
 nanC56jYxgvwEByXdHc1sk/8gFBhhvRZunJxqkh8ucCxLzUEE3udPHDa+nflqr49OVyx
 ywnt/YYmj4s1y4qGvhFW3wmWQEkWD+6aeOPMhAj0jZkXSEKP9yHZZrzO7/2l7Zpq7uuQ YQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1h0cjh4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IIvJKq029961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:19 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 11:57:19 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 0/2] Allow parameter in smc/hvc calls
Date:   Tue, 18 Apr 2023 11:56:57 -0700
Message-ID: <20230418185659.29745-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230409181918.29270-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dSk175OiAwID0TcZQjrl4HYmyoB6hmLq
X-Proofpoint-GUID: dSk175OiAwID0TcZQjrl4HYmyoB6hmLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=627 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180155
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
v4 -> split shmem address into 4KB-pages and offset

v3 -> pass shmem channel address as parameter

v2 -> fix the compilation erros on 32bit platform(see below)
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/

v1 -> original patches

Nikunj Kela (2):
  dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
  firmware: arm_scmi: Augment SMC/HVC to allow optional parameters

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  8 +++++++-
 drivers/firmware/arm_scmi/driver.c                 |  1 +
 drivers/firmware/arm_scmi/smc.c                    | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

