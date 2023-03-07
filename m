Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053A06AD8A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCGICK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCGICH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:02:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4ED31D;
        Tue,  7 Mar 2023 00:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B51C16123C;
        Tue,  7 Mar 2023 08:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D48C433D2;
        Tue,  7 Mar 2023 08:02:04 +0000 (UTC)
Date:   Tue, 7 Mar 2023 09:01:56 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <ZAbvdBbavVDnlgnJ@kroah.com>
References: <20230307134313.1b2aa555@canb.auug.org.au>
 <ZAbaXeEKfUJY+hYx@kroah.com>
 <20230307174855.73b474df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307174855.73b474df@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:48:55PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Tue, 7 Mar 2023 07:31:57 +0100 Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 01:43:13PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the driver-core tree, today's linux-next qemu boot
> > > (powerpc pseries_le_defconfig) produced this boot time warning:
> > > 
> > > HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> > > sysfs: cannot create duplicate filename '//block'  
> > 
> > That is odd.  What type of userspace are you running this with?  And is
> > there a pointer to the .config anywhere?  No one should be needing this
> > old config option anymore, but maybe I messed something up in removing
> > it...
> The userspace is a trivial PowerPC LE initramfs that just shuts down
> after it boots.  However, the warning occurs before the initramfs is
> even unpacked.
> 
> I have attached the generated .config

No .config was attached :(

Anyway, should now be fixed with:
	https://lore.kernel.org/r/20230307075102.3537-1-gregkh@linuxfoundation.org

I'll queue that up to my tree so hopefully linux-next will be working
properly tomorrow.  Sorry for the bug.

greg k-h
