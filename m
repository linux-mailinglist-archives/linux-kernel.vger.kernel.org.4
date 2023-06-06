Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6897234BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjFFBrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjFFBq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:46:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD05E42;
        Mon,  5 Jun 2023 18:46:48 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355G7PnE024523;
        Tue, 6 Jun 2023 01:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=sT5Ump62rzrD/uxIa3alcH+LZAx0r1TdfOFn9futGw0=;
 b=VEjLfUMBUBMSiAnDdP8LGPi3l4ZKw8jfJk2h+QCZD9Sch16nhKgfzCznzT7OskPYHtHJ
 o+lZot37pI8Y7JM6bF/oMMRHQExg5yGML5s38aahFp/WysmIHYabTwxzApDemayVKT1L
 Yuj+ZHeCwVYjjzsB2i7L/k3iMQkQ0R6Ahznq7hzo39g0yNk0Nmo8SS0XeM9fXXlZvvW/
 8gJZqWRLX6tXUEKghmy0CkdzE2Nqpa4zW8xCQJUPSRYJEoPWCiYRmQUM77cFn8+DJirb
 snhEg2NEAg79O5dmVpL2hJgECX6+ZWSBw+0lNnLOxpLCqk/Q51vl/8JVDJysd4lmCZAH Xg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r1evrnp4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 01:46:30 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 4EB6714782;
        Tue,  6 Jun 2023 01:46:30 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 34690809E78;
        Tue,  6 Jun 2023 01:46:29 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 0/5] ARM: Add GPIO support
Date:   Mon,  5 Jun 2023 20:42:29 -0500
Message-Id: <20230606014234.29491-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: wNj3KVuyHjTkOqwTulyJZLfGtC4nehZB
X-Proofpoint-ORIG-GUID: wNj3KVuyHjTkOqwTulyJZLfGtC4nehZB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=935
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC supports GPIO on multiple interfaces. The interfaces are
CPLD and Host. The GPIOs is a combination of both physical and virtual
I/O across the interfaces. The gpio-gxp driver specifically covers the
CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The
gpio-gxp-pl driver covers the CPLD which takes physical I/O from the
board and shares it with GXP via a propriety interface that maps the I/O
onto a specific register area of the GXP. The drivers both support
interrupts but from different interrupt parents.

The gxp-fan-ctrl driver in HWMON no longer will report fan presence
or fan failure states as these GPIOs providing this information will be
consumed by the host. It will be the hosts function to keep track of
fan presence and status.

---
Changes since v2:
 *Removed shared fan variables between HWMON and GPIO based on feedback
 *Removed reporting fan presence and failure from hwmon gxp-fan-ctrl
  driver
 *Removed GPIO dependency from gxp-fan-ctrl driver
 *Changed description and title for hpe,gxp-gpio binding
 *Corrected indention on example for hpe,gxp-gpio binding
 *Removed additional example from hpe,gxp-gpio binding
 
Changes since v1:
 *Removed ARM device tree changes and defconfig changes to reduce
  patchset size
 *Removed GXP PSU changes to reduce patchset size
 *Corrected hpe,gxp-gpio YAML file based on feedback
 *Created new gpio-gxp-pl file to reduce complexity
 *Separated code into two files to keep size down: gpio-gxp.c and
  gpio-gxp-pl.c
 *Fixed Kconfig indentation as well as add new entry for gpio-gxp-pl
 *Removed use of linux/of.h and linux/of_device.h
 *Added mod_devicetable.h and property.h
 *Fixed indentation of defines and uses consistent number of digits
 *Corrected defines with improper GPIO_ namespace.
 *For masks now use BIT()
 *Added comment for PLREG offsets
 *Move gpio_chip to be first in structure
 *Calculate offset for high and low byte GPIO reads instead of having
  H(High) and L(Low) letters added to the variables.
 *Removed repeditive use of "? 1 : 0"
 *Switched to handle_bad_irq()
 *Removed improper bailout on gpiochip_add_data
 *Used GENMASK to arm interrupts
 *Removed use of of_match_device
 *fixed sizeof in devm_kzalloc
 *Added COMPILE_TEST to Kconfig
 *Added dev_err_probe where applicable
 *Removed unecessary parent and compatible checks

Nick Hawkins (5):
  dt-bindings: gpio: Add HPE GXP GPIO
  gpio: gxp: Add HPE GXP GPIO
  dt-bindings: hwmon: hpe,gxp-fan-ctrl: remove fn2 and pl registers
  hwmon: (gxp_fan_ctrl) Provide fan info via gpio
  MAINTAINERS: hpe: Add GPIO

 .../bindings/gpio/hpe,gxp-gpio.yaml           | 139 ++++
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |  16 +-
 MAINTAINERS                                   |   2 +
 drivers/gpio/Kconfig                          |  18 +
 drivers/gpio/Makefile                         |   2 +
 drivers/gpio/gpio-gxp-pl.c                    | 519 ++++++++++++++
 drivers/gpio/gpio-gxp.c                       | 637 ++++++++++++++++++
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/hwmon/gxp-fan-ctrl.c                  | 108 +--
 9 files changed, 1324 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 create mode 100644 drivers/gpio/gpio-gxp-pl.c
 create mode 100644 drivers/gpio/gpio-gxp.c

-- 
2.17.1

