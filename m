Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064326DCAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDJSVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:21:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877F1FD5;
        Mon, 10 Apr 2023 11:21:36 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFxBE8010960;
        Mon, 10 Apr 2023 18:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=am50PlryRRfYXJ4hjNZEKIeFgwMZ+ijTi/TRPQme2VA=;
 b=FC0JUOHaNzmz9vWK8giQ2W7+P9QDZ8g/SMHx4aMSAqdmeww9NNGYC6RFAS7XrXub5bwf
 BgqRBN8DjrIkZ1bPqTjfXIDlnldneiPUJqKiy75CTrue+kprz21+J0hIQB6r6RLwZir4
 VmtSZh7Hx0nlHoI8GMLGflOTLfwdDi5g6JIHvFBLmYcW5YmzmnqusDKVYuTIIzZIDh2W
 RpXco1SbjXY7/yzGF21wNPyu2JPUKlYzpt3IIXDSqfqV6GJ/YdJYfWw6F47CgmSSYhvd
 FxqNOs1WdXzDeoaPzpjC79fFrqaPPttPhy3uZ2uTooah9Wl0t0wvp/vMmTnAfZy2pRYO +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvgkgh1mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AILJvp017053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:19 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 11:21:19 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v2 0/2] Allow parameter in smc/hvc calls
Date:   Mon, 10 Apr 2023 11:20:56 -0700
Message-ID: <20230410182058.8949-1-quic_nkela@quicinc.com>
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
X-Proofpoint-GUID: 3T-b2-G6oYniM6opK5TLZbO8q-KhfSVV
X-Proofpoint-ORIG-GUID: 3T-b2-G6oYniM6opK5TLZbO8q-KhfSVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=449 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100158
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with parameters set
to zeros. We are using multiple scmi instances within
a VM and hypervisor associates a tag with each instance
and expects the tag in hvc calls from that instance, while
sharing the same smc-id(func_id) among the instances.

This patch series introduces new optional dtb bindings which
can be used to pass parameters to smc/hvc calls.

---
v2 -> fix the compilation erros on 32bit platform(see below)
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/

v1 -> original patches

Nikunj Kela (2):
  dt-bindings: firmware: arm,scmi: support parameter passing in smc/hvc
  firmware: arm_scmi: Augment SMC/HVC to allow optional parameters

 .../bindings/firmware/arm,scmi.yaml           | 17 +++++
 drivers/firmware/arm_scmi/smc.c               | 72 ++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.17.1

