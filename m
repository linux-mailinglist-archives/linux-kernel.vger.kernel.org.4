Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6A63275C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiKUPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiKUPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:09:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4813D2296;
        Mon, 21 Nov 2022 06:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669042756; x=1700578756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bg7fc0fdg0hllLzTvAl2qNMGHQGaUp8kFauzj5L30A8=;
  b=rueiAxOLbII/wSYh7jIaJNwLrIFLJKxM08+VYuck5Gb4Ivy6dDhtH/qx
   iY8hGAbAA3HDU5thhOnnyGu/gYd29my9WQ1VTHtm6VfxXt/4TQABKe5PT
   31yauPMM+oce3rTaM8qW+ZOJp2+3A/X4KZIntR4fzcEiRHAX5/GA9IV7/
   QIRiUkEMYB0XeCWVC1nkbYxny3uycWROjB0ZIRgvrxn0CL8YcsmRjxeLV
   Ij/7cAK533ov2bgNaQFqDf162GE4kwNrJbZXDNHzNSumEH66tW8hG48h1
   qsej6pK3dGvxwBMgq5PMXNpTsIoYJkYdJlHi/9dbvHWWlTSU9z7UI8hDI
   w==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="124407130"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 07:59:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 07:59:08 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 07:59:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <richard@nod.at>, <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <pratyush@kernel.org>, <allen-kh.cheng@mediatek.com>,
        <vigneshr@ti.com>, <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <bayi.cheng@mediatek.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix the number of bytes for the dummy cycles
Date:   Mon, 21 Nov 2022 16:59:04 +0200
Message-ID: <166904273877.104708.18259766810338058949.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
References: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
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

On Mon, 31 Oct 2022 20:46:33 +0800, Allen-KH Cheng wrote:
> The number of bytes used by spi_nor_spimem_check_readop() may be
> incorrect for the dummy cycles. Since nor->read_dummy is not initialized
> before spi_nor_spimem_adjust_hwcaps().
> 
> We use both mode and wait state clock cycles instead of nor->read_dummy.
> 
> 
> [...]

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: Fix the number of bytes for the dummy cycles
      https://git.kernel.org/mtd/c/fdc20370d93e

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
