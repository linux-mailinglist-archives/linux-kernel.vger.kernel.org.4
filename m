Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB215F4FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJEGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJEGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:24:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2F120A5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AAD9B81C76
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A4DC433C1;
        Wed,  5 Oct 2022 06:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664951085;
        bh=M/Q+9mGG+P81XeSVT+uevouZE4XbbGBku5NH0ti+rPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvedLHbjDV9v+QYxDIARdT7tVWo5CVPYL8rLYzeZ3Psp4ACLRlZJY9XK0p9nVde7l
         mA1MRNsHmQ0yvN3Zra+Pw3gV87/C6LENtVWLH911/bDHhhH5xycQG18Lbktbh73pYc
         XKV41R9PHmRyNROpgfbBjMdjJ1q8YXpCGks/b4nY=
Date:   Wed, 5 Oct 2022 08:25:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Yz0jVbfDOITZfE9M@kroah.com>
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com>
 <Yzxl2oczTtwEvIqt@chromium.org>
 <Yzxsu2Ms43eTfOYR@kroah.com>
 <Yzy6KNUHFqxWZb9U@chromium.org>
 <CAODwPW-7Y_CbCch+Y5unH3yJD1T=3epYvqja6w_CB-23C9x9sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW-7Y_CbCch+Y5unH3yJD1T=3epYvqja6w_CB-23C9x9sw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:10:01PM -0700, Julius Werner wrote:
> > > Then how does the kernel know what to print out?  Why not add such a
> > > reference somewhere?
> >
> > The kernel really doesn't need to know the list of possible ids: it
> > simply reads what coreboot gives it from the coreboot tables and proxies
> > that on up to sysfs nodes.
> >
> > In an earlier version of this patch
> > (https://lore.kernel.org/chrome-platform/CAODwPW-JzXXsEANaS+6n695YqriAQ0j0LXm31R2u1OP3MhX9Uw@mail.gmail.com/T/#u),
> > I actually had this list so that the directory names were human-readable
> > instead of using the 32-bit CBMEM id, but Julius didn't like it citing
> > that we'd have to keep the kernel tree and the coreboot tree in sync.
> >
> > I'm fine with either solution ... just want to make all parties happy
> > here =)
> 
> There is quite a long list of possible IDs (79 at the current count),
> many of them are just coreboot-internal implementation details for
> specific platforms that are really not interesting to the running OS
> after we're done booting, and new ones get added all the time. I don't
> think there's any practical value in trying to maintain a
> corresponding list in the kernel, it would just be unnecessary bloat
> and a maintenance nightmare to keep in sync.
> 
> This whole driver is supposed to be a thin bridge between coreboot and
> coreboot-specific userspace tools. Those tools will know about the
> specific meaning of individual IDs and the data format of their
> contents, and they are much easier to keep updated and in sync with
> new coreboot releases than the kernel itself. So the whole goal of the
> design is to leave all those details to the userspace tools and have
> the kernel involved as little as possible, just passing the raw
> information through without being involved in its interpretation.

If the kernel is reporting a value, that value needs to be documented
somewhere.  If the kernel is acting on that value, it needs to know what
those values are.

In this specific instance it seems that the kernel knows a subset of the
values, and some random userspace tool knows all of them?  Think about
what you would want to see here if you knew nothing about this at all.

thanks,

greg k-h
