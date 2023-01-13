Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F2669D64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAMQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAMQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:15:33 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849138CBFA;
        Fri, 13 Jan 2023 08:09:29 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFhMu3007323;
        Fri, 13 Jan 2023 16:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=GElG5resOz76T4nov208JdcKStrWjNR88nmRJofSfUo=;
 b=kBz4LQozstb4bQ9GfTcnFoANFJey9LmpK8NMA/2sVq90Cw/X1qKOWtl3jf21WAe5ICqB
 JvyCLpWPFwug4BTo6mccuqs2o2BSv/TxoffHJ9pK+XtzJZ0VME3lkg/iKHdgtdlCGZlh
 xtF1VDAzecUMWlmsbA8LDH6NIIg3vWpvLVdeN1LFyDATJNbhT3hq8rEkgIg3Cffetx/t
 j+En0A30e/eF2lFm+oX5MXZFAmvTCa7SB7mYJZx6NTuIGwIgYdCwLIf5F/y+IzeGgO4X
 l4xPZj8FQzMU+vBoFGzCYc/hCaS5oGjoVzQcq9qQ91kJqb2xwfMENEHJFqkwQOwD5Qyi nQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n3a66g85t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:08:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6873ED6C77;
        Fri, 13 Jan 2023 16:08:53 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 4938480CCD0;
        Fri, 13 Jan 2023 16:08:51 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux@roeck-us.net, verdun@hpe.com,
        nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/2] ARM: Add GXP Fan and SPI controllers
Date:   Fri, 13 Jan 2023 10:06:49 -0600
Message-Id: <20230113160651.51201-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: 0h03e_zySHG0YuVa7jqLEKqF9yN5JkcU
X-Proofpoint-ORIG-GUID: 0h03e_zySHG0YuVa7jqLEKqF9yN5JkcU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301130108
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

Changes since v4:
 *Removed patch for yaml and driver as they have been applied to
  hwmon-next
 *Fixed issues with range issue with dtsi file and removed
  comments

Changes since v3:
 *Removed patch for ABI documentation of sysfs-class-hwmon as it
  was applied
 *Removed unecessary HWMON_PWM_ENABLE usage

Changes since v2:
 *Removed use of regmap in favor of __iomem
 *Updated description on yaml documentation
 *Simplified commit description on sysfs-class-hwmon
 *Removed use of dev and hwmon_dev from drvdata structure
 *Fixed missing breaks in switch statements
 *Added check for pwm values less than 0
 *Removed regmap and slab header file includes

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

Nick Hawkins (2):
  ARM: dts: add GXP Support for fans and SPI
  ARM: multi_v7_defconfig: Add GXP Fan and SPI support

 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 58 +++++++++++++++++++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 64 +++++++++++++++++-------
 arch/arm/configs/multi_v7_defconfig      |  2 +
 3 files changed, 105 insertions(+), 19 deletions(-)

-- 
2.17.1

