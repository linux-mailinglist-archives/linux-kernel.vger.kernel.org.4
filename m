Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BF60C1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiJYCdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJYCdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:33:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCD11D9BD;
        Mon, 24 Oct 2022 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666665190; x=1698201190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIcla/cBfKfsp2q+fhYfTr8alpP/iyi9SD4SxWv2kyM=;
  b=Zx8xUVkSoidm7hJsR1gdJg2WpmVpgXWhWgXqni6BpKNc/J/6h89lOk9B
   usxL6MdtNSl2gVUIltvOiVvi1pT17DOBKS1xN2vrN4V2yHYsXPG3ufUn+
   dzFb4kPNsNkQsG0wqKUrB6AkvspgQY09C28BikN0cy699mBNDK/6IMvqv
   wD3srty8Kxo7idxL8pXXMUqFOiITmKMD51qLKZxA2dOXY4p5YKrDI4TkG
   RMj7CEPO5u/ygHUr8w4WdMcZYBKzAl8rFzAG4LXzXRgiZxlyYLrrNpH2T
   H7NDm/YRRf0abSOVLQAB2WkL5bbPHKl3coUPnkVFdLDNPblURs758gqn7
   A==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="196873207"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2022 19:33:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 24 Oct 2022 19:33:08 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 24 Oct 2022 19:33:03 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <sai.krishna.potthuri@amd.com>,
        <miquel.raynal@bootlin.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <richard@nod.at>, <michael@walle.cc>, <pratyush@kernel.org>,
        <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <saikrishna12468@gmail.com>, <devicetree@vger.kernel.org>,
        <git@amd.com>
Subject: Re: [PATCH v3 0/2] mtd: spi-nor: Add flash device reset support
Date:   Tue, 25 Oct 2022 05:32:59 +0300
Message-ID: <166666517332.181018.1753222058274543983.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 12:14:26 +0530, Sai Krishna Potthuri wrote:
> Update spi-nor dt-binding and spi-nor core to support flash device reset
> using reset-gpios property.
> 
> changes in v3:
> -> 1/2 - Add reset-gpios property in the example dts.
> 
> changes in v2:
> -> 1/2 - Updated the description of the 'reset-gpios' property.
> -> 2/2 - Updated the reset sequence to match with "active low" flag in
> device-tree, also removed unwanted comments.
> -> 2/2 - Updated the logic to perform the flash reset unconditionally.
> -> 2/2 - Updated the delay values to support more number of flash devices.
> 
> [...]

Applied to spi-nor/next, thanks!

[1/2] dt-bindings: mtd: spi-nor: Add reset-gpios property
      https://git.kernel.org/mtd/c/7f2937efe186
[2/2] mtd: spi-nor: Add support for flash reset
      https://git.kernel.org/mtd/c/8f1ee9ef71d0

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
