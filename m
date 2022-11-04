Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9DB61932C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKDJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:11:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D3B41
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:11:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A494G4f015968
        for <linux-kernel@vger.kernel.org>; Fri, 4 Nov 2022 09:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JJm0Pn/xZJgBjOffOFVfDzPGawzaO0ZX2sFfqGf0yrQ=;
 b=EcFyCLl5muUYrymxIipICSZu6eDTrT9snI76T/wLysrWcR0js5DeOcpHhV4yUxEmO9Ek
 rx12pzGX+fAYmpal1HA6cxQdXueYxvTymKEmyRHVk03HMxvdoqhfJhvYBlpvWILDUJAJ
 QbJHvXSULYUpk/eDnyHK8TfxC5Nbz1OpBmwklZFnMW9j+2gg42UrcAh/2+0JChf0FlLd
 DXyQ5qqxHolQjYJPb4yclgNHGn8Il+TZfxciG4brgpvZewaT8T+FMmtJSC5I7lMrOz/H
 QYJ8h3OLAf3vOlV9oYsTSBTtmcKHCN9OLcMbnA0iU/UoMZKgVqD5lwLKFT285RvST5hU jw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmyseg0ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:11:33 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A49BXcA004592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 4 Nov 2022 09:11:33 GMT
Received: from hu-arandive-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 4 Nov 2022 02:11:31 -0700
From:   Aniket Randive <quic_arandive@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_ramkri@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>
Subject: [PATCH] soc: qcom: geni: Add SPI Slave protocol type
Date:   Fri, 4 Nov 2022 14:41:11 +0530
Message-ID: <1667553071-21841-1-git-send-email-quic_arandive@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VfCO6uEtLNRXbVGSy7lAcjClOXhhOw9q
X-Proofpoint-ORIG-GUID: VfCO6uEtLNRXbVGSy7lAcjClOXhhOw9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=792 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "GENI_SE_SPI_SLAVE" entry in enum which represents the
protocols supported by GENI Serial Engines. This is needed
to support the SPI slave feature on QUP based target.

Signed-off-by: Aniket Randive <quic_arandive@quicinc.com>
---
 include/linux/qcom-geni-se.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f567278..9fb2175 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -35,6 +35,7 @@ enum geni_se_protocol_type {
 	GENI_SE_UART,
 	GENI_SE_I2C,
 	GENI_SE_I3C,
+	GENI_SE_SPI_SLAVE,
 };
 
 struct geni_wrapper;
-- 
2.7.4

