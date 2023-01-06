Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C217660564
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjAFRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjAFRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:15:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB17CBCA;
        Fri,  6 Jan 2023 09:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7862B81E1F;
        Fri,  6 Jan 2023 17:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BCC433D2;
        Fri,  6 Jan 2023 17:15:00 +0000 (UTC)
Date:   Fri, 6 Jan 2023 12:14:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in
 vsnprintf()
Message-ID: <20230106121457.05edbbdf@gandalf.local.home>
In-Reply-To: <Y7hDGoCbWG2ZYdlV@alley>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
        <Y7hDGoCbWG2ZYdlV@alley>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 16:49:46 +0100
Petr Mladek <pmladek@suse.com> wrote:

> > Index: linux/lib/vsprintf.c
> > ===================================================================
> > --- linux.orig/lib/vsprintf.c
> > +++ linux/lib/vsprintf.c
> > @@ -2738,6 +2738,15 @@ int vsnprintf(char *buf, size_t size, co
> >  	if (WARN_ON_ONCE(size > INT_MAX))
> >  		return 0;
> >  
> > +	/*
> > +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> > +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> > +	 * dereference and still return # of characters that would be written
> > +	 * if @buf pointed to a valid buffer...
> > +	 */
> > +	if (!buf)
> > +		size = 0;  
> 
> It makes sense except that it would hide bugs. It should print a
> warning, for example:

I agree. This is a bug, and should not be quietly ignored.

> 
> 	char *err_msg;
> 
> 	err_msg = check_pointer_msg(buf);
> 	if (err_msg) {
> 		WARN_ONCE(1, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n");
> 		size = 0;
> 	}

	if (WARN_ONCE(err_msg, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n"))
		size = 0;

  ;-)

-- Steve

> 
> check_pointer_msg() allows to catch even more buggy pointers. WARN()
> helps to locate the caller. WARN_ONCE() variant is used to prevent
> a potential infinite loop.
> 
> > +
> >  	str = buf;
> >  	end = buf + size;
> >    

