Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA376F5A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjECOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:47:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749B5263;
        Wed,  3 May 2023 07:47:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343ElNgj070269;
        Wed, 3 May 2023 09:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683125243;
        bh=Yuzu7i3xAkJWk4hsoh36+CUQtmGT5lhOgXl9Mg5xxfg=;
        h=From:To:CC:Subject:Date;
        b=STcoLADnHMiPZ1/gFAoQsmheLSoZlJgIMTRbo1f3T0y4XyPoBMb6lrri/BKj30N9X
         uXWQuaHs55n1CLiuELWRIGfvq6di+3L0dVgZ3/c1P0BlZ7GMt+UGxPEUjGJ2UTqkoX
         CLolLEp2q/s/LONBDFDYWYqWA8IzF3SAM5/EH5Ck=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343ElNYU005098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 09:47:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 09:47:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 09:47:23 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343ElJNm024509;
        Wed, 3 May 2023 09:47:20 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH 0/1] arm64: dts: ti: k3-j721s2: handling subnode of  msmc node
Date:   Wed, 3 May 2023 20:17:05 +0530
Message-ID: <20230503144706.1265672-1-u-kumar1@ti.com>
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

TI K3 SOCs have msmc sram, part of it can be configured as L3 cache
depending upon system firmware configuration file.

This could be possible to have no L3 cache or variable size of
L3 cache.
In either case top of 64KB of SRAM has to be reserved for system
firmware called tifs.

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html?highlight=msmc
Section: TISCI_MSG_QUERY_MSMC.

But u-boot as part of fix up is deleting sysfw and l3cache node
before passing DT to OS
https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/common.c#L412

In my view we can handle in two ways
1) delete tifs node as well
In this case, only accessible sram will be visible to OS
https://lore.kernel.org/all/20230420081128.3617214-1-u-kumar1@ti.com/

2) make these nodes (tifs, atf and l3cache) as reserved,
so that OS has complete view of memory.
This is patch for option 2.

Nishanth suggested to discuss in k.org group
https://lore.kernel.org/all/20230502230022.5pjywy6h7oqrkmwh@elusive/

So sending this patch for suggestion for selection right option.
Also other options are welcome.


Udit Kumar (1):
  arm64: dts: ti: k3-j721s2: Add reserved status in msmc node.

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1

