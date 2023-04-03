Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CBD6D4C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjDCPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjDCPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:45:08 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7514930E2;
        Mon,  3 Apr 2023 08:45:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333F1Aiu029177;
        Mon, 3 Apr 2023 11:44:34 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pphh8abk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 11:44:33 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 333FiWaw052626
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 11:44:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Apr 2023
 11:44:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Apr 2023 11:44:30 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.17])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 333Fi2OP024018;
        Mon, 3 Apr 2023 11:44:09 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Date:   Mon, 3 Apr 2023 18:43:40 +0300
Message-ID: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Mwd0nkCv0IeITyhyo_cMXgwVbK952C8i
X-Proofpoint-ORIG-GUID: Mwd0nkCv0IeITyhyo_cMXgwVbK952C8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_12,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=535
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030114
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog:
since v5:
  - dt-binding: add enum value "2" to aux-voltage-chargable
  - dt-binding: remove adi,trickle-diode-enable
  - dt-binding: change description of trickle-resistor-ohms
  - dt-binding: reorder as in example schema
  - parse "wakeup-source" when irq not requested
  - remove limitation on max31328 irq and clokout
  - remove error and warning messages during trickle charger setup

since v4:
  - dt-binding: remove interrupt names.
  - dt-binding: add description for "interrupts" property
  - dt-binding: replace deprecated property "trickle-diode-disable"
      by "aux-voltage-chargeable"
  - dt-binding: add new property "adi,trickle-diode-enable"
  - dt-binding: remove "wakeup-source"
  - use clear_bit instead of __clear_bit
  - use devm_of_clk_add_hw_provider instead of of_clk_add_provider
  - use chip_desc pointer as driver data instead of enum.

since v3:
  - add "break" to fix warning: unannotated fall-through 
    Reported-by: kernel test robot <lkp@intel.com>

since v2:
  - dt-binding: update title and description
  - dt-binding: remove last example
  - drop watchdog support
  - support reading 12Hr format instead of forcing 24hr at probe time
  - use "tm_year % 100" instead of range check
  - refactor max313xx_init for readability

Ibrahim Tilki (2):
  drivers: rtc: add max313xx series rtc driver
  dt-bindings: rtc: add max313xx RTCs

 .../devicetree/bindings/rtc/adi,max313xx.yaml |  144 +++
 drivers/rtc/Kconfig                           |   11 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-max313xx.c                    | 1053 +++++++++++++++++
 4 files changed, 1209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
 create mode 100644 drivers/rtc/rtc-max313xx.c

-- 
2.25.1

