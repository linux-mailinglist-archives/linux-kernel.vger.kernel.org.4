Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CE5BF988
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIUIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiIUIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:41:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FF67465
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:41:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 09DE8FF807;
        Wed, 21 Sep 2022 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663749683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkIYDz0g1aDOn6XHJK7GdoNw26KyCG2dLZgmn/ut9Q8=;
        b=YJK5n+/qK2TnS6XJ2Gmp4n7EtE/tOjmztMshZcUB51PzZR4mosZT5tLStt650DlOB0UL2Z
        WSTh9CDEeROZNuRQKV7HrtP/BkqrVl2GwQ5WBIDYpD/XM3eq+leZR9Wv2BtSapaWWcJJxa
        eWOFhz1BeM5/jFmKQD5PFaHfbFUrzqBauYRGbcyO78oBbzwclh9Dm8JtehTcEoThN0rTrW
        Z8kIeumwURgOLtlmnFUWh9dmjbHoGfrqBQU/RGzgL7ZiacYGVxq1+YcVkWES8AxirZWNlY
        U2v57beoNmzYkTP50h5tLbcT9GMeNypEYHNuhxBLunGCzpuDKkGm2T6oK3bhVw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mtd: track maximum number of bitflips for each read request
Date:   Wed, 21 Sep 2022 10:41:20 +0200
Message-Id: <20220921084120.733357-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629125737.14418-2-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'65394169bdae073bfb2c6816f5bf095bd7d53e61'
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

On Wed, 2022-06-29 at 12:57:34 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> mtd_read_oob() callers are currently oblivious to the details of ECC
> errors detected during the read operation - they only learn (through the
> return value) whether any corrected bitflips or uncorrectable errors
> occurred.  More detailed ECC information can be useful to user-space
> applications for making better-informed choices about moving data
> around.
> 
> Extend struct mtd_oob_ops with a pointer to a newly-introduced struct
> mtd_req_stats and set its 'max_bitflips' field to the maximum number of
> bitflips found in a single ECC step during the read operation performed
> by mtd_read_oob().  This is a prerequisite for ultimately passing that
> value back to user space.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
