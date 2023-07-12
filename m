Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA1750A79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjGLOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGLOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:09:29 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58FCE;
        Wed, 12 Jul 2023 07:09:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79B57240003;
        Wed, 12 Jul 2023 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689170965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqMNK+Px/vbRMFAutLCP4VLsa4t9NKZfzY6xHeHvPf8=;
        b=Iq0PyvsWFNgnILfG6BEsTLr/FtmV4YrMx0JgWC1D9lqS2RAC0CoWj/23JCYCwge54DXxJ6
        AwW1r94ZMSagwNrJpqmmxIJVKj4tCsir5KzV8R4AQ2e9Nn6JG/lZM4Fd8ISOtURNGB0FIR
        Y/u6/ZkFCzuSOFi+lvlT+hWorhNWvepl+Dd+gJugwnyYO/oiY00chq0cZ9GiuOSUea1oqB
        MnNx44j0cTZQduQifSMNxBknnOzRbHo3Lo6KSrbpXnZH+CCuzfrW5vb3TFggOe8W/tTYlS
        XvK6aHR8MAQgqpfRMDGDey7hh63aERCsfFWFbJ7zs1gV1i7kseam+Ull2KSUTg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olivier Maignial <olivier.maignial@hotmail.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2, 1/2] mtd: spinand: toshiba: Fix ecc_get_status
Date:   Wed, 12 Jul 2023 16:09:22 +0200
Message-Id: <20230712140922.284272-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <DB4P250MB1032553D05FBE36DEE0D311EFE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8544cda94dae6be3f1359539079c68bb731428b1'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 15:33:36 UTC, Olivier Maignial wrote:
> Reading ECC status is failing.
> 
> tx58cxgxsxraix_ecc_get_status() is using on-stack buffer
> for SPINAND_GET_FEATURE_OP() output. It is not suitable
> for DMA needs of spi-mem.
> 
> Fix this by using the spi-mem operations dedicated buffer
> spinand->scratchbuf.
> 
> See
> spinand->scratchbuf:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mtd/spinand.h?h=v6.3#n418
> spi_mem_check_op():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-mem.c?h=v6.3#n199
> 
> Fixes: 10949af1681d ("mtd: spinand: Add initial support for Toshiba TC58CVG2S0H")
> Cc: stable@vger.kernel.org
> Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
