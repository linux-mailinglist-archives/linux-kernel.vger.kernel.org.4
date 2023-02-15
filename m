Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99031697E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBOOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBOOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76139288
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:33:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9FA2F20AFF;
        Wed, 15 Feb 2023 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676471625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bp7kJkHo2LZMmsBi1G2Dpd7PljoIr2PrseTlVx/FVWM=;
        b=CaMoRkgdEoWW6i7fHbCTyH/wffR/AuLtVDYwLGos0Cx72Alq3gpw5hCP2kSqUqY6a5QUmk
        NLPHa6ZVmDGH0cAdVYD3zdoBMpJIAHHkTIG+4GOG/W0Pc9/d3Nvehw6rR/Ltf5IRZMvef6
        L8yQ3BH/6JayH1VT4OMlebrsclCA/9g=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 513C52C141;
        Wed, 15 Feb 2023 14:33:45 +0000 (UTC)
Date:   Wed, 15 Feb 2023 15:33:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Michael Thalmeier <michael.thalmeier@hale.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        john.ogness@linutronix.de
Subject: Re: [PATCH v2] tty: ttynull: implement console write
Message-ID: <Y+ztReOGJwAbpv52@alley>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+zEAA1hp+3guGxT@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-02-15 12:37:36, Vincent Whitchurch wrote:
> + Cc: John, Petr
> 
> On Tue, Feb 14, 2023 at 12:59:21PM +0100, Michael Thalmeier wrote:
> > Since commit a699449bb13b ("printk: refactor and rework printing logic"),
> > con->write is called without checking if it is implemented in the console
> > driver. This does make some sense, because for all "normal" consoles it
> > is vital to have a write function.
> > As the ttynull console driver does not need any console output the write
> > function was not implemented. This caused a "unable to handle kernel NULL
> > pointer dereference" when the write function is called now.
> > 
> > To fix this issue, implement an empty write function.
> > 
> > Fixes: a699449bb13b ("printk: refactor and rework printing logic")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> 
> Looking at the referenced commit, the only place I see it calling
> con->write() is from call_console_driver(), which is in turn only called
> from console_emit_next_record().  And console_flush_all(), the only
> caller of console_emit_next_record(), checks that con->write is not NULL
> using console_is_usable() before calling console_emit_next_record().

I see the same. The refactoring moved the check of con->write from
call_console_driver() to console_is_usable(). It detects the NULL
pointer earlier in console_flush_all()...

> What am I missing?  Which code path in the referenced commit calls
> con->write without checking for NULL?

Vincent, could you please provide log with the backtrace?

I wonder if the problem is in the RT-patchset where
console_emit_next_record() is called also from the printk kthread.

That said, the current code is error-prone. The check for non-NULL
con->write is too far from the caller.

I would prefer to make it more safe. For example, I would prevent
registration of consoles without con->write callback in the first
place. It would require, to implement the empty write() callback
for ttynull console as done by this patch.

Anyway, I would like to understand if the "unable to handle kernel NULL
pointer dereference" is a real problem in the current implementation.

Best Regards,
Petr
