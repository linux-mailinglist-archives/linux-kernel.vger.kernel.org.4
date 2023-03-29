Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862376CD21E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjC2Ghq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjC2Ghp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:37:45 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA02D41;
        Tue, 28 Mar 2023 23:37:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T6bWmo002971;
        Wed, 29 Mar 2023 01:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680071852;
        bh=JaqVzim8YoWLEFR2NPS/Rdg1/HdxYbI+L0g0r6+YrDI=;
        h=From:To:Subject:Date;
        b=TBewCgllMCcjvdfdpLoZ9Zlv/fHVWDQENtSjNI+Qgil3NF8FmiM6VUODlP6vRiuJS
         aYiXTP9H2BaBXH+qfrW3LUSvl8fEk3vuK815cBE0/KbJw1h23BU6dw3DdkaSZDSCHE
         VWQfvHQ1D/jTREDvGyUNnWrtU9TQ3JqrrJPmVCSs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T6bWO5080868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 01:37:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 01:37:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 01:37:32 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T6bTgk072630;
        Wed, 29 Mar 2023 01:37:30 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j72xx-main: Switch MAIN R5F clusters to Split-mode
Date:   Wed, 29 Mar 2023 12:07:26 +0530
Message-ID: <20230329063728.14126-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E and J7200 SoCs have two R5F clusters in the MAIN domain, and both
of these are configured for LockStep mode at the moment. Switch both of
these R5F clusters to Split mode by default to maximize the number of
R5F cores. The MCU R5F cluster continues to be in the preferred LockStep
mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for early-
booted remoteprocs through the corresponding IPC-only support in the K3
R5F remoteproc driver.

Suman Anna (2):
  arm64: dts: ti: k3-j721e-main: Switch MAIN R5F clusters to Split-mode
  arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

