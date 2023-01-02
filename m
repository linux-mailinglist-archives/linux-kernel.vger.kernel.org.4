Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA065B068
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjABLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjABLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:17:44 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23C5FD3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:17:42 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A25CB40004;
        Mon,  2 Jan 2023 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQ4q1En/5KoBfWdjsEhlx3uY36hLwac59A78Yg4Sh7w=;
        b=gMMs1X7QT/dJfZXE1d7TicDP2UK52byA0wm+9oA2aTzbkAiwsZcX3G4JDL407kSLxayxZ4
        t4gx1WTQY3VsLJU4wdDgiR9Vzf/TBgSSkif0ru24yLZAX6PpdrBI2nDj3OlNcYpDTALwxT
        HPqfmsGJFudjNDa6+2cz3vwD9uXADXo3mGlbWN4Mw0pCSd9F4y46sKj9B471uVJCi9tM4n
        VBX43iHumsq0tE4CnEbIKH0nEP5QjUyfKSogJLpUDKDP4zmJ55IVP+oopiznyskZ4lmvbK
        8AAUZcjcJUUa+MRtVS0ASvORX6htaIw3pMxaQnLjti+62Wc4l5mBOmzm3AbSSw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] mtd: parsers: scpart: fix __udivdi3 undefined on mips
Date:   Mon,  2 Jan 2023 12:17:37 +0100
Message-Id: <20230102111737.85778-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <805fe58e-690f-6a3f-5ebf-2f6f6e6e4599@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'105c14b84d93168431abba5d55e6c26fa4b65abb'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 20:28:29 UTC, Mikhail Zhilkin wrote:
> This fixes the following compile error on mips architecture with clang
> version 16.0.0 reported by the 0-DAY CI Kernel Test Service:
>    ld.lld: error: undefined symbol: __udivdi3
>    referenced by scpart.c
>    mtd/parsers/scpart.o:(scpart_parse) in archive drivers/built-in.a
> 
> As a workaround this makes 'offs' a 32-bit type. This is enough, because
> the mtd containing partition table practically does not exceed 1 MB. We
> can revert this when the [Link] has been resolved.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1635
> Fixes: 9b78ef0c7997 ("mtd: parsers: add support for Sercomm partitions")
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
