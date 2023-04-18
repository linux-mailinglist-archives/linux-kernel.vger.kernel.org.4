Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2106E6852
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDRPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjDRPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C47146C1;
        Tue, 18 Apr 2023 08:32:17 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEwHbH003070;
        Tue, 18 Apr 2023 15:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=gNqosOg24PM4UxT4OZVIS4Pu6MOFBOrsEePLjXVlfzs=;
 b=aADRojhy1CmFqg7E8iP5GRiukGDVxEiEB8qTSIMT9njN61u6V9b7Rp4WB5ZGuh1s1FVC
 skUT8U0Ghjxik+3emBXyW/RgaRBjSmhH+4Kj+OPs88qKT7vslBWY3tkgx9HKMDesd46m
 4aT7eYQSZf7iJMxxFzS5pz4JfgvKhrqv9Uh7bpS0D9mLwmHk9PTQvTjOfX3azI3Rr3yn
 1OhnMIv/ezZW/uLSHKKqoss/rIxQZMcjowM9y+wN4NdPbDsXVuNgbN83+F97EWD+NT2S
 dRWMKHB3xS/z9+5m09VQ3WDyjMj0dwGfm+Weor58ADuHyiQezghFiQdyzeaqIR3WPu/Q 8w== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3q1wdw0b8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:35 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 58087804797;
        Tue, 18 Apr 2023 15:31:35 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1C322816D3A;
        Tue, 18 Apr 2023 15:31:34 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/9] ARM: Add GPIO and PSU Support
Date:   Tue, 18 Apr 2023 10:28:15 -0500
Message-Id: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: fw0a7pAlRw6CszdlX-kuU8qx3SuaT6MP
X-Proofpoint-GUID: fw0a7pAlRw6CszdlX-kuU8qx3SuaT6MP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 mlxlogscore=845 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP has multiple interfaces that provide I/O to it. There is GPIO
coming from the host and from the cpld. Both of these interfaces are
interruptable.

The GXP is able to monitor PSU's via I2C. There is support for up to 8
PSUs. The GXP gets presence information from I/O with the cpld.

The fan controller and the psu monitor consume I/O from the CPLD.
Thus for the GXP to be able to report this GPIO to the OpenBMC stack
calls have been enabled for the GPIO driver to use.

Nick Hawkins (9):
  gpio: gxp: Add HPE GXP GPIO
  hwmon: (gxp_fan_ctrl) Give GPIO access to fan data
  hwmon: (gxp-psu) Add driver to read HPE PSUs
  dt-bindings: hwmon: Modify hpe,gxp-fan-ctrl
  dt-bindings: gpio: Add HPE GXP GPIO
  dt-bindings: hwmon: Add HPE GXP PSU Support
  ARM: dts: gxp: add psu, i2c, gpio
  ARM: multi_v7_defconfig: Add PSU, GPIO, and I2C
  MAINTAINERS: hpe: Add GPIO, PSU

 .../bindings/gpio/hpe,gxp-gpio.yaml           |  137 +++
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |    6 +-
 .../bindings/hwmon/hpe,gxp-psu.yaml           |   45 +
 MAINTAINERS                                   |    4 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  161 +++
 arch/arm/boot/dts/hpe-gxp.dtsi                |  197 ++-
 arch/arm/configs/multi_v7_defconfig           |    5 +-
 drivers/gpio/Kconfig                          |    9 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-gxp.c                       | 1056 +++++++++++++++++
 drivers/hwmon/Kconfig                         |   10 +
 drivers/hwmon/Makefile                        |    1 +
 drivers/hwmon/gxp-fan-ctrl.c                  |   58 +-
 drivers/hwmon/gxp-psu.c                       |  773 ++++++++++++
 14 files changed, 2404 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
 create mode 100644 drivers/gpio/gpio-gxp.c
 create mode 100644 drivers/hwmon/gxp-psu.c

-- 
2.17.1

