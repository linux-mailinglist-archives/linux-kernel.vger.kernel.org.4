Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACB65B06D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjABLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjABLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:19:01 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DEA62EA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:19:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1946FC000D;
        Mon,  2 Jan 2023 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmZOFIRPUxRbgADaNIqMPGTVn972Lk8IMLnC4lxZO7c=;
        b=NekCXkjn8uNt8LsUZK3ktj6JmLI49SywH1StWRlKMSCML2H8aguvs/6eGx2bspGFI3VIF3
        GnwxYbYCEkBetHMM/va6FYRP48CTYUTetEagMmuy/kY8heBJGoNpzWZXJcghkb7rWqUnCL
        bX0CnZLOZdvk61KCIE8Kh/MkFdxA2iPVqRI3IrzkPPp4/Nx5PaxeTmGH/dKup3QnO7ftts
        LUxzI6fyTk06d+keNxvk2n/3WD/nlvhhph0nYbxkPl7eObm91xGpHNjNUCzMRFBb3YHs7S
        MWAIOCzXS5w3HYqzAh3UK4wMqouh/KUmSE5LgQ1zKNuHUZocelTLjct2BgH+tA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Claudius Heine <ch@denx.de>,
        =?utf-8?q?Uw?= =?utf-8?q?e_Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: dataflash: remove duplicate SPI ID table
Date:   Mon,  2 Jan 2023 12:18:56 +0100
Message-Id: <20230102111856.168762-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215164736.1315815-1-arnd@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a30144c02c84614ed160ab70e38fcf7b024a1bb0'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-15 at 16:47:30 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with -Werror=override-init revealds that two patches added
> the same device ID table to this driver:
> 
> drivers/mtd/devices/mtd_dataflash.c:946:27: error: initialized field overwritten [-Werror=override-init]
>   946 |         .id_table       = dataflash_spi_ids,
>       |                           ^~~~~~~~~~~~~~~~~
> drivers/mtd/devices/mtd_dataflash.c:946:27: note: (near initialization for 'dataflash_driver.id_table')
> 
> Remove one of the copies.
> 
> Fixes: 27a030e87292 ("mtd: dataflash: Add device-tree SPI IDs")
> Fixes: ac4f83482afb ("mtd: dataflash: Add SPI ID table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
