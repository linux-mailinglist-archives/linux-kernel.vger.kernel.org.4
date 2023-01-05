Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398C65F005
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjAEPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjAEPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:23:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5312E7;
        Thu,  5 Jan 2023 07:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22ED961A8B;
        Thu,  5 Jan 2023 15:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862E5C433EF;
        Thu,  5 Jan 2023 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672932231;
        bh=1t+dUPzSA0ksnrUuc8/Bbo1ZUCkWyj4rbPQo9hsDiJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ekE8Rde3RBggbbEDkhEA60YtQl5GRgO3hi1QwU9aBreHSl7bI3+UCqBNHFNPhuDWo
         OZwnBLCy/Ttx+tOPXCJf2d4D/+hW9y7bBdQUBv2OOuOFVChia7xIwse1vlRbQKHymC
         0jXxVSOvRFqmHz7ddIjpvjnuFx822i/JUP1WKeA9PZb3iqMZApZewGSgVPlo0ujiqo
         C5u4ux6OfcDnNR69LAriJgAwj4S4d2yWtkx950jmyHPlerjL6LL81Yrjt5RMBE6XD/
         m6r0wDcYagxFLnM8xW5rAojK4nVYjWKi5DgQdNksOo+ylZUXfK2NWDAey+c2+btzus
         YaN8KHkDZuxhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22D145C029A; Thu,  5 Jan 2023 07:23:51 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:23:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu 27/27] rcu: Remove CONFIG_SRCU
Message-ID: <20230105152351.GP4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-27-paulmck@kernel.org>
 <87r0w9csqn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0w9csqn.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:10:16AM +0106, John Ogness wrote:
> On 2023-01-04, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > Now that all references to CONFIG_SRCU have been removed, it is time to
> > remove CONFIG_SRCU itself.
> 
> I think "all references" is a bit misleading since there still are
> several places in the kernel code that use it:
> 
> $ git grep CONFIG_SRCU
> drivers/base/core.c:#ifdef CONFIG_SRCU
> drivers/base/core.c:#else /* !CONFIG_SRCU */
> drivers/base/core.c:#endif /* !CONFIG_SRCU */
> fs/locks.c:#if IS_ENABLED(CONFIG_SRCU)
> fs/locks.c:#else /* !IS_ENABLED(CONFIG_SRCU) */
> fs/locks.c:#endif /* IS_ENABLED(CONFIG_SRCU) */
> kernel/notifier.c:#ifdef CONFIG_SRCU
> kernel/notifier.c:#endif /* CONFIG_SRCU */

In the -rcu tree, these are removed by these commits:

1798c5b6b0ea ("drivers/base: Remove CONFIG_SRCU")
19aa50512372 ("fs: Remove CONFIG_SRCU")
fe0c9bd625ad ("kernel/notifier: Remove CONFIG_SRCU")

> Should those be removed before this patch?

When I merge the -rcu tree's "dev" branch with current mainline, "git
grep CONFIG_SRCU" gives me no output.  Am I fat-fingering something here?

							Thanx, Paul
