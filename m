Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E95669D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAMQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjAMQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A00172D02;
        Fri, 13 Jan 2023 07:58:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D752F62161;
        Fri, 13 Jan 2023 15:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9713C433EF;
        Fri, 13 Jan 2023 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673625488;
        bh=xRUDU38G2kr9keNO85ksGF5Z1DIZ7EjjQoi32nG2bYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFtSGsN2g3v7UNtRwHsLERgkx2a5RTR4cpeSEVqYCxfcVTTOgNtrXQPxlu09+QLZk
         JGH8rQCdRuf+Cts5PK9+gURe8v3hriQqX0v/XO8lldEvPzTYsCacuJmh6o0pEhirqV
         L+1iy/xS62L5I0myzwlyF5HRL8V4B3J+6BZ6wfTA=
Date:   Fri, 13 Jan 2023 16:57:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        slipper.alive@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
Message-ID: <Y8F/h6gBPwj18JbY@kroah.com>
References: <16735310493146@kroah.com>
 <Y8AP6Lqo9sfX9Bb8@kroah.com>
 <20230112105731.0da81d58@kernel.org>
 <Y8BZboDOQ1I+VTAC@kroah.com>
 <Y8FDhdy3s1z/JxAi@kroah.com>
 <397b05375f57ec5dc0f084315b995bfda4527d95.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397b05375f57ec5dc0f084315b995bfda4527d95.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:51:40PM +0100, Paolo Abeni wrote:
> Hello,
> On Fri, 2023-01-13 at 12:41 +0100, Greg KH wrote:
> > On Thu, Jan 12, 2023 at 08:03:10PM +0100, Greg KH wrote:
> > > On Thu, Jan 12, 2023 at 10:57:31AM -0800, Jakub Kicinski wrote:
> > > > On Thu, 12 Jan 2023 14:49:28 +0100 Greg KH wrote:
> > > > > On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> > > > > > 
> > > > > > This is a note to let you know that I've just added the patch titled
> > > > > > 
> > > > > >     net/ulp: prevent ULP without clone op from entering the LISTEN status
> > > > > > 
> > > > > > to the 5.4-stable tree which can be found at:
> > > > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary  
> > > > > 
> > > > > Oops, nope, this broke the build for 5.4 and older kernels, now
> > > > > dropping.
> > > > 
> > > > There's no clone op, right?
> > > 
> > > Correct.
> > > 
> > > > If you're willing to futz with it I think
> > > > you just need to remove the "and the ops don't have ->clone" part of
> > > > the conditions. Any presence of ops on older kernels should make us
> > > > bail.
> > 
> > Ok, I've queued up the following patch for 5.4. and older.  Let me know
> > if I've messed anything up here, but it at least builds for me :)
> 
> The backport patch LGTM, thanks!

Wonderful, thanks for the review!
