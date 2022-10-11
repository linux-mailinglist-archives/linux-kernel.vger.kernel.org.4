Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339A5FBAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJKS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJKS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:28 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3880BE9;
        Tue, 11 Oct 2022 11:56:27 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BHNtK7000518;
        Tue, 11 Oct 2022 18:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=2xXCj9pupcZ+eq8rcJhUB7SjmJADAHy3fewK97q3xic=;
 b=lXFVnIYfcCd3nwoEkKyVr4kQ1tYHDYZPGgezrljIaOSux0N5DSTOtuq+6LaBidsJMKg1
 q/vzYCDJHf6pssHeEPHURPDJy3j9POgHYGzb5BJXm+Xk2TShCpeSFpIGn8s2BprvKuZz
 Z9RFRBdcib6vJGE9bmrWO7RnVq/PSvl4Rtx62mhT7ZjHBHfvaKl5B82UxocIPdCMOdM6
 75wiihcBPqeFK1z5ArahBVNY9UI1WqGK+dpOho/gf53hvt0zHx+gpCEy0sP8WMfyVfIN
 rjTHq0ud3rp8IZJVqQYZNyRFimzVj7LX15t2SId52wa/klC4ypaQB6cIMwfmKlO81K/l Fg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k5cd4gvkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:01 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A33BAD25E;
        Tue, 11 Oct 2022 18:56:00 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E689580873C;
        Tue, 11 Oct 2022 18:55:59 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/5] Add PLREG and SPI Driver GXP Support
Date:   Tue, 11 Oct 2022 13:55:20 -0500
Message-Id: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: gHh7P8wiBi4bMmCE8x7PkeHT3OUR5IZ0
X-Proofpoint-ORIG-GUID: gHh7P8wiBi4bMmCE8x7PkeHT3OUR5IZ0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC is interfaced with a programmable logic device that takes
inputs/outputs from the server board. All these inputs/outputs are
presented in register form to the SoC. The Programmable Logic
Register driver enables access to these registers and provides a
standard way to provide access across the HPE portfolio. Additionally
this patchset also enables the SPI driver that already exists in linux
in the spi driver as spi-gxp file

Nick Hawkins (5):
  soc: hpe: add support for HPE GXP Programmable Register Driver
  dt-bindings: soc: hpe: Add hpe,gxp-plreg
  ARM: dts: hpe: Add PLREG/SPI Support
  ARM: multi_v7_defconfig: Enable GXP SPI and PLREG Drivers
  MAINTAINERS: Add HPE SOC Drivers

 .../bindings/soc/hpe/hpe,gxp-plreg.yaml       |   43 +
 MAINTAINERS                                   |    3 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  275 ++++
 arch/arm/boot/dts/hpe-gxp.dtsi                |   28 +-
 arch/arm/configs/multi_v7_defconfig           |    2 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/hpe/Kconfig                       |   19 +
 drivers/soc/hpe/Makefile                      |    7 +
 drivers/soc/hpe/gxp-plreg.c                   | 1207 +++++++++++++++++
 drivers/soc/hpe/gxp-soclib.c                  |   19 +
 drivers/soc/hpe/gxp-soclib.h                  |   15 +
 include/linux/soc/hpe/gxp.h                   |   15 +
 13 files changed, 1634 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
 create mode 100644 drivers/soc/hpe/Kconfig
 create mode 100644 drivers/soc/hpe/Makefile
 create mode 100644 drivers/soc/hpe/gxp-plreg.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.h
 create mode 100644 include/linux/soc/hpe/gxp.h

-- 
2.17.1

