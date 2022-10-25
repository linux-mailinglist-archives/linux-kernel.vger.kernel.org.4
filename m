Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C460C1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJYCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJYCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:42:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194C63FC;
        Mon, 24 Oct 2022 19:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666665776; x=1698201776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIcla/cBfKfsp2q+fhYfTr8alpP/iyi9SD4SxWv2kyM=;
  b=QecRc8VS4/EvhGraME+4l5kG1TuSg5Q9nBxguAWo4tqsrBvar38GkqQk
   79F924HCBLUI4St4NL640ktgtryAOdBGbrENkxco18yVh1OII9hYOlYqe
   uRFxzxzlwQQ1N9wRtN2p6jNRxAqQmIlCMfU9wElP57AhFxd7E4Iip6CAr
   mVXHrgv0Jb9NhrhUGwFWWHu0DBielGNm4r6JpiiuvjWKHkqK4ggRYCDH8
   5EQq93rhCQo9mVjZzLF8VYHyDvv25nHgvOH9q10N6bwJTpARM42VDhLIo
   wt6Upwvxf0WI96TSvGsVS/mOUlaivZhAYO3E4O741VuifhW1i9xXzaG5D
   A==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="120182565"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2022 19:40:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 24 Oct 2022 19:40:11 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 24 Oct 2022 19:40:06 -0700
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
Date:   Tue, 25 Oct 2022 05:40:02 +0300
Message-ID: <166666517332.181018.1753222058274543983.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
