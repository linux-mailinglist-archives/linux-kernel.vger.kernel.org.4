Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210726DB695
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDGWjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDGWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:39:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A3BB80;
        Fri,  7 Apr 2023 15:39:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337MU3TF002575;
        Fri, 7 Apr 2023 22:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4wy59giH1iZ0lLV4ochSNdMNyXqOjCvvleqBjTCZwoE=;
 b=UXgCgL4+inHMZgwAQEA/4AhzAcCd9YPF3nBUAAnc2QdDvIzG1lAK5EXOwJiCIb1TJafK
 wCBfS33LPdqvGpWJEgr4VTkvImq5KjR+cQKLhQSduLMh5AYsKyCG0/s5jvEP8rlDK7At
 ZPgS1DDk/IK44byghiUyw24tbuLgYSlkqGPZw8KRs2KZdXgp9OTzj1mC02J6uDwf45r7
 g38Nyz/NqhjcyboMjM0QH+KXBhlv6jOFVd36wE6s1JWPsxiHtOigcMIQBdaOaO+vFAzu
 RwjOXhLbcv90bl55st30Aji/IuAezteKq0wCPqKzkNORYP2CVGhtwa8j8xlS3sI00BR5 xA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb9wj5kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 22:39:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337MdA8F003439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 22:39:10 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 15:39:10 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 0/3] Add support for high resolution PWMs
Date:   Fri, 7 Apr 2023 15:38:46 -0700
Message-ID: <20230407223849.17623-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _K6f48eR73Bw6sbf-WIHrZn9nUrZM8Pv
X-Proofpoint-ORIG-GUID: _K6f48eR73Bw6sbf-WIHrZn9nUrZM8Pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=615 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070205
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain PMICs have a high reolution PWM module which can support from 8-bit
to 15-bit PWM. This change series adds support for those PMICs. Thanks!

Changes since v1:
  1. Updated some variable names in driver. 
  2. Updated driver to address compilation issue reported by
     kernel test robot.

Anjelique Melendez (3):
  dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
  leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
  leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM

 .../bindings/leds/leds-qcom-lpg.yaml          |   1 +
 drivers/leds/rgb/leds-qcom-lpg.c              | 160 +++++++++++++-----
 2 files changed, 116 insertions(+), 45 deletions(-)

-- 
2.40.0

