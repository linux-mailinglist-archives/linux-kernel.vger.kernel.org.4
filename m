Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D061F99A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiKGQ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiKGQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:26:53 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034323398
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:23:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 97A2860011;
        Mon,  7 Nov 2022 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOnSmGFEa4r00L7WXSL6QGydLMdsKXngB2IfSPB5BuU=;
        b=b6FTxnjuaC5M5YphQ0GsPxIt37gsLGPdBl3YsGBCRGNUeA/joJjDG9CfFE9w9R7yNIRDrq
        KksovDYtAKYf6IheJYJduT45qWjCMY3TPJ/E3uHlWzWvKyOmu7W+dMJ1SUPxLyMKeUuxVw
        JnDp10fcfqlah2El/qSPFmYpL0MLayvuMU9fHUH+pAOwhFziWSlxAjfEz0UAyHZnNGJNBO
        5FEkN5FWH8MRWgl48B+kGG3fFZuhUiErPyroJvqmZj2KTHbjiVSwCt/JFZ74YVIcrmOyzK
        g7pHqr8aIKbG22yojce7vgjcPYlNOzVG3as4y2uznyQcuR/ADk2SR+tJZHr9xw==
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
Subject: Re: [PATCH 2/2] mtd: rawnand: lpc32xx_slc: Switch to using pm_ptr()
Date:   Mon,  7 Nov 2022 17:23:03 +0100
Message-Id: <20221107162303.54160-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027131028.3838303-2-geert@linux-m68k.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bb144c285bd5585be101aaf5464ad8949ba1305d'
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

On Thu, 2022-10-27 at 13:10:28 UTC, Geert Uytterhoeven wrote:
> The switch to using the gpiod API removed the last user of
> lpc32xx_wp_disable() outside #ifdef CONFIG_PM, causing build failures if
> CONFIG_PM=n:
> 
>     drivers/mtd/nand/raw/lpc32xx_slc.c:318:13: error: ‘lpc32xx_wp_disable’ defined but not used [-Werror=unused-function]
>       318 | static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
>           |             ^~~~~~~~~~~~~~~~~~
> 
> Fix this by switching from #ifdef CONFIG_PM to pm_ptr(), increasing
> compile-coverage as a side-effect.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: 6b923db2867cb5e1 ("mtd: rawnand: lpc32xx_slc: switch to using gpiod API")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
