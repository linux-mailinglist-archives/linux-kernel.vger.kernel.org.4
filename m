Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705BF63B585
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiK1XE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiK1XEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:04:25 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678612B249;
        Mon, 28 Nov 2022 15:04:24 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASMCR1k017358;
        Mon, 28 Nov 2022 23:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=KfcFH3MOy6fuzSNAw8UyiHiM41rjSKFf8+hOai5NNV4=;
 b=Dq0Zb0m+zWg7bSkvXYk51y3nJNSWXjT9sEZz0jbxedgBK7HKFkxYb7P9HC1edvi7/kMm
 cwwWmRvCtN6CIW9f4oHzpRMDjrRCbD9DIYOEuz1Ec77DTvxjUcKuH0O2BFx6NA7wMuaw
 N9Z8Ku4el4seR7c2qgmY5GPT4HTxgKR6WslUt33bgHR++lYPBS1VBoN7z9oZlLKBvnvF
 KNbaUayVQN2p+QQezQqQax5/m4RIsC09T9wHQyC0VNfwN0HOAjxvYqLYFLlUY7AEBJdI
 M5jCNaGhHgKeW0Iofm9pDokJNdKfZPwuFjA1M7AdoqKAxDsDCkhi93NTJQHiiSEkZE5f +w== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m4x6av7pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:03:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id DD7B0806B7E;
        Mon, 28 Nov 2022 23:03:47 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9181D806133;
        Mon, 28 Nov 2022 23:03:46 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] ARM: Add GXP Fan and SPI controllers
Date:   Mon, 28 Nov 2022 17:02:13 -0600
Message-Id: <20221128230219.39537-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: 2rkTC8pkTepI9rsMCROewBBMLXnSj-Y5
X-Proofpoint-ORIG-GUID: 2rkTC8pkTepI9rsMCROewBBMLXnSj-Y5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC can support up to 16 fans through the interface provided by
the CPLD. The fans speeds are controlled via a pwm value 0-255. The fans
are also capable of reporting if they have failed to the CPLD which in
turn reports the status to the GXP SoC. Based on previous feedback the
registers required for fan control have been regmaped individualy to fan
driver. Specifically these registers are the function 2 registers and the
programmable logic registers from the CPLD. Additionally in this patchset
there is support for the SPI driver which already exists as spi-gxp.c in
the SPI driver.

---

Changes since v1:

*Renamed fn2reg to fn2 in dtsi file and documentation
*Renamed plreg to pl in dtsi file and documentation
*Renamed fanctrl to fan-controller in dtsi file and documentation
*Adjusted base register range for fan ctrl in dtsi
*Changed commit description on fan-ctrl device-tree binding
*Changed register description on fan-ctrl device-tree binding
*Changed number of supported fans from 16 to 8 in driver code and
 documentation
*Modified commit description of fan code
*Removed support for fan[0-15]_input
*Removed PWM defines in driver code
*Added gxp-fan-ctrl to hwmon's index.rst
*Removed mutex in driver code
*Added fan_enable support in fan code and documentation
*Fixed comment in driver code presents -> present
*Removed unecessary include files in fan code
*Added comments to describe what power state is and
 calculations for accessing plreg in fan code
*Removed use of variable offsets in fan code
*Fixed GPL header in fan code
*Changed module description for fan controller
*Added kfree in case of failure to initialize driver
*Added missing yaml file to MAINTAINERS

Nick Hawkins (6):
  hwmon: (gxp-fan-ctrl) Add GXP fan controller
  ABI: sysfs-class-hwmon: add a description for fanY_fault
  dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
  ARM: dts: add GXP Support for fans and SPI
  ARM: multi_v7_defconfig: Add GXP Fan and SPI support
  MAINTAINERS: add gxp fan controller and documents

 Documentation/ABI/testing/sysfs-class-hwmon   |   9 +
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |  41 +++
 Documentation/hwmon/gxp-fan-ctrl.rst          |  28 ++
 Documentation/hwmon/index.rst                 |   1 +
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  58 ++++
 arch/arm/boot/dts/hpe-gxp.dtsi                |  64 ++--
 arch/arm/configs/multi_v7_defconfig           |   2 +
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/gxp-fan-ctrl.c                  | 305 ++++++++++++++++++
 11 files changed, 502 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
 create mode 100644 drivers/hwmon/gxp-fan-ctrl.c

-- 
2.17.1

