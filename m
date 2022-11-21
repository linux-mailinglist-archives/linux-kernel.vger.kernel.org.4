Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127C6327A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiKUPQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiKUPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:15:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43183BEB4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669043488; x=1700579488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bLQDaKJTxRYcYn42c9ziV2g4j4CTk2Il5ri2fVpJBxs=;
  b=RGMR7/KpWVZJh/FFoyHseBpBMvSfCyjEJRqnVgs5JtCeEK0qRPx6jdcv
   qK8COaDUjFRIY7AKabYZRHKzhhbR+xkX4x8UjmMoAXQN7hbyo9qg81qz9
   0WQ3fxiPILpQqLZHZrcWN3Gl8Xm8IjPohtYv2bVnOc0ucRq64HlaZzU2P
   aRY5rH/jYNlKzq8+UpBk2I6OXNHfKlOkBmuv3kjqiSJkftc2FWXAIjRJ5
   qqCxG64PSkDQFH6i5krFMvJwGPT9UDDk9MUcUnNZfif82IOqXlfWsWFO/
   3cpzGzx/Gtqo9e4J3FyaC4Ef6Hg0Gom+2m3m9NT2u00ZenHtQV6MBD3pA
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="184495814"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 08:11:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 08:11:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 08:11:23 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <farbere@amazon.com>,
        <miquel.raynal@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>, <talel@amazon.com>,
        <shellykz@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <itamark@amazon.com>, <dkl@amazon.com>, <amitlavi@amazon.com>,
        <hanochu@amazon.com>
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: micron-st: Enable locking for mt25qu256a
Date:   Mon, 21 Nov 2022 17:11:22 +0200
Message-ID: <166904347234.110206.17589420162620604946.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020092058.33844-1-farbere@amazon.com>
References: <20221020092058.33844-1-farbere@amazon.com>
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

On Thu, 20 Oct 2022 09:20:58 +0000, Eliav Farber wrote:
> mt25qu256a [1] uses the 4 bit Block Protection scheme and supports
> Top/Bottom protection via the BP and TB bits of the Status Register.
> BP3 is located in bit 6 of the Status Register.
> Tested on MT25QU256ABA8ESF-0SIT.
> 
> [1] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf
> 
> [...]

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: micron-st: Enable locking for mt25qu256a
      https://git.kernel.org/mtd/c/bcc0c61e6134

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
