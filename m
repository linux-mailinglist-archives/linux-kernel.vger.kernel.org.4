Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E375B47A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIJRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIJRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:20:46 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BD36DF8;
        Sat, 10 Sep 2022 10:20:45 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AC1mZr019483;
        Sat, 10 Sep 2022 13:20:23 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jgme5ar96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 13:20:22 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28AHKL9Z056501
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 10 Sep 2022 13:20:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 10 Sep
 2022 13:20:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 10 Sep 2022 13:20:20 -0400
Received: from ibrahim-vm.scloud.analog.com ([10.158.19.28])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28AHJwcF025933;
        Sat, 10 Sep 2022 13:20:03 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-hwmon@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/4] hwmon: Add max31760 fan speed controller
Date:   Sat, 10 Sep 2022 20:19:41 +0300
Message-ID: <20220910171945.48088-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FHfP-4lNCyiB7swOgA1vJLDRmr6ymAKH
X-Proofpoint-ORIG-GUID: FHfP-4lNCyiB7swOgA1vJLDRmr6ymAKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=961 phishscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209100063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v9:
  - return -EINVAL when writing fan_enable and pwm_enable
  - fix dt-bindings errors

changes in v8:
  - use sizeof(*)
  - use DEFINE_SIMPLE_DEV_PM_OPS
  - remove __maybe_unused
  - remove of_match_ptr
  - dt-bindings: style fixes

changes in v7:
  - make max31760_read_string static

changes in v6:
  - update description of hwmon documentation
  - add hwmon documentation to index.rst

changes in v5:
  - add dt-bindings documentation
  - add maintainer

changes in v4:
  - use sysfs_emit instead of sprintf
  - use kstrtou8 for pwm
  - use closest match for pwm1_auto_point_temp_hyst

changes in v3:
  - add regmap cache
  - remove pwm1_auto_point[1-48]_{temp,temp_hyst} attributes
  - add pwm1_auto_point_temp_hyst attribute

changes in v2:
  - remove pulse_per_rev variable in tach_to_rpm
  - remove temperature max_hyst and crit_hyst
  - strict value checking for fan_enable and pwm_enable
  - do not clamp pwm value for Look-up table
  - add sysfs_attr_init call
  - add documentation


Ibrahim Tilki (4):
  drivers: hwmon: Add max31760 fan speed controller driver
  docs: hwmon: add max31760 documentation
  dt-bindings: hwmon: Add bindings for max31760
  MAINTAINERS: Add maintainer for hwmon/max31760

 .../bindings/hwmon/adi,max31760.yaml          |  42 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/max31760.rst              |  77 +++
 MAINTAINERS                                   |   9 +
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/max31760.c                      | 596 ++++++++++++++++++
 7 files changed, 738 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
 create mode 100644 Documentation/hwmon/max31760.rst
 create mode 100644 drivers/hwmon/max31760.c

-- 
2.36.1

