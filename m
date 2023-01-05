Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294B65E9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjAELZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjAELZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:25:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8752858D12
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 03:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0312CE1AA9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D769C4339B;
        Thu,  5 Jan 2023 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672917920;
        bh=KcCgz18PSxkemuPvCra8wEPTHz+NwNQi4KbNkNyT/3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULwyogpOG93nNkAUZg2F/U/UehMbGMII/xmBG5t5C3FqVluL8iZtOaS0SDflzUKL6
         XtwcPv1MHsJNot3bwsMhOcjOoJeIBxRhOJC2jSHSXzhjSNIA76XczzyP56pIqRMPgl
         adAoWo9dEklJkkcr9KY1Dp9OotrlTFDaWiYl2CnA=
Date:   Thu, 5 Jan 2023 12:25:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <Y7aznc+/wm69554m@kroah.com>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:43:16PM -0700, Jens Axboe wrote:
> > The removal seems to revert cleanly, although it does require
> > reverting a few subsequent commits too (that removed code that only
> > pktcdvd used):
> > 
> >     git revert db1c7d779767 85d6ce58e493 f40eb99897af
> > 
> > where we have
> > 
> >     db1c7d779767 block: bio_copy_data_iter
> >     85d6ce58e493 block: remove devnode callback from struct
> > block_device_operations
> >     f40eb99897af pktcdvd: remove driver.
> 
> I'll queue this up - and unless I hear valid complaints to why we should
> not just reinstate the driver for now, it'll go out with the next pull
> request.

If you do revert these, watch out for a build warning from the driver
core when you revert this, I think there's a 'const' missing from
somewhere that you might have to add back in due to other driver core
changes.

thanks,

greg k-h
