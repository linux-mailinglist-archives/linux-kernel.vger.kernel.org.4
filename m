Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0163AA61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiK1OEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiK1OEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA6FD12C;
        Mon, 28 Nov 2022 06:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A917B80DDA;
        Mon, 28 Nov 2022 14:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49DDC433D7;
        Mon, 28 Nov 2022 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669644259;
        bh=hJGjJg60sjMbrCzlwGn3rya6L16V299vyXbEqb4YAR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGlQHwLR8hxljgzrgVHHC9LZOQfx9gKF+fQ1o5nVnR3iIyt98G1ob49nUHqdwuWKL
         sbqABdmC0J29f+uqMO09G/htURJnWsQevMZqn5ctWeH/DS0VIqmDf4O4H0ABDSwKqI
         tt2h3ljwB5yOAra2d6NUD4Pk+s0QuO0q9Qx/oqvChA3FAOMULv30J3GR4VFvN3fHXP
         NXxMAzl5symBF+2sGLx848HwjtoldJG1Hjr2ymuYPrWJ+Prwu8pDCA3j2a4cRbAK7z
         UyA7+gEfkG1dLHsYKVioRBfxcrlP3J8hY6sggXIFfI4v7rc8C+cPYbNP43zEWNVyFY
         NKq+DzkKzC/ww==
Date:   Mon, 28 Nov 2022 14:04:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Message-ID: <Y4S/3T7jzXzTHNSc@google.com>
References: <20221122123523.3068034-1-john@metanate.com>
 <Y30SWm+bhv8srJC2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y30SWm+bhv8srJC2@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, Lee Jones wrote:

> On Tue, 22 Nov 2022, John Keeping wrote:
> 
> > This series arises from the recent thread [1] on lifetime issues.
> > 
> > The main point is the first patch, with the second being an unrelated
> > fix for an issue spotted while working on this.  Both of these have
> > Fixes: tags for backporting to stable.
> > 
> > The final patch tidies up some error handling to hopefully avoid patch 2
> > issues in the future.
> > 
> > [1] https://lore.kernel.org/r/20221117120813.1257583-1-lee@kernel.org
> > 
> > John Keeping (3):
> >   usb: gadget: f_hid: fix f_hidg lifetime vs cdev
> >   usb: gadget: f_hid: fix refcount leak on error path
> >   usb: gadget: f_hid: tidy error handling in hidg_alloc
> > 
> >  drivers/usb/gadget/function/f_hid.c | 60 ++++++++++++++++-------------
> >  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> For the set:
> 
> Reviewed-by: Lee Jones <lee@kernel.org>
> Tested-by: Lee Jones <lee@kernel.org>

Greg, is this still on your radar?

-- 
Lee Jones [李琼斯]
