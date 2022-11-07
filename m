Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE261F9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiKGQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiKGQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:26:58 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BEA23BF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:23:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1CFC6FF80D;
        Mon,  7 Nov 2022 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LxItcH4X2mFQAidJj37AbVcqbpSvYbEJuz7SqLc9TQ=;
        b=p1NvpJd/KJM+3OIkyg9dl4Z+40cVp9CZaN5QONPOCiumjj9tqvbOEaEDAOrJVSXoxuO142
        xLWnUKsqmVRsO4SssF/AhCAtEcbp/FouJzGS2aCSAwV8zCtEs+mriyj5g1SgzC/nFqH17C
        DfZFw0ImIQt2Ur86oIheCRM7Ml1ASh9KiQzzYyffQMNDEWKSFybaj1LnfGSCnxPk0kpOei
        21+bYkFUqMQfIfdoV41NL6vAgDbXnkWedFMYVwCXVdrWrjv8RNGx49vCBDOrkpG+1ZSaPQ
        GU9bVBb6UG2ka9VnaqMEfm28YA0aGSiPOnVy79SmknToN7WkAMB1UGBdZGsGSg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
Subject: Re: [PATCH 1/2] mtd: rawnand: lpc32xx_mlc: Switch to using pm_ptr()
Date:   Mon,  7 Nov 2022 17:23:09 +0100
Message-Id: <20221107162309.54192-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027131028.3838303-1-geert@linux-m68k.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'991cc42a276f1d9303674a04a351942e47c29a3f'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 13:10:27 UTC, Geert Uytterhoeven wrote:
> The switch to using the gpiod API removed the last user of
> lpc32xx_wp_disable() outside #ifdef CONFIG_PM, causing build failures if
> CONFIG_PM=n:
> 
>     drivers/mtd/nand/raw/lpc32xx_mlc.c:380:13: error: ‘lpc32xx_wp_disable’ defined but not used [-Werror=unused-function]
>       380 | static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
>           |             ^~~~~~~~~~~~~~~~~~
> 
> Fix this by switching from #ifdef CONFIG_PM to pm_ptr(), increasing
> compile-coverage as a side-effect.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: 782e32a990d9d702 ("mtd: rawnand: lpc32xx_mlc: switch to using gpiod API")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
