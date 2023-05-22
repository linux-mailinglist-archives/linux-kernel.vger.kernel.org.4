Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6B70C2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjEVP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjEVP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:58:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E55B5;
        Mon, 22 May 2023 08:58:45 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2C9BD60003;
        Mon, 22 May 2023 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684771124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFwgjCPf/4asoNSTd2rB0052AcQsns5SfkHhPLz5LaE=;
        b=fg4hZ1nrhDhCKJ9uVedfX193NoCwJ8eeuuApDSDCP27/ahRcDy22tl3vsTuhlUyb/44saU
        YHuoGm3urtJDj86mcTGQ5E2fJvNgkjpZRAefGC0c9Nn+jG3WXuOUIESM/dZrME7dMIBqXu
        xd/K+Ph1Vyb6LiJrRg2Q15I5Z/PUc3wwT75OvoRDPLpSNviOwaVIIfu1JBobK80+xzsji5
        I6oOqQdwBik5cdfCeqGWMGGbMMzMm+F4vLNCMErSM8+IeWLUs4tWhgG02iD7U6/vDqOG04
        Xi0uYzddRGpIGoFK9pBaIpoSRVXKoZdvhe+k7afrmBkS90t/2dpnAxbQ6VC4+w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix empty stub helper definitions
Date:   Mon, 22 May 2023 17:58:42 +0200
Message-Id: <20230522155842.46808-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516202133.559488-1-arnd@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6b31b07fc235cf089bf87de1b8b5e471a5f7a090'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 20:21:24 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A few functions provide an empty interface definition when
> CONFIG_MTD_NAND_INGENIC_ECC is disabled, but they are accidentally
> defined as global functions in the header:
> 
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: error: no previous prototype for 'ingenic_ecc_calculate'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: error: no previous prototype for 'ingenic_ecc_correct'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: error: no previous prototype for 'ingenic_ecc_release'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: error: no previous prototype for 'of_ingenic_ecc_get'
> 
> Turn them into 'static inline' definitions instead.
> 
> Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
