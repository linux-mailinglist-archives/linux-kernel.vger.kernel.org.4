Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5761A13C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKDTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKDTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:53 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC9F2F;
        Fri,  4 Nov 2022 12:38:43 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Io2a2032674;
        Fri, 4 Nov 2022 19:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=8MxEKOo6LY1pXE6amFKVRRRqYGk9kKOjIJAqfVf3W0s=;
 b=fNdLnqyD2SsPrb/O5i4REVdRbmkqVOoVgnTHwCG7wYaZiwACMCcDfDjQETwpGaas8wwE
 XR7yBqjwG424Woxn0g9r/M3qwVpH4Tb88w1ZhhhufEPbwSZtSh1wd21uu3awoOxlJbuQ
 xXO+XtbWrJgJdP5Fs5+Z82NYF01KCb9UehnMiJbkVFYGVevODPd4bQPe6Z7tBXgUdw/i
 BMdWYyOCQ5BKW24XjwwPWArJ76Ws8HNfnzcf7J0qu2ANGVayFa06MMQMITn5kG89HAoq
 p16cVvRqLKesjQu2vdYzK32DfG47JXtnGAC0h7J4vXFVX/JmSLTsqkPuCMcW2g09+WtN Hg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kn8bv08sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 32B42295A9;
        Fri,  4 Nov 2022 19:38:09 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 04B3D8089A5;
        Fri,  4 Nov 2022 19:38:07 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/6] ARM: Add GXP Fan and SPI controllers
Date:   Fri,  4 Nov 2022 14:36:51 -0500
Message-Id: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: Vgt_moPJ3UE3OnS6ruEH78KCs5f8W0Ov
X-Proofpoint-GUID: Vgt_moPJ3UE3OnS6ruEH78KCs5f8W0Ov
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Nick Hawkins (6):
  hwmon: (gxp-fan-ctrl) Add GXP fan controller
  ABI: sysfs-class-hwmon: add a description for fanY_fault
  dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
  ARM: dts: add GXP Support for fans and SPI
  ARM: multi_v7_defconfig: Add GXP Fan and SPI support
  MAINTAINERS: add gxp fan controller and documents

 Documentation/ABI/testing/sysfs-class-hwmon   |   9 +
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      |  41 ++
 Documentation/hwmon/gxp-fan-ctrl.rst          |  36 ++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  58 +++
 arch/arm/boot/dts/hpe-gxp.dtsi                |  64 +++-
 arch/arm/configs/multi_v7_defconfig           |   2 +
 drivers/hwmon/Kconfig                         |   8 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/gxp-fan-ctrl.c                  | 362 ++++++++++++++++++
 10 files changed, 564 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
 create mode 100644 drivers/hwmon/gxp-fan-ctrl.c

-- 
2.17.1

