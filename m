Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBC600DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJQLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJQLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:32:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879162559D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B7E8B81187
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C9EC433C1;
        Mon, 17 Oct 2022 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666006356;
        bh=95sQqzawlZHJ6uTwP64J98sMDGemH04NWpgtung+IrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7F+y2hZlMyosCjis9AdpKxOfcjfTSaJSmRUa4txeESy1JZYbpUpELaeY5QAZ9TOc
         uazKGwaXmluEt9UuIo5mRDbQ32B908t61gKVFl1CT6ZudPwgXYsJ5MsXhHi6ln2k3R
         lqdCFeQPY7wjNJt0xf3Bu+jyjTW9sjRkHRAMgNCs=
Date:   Mon, 17 Oct 2022 13:32:33 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Message-ID: <Y009UQUfn4m/1IET@kroah.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
 <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com>
 <Y00Mfgymi+Xv6El3@kroah.com>
 <b13c5bb641d64433a85c52f694a838e7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13c5bb641d64433a85c52f694a838e7@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:24:26AM +0000, David Laight wrote:
> From: Greg Kroah-Hartman
> > Sent: 17 October 2022 09:04
> > 
> > On Mon, Oct 17, 2022 at 07:54:52AM +0000, Sakari Ailus wrote:
> > > Hi Greg,
> > >
> > > On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> > > > If a const * to a kobject is passed to kobj_to_dev(), we want to return
> > > > back a const * to a device as the driver core shouldn't be modifying a
> > > > constant structure.  But when dealing with container_of() the pointer
> > > > const attribute is cast away, so we need to manually handle this by
> > > > determining the type of the pointer passed in to know the type of the
> > > > pointer to pass out.
> > >
> > > Alternatively container_of() could be fixed, but that will likely produce
> > > lots of warnings currently.
> > 
> > Yeah, we can not do that because, as you found out, there's just too
> > many warnings that it would cause.  Let's work on the individual
> > subsystems to clean them all up first before worrying about the core
> > container_of() macro as that should fix the majority of the build
> > warnings.
> 
> Is it possible to generate a fixed container_of() with a
> different name and then use that to clean up the subsystems?
> Then finally rename it back?
> 
> That you probably be a lot less churn.

That's the identical churn.
