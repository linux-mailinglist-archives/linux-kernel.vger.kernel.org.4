Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012896F66D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjEDIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEDIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:06:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB149CA;
        Thu,  4 May 2023 01:06:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34485Udh087722;
        Thu, 4 May 2023 03:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683187531;
        bh=E+Lx8ZlNsCu0esl7XN9gZb3g6iVSPCuFL5jxIZ3bgEw=;
        h=From:To:CC:Subject:Date;
        b=owgIlxGcKgZxy2ZX8r6sskMiYiuKzQ+v8RzxNFjyDrqPtTHqxiVw+JPtUCFcIU+a7
         +jy9m17/kkOWOZ1QNEPky/hrBPMKwA4egXtRTg62DC2dq/Lj2QHE7OoaA7/Nr2jUSc
         mNU9UHD8m2IIqKXigoeY12HTpaV6ZS1ZDd5JfLes=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34485Uua060579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 03:05:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 03:05:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 03:05:30 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34485R1O090093;
        Thu, 4 May 2023 03:05:27 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v6 0/3] Add support for ESM
Date:   Thu, 4 May 2023 13:35:23 +0530
Message-ID: <20230504080526.133149-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ESM (Error Signaling Module) is a fundamental IP responsible for
handling safety events. The driver currently present in U-Boot is
responsible for configuring ESM. This patch series adds dt-binding and
nodes for J721E and J7200. This goes towards end goal of having DTB sync
with that of U-Boot as well as ensuring completeness of hardware
description in devicetree.

Changes in v6:
	- moved additionalProperties after required in dt-binding

Changes in v5:
	- added esm node to k3-j721e-main.dtsi

Changes in v4:
	- hwmon/ti,j721e-esm.yaml -> misc/ti,j721e-esm.yaml
	- retained tag by Krzysztof for dt-binding

Changes in v3:
	- formatting changes in dt-binding
	- modified example in dt-binding cbass_main -> bus
	- changed subject misc -> hwmon

Changes in v2:
	- misc/esm-k3.yaml -> hwmon/ti,j721e-esm.yaml
	- formatting changes in dt-binding
	- modified example in dt-binding

Neha Malcom Francis (3):
  dt-bindings: misc: esm: Add ESM support for TI K3 devices
  arm64: dts: ti: k3-j721e: Add ESM support
  arm64: dts: ti: k3-j7200: Add ESM support

 .../bindings/misc/ti,j721e-esm.yaml           | 53 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  6 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
 5 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml

-- 
2.34.1

