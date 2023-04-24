Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497F6ECA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDXKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:50:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD1919A;
        Mon, 24 Apr 2023 03:50:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OAoFBX106953;
        Mon, 24 Apr 2023 05:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682333415;
        bh=nN8VYG0CcZuH7mcRdjGhmPU9mLRfs9U98nGSCM4YgbU=;
        h=From:To:CC:Subject:Date;
        b=QgCE2jhMpdfo5D82LAo0/ubwLs4718mQMtJgPjS+DE6mHUoBbcZzJAH9AOK5VSiwK
         HHK/EIOcpT+zSEXxH+6y+QIzx1NDDm/LTghBWYFcUUsotYh22JASdsRWktL982mglM
         LWmhlki3lfGHeQo6xeHiFaue0zOcoET+HXvAjje0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OAoFM4039323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 05:50:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 05:50:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 05:50:15 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OAoBPD004376;
        Mon, 24 Apr 2023 05:50:12 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <kristo@kernel.org>
Subject: [PATCH RESEND v3 0/3] Add support for ESM
Date:   Mon, 24 Apr 2023 16:20:08 +0530
Message-ID: <20230424105011.70674-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as no major changes, commit subject change only.

ESM (Error Signaling Module) is a fundamental IP responsible for
handling safety events. The driver currently present in U-Boot is
responsible for configuring ESM. This patch series adds dt-binding and
nodes for J721E and J7200. This goes towards end goal of having DTB sync
with that of U-Boot as well as ensuring completeness of hardware
description in devicetree.

Neha Malcom Francis (3):
  dt-bindings: hwmon: esm: Add ESM support for TI K3 devices
  arm64: dts: ti: k3-j721e: Add ESM support
  arm64: dts: ti: k3-j7200: Add ESM support

 .../bindings/hwmon/ti,j721e-esm.yaml          | 53 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
 4 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml

-- 
2.34.1

