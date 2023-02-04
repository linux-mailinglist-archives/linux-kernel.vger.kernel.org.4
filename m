Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938468AA94
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBDOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:34:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C12301AB;
        Sat,  4 Feb 2023 06:34:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA511B8091A;
        Sat,  4 Feb 2023 14:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ADCC4339B;
        Sat,  4 Feb 2023 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675521263;
        bh=2aZTZsTIjz5o7VqmbvFNDm179P0IG4A3ReKEER0W7t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpFYR3U6GmYf733FDc53N06eR4bPX0unMeUeCpuzC+Sb0+UBX8on6oIa49C+9moQ+
         zmC+Y65c9mzMnAxcbJN5tdN14mqpHEq8RQdBA9we4lNyK9Pc+uWTu4hG0ErIuEezKh
         mqP5P+4Hx6jcopYcphyj13Ea43PyALsTm3t3R9Ow=
Date:   Sat, 4 Feb 2023 15:34:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y95s7P+Z2nOz4lDE@kroah.com>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 11:21:27PM +0900, Tetsuo Handa wrote:
> On 2023/02/04 22:47, Greg Kroah-Hartman wrote:
> > On Sat, Feb 04, 2023 at 10:32:11PM +0900, Tetsuo Handa wrote:
> >> Hello.
> >>
> >> There is a long-standing deadlock problem in driver core code caused by
> >> "struct device"->mutex being marked as "do not apply lockdep checks".
> > 
> > The marking of a lock does not cause a deadlock problem, so what do you
> > mean exactly by this?  Where is the actual deadlock?
> 
> A few of examples:
> 
>   https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
>   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
>   https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

Random links to syzkaller reports that are huge and not descriptive does
not actually persuade me as I don't have the inclination to dig through
them, sorry.

Specific examples, with code, please.

> >> We can make this deadlock visible by applying [1], and we can confirm that
> >> there is a deadlock problem that I think needs to be addressed in core code [2].
> > 
> > Any reason why you didn't cc: us on these patches?
> 
> We can't apply this "drivers/core: Remove lockdep_set_novalidate_class() usage" patch

What patch is that?  I do not see that in my inbox anywhere.  I don't
even see it in my lkml archive, so I do not know what you are talking
about.

> until we fix all lockdep warnings that happen during the boot stage;

What lockdep warnings?

> otherwise syzbot testing can't work which is more painful than
> applying this patch now.

Again, I'm totally confused.  What is the real bug/problem/issue here?

Where is the deadlock?

> Therefore, I locally tested this patch (in order not to be applied now).

What patch?  I'm totally confused.

> And I got a lockdep warning on the perf_event code.

What warning?

> I got next lockdep warning on the driver core code when I tried a fix
> for the perf_event code suggested by Peter Zijlstra.

Again, what warning?

> Since Peter confirmed that this is a problem that led to commit
> 1704f47b50b5 ("lockdep: Add novalidate class for dev->mutex
> conversion"), this time I'm reporting this problem to you (so that you
> can propose a fix for the driver core code).

Again, I have no idea what the real problem is!

Please show me in the driver core code, where the deadlock is that needs
to be resolved.  Without that, I can't answer anything...

totally and throughly confused,

greg k-h
