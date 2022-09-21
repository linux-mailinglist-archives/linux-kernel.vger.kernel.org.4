Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F043A5BF987
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIUIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiIUIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:41:17 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4E7EFD3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:41:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F0E0624000C;
        Wed, 21 Sep 2022 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663749674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9cbzyFuyH09NAncmcdVqfJayfGYNOCh5xOhUfCxaJ8=;
        b=ZnDnZ51EEuIeSc/H/wAUhgxkQDL3Xs+bZS6dgEzs23GnOOAg3BaXHX9xYxpzcbFnjePweV
        oXaiQ3sCYfMC+hnyJfZhNEuL5cLELdQH9CeT4d/I7TaNOKWBiB2tbg2C4j2Iggjw6ghB98
        n3FmDYrKFg4Epg/HpZUIuBp4daAYYZxUZPuHMxwEEN6aNen1/Pkvz8W1cGuNB+9l4bl90M
        JNXeU1gKecYT/+YTEV5/mTaO9qThJFHq04WlDzGIvQBd164Yd/SsUDVYSkr+ZGrz9Y946M
        bfunZQk6hoZqLr0FEv6dfjVioqmdleFGkTXuPmCImdnO0vL8jc84G3DoS9HOyA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mtd: always initialize 'stats' in struct mtd_oob_ops
Date:   Wed, 21 Sep 2022 10:41:11 +0200
Message-Id: <20220921084111.733303-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629125737.14418-3-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'745df17906029cc683b8b5ac8bcb08f82860baff'
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

On Wed, 2022-06-29 at 12:57:35 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> As the 'stats' field in struct mtd_oob_ops is used in conditional
> expressions, ensure it is always zero-initialized in all such structures
> to prevent random stack garbage from being interpreted as a pointer.
> 
> Strictly speaking, this problem currently only needs to be fixed for
> struct mtd_oob_ops structures subsequently passed to mtd_read_oob().
> However, this commit goes a step further and makes all instances of
> struct mtd_oob_ops in the tree zero-initialized, in hope of preventing
> future problems, e.g. if struct mtd_req_stats gets extended with write
> statistics at some point.
> 
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
