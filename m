Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C362C3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiKPQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiKPQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:16:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC32D135
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CFD1B81DE0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB8EC433C1;
        Wed, 16 Nov 2022 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668615382;
        bh=VuCtC4r5rO4v5LPmAf61/aocsA7ivweRS0+kvCJ2oIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODk9UlAYGLYxEAECTGQ6TqvD/DAIlHdnfrqVlqAgkVGEP6AAGubJ/A3oYNyjTMuIR
         u4krZydeXlDCZg4OuGn9wz81a4H2RQ8sGt5CqVy7BbMBss22VWlhGBbCJui/Wrx2d3
         IQS0qc5QeW7jGkLmNP2RqWol+w4K+2ulNSqZMJWQ=
Date:   Wed, 16 Nov 2022 17:16:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3UM1PSJnr8xQ966@kroah.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
 <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:04:37PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 16, 2022 at 04:20:08PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 16, 2022 at 03:29:31PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > > + * @uuid:		Reserved (used to be UUID of the VM)
> > > > 
> > > > If it's reserved, then don't you need to check for 0?
> > > 
> > > Reserved in a way that it may content something we just don't care about.
> > 
> > "reserved" in the kernel ioctls mean "must be 0 and we will test for it,
> > otherwise this is an empty/useless field that can never be touched again
> > in the future.
> > 
> > Please spell it out in detail as to if you can ever use this later on,
> > and what the kernel will do (if anything) if it is set.
> > 
> > And if "the kernel ignores it" then that means these bytes are now
> > "empty space never to be used again", right?
> 
> Right, I will fix this in v5.
> 
> ...
> 
> > > > > +	__u8	uuid[16];
> > > > 
> > > > You just changed the type here, so what is that going to break in
> > > > userspace that depended on this being of a structure type and now it's
> > > > an array?
> > > 
> > > It's the same. The previous was hidden behind additional type level.
> > 
> > Same size, yes.  Same C structure definition, no.
> 
> It doesn't matter, see below.
> 
> > > > And no other kernel changes needed?  Shouldn't you warn if this field is
> > > > set?
> > > 
> > > No, as pointed out in the commit message kernel never ever used this.
> > 
> > That does not mean that userspace tools never did, right?  You are
> > changing the structure definition, what tool just broke?
> 
> The only tool has been amended like a year ago, so the answer is none.
> The commit message has links to the commits in question that made that
> amendment.
> 
> Maybe I should remove Fixes tags? In such case we will very much know
> that no old tools will be run on the new kernel.

Please remove "fixes" as this doesn't "fix" anything.

thanks,

greg k-h
