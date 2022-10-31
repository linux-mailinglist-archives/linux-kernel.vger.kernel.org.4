Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD26139F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiJaPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiJaPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:25:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F8110E;
        Mon, 31 Oct 2022 08:25:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VFPM3P011595;
        Mon, 31 Oct 2022 10:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667229922;
        bh=orKpYPQSkt5tm6oRJm2y3sJZedfZKyD0LlY0bocdCJE=;
        h=From:To:CC:Subject:Date;
        b=X3diNACQgxK+S8K26bnlCId+0gVYZDR1ZUPzHyw85IxnFAQXj1moVmKv4Oj3OyUYC
         EVUMB9qx9Hvt2zX0HtkhHi/PwsyGaoM7A/+gna68U068IZ9KfIabZz+09QmzxGQUwJ
         r5T/jGZ9weqKxj878uTvNSyDzjx7HM1Kdrf0ve0w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VFPMS1004973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 10:25:22 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 10:25:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 10:25:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VFPKtu045270;
        Mon, 31 Oct 2022 10:25:21 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 0/3] Drop dma-coherent property from SA2UL
Date:   Mon, 31 Oct 2022 20:55:17 +0530
Message-ID: <20221031152520.355653-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto driver itself is not dma-coherent. It is the system-dma
that moves data and so 'dma-coherent' property should be dropped.

This series drop it from the crypto nodes for the J7 family of
TI SoCs.

DT binding fixes have already been merged[0].

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a536208da6f7d877f1adbad4ff13f63f31f59d91

Jayesh Choudhary (3):
  arm64: dts: ti: k3-am65-main: drop dma-coherent in crypto node
  arm64: dts: ti: k3-j721e-main: drop dma-coherent in crypto node
  arm64: dts: ti: k3-j7200-mcu-wakeup: drop dma-coherent in crypto node

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 1 -
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 1 -
 3 files changed, 3 deletions(-)

-- 
2.25.1

