Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DE69E1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjBUNuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjBUNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:50:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291C28D2B;
        Tue, 21 Feb 2023 05:50:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D9DE61029;
        Tue, 21 Feb 2023 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B19C433EF;
        Tue, 21 Feb 2023 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676987425;
        bh=Z4aish3Apqp64SElU/yyo7PrgTh1M116rVxHyOgx8Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9iqgYk5Zv3oYRnYuVa4qZl34aqIJ9IZXL9I8ukVUkG7uPM6/t1Spj07z3JCqCRCS
         mO8m/u+h2MoiszeuplYv9TGtKU6TRTiIbovZc9yjRbFjI1ytKB2wnTWDllkQBIcyYK
         ecmpMUbSFNYxMdPtuCstA5t7menm8Y2ck/94+uw4=
Date:   Tue, 21 Feb 2023 14:50:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <Y/TMH8Hf6zBrC3yc@kroah.com>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <dcaaf7d5-b2d5-dbb9-f3fe-2232ee525cc8@kernel.org>
 <2094ecec-f63c-4e8a-ba97-da77c5266da1@t-8ch.de>
 <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:30:11AM -0500, George Kennedy wrote:
> 
> 
> On 2/20/2023 11:34 AM, Thomas Weiﬂschuh wrote:
> > +Cc people who were involved in the original thread.
> > 
> > On Mon, Feb 20, 2023 at 12:48:59PM +0100, Jiri Slaby wrote:
> > > On 20. 02. 23, 7:46, linux@weissschuh.net wrote:
> > > > From: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > 
> > > > Commit 226fae124b2d
> > > > ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> > > > moved the call to vcs_vc() into the loop.
> > > > While doing this it also moved the unconditional assignment of
> > > > "ret = -ENXIO".
> > > > This unconditional assignment was valid outside the loop but within it
> > > > it clobbers the actual value of ret.
> > > > 
> > > > To avoid this only assign "ret = -ENXIO" when actually needed.
> > > Not sure -- I cannot find it -- but hasn't George fixed this yet?
> > Indeed there was a proposed fix at
> > https://lore.kernel.org/lkml/1675704844-17228-1-git-send-email-george.kennedy@oracle.com/
> > 
> > Linus had some suggestions so it was not applied as is.
> > 
> > I'm not sure what the current state is.
> > George, do you have something in the pipeline?
> 
> Yes, that is in the pipeline:
> https://lore.kernel.org/lkml/1675774098-17722-1-git-send-email-george.kennedy@oracle.com/
> 
> Linus suggested the fix, which was tested and submitted.
> 
> Jiri commented on the patch, which I believe was directed at Linus as he
> suggested the fix.

And I was waiting for a new version from you based on those comments :(

Can you fix that up and send?

thanks,

greg k-h
