Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4A5C0042
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIUOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIUOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A89835C;
        Wed, 21 Sep 2022 07:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6843261CF5;
        Wed, 21 Sep 2022 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6568FC433D6;
        Wed, 21 Sep 2022 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663771627;
        bh=vA63dnuahnhCE3YTH1Y9D3wDgCIKrDiu7xCHCLKXjys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zi8uPZEkf4MQtaahUsqjgDLjlangK/V1F6GT+oXQPvtR4hPhDjT/QcrtnuAaH+f1b
         5JVmGb7Ar12iBe2RrXkWJKOo3EODaZ/qum4ricRPDvau5HWeYcvlFg6UKsJQzFj5Oy
         uDlQ9h2+K7YF0ce2KvJbbe5uCq+GBsZhHJCcTvTE=
Date:   Wed, 21 Sep 2022 16:47:04 +0200
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
Message-ID: <Yysj6AXQ44/el4pS@kroah.com>
References: <Yxr4SD4d0rZ9TZik@T590>
 <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590>
 <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
 <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
 <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
 <c7c909aa-71d9-b43c-293e-d4801a00861e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c909aa-71d9-b43c-293e-d4801a00861e@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:34:26AM -0600, Jens Axboe wrote:
> On 9/21/22 3:25 AM, Thorsten Leemhuis wrote:
> > On 20.09.22 16:14, Jens Axboe wrote:
> >> On 9/20/22 8:12 AM, Christoph Hellwig wrote:
> >>> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
> >>>> Christoph and I discussed this one last week, and he has a plan to try
> >>>> a flag approach. Christoph, did you get a chance to bang that out? Would
> >>>> be nice to get this one wrapped up.
> >>>
> >>> I gave up on that as it will be far too much change so late in
> >>> the cycle and sent you the revert yesterday.
> >>
> >> Gotcha, haven't made it all the way through the emails of the morning yet.
> >> I'll queue it up.
> > 
> > Thx to both of you for taking care of this.
> > 
> > Nitpicking: that patch is missing a "CC: stable@..." tag to ensure
> > automatic and quick backporting to 5.19.y. Or is the block layer among
> > the subsystems that prefer to handle such things manually?
> > 
> > Ohh, and a fixes tag might have been good as well; a "Link:" tag
> > pointing to the report, too. If either would have been there, regzbot
> > would have noticed Christoph's patch posting and I wouldn't have
> > bothered you yesterday. :-) But whatever, not that important.
> 
> We'll just have to ensure we ping stable on it when it goes in.

If you have a git id that is not going to change, I can watch out for it
to land in Linus's tree...

thanks,

greg k-h
