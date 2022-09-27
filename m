Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF675EC772
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiI0PTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiI0PT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:19:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199A1432B9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:19:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AEC2C1F891;
        Tue, 27 Sep 2022 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664291965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9H9FuxWTVZeaYAprCOlqzp8J1vVr73QDuMTqkuhcOk=;
        b=gy8gZezK29Bc7BAGDAS3J70kAMK63Xiv+kq+9OzOd3fWp29fbweFnDys8/6HmcwOp1e6hP
        1EFiKFMPX9p5N+UI53pjMOi+hBDnxC38pOHQ7xB84Me1jdHCl2RB3Uqlnx+KRbi/mMslOz
        Oa+E8qSMjiNUAevwOysHe1wlA1NDiw0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4281C2C16B;
        Tue, 27 Sep 2022 15:19:24 +0000 (UTC)
Date:   Tue, 27 Sep 2022 17:19:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 06/29] printk: Protect [un]register_console() with a
 mutex
Message-ID: <YzMUe5soxMrsFM8V@alley>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.712668210@linutronix.de>
 <YzLIy4emYX6JpzuN@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLIy4emYX6JpzuN@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-27 11:56:30, Petr Mladek wrote:
> On Sun 2022-09-11 00:27:41, Thomas Gleixner wrote:
> > Unprotected list walks are a brilliant idea. Especially in the context of
> > hotpluggable consoles.
> 
> Yeah, it is crazy. And it is there probably since the beginning.
> 
> > @@ -3107,13 +3143,14 @@ void register_console(struct console *ne
> >  	bool realcon_enabled = false;
> >  	int err;
> >  
> > -	for_each_console(con) {
> > +	console_list_lock();
> 
> Hmm, the new mutex is really nasty. It has very strange semantic.
> It makes the locking even more complicated.

Please, continue the discussion in the reply to the v1 patchset,
see https://lore.kernel.org/r/YzMT27FVllY3u05k@alley

I send it to this RFC by mistake.

I am sorry for the mess.

Best Regards,
Petr
