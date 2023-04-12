Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802AA6DFA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDLPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDLPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:35:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D359D3;
        Wed, 12 Apr 2023 08:35:11 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CDuwAP011904;
        Wed, 12 Apr 2023 11:34:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu5687k7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 11:34:17 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 33CFYE0B017828
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 11:34:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Apr
 2023 11:34:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Apr 2023 11:34:13 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33CFXucv019897;
        Wed, 12 Apr 2023 11:33:58 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/2] Hwmon driver for MAX31827 temperature switch
Date:   Wed, 12 Apr 2023 18:33:30 +0300
Message-ID: <20230412153334.181852-1-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ytevDmHDrQgOkN9R7dUEIKcEiH-2py2b
X-Proofpoint-ORIG-GUID: ytevDmHDrQgOkN9R7dUEIKcEiH-2py2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120137
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new functionalities: max_alarm, min_alarm and update_interval.

Modified enable attribute: it switches between 1Hz periodic conversions
and shutdown mode.

When requesting a temperature read in shutdown mode 1shot is triggered,
the driver waits until the conversion is completed and then displays the
read value.

Added new write_alarm_val function which puts the device in shutdown
mode, modifies the value of an alarm attribute and the reenables the
device with the previous configurations. I used more bitwise operations
in this functions instead of regmap_update_bits, because this way only 2
write and 2 read operations are performed. With regmap_update_bits 3
write operations and 2 read operations would be performed.

Added support for the other 2 chips from the datasheet: max31828,
max31829.

Added documentation for the driver. 

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max31827-max31829.pdf

*** BLURB HERE ***

Daniel Matyas (2):
  dt-bindings: hwmon: add MAX31827
  hwmon: max31827: add MAX31827 driver

 .../bindings/hwmon/adi,max31827.yaml          |  51 +++
 Documentation/hwmon/max31827.rst              |  88 +++++
 MAINTAINERS                                   |   9 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/max31827.c                      | 324 ++++++++++++++++++
 6 files changed, 484 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
 create mode 100644 Documentation/hwmon/max31827.rst
 create mode 100644 drivers/hwmon/max31827.c

-- 
2.34.1

