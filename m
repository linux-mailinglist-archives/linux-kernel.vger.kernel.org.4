Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84599663826
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAJE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAJEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:25:59 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590163F5;
        Mon,  9 Jan 2023 20:25:58 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A422L4003370;
        Tue, 10 Jan 2023 04:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=oADZAnV3rWFTc+Si9n98UlfL8xVyj92lEDEZZ5a7VMA=;
 b=aL3sfE+65Slgrh1DXrSx8EOf4Y2vQAWdw5Yxfx1l3BBguo4y+d2avFHJS9QwgXPkWdnu
 wKHegh8YhKYlbrbl7kGxR8vhY8pNJp1xV2lIc439pUua4m94x/OFDxMkG1Huo7fWU8gr
 UVOgc137wQuQ18G4/u19DvD705sWW62uDhseWZp5NSugObPv+XhGKvtHsHPPhRUzDW5r
 a9nDMqHXMpu0zyCQzusQkjwagPnApUWWzZ1dtATbZfXAnrWYT2qwpD/Guip9XyptDPhT
 +/Zk4j+czsTmjPXB5y4Y2oJjdgmHnv9pj6rYsPnjgOrXI3DVh5kTY0GC+tDVXBrIhzND TQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n103ng8tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:25:42 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4A8BE807EF3;
        Tue, 10 Jan 2023 04:25:41 +0000 (UTC)
Received: from openbmc-dev.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 07C9C800BB1;
        Tue, 10 Jan 2023 04:25:36 +0000 (UTC)
From:   clayc@hpe.com
To:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
Cc:     Clay Chang <clayc@hpe.com>
Subject: [PATCH 0/5] ARM: Add GXP SROM Support
Date:   Tue, 10 Jan 2023 12:25:28 +0800
Message-Id: <20230110042533.12894-1-clayc@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: HrmQPcT41TpapgC6vSRun4wFEpOITVcX
X-Proofpoint-ORIG-GUID: HrmQPcT41TpapgC6vSRun4wFEpOITVcX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 mlxlogscore=613 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clay Chang <clayc@hpe.com>

The GXP SROM control register can be used to configure LPC related
legacy I/O registers. Currently only the SROM RAM Offset Register
(vromoff) is exported.

Clay Chang (5):
  soc: hpe: Add GXP SROM Control Register Driver
  dt-bindings: soc: hpe: hpe,gxp-srom.yaml
  ARM: dts: hpe: Add SROM Driver
  ARM: multi_v7_defconfig: Add GXP SROM Driver
  MAINTAINERS: Add maintainer of GXP SROM support

 .../bindings/soc/hpe/hpe,gxp-srom.yaml        |  36 +++++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/hpe-gxp.dtsi                |  41 ++---
 arch/arm/configs/multi_v7_defconfig           |   2 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/hpe/Kconfig                       |  29 ++++
 drivers/soc/hpe/Makefile                      |   2 +
 drivers/soc/hpe/gxp-soclib.c                  |  17 +++
 drivers/soc/hpe/gxp-soclib.h                  |   9 ++
 drivers/soc/hpe/gxp-srom.c                    | 141 ++++++++++++++++++
 11 files changed, 269 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
 create mode 100644 drivers/soc/hpe/Kconfig
 create mode 100644 drivers/soc/hpe/Makefile
 create mode 100644 drivers/soc/hpe/gxp-soclib.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.h
 create mode 100644 drivers/soc/hpe/gxp-srom.c

-- 
2.17.1

