Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C673748E52
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjGETub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjGETuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E617121;
        Wed,  5 Jul 2023 12:50:12 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365GsBDP028057;
        Wed, 5 Jul 2023 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=2TZ7uWy+KV2H+l6ExuqmbxwHBn84OisbQ+LUXCERh7E=;
 b=S51fsHBgKxibwrnifbcQzN2WRS7KkID5Pq4PV/hUen/ZeVsl/o4p2fQ20oCcOikTcBg+
 VysStpbHr3ZFgtJj+qGYW2HVNrCBnIQBUQ0cNe0KMST9F6aGzOhKCbBtt74YhCTVDFsz
 9/GZWEy63G0JReltp09LFmPrbJrQyKbKVv2xMXafgjFOlq/IGP+6AazezDG0ByqtwRmu
 esjPOvS5IQdTaRSyYPOqZmENJazWJFiaF7SyO2rX7ktn0RUXma8Kd96dqH0HjJHMMKmG
 Bfth5tkDA9qb/4DizJZFr5xtOWx9ozs3kQrSvFzaBWwtvAFISrUSMbYqwOfY6dXk0/JX Lw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rn93utu08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:49:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9CCBC804DF3;
        Wed,  5 Jul 2023 19:49:43 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2C0F28081E4;
        Wed,  5 Jul 2023 19:49:42 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5 0/5] ARM: Add GPIO support
Date:   Wed,  5 Jul 2023 14:45:39 -0500
Message-Id: <20230705194544.100370-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: 6x1Osdyk7klH7nzwkV0PSvzArQMoD4SW
X-Proofpoint-GUID: 6x1Osdyk7klH7nzwkV0PSvzArQMoD4SW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050180
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
CPLD and Host. The GPIOs are a combination of both physical and virtual
I/O across the interfaces. The gpio-gxp-pl driver covers the CPLD which
takes physical I/O from the board and shares it with GXP via a proprietary
interface that maps the I/O onto a specific register area of the GXP.
The CPLD interface supports interrupts.

Notes:

Based on previous feedback the gpio-gxp.c driver has been discarded in
favor of it going into a separate larger patchset. This leaves behind
only the gpio-gxp-pl.c driver.

After exploring the recommendation of using regmap_gpio it does not seem
like a good fit. Some of the GPIOs are a combination of several bits in
a byte where others are not contiguous blocks of GPIOs.

The gxp-fan-ctrl driver in HWMON no longer will report fan presence
or fan failure states as these GPIOs providing this information will be
consumed by the host. It will be the hosts function to keep track of
fan presence and status. There was an excellent suggestion to have linux
handle the entire thermal management of the system however the HPE
OpenBMC developers prefer to handle this inside OpenBMC stack instead.

---

Changes since v4:
 *Removed gpio-gxp.c patch as it requires a much larger patchset based
  on feedback.
 *Modified MAINTAINERS Removing gpio-gxp.c and adding missing
  gpio-gxp-pl.c
 *Modified hpe,gxp-gpio.yaml by removing hpe,gxp-gpio compatible
  reference for now in favor of adding it later with separate patchset.
 *Modified cover letter to explain that although there is a suggestion
  to have the kernel handle all thermal matters the HPE OpenBMC developers
  prefer to handle it there instead.
 *Modified cover letter to explain gpio-gxp.c removal

Changes since v3:
 *Added called with debugfs to read server id
 *Added reviewed-by: tags to hwmon fan driver and fan yaml
 *Changed maxItems to be 4 instead of 6 on reg and reg-names in gpio
  yaml
 *Moved gpio-gxp-pl.c to be in a separate patch/commit.
 *Moved regmap_config out of function in both gpio drivers to turn into
  static const
 *Removed unnecesary variables and redundant conditionals
 *Modified regmap_read switch statements to calculate offset and mask
  then read at end
 *Removed use of -EOPNOTSUPP in favor of -ENOTSUPP
 *Removed redundant casting
 *Switched generic_handle_irq for generic_handle_domain_irq
 *Used GENMASK where applicable
 *Used bitmap_xor and for_each_bit_set in PL PSU interrupt
 *Made GPIO chip const and marked as a template (in the name)
 *Made irq_chip const and immutable
 *Corrected check on devm_gpiochip_add_data
 *Removed dev_err_probe on platform_get_irq
 *Changed return 0 to devm_request_irq

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
  gpio: gxp: Add HPE GXP GPIO PL
  dt-bindings: hwmon: hpe,gxp-fan-ctrl: remove fn2 and pl registers
  hwmon: (gxp_fan_ctrl) Provide fan info via gpio
  MAINTAINERS: hpe: Add GPIO

 .../bindings/gpio/hpe,gxp-gpio.yaml           |  71 +++
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |  16 +-
 MAINTAINERS                                   |   2 +
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-gxp-pl.c                    | 582 ++++++++++++++++++
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/hwmon/gxp-fan-ctrl.c                  | 106 +---
 8 files changed, 671 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 create mode 100644 drivers/gpio/gpio-gxp-pl.c

-- 
2.17.1

