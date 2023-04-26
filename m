Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477776EF487
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjDZMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjDZMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:43:32 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EE26B8;
        Wed, 26 Apr 2023 05:42:59 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QC3sHE030568;
        Wed, 26 Apr 2023 08:41:54 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3q69tgstkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 08:41:54 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 33QCfrH9055259
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 08:41:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 26 Apr
 2023 08:41:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Apr 2023 08:41:52 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33QCfabG007637;
        Wed, 26 Apr 2023 08:41:39 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 0/2] Hwmon driver for MAX31827 temperature switch
Date:   Wed, 26 Apr 2023 15:40:44 +0300
Message-ID: <20230426124049.258359-1-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3KyfBKNOltwzu48e15GFaiydW99z2GYF
X-Proofpoint-ORIG-GUID: 3KyfBKNOltwzu48e15GFaiydW99z2GYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=714 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260113
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed of_match_table and kept only id_table. Removed other device id's
from id_table (I have them only in the devicetree-binding).

Added mutex protection where it was needed.

Daniel Matyas (2):
  dt-bindings: hwmon: add MAX31827
  hwmon: max31827: add MAX31827 driver

 .../bindings/hwmon/adi,max31827.yaml          |  54 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/max31827.rst              |  83 ++++
 MAINTAINERS                                   |   9 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   2 +-
 drivers/hwmon/max31827.c                      | 406 ++++++++++++++++++
 7 files changed, 565 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
 create mode 100644 Documentation/hwmon/max31827.rst
 create mode 100644 drivers/hwmon/max31827.c

-- 
2.34.1

