Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307C665F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAKPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjAKPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:36:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124A19C2C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:36:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 75A2F4CA5;
        Wed, 11 Jan 2023 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673451400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xT70OWcz833cuZFvU6lsxCC9SixCafTZ0oSiz97CmfE=;
        b=a1XgE2AEDfI2pmKsQcZKd/Nn6GvJw6PpzPFF8zM5YajPNQg1+06otGxSDbhCW14VIwWGAI
        ndybgQ2FY5cSZZAAH8P41ND2HEAwbq5utx+tW4MDswkJWpZCM6TxqJgmwi2Z11Mpb3ch8F
        5aZC/GbFiYxhSvPNqUJnFQSCAfAcGAg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13E3D2C141;
        Wed, 11 Jan 2023 15:36:39 +0000 (UTC)
Date:   Wed, 11 Jan 2023 16:36:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 0/8] printk: cleanup buffer handling
Message-ID: <Y77XhV0oLEyRqa2r@alley>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
 <Y7wue/a2Pz0hi2cJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wue/a2Pz0hi2cJ@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-09 16:10:52, Petr Mladek wrote:
> On Mon 2023-01-09 11:13:52, John Ogness wrote:
> > Hi,
> > 
> > This is v5 of a series to cleanup console buffer handling and
> > prepare for code sharing with the upcoming threaded/atomic
> > consoles. v4 is here [0].
> > 
> > The main purpose of the series is to introduce two new lockless
> > functions to handle reading and formatting of printk messages. These
> > functions can then be used from any context, which is important for
> > the upcoming threaded/atomic consoles. The series also helps to
> > cleanup some of the internal printk interfaces and cleanly separate
> > formatting code from outputting code.
> > 
> > Changes since v4:
> > 
> > - Make console_prepend_dropped() a NOP for !CONFIG_PRINTK to
> >   workaround compiler warnings.
> > 
> > - In devkmsg_read() use printk_get_next_message() for the wait
> >   condition instead of looping to retry the actual read.
> > 
> > - Add an argument @may_suppress to printk_get_next_message() so
> >   devkmsg_read() can specify that records should not be skipped
> >   based on loglevel.
> > 
> > John Ogness
> > 
> > [0] https://lore.kernel.org/lkml/20230105103735.880956-1-john.ogness@linutronix.de
> > 
> > John Ogness (6):
> >   printk: move size limit macros into internal.h
> >   printk: introduce struct printk_buffers
> >   printk: introduce printk_get_next_message() and printk_message
> >   printk: introduce console_prepend_dropped() for dropped messages
> >   printk: use printk_buffers for devkmsg
> >   printk: adjust string limit macros
> > 
> > Thomas Gleixner (2):
> >   console: Use BIT() macros for @flags values
> >   console: Document struct console
> 
> The series looks ready for linux-next from my POV.
> 
> I am going to push it into a new branch rework/buffers-cleanup within
> two days or so unless anyone speak against it.

JFYI, the patchset has been committed into printk/linux.git,
branch rework/buffers-cleanup.

It it intended for the next 6.3 merge window.

Best Regards,
Petr
