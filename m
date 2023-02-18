Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208269B8D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBRIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:54:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0803C792
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:54:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B4860909
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 08:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C63C433EF;
        Sat, 18 Feb 2023 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676710455;
        bh=M0KZIpvZENwj1uzIM0ne/gt/L6cq4cB4mbBHSeUv2Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1C5y0o5k97dqezI6+zyiyzEvFPLALtXHS9ehludc8HdYfdRK1ciiU4ALNThqg60F
         p3KWAvS3JYdgCgiQORleU63BK6ATvDhG7ZgkI/sGnwG0x3muCKJvsPEryTvrII/+bw
         wmLz9moU6xG0fDwDte9zOUvd8XP6B77yqpCExmcU=
Date:   Sat, 18 Feb 2023 09:54:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
Message-ID: <Y/CSNLm9iihwRa72@kroah.com>
References: <20230218083252.2044423-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 12:32:47AM -0800, Saravana Kannan wrote:
> Hi Mark/Liam,
> 
> This series is just an RFC to see if you agree with where this is going.
> Please point out bugs, but don't bother with a proper code review.
> 
> The high level idea is to not reimplement what driver core can already
> handle for us and use it to do some of the work. Instead of trying to
> resolve supplies from all different code paths and bits and pieces of
> the tree, we just build it from the root to the leaves by using deferred
> probing to sequence things in the right order.
> 
> The last patch is the main one. Rest of them are just setting up for it.
> 
> I believe there's room for further simplification but this is what I
> could whip up as a quick first draft that shows the high level idea.
> I'll probably need some help with getting a better understanding of why
> things are done in a specific order in regulator_register() before I
> could attempt simplifying things further.
> 
> Ideally, regulator_register() would just have DT parsing, init data
> struct sanity checks and adding the regulator device and then we move
> everything else to into the probe function that's guaranteed to run only
> after the supply has been resolved/ready to resolve.
> 
> fw_devlink/device links should further optimize the flow and also allow
> us to simplify some of the guarantees and address some of the existing
> FIXMEs. But this patch series is NOT dependent on fw_devlink or device
> links.
> 
> Any thoughts on where this is going?
> 
> I've tested this on one hardware I have and it works and nothing is
> broken. But the regulator tree in my hardware isn't that complicated or
> deep. The regulators are also added mostly in the right order (due to
> existing fw_devlink). So if you agree with the idea, the next step is to
> ask people to give it a test.
> 
> Also, it's based on driver-core-next since that's what I had synced up
> and had a working baseline. I'll rebase it on the regulator tree when I
> go from RFC -> PATCH.

At first glance, this looks sane to me, thanks for doing this work!

greg k-h
