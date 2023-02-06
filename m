Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81768C5CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBFSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:31:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52F29E25;
        Mon,  6 Feb 2023 10:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D220FB815D2;
        Mon,  6 Feb 2023 18:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC5DC433EF;
        Mon,  6 Feb 2023 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675708282;
        bh=X2golyd3HFMbWr7VHjLRA9jNcYpUlNQZlZy5Z6FAVsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1waMvolaH0CI0GoaNScKLdPGPDRCcZiZWOuVaFq58MQ9S5iRHKfM90+v6KxS0Gh+l
         Wxz+R+X8WJ/qDvWJA9Tcqo+stanUi62+YfcQWfVWsh7NgjBDShYVTIH1FMdzqjvKgl
         BCr0j7bQuzFs/+aqqaUH3QbLqr2Pz9xxJHMoHDc0=
Date:   Mon, 6 Feb 2023 19:31:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vc_screen: break from vcs_read() while loop if vcs_vc()
 returns NULL
Message-ID: <Y+FHd2WR9w6zBZd7@kroah.com>
References: <1675704844-17228-1-git-send-email-george.kennedy@oracle.com>
 <CAHk-=wi5h32VBgzYgFy8KoXbcDMa9K_ihDjfxD-iScy7L+M=QQ@mail.gmail.com>
 <a305b9e4-349d-8936-b0ba-3dcaa4199ebc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a305b9e4-349d-8936-b0ba-3dcaa4199ebc@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 01:20:28PM -0500, George Kennedy wrote:
> 
> 
> On 2/6/2023 1:12 PM, Linus Torvalds wrote:
> > On Mon, Feb 6, 2023 at 9:34 AM George Kennedy <george.kennedy@oracle.com> wrote:
> > > 
> > > -               ret = -ENXIO;
> > >                  vc = vcs_vc(inode, &viewed);
> > > -               if (!vc)
> > > +               if (!vc) {
> > > +                       if (read)
> > > +                               break;
> > > +                       ret = -ENXIO;
> > >                          goto unlock_out;
> > > +               }
> > That works, but the whole "if (read)" thing is already done after the
> > loop, so instead of essentially duplicating that logic, I really think
> > the patch should be just a plain
> > 
> >                  vc = vcs_vc(inode, &viewed);
> >                  if (!vc)
> > -                       goto unlock_out;
> > +                       break;
> > 
> > and nothing else.
> > 
> > And yes, the pre-existing vcs_size() error handling has that same ugly pattern.
> > 
> > It might be worth cleaning up too, although right now that
> > 
> >                  size = vcs_size(vc, attr, uni_mode);
> >                  if (size < 0) {
> >                          if (read)
> >                                  break;
> > 
> > pattern means that if we 'break' there, 'read' is non-zero, so 'ret'
> > doesn't matter. Which is also ugly, but works.
> > 
> > I *think* it could all be rewritten to just use 'break' everywhere in
> > the loop, and make 'ret' handling be saner.
> > 
> > Something like the attached patch, but while I tried to think about
> > it, I didn't spend a lot of effort on it, and I certainly didn't test
> > it. So I'm sending this out as a "Hmm. This _looks_ better to me, but
> > whatever" patch.
> 
> Thank you Linus,
> 
> Will start with your suggested patch and will test it.

And I'll go drop your patch from my tree before the 0-day bots pick it
up :)

thanks,

greg k-h
