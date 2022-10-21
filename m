Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11D1607A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJUPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJUPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:16:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A926B6E6;
        Fri, 21 Oct 2022 08:16:32 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LEreeZ018146;
        Fri, 21 Oct 2022 15:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ef6LKQX/JIvvfxAKPolHgGyhRjCChbGHT3p+eMM2Vqs=;
 b=mB/sPyw7sxINk3xkRTUQ8znNu6sXoOvk3eq9PUsuRtgpqOaV6IQ+qBtVKRdjlEmLEqAX
 ULpR0Im28oHkck8bvIABhWYciSBTaFPFfb/bxVL8pYLMBb6gTPCYN9fKqg6Tx/o2pTdL
 49O6MZ+kpw00KSnffys1VjDtCxvo9n3iZ2h88PHdcrh9MNMBPMRGgmkxsy0B33Mxh2bA
 XSvj+Bry4itJwr7dU/8uByW+JZP1OpIBWKbZPP5ToO3vqPV2FPuKFQnVNAjWsF5Gfxui
 b9d3QYX+cNDqdKzcV1tGjcKv8dQ7g9kHXkFQlxT8Dy0USJDvdFXJdQI+tCr9DDNREi60 qQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbwkch2ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:16:07 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LF5X16005260;
        Fri, 21 Oct 2022 15:16:06 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3kapd5k1yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:16:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LFG4Ul53608930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 15:16:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B282058061;
        Fri, 21 Oct 2022 15:16:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4B0D58060;
        Fri, 21 Oct 2022 15:16:02 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.163.86])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 15:16:02 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] watchdog: aspeed: Add pre-timeout interrupt support
Date:   Fri, 21 Oct 2022 10:15:57 -0500
Message-Id: <20221021151559.781983-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MU2WAMRpGcP35ziyzqYqOl3ikXu_gv7o
X-Proofpoint-ORIG-GUID: MU2WAMRpGcP35ziyzqYqOl3ikXu_gv7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=915 bulkscore=0
 mlxscore=0 clxscore=1011 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the pre-timeout interrupt if requested by device property, and
document that property.

Eddie James (2):
  watchdog: aspeed: Add pre-timeout interrupt support
  dt-bindings: watchdog: aspeed: Document aspeed,pre-timeout-irq-us

 .../bindings/watchdog/aspeed-wdt.txt          |  7 ++-
 drivers/watchdog/aspeed_wdt.c                 | 53 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.31.1

