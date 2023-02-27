Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CB6A41FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjB0MrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0MrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:47:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442221E5DF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D272F60D54
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35995C433EF;
        Mon, 27 Feb 2023 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677502037;
        bh=bSIl4J86D5IiibNBkGu6/3POT7JonYKW4POq9463Uz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MU1S279K64BnlDOGX43INr4aIPeUp7SUpM7rwdIEECiDnXGbZ1Y0GiP3km9lAn9do
         cJBm2kvFYi23ROLGcQx/iwqUNnFkt5ZoZFZ2B97coVs/d0kSxgjMmFWEE2ZXM+hzuE
         N3CEEBk2OPjMuqjFu+8Yjehlyf0gPj8DGhp6sA5mpF7QnbaR8QL1wRC9KnVsO9m3Dz
         pdM9hSYH6+jZD3HbRfJzQ8rMM49tipXl5YWBaDNN1nUn3HxWnw0poUWfVX/yoyG5SU
         VAC9As60yOg8e3P7KWI0FV1ktyBVYZJx70BG/NGFgvvRSeo/bmME4mVll+l3RYOUXk
         +HKAgHal62f4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pWcum-0001vd-VC; Mon, 27 Feb 2023 13:47:37 +0100
Date:   Mon, 27 Feb 2023 13:47:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org, hsinyi@chromium.org, maz@kernel.org
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
Message-ID: <Y/ymaBLXMvZvGQ6Q@hovoldconsulting.com>
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
 <Y/yNxQADtJJLFY5W@hovoldconsulting.com>
 <fff4df7a-1c19-72e4-c9ab-aeed27b9bc6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff4df7a-1c19-72e4-c9ab-aeed27b9bc6d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:25:08PM +0800, Bingbu Cao wrote:
> 
> On 2/27/23 7:02 PM, Johan Hovold wrote:
> > On Mon, Feb 27, 2023 at 06:46:05PM +0800, Bingbu Cao wrote:
> >>
> >> Hi, Johan and Zyngier, 
> >>
> >> I am using a Dell XPS laptop(Intel Processor) just update my
> >> Linux kernel to latest tag 6.2.0, and then I see that the kernel
> >> cannot boot successfully, it reported:
> >> --------------------------------------------
> >> Gave up waiting for root file system device. Common problems:

> >> I am sure that my previous kernel 6.2.0-rc4 work normally, so I
> >> did some bisect and found the commit below cause the failure on
> >> my system:
> >>
> >> 9dbb8e3452ab irqdomain: Switch to per-domain locking
> > 
> > This commit is not in 6.2.0, so I assume you're using a build of Linus's
> > master branch (i.e. what will become 6.3-rc1)?
> 
> Yes, I am using Linus's master branch, the HEAD is d2980d8d8265.
> 
> > 
> >> I really have no idea why it cause my problem, but I see just
> >> reverting this commit really help me.
> >>
> >> Do you have any idea?
> > 
> > Is there anything suspicious in dmesg (e.g. any new warnings or stack
> > dumps)?
> 
> No crash, just the initramfs warning message I mentioned above.

Ok, thanks for confirming. Then I'm afraid the below patch should not
make any difference either.

One more thing you could try is to run with lockdep enabled if you don't
do that already and see if it detects any new issues.

Are you using nvme for the rootfs? Are there any messages in the logs
from when probing the nvme?

It's possible that changed timings may have exposed a bug elsewhere, but
let's see what lockdep says first.

> > One issue with the above commit that affects some systems (e.g. using
> > xen virtualisation) has been reported and fixed already. Could you try
> > applying the following and see if that helps?
> > 
> > 	https://lore.kernel.org/all/20230223083800.31347-1-jgross@suse.com/
> 
> Thanks, I will try and come back.
 
Johan
