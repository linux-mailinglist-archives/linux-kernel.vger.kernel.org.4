Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2C697FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBOPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBOPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:41:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4A3B0EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:41:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD79833744;
        Wed, 15 Feb 2023 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676475679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ds4a8MZXrTFQmvFjd/tW04lFHt9bdke4Re2KrEs3co4=;
        b=dWZgHCZtsVhD1UMyX1ZivgNCtkEmrlpAsMr4MqeOXDNNnmT4c49lAv3nLSDt5bXPyzPFS5
        0AlYula7qvYN66bzCNygcTLowG6UQYR0NMDEA4neTqZrUWTLlOJaubZYnVYqpsET6hfKhV
        3j00+wt/Oian9eow24Z/xlO5AWaJWQE=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29F842C141;
        Wed, 15 Feb 2023 15:41:19 +0000 (UTC)
Date:   Wed, 15 Feb 2023 16:41:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND v4] printf: fix errname.c list
Message-ID: <Y+z9G1VJx9jeCSgr@alley>
References: <20230206194126.380350-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206194126.380350-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-02-06 20:40:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
> 
> lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
>    15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>       |                                                                   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>   172 |  E(EDEADLK), /* EDEADLOCK */
>       |  ^
> 
> On parisc, a similar error happens with -ECANCELLED, which is an
> alias for ECANCELED.
> 
> Make the EDEADLK printing conditional on the number being distinct
> from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> can never be hit.
> 
> To ensure these are correct, add static_assert lines that verify
> all the remaining aliases are in fact identical to the canonical
> name.
> 
> Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
> Cc: Petr Mladek <pmladek@suse.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link: https://lore.kernel.org/all/20210514213456.745039-1-arnd@kernel.org/
> Link: https://lore.kernel.org/all/20210927123409.1109737-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have just pushed the patch into printk/linux.git, branch for-6.3.

> I sent this a few times, but it never made it in so far. The warning
> still shows up when enabling extra warnings, and this is an actual bug.

I am sorry for the delay, v3 somehow fallen under cracks. Anyway, v4
seems to be the only resend that I got. v3 was needed because of a
problem reported in v2.

Best Regards,
Petr
