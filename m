Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949A6F54CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECJdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjECJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:33:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93614C1E;
        Wed,  3 May 2023 02:33:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3439XEx7089718;
        Wed, 3 May 2023 04:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683106394;
        bh=51vNYF5jUUgjJ+YVXLiVvGHHAtSEJjbLxUMXFfoDjSM=;
        h=From:To:CC:Subject:Date;
        b=qaP4rbUc5jc2Xq3UMtMU64O3G/ypfzvbIJUK0/+wYNXXW+s59o5t3fp3ZiR7vhNZ3
         nH031OeXLa/Oz1DGVCd4b0IB7D1O72b9+Q6wkG7gwS0TrNYH9Q/p5BgTmxcLoL2ab1
         RETrcGvzMj96KARiGSlWubi7G55Djt9VSeqjk/5I=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3439XExY006897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 04:33:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 04:33:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 04:33:13 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3439XAIl084380;
        Wed, 3 May 2023 04:33:11 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v4 0/3] Add support for ESM
Date:   Wed, 3 May 2023 15:03:07 +0530
Message-ID: <20230503093310.85779-1-n-francis@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
 4 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml

-- 
2.34.1

