Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925AC609E70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJXKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJXKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D95A160
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C37061166
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727BC433C1;
        Mon, 24 Oct 2022 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666605719;
        bh=cDnYOWhhOm4r0Ge2hDn+Dpz893psrd9PzlIJm4K3Ccw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6SpKrWO9cG4NtrP6Fq23fZcUJpgRGq8BLbRKsY3NuPYToFuGyWRwMeWUSm3QwBWh
         FR6y79wNO0nDJr7DZ0plT3Hn2MNCxSHIRycIOF3Dw2RX3FjvHzC62yRBxf0p50GDSK
         3QKY0iNDoJ2byybbtpMAXkIunK/dh2VGK7B2c0bc=
Date:   Mon, 24 Oct 2022 12:01:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZilPypeNNjl/6J@kroah.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
 <Y1ZZcL/Q7QJ+YYhJ@smile.fi.intel.com>
 <fbe735d131a44c2a95248cc4ad51485b@AcuMS.aculab.com>
 <Y1ZcyBd2Yjir/dNO@smile.fi.intel.com>
 <57360b976d5944babe1e85fc51b3f6f6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57360b976d5944babe1e85fc51b3f6f6@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:46:40AM +0000, David Laight wrote:
> From: 'Andy Shevchenko'
> > Sent: 24 October 2022 10:37
> > ...
> > 
> > > > > > Wait, no one uses this macro, so why not just remove it entirely?
> > > > >
> > > > > Good question. It appears to be a (relatively) common pattern to look up
> > > > > something and the return its containing object if the lookup was
> > > > > successful. Doing a quick
> > > > >
> > > > > 	$ git grep 'container_of.*:' drivers include
> > > > >
> > > > > reveals more than 20 instances of the pattern. There are probably more
> > > > > those that use if for testing for NULL. I guess people don't know about
> > > > > this macro, apart from the developers of the staging driver it was added
> > > > > for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).
> > > >
> > > > Maybe we can provide an example to keep this macro in the kernel, meaning
> > > > convert one of the drivers / subsystem to actually use it?
> > >
> > > Adding _safe() to a function name doesn't actually tell you anything.
> > > You still need to look up what it is 'safe' against.
> > >
> > > In this case the full code pattern is actually much clearer.
> > >
> > > It is also quite likely that it is followed by an:
> > > 	if (!ptr)
> > > 		return xxx;
> > > You that can/should really be put before the container_of() call.
> > 
> > return statements in macros are no go. Or you meant something else?
> 
> I meant in the function itself.
> 
> It might be interesting to check how many of the function
> can actually have a NULL pointer?
> Especially in staging code might be being 'defensive'.

This is a pointless discussion, this macro will now be deleted, sorry.

greg k-h
