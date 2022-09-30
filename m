Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE475F10C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiI3R1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiI3R1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872561C3DF7;
        Fri, 30 Sep 2022 10:27:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 019271F8B9;
        Fri, 30 Sep 2022 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664558829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFL6LlhwvZGz/p5H7pzHxGfwk3dZsCKYsSd1m5JM4oM=;
        b=fVFmnuf1u1KQlPpWHU/orNzNBxCa48mSUZkdDX4xlVMEG3NTwC9YxcZf+MalvdIs8VPDMC
        osCorspvdyRlzuSH6nWTp5FHT9YJrkRNI+xnlBo1Cinbk4bxPlh8r1QOWYUzGwN4Ing/dy
        eTbPx3G/4qET3f0xn+WB1F2qlpsf9P8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 526442C161;
        Fri, 30 Sep 2022 17:27:08 +0000 (UTC)
Date:   Fri, 30 Sep 2022 19:27:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
Message-ID: <Yzcm6Fb6FJGbspgY@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-11-john.ogness@linutronix.de>
 <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
 <YzarXlj1NyFGTC08@alley>
 <87o7uxugbr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7uxugbr.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 15:50:56, John Ogness wrote:
> On 2022-09-30, Petr Mladek <pmladek@suse.com> wrote:
> > Anyway, what about using the later added SRCU walk here?
> > After all, this is exactly what RCU is for, isn't it?
> 
> So I think a lot of the problems with this series is that SRCU is
> introduced too late. We are debating things in patch 6 that are
> irrelevant by patch 12.

> I will rework the series so that the changes come in the following
> order:
> 
> 1. provide an atomic console_is_enabled()
>
> 2. convert the list to SRCU
> 
> 3. move all iterators from console_lock()/console_trylock() to SRCU
> 
> Step 3 may result in console_lock()/console_trylock() calls disappearing
> or relocating to where they are needed for non-list-synchronization
> purposes.

I agree that introding SRCU as early as possible would
help. The current patchset converts the same code several times...

Best Regards,
Petr
