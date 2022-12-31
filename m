Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D7565A4BA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiLaNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLaNsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:48:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFD6241
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC45560AB6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AF3C433EF;
        Sat, 31 Dec 2022 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672494517;
        bh=C99Hco05hYs8j1oY2MO4kOkcmdEUFj5O3U8luFec220=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c03dPskaYea4aiBeGwBwfNlXtm5pQnrXi+jVyRki0vVuh2ZpLx5JnP3CMkj43KgiY
         jTLZVohL1cLMICu3c7O5cB8x90heEKk69c4ySTdU3uyNLgyVpZQy1E/eCwIfFmu9Yz
         iZUtSnEy8dDZl99iNgXxqy/qBq2zG6SVzZEsUnYQ=
Date:   Sat, 31 Dec 2022 14:48:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Message-ID: <Y7A9ssF/WPVDMUKl@kroah.com>
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <Y7AHvYfZreO/G/kT@kroah.com>
 <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
 <Y7AhLWSPE+2hnZ2I@kroah.com>
 <CALQpDLc4+-0st-U_s+09QCb2nmv=nQizheGXjhyKJLGS45zmZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQpDLc4+-0st-U_s+09QCb2nmv=nQizheGXjhyKJLGS45zmZw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sat, Dec 31, 2022 at 10:06:19PM +0900, Yoochan Lee wrote:
> Thanks.
> 
> Since I don't have a real device, it is difficult to verify the bug dynamically.
> However, this type of race condition (i.e., b/w remove device and
> fops) is prevalently founded recently[1-3].
> Therefore, I think this bug can be triggered if a real device exists.

And how can this device actually be removed from the system?  Is that
possible with this hardware?

> The main reason for this race condition (i.e., b/w detach and fops) is
> there is no proper lock mechanism.
> I think the detach device function is delayed until the other
> operations (e.g., fops) is finished.
> To this end, I use kref to wait for the other operations.

And again, this is not the correct solution as you have way too many
reference counts happening here.  Please become more familiar with how
these all work before adding another one and causing more problems like
this patch did :(

> The tool I am making is currently under development, and it can find
> the race condition between detach function and fops.

Then you MUST document this as it looks like your tool needs work.
Please read Documentation/process/researcher-guidelines.rst for what you
MUST do if you use a tool to find "issues" and send out random patches.

good luck!

greg k-h
