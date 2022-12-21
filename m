Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE1652C70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLUFiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiLUFiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:38:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE31D65A;
        Tue, 20 Dec 2022 21:38:05 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL4mCup012618;
        Wed, 21 Dec 2022 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/LhkojW8t1G5vUSyhOyg0ZsF21eTZExaLiYk2EUrfDc=;
 b=DIxRTQzQPJX0cUBZvw3hoY8MbZnrIvKbl22yVDAAajR/lRDWvlNLKSxV9rtbhqVkzAPf
 JV0tN7sYUL/9+nauz7RnJ+TTWhLiTRQBGKwFcyU8LYNPRp3lJ6UHtJXs1vLf8wxBrBQa
 FSWj391pwDf4uK3Mv+VCfqK0zquzMnMDCG27FrbAb53myCizFApkpgiRxYBQLsPIWhyW
 Oc+k2yG41lFSk8RIE0Bpn8HaOF4QypeZZTeb0eDHTO/D9wu7mVDCshMbRcknr/EiTwJK
 4ZnPolkTsISZN8aSuOaLkNheIf4TodTEwR10d01Sh+GoYO8N+y9a4/4hCHzr+UYxZquN Bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mkmvt8qmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:38:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL5bxLA004178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:38:00 GMT
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 21:37:55 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <quic_kamalw@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH] spmi: Add a check for remove callback when removing a SPMI driver
Date:   Wed, 21 Dec 2022 11:07:12 +0530
Message-ID: <1671601032-18397-2-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671601032-18397-1-git-send-email-quic_jprakash@quicinc.com>
References: <1671601032-18397-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WbEwyLVQ6xJKuxjIf_kv1RA-4agEr9n8
X-Proofpoint-GUID: WbEwyLVQ6xJKuxjIf_kv1RA-4agEr9n8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_01,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=649
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210038
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a SPMI driver, there can be a crash due to NULL pointer
dereference if it does not have a remove callback defined. This is
one such call trace observed when removing the QCOM SPMI PMIC driver:

 dump_backtrace.cfi_jt+0x0/0x8
 dump_stack_lvl+0xd8/0x16c
 panic+0x188/0x498
 __cfi_slowpath+0x0/0x214
 __cfi_slowpath+0x1dc/0x214
 spmi_drv_remove+0x16c/0x1e0
 device_release_driver_internal+0x468/0x79c
 driver_detach+0x11c/0x1a0
 bus_remove_driver+0xc4/0x124
 driver_unregister+0x58/0x84
 cleanup_module+0x1c/0xc24 [qcom_spmi_pmic]
 __do_sys_delete_module+0x3ec/0x53c
 __arm64_sys_delete_module+0x18/0x28
 el0_svc_common+0xdc/0x294
 el0_svc+0x38/0x9c
 el0_sync_handler+0x8c/0xf0
 el0_sync+0x1b4/0x1c0

If a driver has all its resources allocated through devm_() APIs and
does not need any other explicit cleanup, it would not require a
remove callback to be defined. Hence, add a check for remove callback
presence before calling it when removing a SPMI driver.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/spmi/spmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index a456ce5..6b34356 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -350,7 +350,8 @@ static void spmi_drv_remove(struct device *dev)
 	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
 
 	pm_runtime_get_sync(dev);
-	sdrv->remove(to_spmi_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_spmi_device(dev));
 	pm_runtime_put_noidle(dev);
 
 	pm_runtime_disable(dev);
-- 
2.7.4

