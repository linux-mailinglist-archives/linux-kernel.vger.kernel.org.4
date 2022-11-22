Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65E633F37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiKVOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiKVOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:48:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2CA2606
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2EA67CE1D3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB7C433C1;
        Tue, 22 Nov 2022 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669128520;
        bh=H5yrJKp7IZ87cLQJKQXNDqJd6jBA32LmwBeh/HfHH2w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d2kuog9NAF3d688Expouf0jXiAbwY/5aL0M30bbseV7liEMBibzt4IOF72Ovh4+xL
         qD17J7uD+nsKg7aQpACaTY7aDmfCnKSiu2TFUHKFSC60XT+TRIgj+vCwufwfDPSKXC
         mjGp8CIK+LbWA0m1+CPoPU9Ox5ok7hCLcOgwoSnxSvAbkbqwJUZviorfgwFByEeVRv
         EeEguzDWnf355Zfy7083KXUFQQGVfXOoaeDAqAy6Pi5Oqr3HfYEa+Z3xvQYKuuuDxA
         O7mpZd3d7YAK58da6NXrshPzTQDhsIOPuV0roOnSvOKAv4rqSNWyRyJWaJCZi5L+n6
         EZoROpiliEIjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC3EB5C09C9; Tue, 22 Nov 2022 06:48:39 -0800 (PST)
Date:   Tue, 22 Nov 2022 06:48:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7szoyij.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:33:16PM +0106, John Ogness wrote:
> Hi Petr,
> 
> On 2022-11-22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Today's Linux next 20221122 tag clang-15 tinyconfig builds fails on
> > powerpc and s390 architectures.
> 
> The problem is that CONFIG_SRCU is not selected. This must be selected
> by any modules that requires SRCU. However, printk.c is _always_ built
> into the kernel (even if !CONFIG_PRINTK). The registration of consoles
> and the console list (which uses SRCU) is _always_ built into the
> kernel.
> 
> So should CONFIG_SRCU now always be active?
> 
> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?

The people wanting it separate back in the day were those wanting very
tiny kernels.  I have not heard from them in a long time, so maybe it
is now OK to just make SRCU unconditional.

							Thanx, Paul
