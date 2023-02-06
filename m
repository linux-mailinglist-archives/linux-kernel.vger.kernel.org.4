Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FC68B5C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBFGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBFGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:48:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A046A5D7;
        Sun,  5 Feb 2023 22:48:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA81B80D52;
        Mon,  6 Feb 2023 06:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F51C433EF;
        Mon,  6 Feb 2023 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675666086;
        bh=1VtEB+g5PvA7JJDmummqrb9ZrXzYa3O18vA/KOro2kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odUmwiZGoifvDiADHA/k0+2HHMJV/ssZR9P3lWDe2Lnq5NdUUXBXu/kk/q2kIl/7Q
         U7PoC63WvzX5Y5N19cTwhiOGEmDydI+urVvcTPURLRX9zj+fq+Not27r73TqsTO/ga
         9S72StcCmugISBEiYxSUNgRZX0s9Nc5AuwkzpIC0=
Date:   Mon, 6 Feb 2023 07:48:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y+Cio48RvJe9Y2cv@kroah.com>
References: <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <c7fb01a9-3e12-77ed-5c4c-db7deb64dc73@I-love.SAKURA.ne.jp>
 <20230206025629.1786-1-hdanton@sina.com>
 <20230206064305.1838-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206064305.1838-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:43:05PM +0800, Hillf Danton wrote:
> On Mon, 6 Feb 2023 06:17:03 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > On Mon, Feb 06, 2023 at 10:56:29AM +0800, Hillf Danton wrote:
> > > On Sun, 5 Feb 2023 11:46:06 -0500 Alan Stern <stern@rowland.harvard.edu>
> > > > 
> > > > And by the way, by disabling lockdep validation I am declaraing that 
> > > > enabling it would cause an overwhelming number of false positives, 
> > > 
> > > Could you share 5 false positives you see upstream to help understand how
> > > it is useless?
> > 
> > Please see this other email in this thread:
> > 	https://lore.kernel.org/r/Y98FLlr7jkiFlV0k@rowland.harvard.edu
> 
> What lockdep warnings?  Specific examples, please.

Remove the one line of code, as per the patch in this thread, and boot
with lockdep enabled and see what happens if you wish to see them
yourself.

thanks,

greg k-h
