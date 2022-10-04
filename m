Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144A5F3D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJDH3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJDH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:29:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B94D244
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:28:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB0871F914;
        Tue,  4 Oct 2022 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664868533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu0Bj/Z++bDprCboDOYyy/3zE2MzwZRpWsw/NxS0jsE=;
        b=Dnb6xDnJvDPplCbzyU8Snt+kaQUa/z3rBZ2H8cgT8hU/IFxRBriDDqWWecCxzm7liKGvgk
        OZybRD4lUAsyHChbiEl+gllTxGOtmGMootg6MANx5pK/Gtqd47ex9+XIj+zr5n3VAIK0gF
        YiLWWSlD586woGtZQIEExU3CvKmBmfQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B83F2C143;
        Tue,  4 Oct 2022 07:28:53 +0000 (UTC)
Date:   Tue, 4 Oct 2022 09:28:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzvgtQLLTKQEXlnD@alley>
References: <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
 <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de>
 <YzcvvPargLYDHhgq@alley>
 <87zgeg7gnb.fsf@jogness.linutronix.de>
 <YzrzmHZYxp8iKEDT@alley>
 <87a66c66px.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a66c66px.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-03 21:41:22, John Ogness wrote:
> On 2022-10-03, Petr Mladek <pmladek@suse.com> wrote:
> > What is exactly wrong with console_lock, please?
> 
> It is ambiguously performing multiple tasks:
> 
> - protecting the console list
> - protecting individual console fields
> - serializing console printing
> - stopping all console printing
> 
> And the answer to that is: A BKL is preventing us from optimizing the
> kernel by decoupling unrelated activities.
>
> > The above proposal suggests that it might be something like:
> >
> > register_console()
> > {
> > 	console_list_lock();
> >
> > 	if (!need_console())
> > 		goto out;
> >
> > 	if (!try_enable_console())
> > 		goto out;
> >
> > 	if (!(con->flags & CON_NOBLK))
> > 		console_lock()
> 
> Why are you taking the console_lock here? The console_list_lock needs to
> replace this responsibility. I realize the RFC and this v1 series does
> not do this. For v2, it will be clear.

This is the important information that I missed. It is a great idea.
I agree that console_list_lock() would be a step forward if this worked.

As you say, in the RFC and this v1, console_lock() was still used
to synchronize the list and the metadata manipulation. It means that
console_lock() was as complex as before. In fact, it was even
more complex because console_list_lock() appeared in its lock
dependency chains. And it was not clear that v2 would be
any different in this regard.

Best Regards,
Petr
