Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3737063FD07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiLBA1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiLBA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF6DFB5B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE4EDB8206B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871E3C433D7;
        Fri,  2 Dec 2022 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940512;
        bh=6J4gjTFKqHik2LyDMx2EWXKGkBCUVxElfOKE7z1d+JI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CcxaMKKNorEFYMamBbJfZ0JTD6T4zVrpK+Vf2Xhnr10QF7MoiM8QsrJ6Lutfp0YGM
         Efm3czEHA9znoNPD7kKfmFqYw9jOeI2q/pemhcqYlO8khCXLlCHs/rHkTxIxPqQPfn
         w58rbTW/k50kKxlTIUhoVQcDcayrUH9SBNzRre2tBXrtYrUhTZgRTFHQHWMq8yZmbR
         L7WTQGNDc32qZIPVY+/fGyDejYcNyXQ32vOzobnLpcccxPERLwy94i0b9hQz80Iw0F
         HXyKjz+NhpmaetDQ46XL+SUjuraQdkA+YJU15vKMsCEWBzhrfulHpyykiPqZ778pH+
         Sp06cC0y+EHVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2845E5C05F8; Thu,  1 Dec 2022 16:21:52 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:21:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qiang1.zhang@intel.com, sfr@canb.auug.org.au
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
Message-ID: <20221202002152.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
 <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
 <87lenqq012.fsf@jogness.linutronix.de>
 <20221201215650.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <87edtipycj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edtipycj.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:18:44PM +0106, John Ogness wrote:
> On 2022-12-01, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > I therefore need to pull this into the pile for the upcoming merge
> > window:
> >
> > dbc6ca150842 ("srcu: Make Tiny synchronize_srcu() check for readers")
> >
> > And kudos to Zqiang for a proactive fix!  ;-)
> 
> Yes! Great job!
> 
> > I will add your (John's) Tested-by, but please let me know if this is
> > inappropriate.
> 
> Sure.
> 
> Tested-by: John Ogness <john.ogness@linutronix.de>

Applied, thank you!

The new -rcu branch is srcunmisafe.2022.12.01a.

Adding Stephen Rothwell on CC because Mr. Murphy says that this change
will once again mess up -next.  Apologies in advance!!!

							Thanx, Paul
