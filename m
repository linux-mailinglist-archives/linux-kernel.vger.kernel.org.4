Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63EE68EECE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjBHMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBHMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:21:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A426CE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F80B616A7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A47C433D2;
        Wed,  8 Feb 2023 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675858863;
        bh=ZE61/gpGaZcbujb/9CQDWc8EVfZYAwbH+E5VhghTX34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZIZHzHHIgebCH6fBk7tv0OpgGe3KUPB00UMv4y4x0nuOypsGhWWyjfXl6b/JyQW3
         xU4B1lztaHRwkpZrXmTnpBG2LjONnsRxw59VhSgdYdpmeWZWxC/XfXSWp2jd4K7MUb
         Os/yVK547Sjpjkk6JqXftylEwW6ZjOplQFblmt1Q=
Date:   Wed, 8 Feb 2023 13:21:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Chris Down <chris@chrisdown.name>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] kernel/printk/index.c: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y+OTrA6E3ld+awa7@kroah.com>
References: <20230202151411.2308576-1-gregkh@linuxfoundation.org>
 <Y9ze8RERj/E1BF8A@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ze8RERj/E1BF8A@alley>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:16:17AM +0100, Petr Mladek wrote:
> On Thu 2023-02-02 16:14:11, Greg Kroah-Hartman wrote:
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To make things simpler, just
> > call debugfs_lookup_and_remove() instead which handles all of the logic
> > at once.
> > 
> > Cc: Chris Down <chris@chrisdown.name>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> JFYI, the patch has been committed into printk/linux.git, branch for-6.3.

Wonderful, thank you!

greg k-h
