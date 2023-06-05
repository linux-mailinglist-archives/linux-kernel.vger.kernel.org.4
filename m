Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073B722FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjFETg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFETg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D8AF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3394621F8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25F6C433D2;
        Mon,  5 Jun 2023 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685993785;
        bh=+giQO/41KfxmdSnorRAH0Il/f9FFoxZF4d9pD94EDJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFvpg46EjKT6rlArh7FE5yHdzcwCoiL7dygFJIOy94thjJU54tsBaqO+IWf8fwnRJ
         brfN7KFimR08CQoqNhKSuK54kqIT4MYFEoB1fRYs5AqP+0nZHN9vpBVD4yIdn6hXnp
         5J2vS1+bNNQQdeoibSfhPWOsZfjvTIbkVtMd4/5NHYGHKXeHgAL2WaHX0SaozHnrO2
         Xp6+52t6mrXEwruD18ZlFMz4qFJZXE09lQ1IKwGWvFwNeFS4MUt86x1gt/U7iVI2Ze
         jG3u5yF5whPRTAANvDpp7S2Es0GLnMF3zC+4V/GvFe6q8lWpu+LQPE0gYczwE1OG/v
         lZZdhuK6o5k+A==
Date:   Mon, 5 Jun 2023 12:36:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZH45N4nsqxCnhnoU@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
 <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
 <ZBzkzg+lr+TOXZcW@google.com>
 <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
 <ZBzy7RHlCqmApxUe@google.com>
 <ZCDXnuV7oZwcYvRP@infradead.org>
 <20230605115638.GA23662@gsv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605115638.GA23662@gsv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Hans Holmberg wrote:
> 
> On Sun, Mar 26, 2023 at 04:39:10PM -0700, hch@infradead.org wrote:
> > On Thu, Mar 23, 2023 at 05:46:37PM -0700, Jaegeuk Kim wrote:
> > > > Yes, and that was exactly my point: with LFS mode, O_DIRECT write
> > > > should never overwrite anything. So I do not see why direct writes
> > > > should be handled as buffered writes with zoned devices. Am I missing
> > > > something here ?
> > > 
> > > That's an easiest way to serialize block allocation and submit_bio when users
> > > are calling buffered writes and direct writes in parallel. :)
> > > I just felt that if we can manage both of them in direct write path along with
> > > buffered write path, we may be able to avoid memcpy.
> > 
> > Yes.  Note that right now f2fs doesn't really support proper O_DIRECT
> > for buffered I/O either, as non-overwrites require a feature similar
> > to unwritten extents, or a split of the allocation phase and the record
> > metdata phase.  If we'd go for the second choice for f2fs, which is the
> > more elegant thing to do, you'll get the zoned direct I/O write support
> > almost for free.
> 
> So, Jaegeuk, do you think suporting direct io proper is the way to do to fix this
> issue? That looks like a better solution to me (at least long term).
> 
> Until that would be put into place, do you want my fix (with your code
> style fixes) rebased and resent?

Yes, it's already landed in 6.4-rc1 of Linus tree, and surely I have the topic
in my long term plan.

Thanks,

> 
> Cheers,
> Hans
