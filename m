Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECABB633A21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiKVKbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiKVKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:30:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EC18B0A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669112780; x=1700648780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=recIsswHDOyLzIEBSJ9pGwngd2wlATVE6OR9nm9abPo=;
  b=WL7786c6MV/QSwb63lNhS+FilHLA77i+ZMQVvasd0MJ9i038/UtqHgxy
   vj1ovh00IZ1Ah8VCUcC+sRHU79ZactuYfsypj4OdxCfCAZ1R62nSyUDQu
   PLEYFwHY5X5/iuqwVXUSi2aNYzm5Ba8EWABiUGHdmhjLJMpwJrVDeaPnF
   PRshWWbLHCu4ZGYMAyB23pnRll9wz7pzauGeg1yZ00OnUzOoO1ZPvlBC1
   0yTUJd/5MYUzrFEPL8WI+ajfveh/uOBrVdo4vsGs2o4ooSjk30R/x95Gx
   /LzQcB8YxGQqWIPwM4dnJXMA3q7B8dVA10YAt02x2DUJxoqacWiWG9Kj8
   g==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="184647678"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 03:26:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 03:26:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 22 Nov 2022 03:26:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Richard Weinberger" <richard@nod.at>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <ben.dooks@sifive.com>, <william.salmon@sifive.com>,
        <jude.onyenegecha@sifive.com>, <adnan.chowdhury@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <greentime.hu@sifive.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
Date:   Tue, 22 Nov 2022 12:26:06 +0200
Message-ID: <166909836606.156581.1226064412350775051.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 19:48:07 +0100, Sudip Mukherjee wrote:
> The datasheet of is25wp256 says it supports SFDP. Get rid of the static
> initialization of the flash parameters and init them when parsing SFDP.
> 
> Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
> SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
> After this patch, it parses the SFDP information and still uses the
> same opcodes.
> 
> [...]


Applied to spi-nor/next, thanks!

[1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
      https://git.kernel.org/mtd/c/a30f53d8bc0fi
[tudor.ambarus@microchip.com: set sector_size and n_sectors to zero]

[2/2] mtd: spi-nor: add SFDP fixups for Quad Page Program
      https://git.kernel.org/mtd/c/1799cd8540b6
[tudor.ambarus@microchip.com: move pp setting in spi_nor_init_default_params]

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
