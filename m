Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017506B5015
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCJS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCJS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:29:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA9AD290A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/P4HfuWEJ6q0Nqxd9GvnKNVVLfpkHZSOW3oGoBbL8I=; b=wcnILBpFSL2OULFuodA9UZkcKR
        AdZosWjqokmqdnj0Bazv6Yurujxvc18gkSDA2r7UjJcQH1lJ8MZglEZjiNrdqYQJcoqqQCrp/BHDG
        uc8qFvOiepOHB37feVsEjWn5DvkjZRDIH9mpwG1q1jLwUXEio/5SlFvEkQSHe7/YooGxCCpR10VxD
        I+aN1IjpMa5jYnjlbZ8l/M5Zlzew2WOPzOerBpGwLUJxL8tur2DU3d9U5bsj3i8jo0fFlfeD6tLI9
        JKAPseU5q8LTt37QHz3GAKDn9gyTluK7cyN+MdH8iMu8JGravxjU93LAWxwXclQkKCfoEGQZTc0hl
        f4cgpU5w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pahUi-00Fl1I-0F; Fri, 10 Mar 2023 18:29:32 +0000
Date:   Fri, 10 Mar 2023 10:29:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Jason Baron <jbaron@akamai.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dyndbg: allow including dyndbg.h in decompressor
Message-ID: <ZAt3CxXavMl4vECg@bombadil.infradead.org>
References: <20230310140133.291594-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140133.291594-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:01:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After a change to linux/module.h, dyndbg.h is now included
> indirectly from the decompressor for lz4 support, which in turn
> causes a build failure on 32-bit Arm:
> 
> In file included from include/linux/module.h:30,
>                  from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
>                  from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
>                  from arch/arm/boot/compressed/decompress.c:59:
> include/linux/dynamic_debug.h: In function 'ddebug_dyndbg_module_param_cb':
> include/linux/dynamic_debug.h:307:14: error: implicit declaration of function 'strcmp' [-Werror=implicit-function-declaration]
>   307 |         if (!strcmp(param, "dyndbg")) {
>       |              ^~~~~~
> include/linux/dynamic_debug.h:1:1: note: 'strcmp' is defined in header '<string.h>'; did you forget to '#include <string.h>'?
>   +++ |+#include <string.h>
> 
> The decompressor has its own replacement for the linux/string.h contents,
> so the normal declaration is not visible here. Since the function is
> not actually called, it is sufficient to add a declaration, and this
> is in fact the correct one as it matches the definition in
> arch/arm/boot/compressed/string.c.
> 
> Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch that caused the problem is in linux-next, maybe fold
> the fix into that patch if possible
> ---

Thanks for figuring this out, Arnd! Pushed to modules-next!

  Luis
