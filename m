Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6571862A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjEaPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEaPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:23:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5D125;
        Wed, 31 May 2023 08:23:37 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VC585l023966;
        Wed, 31 May 2023 15:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version; s=pps0720;
 bh=aQNfR11sepJZ8RJU6OqmdsnQ5GGzoMBtZGXeR4nlGPQ=;
 b=ifcBknaEurwCmibJPC3hKdfdES6JjHdhcHfGXNFG/spPTEXeTImmA0tEt0NB1UQ5FkB3
 c4+MAGfWvF/kCjSXJ/HzWP7bzvUwGLbVT4xQMApJzrYCgrAyEIoax1FkG6fUx8lLM5CW
 C2VDruIxc8EeQsqPow9VTVe+nKG+9KtVld09AfANVngTjTFqn7LWwYuH35KmXbczQlVn
 52MH3le4bUwvw4S7ZcIw1ObldGmnYZn2+9nOcoSptEnzIqyWa6sEozAQsG+yG7Y8zS83
 0aOYpfpPlwjy8cJVDmVlQ39YCCkxIr3csURJQli3JlUMLiWHAnJXqCOnzqZCPmbAIqKS xg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qx5x3hr3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:23:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 30DB914783;
        Wed, 31 May 2023 15:23:12 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2438780B983;
        Wed, 31 May 2023 15:23:11 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 0/5] ARM: Add GPIO support
Date:   Wed, 31 May 2023 10:19:13 -0500
Message-Id: <20230531151918.105223-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: 6N2YKcgA2-IR7JYMnVMzyGtSvh7dFV9W
X-Proofpoint-GUID: 6N2YKcgA2-IR7JYMnVMzyGtSvh7dFV9W
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310130
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Note: The previous version of this patchset was titled "Add GPIO and PSU
support". Based on feedback and in an effort to reduce size PSU has been
removed. Link:
https://lore.kernel.org/all/20230418152824.110823-1-nick.hawkins@hpe.com/

The GXP SoC supports GPIO on multiple interfaces. The interfaces are
CPLD and Host. The GPIOs is a combination of both physical and virtual
I/O across the interfaces. The gpio-gxp driver specifically covers the
CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The
gpio-gxp-pl driver covers the CPLD which takes physical I/O from the
board and shares it with GXP via a propriety interface that maps the I/O
onto a specific register area of the GXP. The drivers both support
interrupts but from different interrupt parents.

There is a need for both the host OpenBMC and the gxp-fan-ctrl driver to
access the same GPIO information from the CPLD. The OpenBMC stack is
reacting to changes in GPIOs and taking action. This requires it to hold
the GPIO which creates a problem where both the host and linux cannot
have the same GPIO. Thus an attempt to remedy this was to add a shared
variable between the GPIO driver and the fan control driver to provide
fan presence and failure information. This is why hwmon has been included
in this patchset.

---

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
  dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2 and pl regs
  hwmon: (gxp_fan_ctrl) Provide fan info via gpio
  MAINTAINERS: hpe: Add GPIO

 .../bindings/gpio/hpe,gxp-gpio.yaml           | 190 ++++++
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |  16 +-
 MAINTAINERS                                   |   2 +
 drivers/gpio/Kconfig                          |  18 +
 drivers/gpio/Makefile                         |   2 +
 drivers/gpio/gpio-gxp-pl.c                    | 536 +++++++++++++++
 drivers/gpio/gpio-gxp.c                       | 637 ++++++++++++++++++
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/hwmon/gxp-fan-ctrl.c                  |  61 +-
 drivers/hwmon/gxp-gpio.h                      |  13 +
 10 files changed, 1409 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 create mode 100644 drivers/gpio/gpio-gxp-pl.c
 create mode 100644 drivers/gpio/gpio-gxp.c
 create mode 100644 drivers/hwmon/gxp-gpio.h

-- 
2.17.1

