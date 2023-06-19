Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E319735900
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFSN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14E128
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AECD60C72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F853C433C8;
        Mon, 19 Jun 2023 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687183122;
        bh=CDEdPUNLuINNm5vT+mT//9EOuPnulyiEOGsPKwBeOAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfliLEv7dYcFbWHLpRyjO0wYoMYpE8yymjGa1Fvk7xQsemNjWhURCLibUCUn21c92
         JFYjE2aRGVwHYP0iigzLmG5mHciRY0YJJ91PbMwq6hbVJc+3DxyNSOWuJE4tiacK66
         5R+cS/bj+plpv69TYEUIAEHi1gt+Yg58je5vnwaY=
Date:   Mon, 19 Jun 2023 15:58:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: JFYI: patches in next that might be good to mainline rather
 sooner than later?
Message-ID: <2023061936-eatable-grumbling-f3c1@gregkh>
References: <9e0f5378-63d8-add4-2b79-2173a4c98086@leemhuis.info>
 <24edd13e-791a-bd05-0a44-dd5475c7e200@leemhuis.info>
 <2023061955-abdominal-refute-4b5a@gregkh>
 <97b81eab-8e09-2163-1b91-daecb8127a7c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b81eab-8e09-2163-1b91-daecb8127a7c@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 02:19:49PM +0200, Thorsten Leemhuis wrote:
> Last year on the maintainers summit we discussed this "delayed stable
> backport" thingy that afaik works something like this:
> 
> Cc: <stable@vger.kernel.org> # after 4 weeks
> 
> Or is it more like this?
> 
> Cc: <stable@vger.kernel.org> # 6.2 [after 4 weeks]
> 
> I think the conclusion was to add this to the documentation, but that
> afaics never happened. If you tell me the format you or your scripts
> expect, I'd be willing to create a patch.

Either of them will work, as my "script" is me reviewing each patch :)

It's rare that I see this, I have been doing it for a few USB patches
recently, but I don't mark them as I know to hold off on stable
integration a bit, but I can't read the minds of other maintainers.

> > The "fixes-only" commits are a bit more interesting, we still have huge
> > swaths of subsystems that refuse to actually tag commits for stable, but
> > luckily developers know to at least put a "Fixes:" tag on their fixes,
> > which help us out in classifying where they should go.
> 
> Various aspects contribute to this, but due to my regression tracking
> efforts two of them jumped to my mind here:
> 
> * A clear statement from Linus wrt to the stable tags in changes that
> fix regressions would be good. E.g. something along the lines of "always
> add a CC: <stable@... tag when fixing a regression caused by change
> mainlined during the past year to ensure the fix reaches the users of
> stable trees quickly".

Sounds good to me for you to say that!  It should happen, but remember
many maintainers still don't want to, or feel they need to, tag anything
for stable.  And that's fine, I can't tell people what to do and the
stable tree stuff was ALWAYS designed to never require maintainers to do
more work than they wanted to.

Hence Sasha's great AUTOSEL work in digging out patches from those
subsystems that do NOT mark anything for stable.

So while we can ask, we can never require.

> * a (big?) part of the problem afaics is that many developers and
> maintainers seem to think that a "Fixes:" tag is enough to ensure a
> backport. You efforts educating them[2] at least from here look a bit
> like a endless game of whac-a-mole, as you sent such mails for quite a
> while already and it seems nothing much has changed. Sometimes I wonder
> if we should spam everyone in MAINTAINERS (and some of the regular
> developers as well?) with a short PSA trying to kill that myth. But I
> don't really like that idea myself. Maybe it would help if Linus
> mentions it two or three times in release announcements?
> 
>   [2] for the unaware and the record, here are two recent ones:
> https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/
> https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/

Given that the cc: stable predates the Fixes: tag by years, it's funny
that people don't realize this.

BUT it's the fixes tag that we have been using for those subsystems that
do NOT tag stuff for stable, so I guess when people saw patches flow in,
they just "assumed" that this was the normal process.

So yes, I'll keep reminding people, and Sasha does a great job in
sweeping up the Fixes: only patches, it is never guaranteed that this
will get into a stable release.

Except for a yearly "here is how stable works" email like you say to all
MAINTAINERS, I don't know how it would be any more explicit than what we
have documented today.  Maybe I should do that yearly type of an email,
consider it a christmas card update or something :)

thanks,

greg k-h
