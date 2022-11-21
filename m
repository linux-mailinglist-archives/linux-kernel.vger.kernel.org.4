Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B086325FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKUOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:35:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DBCC694C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669041330; x=1700577330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=81q/NWq8iLH9tF/aVF7hETErH6QjCfNUwmfq2TDAUcY=;
  b=ocKIBGb5LVX5Ot921FCgrBV4YyTm5x8B1jH7QXdZpBHjSJMOmdGUxg48
   x3nGOtM7z4XJUoc4DW+3e03dyJo712fZ2ZctmHPxypzWuNpk7vo2Ai0hU
   rxlExNwnjYzbMmHcNDFZzPb0h2O6Y1fZn1u4dFw3llVqOi3rIfHal+uM9
   V4GfMnec67tblv5E5DmKS7yzGXeWbWFFa8+koY2P/8xbanydSmB/hQIWU
   GdnOjF2uBIaPCMb5egQqK7oO4BVOO+Wb67LiGFKV7ZKLlnqFq4FN6z+DB
   ZsNcNl9kkcteLHgKsJuFPbp4QlJkFqlnO0vrSLaqIBbFvT22as35BbFSj
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="187957811"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 07:32:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 07:32:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 07:32:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <pratyush@kernel.org>, <michael@walle.cc>,
        <yaliang.wang@windriver.com>, <richard@nod.at>,
        <cyrille.pitchen@wedev4u.fr>, <vigneshr@ti.com>,
        <andy.yan@rock-chips.com>, <miquel.raynal@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt
Date:   Mon, 21 Nov 2022 16:32:07 +0200
Message-ID: <166904099810.93917.2481343672925708577.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221016171901.1483542-1-yaliang.wang@windriver.com>
References: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com> <20221016171901.1483542-1-yaliang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 01:19:00 +0800, yaliang.wang@windriver.com wrote:
> GD25Q256 'C' generation 'GD25Q256C' implements the JESD216 standards,
> JESD216 doesn't define the QER field in BFPT, but the 'GD25Q256C'
> does define QE bit in status register 1 bit 6, so we need to tweak
> quad_enable to properly set the function.
> 
> 'D' and 'E' generations implement the JESD216B standards, so parsing
> the SFDP to set quad_enable function is enough for them.
> 
> [...]

Updated comment in gd25q256_post_bfpt and applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt
      https://git.kernel.org/mtd/c/4dc49062a7e9

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
