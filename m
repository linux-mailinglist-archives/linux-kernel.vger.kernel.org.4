Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204EC70C2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjEVP6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjEVP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:58:52 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB2FD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:58:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6214EE0009;
        Mon, 22 May 2023 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684771129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRhN3nhoRvLHX9ULUKdlTr8n0Dhwe8XNUhXojW9CbN4=;
        b=fnfSSEjrrah/faLLdXMylzu8+6pYud74dSSedOorEws0D3Qn7YSp7rNMOoX9Llv8RtdBZW
        z2Vvffmru5f16h3WCyYcTNi29oFJeqCvXyV+sGh/18XscxQS1hLuOdAgwS6dmkmpFO2LjI
        k/WboUXnk3SacFWJnvzU+cirXlTzvVKlk9lxGr2oegYsRWGaCtul8NM6Ag4//VGP9Tn8S+
        HNThRHR8KhoyogMcD7Ggo5aHc9uk0HzmwxJyyUnSEqRFqyqGQVIGbgceNGm7HV87pwEGEt
        bT7tU8pLkTTkqFP5MZaWBv3HdY4IwNsQ39U2s8n4wV4JJGW2cBdUlnFuWYFRSA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>, miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH v2] mtd: spi-nor: spansion: make sure local struct does not contain garbage
Date:   Mon, 22 May 2023 17:58:47 +0200
Message-Id: <20230522155848.46842-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509193900.948753-1-tudor.ambarus@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'38d1384c83954ad3eec90bbf0853034d1680ede7'
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

On Tue, 2023-05-09 at 19:39:00 UTC, Tudor Ambarus wrote:
> Following errors were seen with um-x86_64-gcc12/um-allyesconfig:
> + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
> 
> Initialise local struct spi_mem_op with all zeros at declaration in
> order to avoid using garbage data for fields that are not explicitly
> set afterwards.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: c87c9b11c53ce ("mtd: spi-nor: spansion: Determine current address mode")
> Fixes: 6afcc84080c41 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
