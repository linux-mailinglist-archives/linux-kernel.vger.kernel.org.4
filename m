Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81B62C252
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKPPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiKPPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:20:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8654B01
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F5661E68
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEC5C433D6;
        Wed, 16 Nov 2022 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668612011;
        bh=U/jbZLeft56Z3hxy0pMULS5BHNRXuyE6m2kBdtKxdkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdaintBuvVizx1uOplIwVzmDJuf579uy+UfYaeE0pnc2/7XsbvHvkDm0VQwKIwNSs
         82xqrapnlbKZClbol/H+0WvVJxPg987/L0hYW/gGBO7llsH+9E+XDhnsmEWy62QxQ/
         CNH1ggR1UweUpRt7xnlh8fcysk6K6xqrc+GwJSn0=
Date:   Wed, 16 Nov 2022 16:20:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3T/qJalJ9H224Mu@kroah.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:29:31PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> > > After the commits for userspace (see Link tags below) the uuid field is
> > > not being used in the ACRN code. Update kernel to reflect these changes.
> > > I.e. we do the following:
> > > - adding a comment explaining that it's not used anymore
> > > - replacing the specific type by a raw buffer
> > > - updating the example code accordingly
> > > 
> > > The advertised field confused users and actually never been used. So
> > > the wrong part here is that kernel puts something which userspace never
> > > used and hence this may confuse a reader of this code.
> 
> > > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > + * @uuid:		Reserved (used to be UUID of the VM)
> > 
> > If it's reserved, then don't you need to check for 0?
> 
> Reserved in a way that it may content something we just don't care about.

"reserved" in the kernel ioctls mean "must be 0 and we will test for it,
otherwise this is an empty/useless field that can never be touched again
in the future.

Please spell it out in detail as to if you can ever use this later on,
and what the kernel will do (if anything) if it is set.

And if "the kernel ignores it" then that means these bytes are now
"empty space never to be used again", right?

> ...
> 
> > > +	__u8	uuid[16];
> > 
> > You just changed the type here, so what is that going to break in
> > userspace that depended on this being of a structure type and now it's
> > an array?
> 
> It's the same. The previous was hidden behind additional type level.

Same size, yes.  Same C structure definition, no.

> > And no other kernel changes needed?  Shouldn't you warn if this field is
> > set?
> 
> No, as pointed out in the commit message kernel never ever used this.

That does not mean that userspace tools never did, right?  You are
changing the structure definition, what tool just broke?

thanks,

greg k-h
