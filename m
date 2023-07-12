Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE0750A76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGLOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjGLOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:09:24 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821710C7;
        Wed, 12 Jul 2023 07:09:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A7C31BF208;
        Wed, 12 Jul 2023 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689170960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aepDpfAxOFfINdI3jia3k3kNLHibllPD8E/Dp+aDfU8=;
        b=nV7PxOSauISHx1sKkpQS8lsuk5uUHXnGSLJGe86leC4yLD1evLKMBLceQJzNPbQ+j0Q8wo
        WE5I9t5gL5+xBwvMrfVQtvEyCgdwrcoIG84ehSu7GoZwUFHo4ggDuMim6YkNCIdXDUYe7n
        g3m7uG0SgAb+a3JlNXmPo+3jGDOpslIy9My74QUh3YsJjZBdeP9RTWAYVXHAk0/dvXGVv9
        U/R1lQEOgib8/x5beVVM1L/fgQNkfLgxPr9ztivg1dOkXiUwYMUaZrQM4ZYihmzY23n3YP
        OJtt4E1dFuRYVtqvq6GAi6QfKIvk5hMYueTM/O5J3STeKGUKo/m+6lPh2tOZmg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olivier Maignial <olivier.maignial@hotmail.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2, 2/2] mtd: spinand: winbond: Fix ecc_get_status
Date:   Wed, 12 Jul 2023 16:09:17 +0200
Message-Id: <20230712140917.284243-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <DB4P250MB1032EDB9E36B764A33769039FE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f5a05060670a4d8d6523afc7963eb559c2e3615f'
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

On Fri, 2023-06-23 at 15:33:37 UTC, Olivier Maignial wrote:
> Reading ECC status is failing.
> 
> w25n02kv_ecc_get_status() is using on-stack buffer for
> SPINAND_GET_FEATURE_OP() output. It is not suitable for
> DMA needs of spi-mem.
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
> Fixes: 6154c7a58348 ("mtd: spinand: winbond: add Winbond W25N02KV flash support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
