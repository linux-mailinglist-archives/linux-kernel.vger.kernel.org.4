Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7A0698045
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBOQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:13:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035639CC3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:13:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF04F1F8D6;
        Wed, 15 Feb 2023 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676477601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO6TMATtoIzjhUOxe6hhhYeI9Ys3fzNE2u1n+L9XlU0=;
        b=aU5eYNsiUKzXdSgol90wtlxGNSEtXqupTpn5XWRKcTf/ol1lAJxAMbWp+e6XmofE41dzdD
        zD+t0L2zHV8ysF1D+SlZparKAASlfkELS2lcpJyk+jBbhvThyGZUiAfIU2CKjhysDUJb/2
        tFbygIDacKDBXGtxcwFqhCbaNnO3WGg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 964782C141;
        Wed, 15 Feb 2023 16:13:21 +0000 (UTC)
Date:   Wed, 15 Feb 2023 17:13:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
Message-ID: <Y+0EnQ/Ujtq+nEFf@alley>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com>
 <Y+ztReOGJwAbpv52@alley>
 <87y1oz7y9s.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1oz7y9s.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-02-15 16:24:23, John Ogness wrote:
> On 2023-02-15, Petr Mladek <pmladek@suse.com> wrote:
> > That said, the current code is error-prone. The check for non-NULL
> > con->write is too far from the caller.
> 
> con->write is supposed to be immutable after registration, so having the
> check "far from the caller" is not a real danger.
> 
> console_emit_next_record() is the toplevel function responsible for
> printing on a particular console so I think it is appropriate that the
> check is made when determining if this function should be called. I also
> think console_is_usable() is the proper place for the NULL check to
> reside since that is the function that determines if printing is
> allowed.

I agree that the current code is not that bad. But still, the call
chain is:

  + console_flush_all()
    + console_emit_next_record()
      + call_console_driver()
	+ con->write()

I could imagine another code that would call call_console_driver()
or console_emit_next_record() directly. We might just hope that
it would check console_is_usable() or con->write pointer before.
I consider this error-prone.

Also, as you say, con->write is immutable. All real consoles have it
defined. It does not make sense to check it again and again.
I would leave console_is_usable() for checks that might really
change at runtime.


> > I would prefer to make it more safe. For example, I would prevent
> > registration of consoles without con->write callback in the first
> > place. It would require, to implement the empty write() callback
> > for ttynull console as done by this patch.
> 
> I would prefer that we do not start encouraging dummy implementations.
> If you insist on con->write having _some_ value other than NULL, then we
> could define some macro with a special value (CONSOLE_NO_WRITE). But
> then we have to check that value. IMHO, allowing NULL is not an issue.

ttynull is really special. It is a dummy driver and dummy callbacks
are perfectly fine. IMHO, one dummy driver is enough. Ideally,
the generic printk code should not need any special hacks to
handle it.

IMHO, normal console drivers would be useless without write()
callback. It sounds perfectly fine to reject useless console
drivers at all. And it sounds like a reasonable check
in register_console() that would reject bad console drivers.

Best Regards,
Petr
