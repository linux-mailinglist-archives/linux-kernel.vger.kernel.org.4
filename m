Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC368B684
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:38:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7318A83;
        Sun,  5 Feb 2023 23:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FC160D33;
        Mon,  6 Feb 2023 07:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00200C433EF;
        Mon,  6 Feb 2023 07:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675669130;
        bh=smzP3YNn8roFY5Mdez0Fv3NsByYPwnoN/wK6IdF3Yls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGYUvlHwzclrSSWIzdFXCKSjD+Xuq87sN7JmpLkhWdc4ECUCjJ3sGn2CgEhsAEuaP
         AkjDHllUgZVBjpb84FOYW5wLYEHRt9YiA6kdvNP/uZD6Mj6JWhPZ85e5oBXF47aM69
         0qcnEfEIQzid9tkLgin8zP588nlfmYgliCUusPyE=
Date:   Mon, 6 Feb 2023 08:38:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
Message-ID: <Y+Cuh3LmsF9PGO6z@kroah.com>
References: <Y9+Yv1CQKNP0Bwqq@kroah.com>
 <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 12:17:05PM -0800, Linus Torvalds wrote:
> On Sun, Feb 5, 2023 at 3:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > George Kennedy (1):
> >       vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF
> 
> Hmm.
> 
> I think the "goto unlock_out" should be a "break". A partial read
> should return the partial success, not an error.
> 
> That situation didn't exist when the check was outside the loop, but does now.
> 
> Now, I don't think this matters for any sane situation, but since I
> looked at this patch I thought I'd mention it.

Fair enough, George, can you send a follow-on patch to fix this up?

thanks,

greg k-h
