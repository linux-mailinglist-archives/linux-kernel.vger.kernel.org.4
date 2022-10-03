Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96E5F3138
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJCN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJCN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:26:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6E23397
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:26:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2BFC1F941;
        Mon,  3 Oct 2022 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664803574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTTXws0gsUw4MuWZ4kkiI9yugm1LaXMelRQ8q3jakdw=;
        b=RADpKet7DFnCo24kuq7lVS+/2qyex0MVxJRMvxzTi6VCH5VDd/JOfcUx1N9LyMaekepToJ
        ZnrZnsweUM/6u2X93Cu0Soe+yybBdyxRzBe5Mj75CMSV/Qk23s2PKOPBr/01nX9ZyA4LkT
        bQtfiFTcgCol8hcQYcM21O2bNP0NE/o=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 568582C142;
        Mon,  3 Oct 2022 13:26:14 +0000 (UTC)
Date:   Mon, 3 Oct 2022 15:26:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <Yzri9bJiS46Bd1DH@alley>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
 <YzbyBA9uJUL/a32P@smile.fi.intel.com>
 <20220930140531.r6txx6ujvvbrr7hh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930140531.r6txx6ujvvbrr7hh@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 16:05:31, Uwe Kleine-König wrote:
> On Fri, Sep 30, 2022 at 04:41:24PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 30, 2022 at 01:10:50PM +0200, Uwe Kleine-König wrote:
> > > For code that emits a string representing a usual return value it's
> > > convenient to have a 0 result in a string representation of success
> > > instead of "00000000".
> > 
> > This is a controversial change. For APIs that comes to my mind it means
> > "OPTIONAL resource NOT FOUND, while no error happened". Doe it mean success?
> > I don't think so.
> 
> OK, agreed. Would you feed such a value unchecked to %pe today (i.e.
> without my patch)?

People are primary interested into debug messages when things does
not work as expected. The check might be missing intentionally
to show all values or by mistake.

The tracepoint, used as motivation for this patch [1], is exactly
the situation where return values are printed without any check.

The problem is that %pe is used for both pointer and integer
return values. They have different semantic.

I do not feel comfortable with "improving" one use case and
breaking the other.

One solution would be to add support for "%de" but this would break
things. "%de" is supposed to print the 'e'. For example, it should
printk "123e" when the given number is 123.

Another solution would be to add modifier for the "%pe" modifier.
For example, "%ped". It would mean that the given value is in "int"
range. It could even print non-hashed value when it is out of range.

[1] https://lore.kernel.org/linux-pwm/20220916151506.298488-2-u.kleine-koenig@pengutronix.de/

Best Regards,
Petr
