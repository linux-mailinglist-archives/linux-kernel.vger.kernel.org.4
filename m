Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC063BC64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiK2I7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiK2I7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:59:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4110C4E43D;
        Tue, 29 Nov 2022 00:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF1FDB811BE;
        Tue, 29 Nov 2022 08:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CFDC433D6;
        Tue, 29 Nov 2022 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669712369;
        bh=zNt+Ny2i/8GNi8+AMWI3me0E1WKcpr5EHMLf+NNKBak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvdcmnCHLDn8Duw25N3/DfFZjsEw3npHNLwTv5O6ISs4U3ud7vz9jseJj9Kc0+EUG
         /u84ovUe7UD6w7e7uDt40zZ0vQX3Mpinw+EaKsHZmkYzgzZEW56RJva5yFpx0igqON
         WSLuDE8As19bgiP2HU9gD4+B4hw2fzUctZtbrxIl5xEKFKDUO43WGt9z4PA610ZPu/
         JVnmqSs94/+1AVrz5NEeVMiLpcLPe1KACrugEgoLfU9YWUJKLdPiqmTsqc59e3dci6
         HVoJAcDpVKqq/Orfd2uAyBkN/t7hiiSQi6+7GJKIaSv1w6OOVZQ6XcKKpG0M06MGcD
         hFL1S+x7quWIg==
Date:   Tue, 29 Nov 2022 08:59:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Message-ID: <Y4XJ7FoWUqwjnAoD@google.com>
References: <20221122123523.3068034-1-john@metanate.com>
 <Y30SWm+bhv8srJC2@google.com>
 <Y4S/3T7jzXzTHNSc@google.com>
 <Y4T0JMU93gr+MklZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4T0JMU93gr+MklZ@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022, Greg Kroah-Hartman wrote:

> On Mon, Nov 28, 2022 at 02:04:13PM +0000, Lee Jones wrote:
> > On Tue, 22 Nov 2022, Lee Jones wrote:
> > 
> > > On Tue, 22 Nov 2022, John Keeping wrote:
> > > 
> > > > This series arises from the recent thread [1] on lifetime issues.
> > > > 
> > > > The main point is the first patch, with the second being an unrelated
> > > > fix for an issue spotted while working on this.  Both of these have
> > > > Fixes: tags for backporting to stable.
> > > > 
> > > > The final patch tidies up some error handling to hopefully avoid patch 2
> > > > issues in the future.
> > > > 
> > > > [1] https://lore.kernel.org/r/20221117120813.1257583-1-lee@kernel.org
> > > > 
> > > > John Keeping (3):
> > > >   usb: gadget: f_hid: fix f_hidg lifetime vs cdev
> > > >   usb: gadget: f_hid: fix refcount leak on error path
> > > >   usb: gadget: f_hid: tidy error handling in hidg_alloc
> > > > 
> > > >  drivers/usb/gadget/function/f_hid.c | 60 ++++++++++++++++-------------
> > > >  1 file changed, 33 insertions(+), 27 deletions(-)
> > > 
> > > For the set:
> > > 
> > > Reviewed-by: Lee Jones <lee@kernel.org>
> > > Tested-by: Lee Jones <lee@kernel.org>
> > 
> > Greg, is this still on your radar?
> 
> Yes, let me catch up on pending patches...

Perfect, thank you.

-- 
Lee Jones [李琼斯]
