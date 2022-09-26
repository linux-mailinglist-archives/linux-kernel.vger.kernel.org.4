Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537D5E9A39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiIZHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiIZHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C610F3136D;
        Mon, 26 Sep 2022 00:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE2361785;
        Mon, 26 Sep 2022 07:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6EDC433C1;
        Mon, 26 Sep 2022 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664176154;
        bh=+wwySMrMtE5CQ6gKHpsT7ms5I9rHyoBUL87VEi0oDP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1+NL5oeoW+aj/l9B3+3Sh9nqoAlC6A3JngBgscVBPS0e/Vu4dNrTNcVropQczx/Q
         1O0L1R7HvLYovDo+zujHFZyS0OZ94oVCnahT6vgs3N8shPACeqX+NDWud7TJQBlCwQ
         6pyQ9zpd9zuV44nlicUdPuMIXSf38Km8N+l4sTJ0=
Date:   Mon, 26 Sep 2022 09:09:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Christoph Hellwig <hch@lst.de>,
        Dusty Mabe <dusty@dustymabe.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <YzFQF3cccwK1G2FS@kroah.com>
References: <Yx/jLTknQm9VeHi4@T590>
 <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
 <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
 <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
 <c7c909aa-71d9-b43c-293e-d4801a00861e@kernel.dk>
 <Yysj6AXQ44/el4pS@kroah.com>
 <cecf4c71-14be-4ff8-df83-cfd1da102bcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cecf4c71-14be-4ff8-df83-cfd1da102bcf@kernel.dk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:56:53AM -0600, Jens Axboe wrote:
> On Wed, Sep 21, 2022 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 08:34:26AM -0600, Jens Axboe wrote:
> > > On 9/21/22 3:25 AM, Thorsten Leemhuis wrote:
> > > > On 20.09.22 16:14, Jens Axboe wrote:
> > > >> On 9/20/22 8:12 AM, Christoph Hellwig wrote:
> > > >>> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
> > > >>>> Christoph and I discussed this one last week, and he has a plan to try
> > > >>>> a flag approach. Christoph, did you get a chance to bang that out? Would
> > > >>>> be nice to get this one wrapped up.
> > > >>>
> > > >>> I gave up on that as it will be far too much change so late in
> > > >>> the cycle and sent you the revert yesterday.
> > > >>
> > > >> Gotcha, haven't made it all the way through the emails of the morning yet.
> > > >> I'll queue it up.
> > > >
> > > > Thx to both of you for taking care of this.
> > > >
> > > > Nitpicking: that patch is missing a "CC: stable@..." tag to ensure
> > > > automatic and quick backporting to 5.19.y. Or is the block layer among
> > > > the subsystems that prefer to handle such things manually?
> > > >
> > > > Ohh, and a fixes tag might have been good as well; a "Link:" tag
> > > > pointing to the report, too. If either would have been there, regzbot
> > > > would have noticed Christoph's patch posting and I wouldn't have
> > > > bothered you yesterday. :-) But whatever, not that important.
> > >
> > > We'll just have to ensure we ping stable on it when it goes in.
> >
> > If you have a git id that is not going to change, I can watch out for it
> > to land in Linus's tree...
> 
> This is the one:
> 
> commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06 (origin/block-6.0, block-6.0)
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Sep 19 16:40:49 2022 +0200
> 
>     Revert "block: freeze the queue earlier in del_gendisk"
> 
> Thanks Greg!

Now queued up, thanks.

greg k-h
