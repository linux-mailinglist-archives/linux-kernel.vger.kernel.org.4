Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6626B748B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCMKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCMKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:47:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE875DEF2;
        Mon, 13 Mar 2023 03:47:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DAlN3m045997;
        Mon, 13 Mar 2023 05:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678704443;
        bh=ARpd4KACNJ73JIxwNWixFY6Gksfuk0bedsAxazFjpKY=;
        h=From:To:CC:Subject:Date;
        b=wvuF8eBeB4Vo/N5y89A52ZoXkjXWvxp/CTGJRQbcz4QyLjWhmrmzJE6nZMmU3KIWE
         8+V7Ywi2Th2/0lPH3MSbJaIYCX2T5URYlrmI2joXqyBhXmnts2TrMAOB1ndS+6cZFf
         GSxqDzy8rPa/aHhyV14Kpo7jkFbhs0XzIF896frc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DAlNNP130424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 05:47:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 05:47:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 05:47:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DAlMKB024327;
        Mon, 13 Mar 2023 05:47:22 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kamlesh@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 0/2] Add Crypto Support for J784S4 SoC
Date:   Mon, 13 Mar 2023 16:17:19 +0530
Message-ID: <20230313104721.407071-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the crypto node for sa2ul for j784s4 platform.

First patch adds the device-id for NAVSS without which the probe
for dma-controller fails due to 'ti,sci-dev-id' read failure.
Second patch adds the crypto node.

This series has functional dependency on j784s4 k3_soc_id[1] and
PSIL-thread support[2] but it does not affect the boot.

[1]:
<https://lore.kernel.org/all/20230313065025.185320-1-j-choudhary@ti.com/>

[2]:
<https://lore.kernel.org/all/20230308201513.116638-1-j-choudhary@ti.com/>

For testing the crypto support, crypto extra tests and self tests were
enabled and tcrypt tests were used to verify SHA-1/256/512, AES and DES3
algorithms.

Testing log:
<https://gist.github.com/Jayesh2000/4fe36337af6f9dc96a055359d5d6f4ca>

Jayesh Choudhary (2):
  arm64: dts: ti: k3-j784s4-main: Add 'ti,sci-dev-id' for main_navss
  arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.25.1

