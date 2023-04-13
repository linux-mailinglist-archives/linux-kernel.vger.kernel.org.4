Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E416E0F13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjDMNnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDMNng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:43:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9ADBB92
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:42:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 890AD218B1;
        Thu, 13 Apr 2023 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681393328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laiMbeK7JM+yqQBuZgOEovH0qN4DzeU6w/zO8nnlU6g=;
        b=FsVF1dUBTNAgHOaQEIvxa2MQ39g2evXXxk0lBR+tiBwjv5PNDbsJfmUIFLtRxyFsb62UgW
        VDuHHVugz+w/3ATqOKy2tDPM1irizPPQ7ommpzATV0bB6IRGWmmHVpZ/PWBZgTN0EzNjCv
        KI07YXiplfFjjoVrfQiGf6JsH0dhr/k=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58D5C2C143;
        Thu, 13 Apr 2023 13:42:08 +0000 (UTC)
Date:   Thu, 13 Apr 2023 15:42:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/18] printk: Add NMI check to
 down_trylock_console_sem()
Message-ID: <ZDgGsJ2BKwXpeuoj@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-3-john.ogness@linutronix.de>
 <ZAdgtcbPyQ/8dIDw@alley>
 <874jqj7gmj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jqj7gmj.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-03-17 12:43:56, John Ogness wrote:
> On 2023-03-07, Petr Mladek <pmladek@suse.com> wrote:
> > So that this change would cause a non-paired console_unlock().
> > And console_unlock might still deadlock on the console_sem->lock.
> 
> Yes, but at least it would have flushed beforehand.
> 
> > One solution would be to call console_flush_all() directly in
> > console_flush_on_panic() without taking console_lock().
> >
> > It should not be worse than the current code which ignores
> > the console_trylock() return value.
> 
> I think your suggestion is acceptable.
> 
> > Note that it mostly works because console_flush_on_panic() is called
> > when other CPUs are supposed to be stopped.
> >
> > We only would need to prevent other CPUs from flushing messages
> > as well if they were still running by chance. But we actually already
> > do this, see abandon_console_lock_in_panic(). Well, we should
> > make sure that the abandon_console_lock_in_panic() check is
> > done before flushing the first message.
> >
> > All these changes together would prevent deadlock on
> > console_sem->lock.  But the synchronization "guarantees" should stay
> > the same.
> 
> We could also update console_trylock() and console_lock() to fail and
> infinitely sleep, respectively, when abandon_console_lock_in_panic() is
> true. That would prevent CPUs from newly acquiring the console lock and
> interfering with the panic CPU.

Interesting idea. It should be safe after panic() tries to
stop the CPUs. But I am slightly worried to do this earlier.

I wonder if it might block, for example, trigger_all_cpu_backtrace()
that is called when (panic_print & PANIC_PRINT_ALL_CPU_BT) bit is set.

Best Regards.
Petr
