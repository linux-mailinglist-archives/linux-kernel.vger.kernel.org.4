Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECB5E6297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiIVMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIVMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:40:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5170E6C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AF60B8362F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E0C433C1;
        Thu, 22 Sep 2022 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663850403;
        bh=OmOE0nh7bHVmof8ZvHEBC68t4a89rpX3I6KpWBI4zis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFpmc9olMJ/X9umMTl3oTOasfy4xDO+ZTP4kLThzXPg+vJXtLernHWXQyKi9f9lPZ
         3enwGGOLcqaex+lUKdoHyeHdFN8MVWgZg5ujLOjuUDFk4LSz9th71ifEHJnIC+lBkA
         SS27gs+U8lX+Ml2DXSUkTxMF8KVTFkU2Ln44wXUM=
Date:   Thu, 22 Sep 2022 14:40:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <YyxXoPmtTZHCr5pR@kroah.com>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:32:10AM -0400, Phil Auld wrote:
> On Thu, Sep 22, 2022 at 01:32:17PM +0200 Petr Štetiar wrote:
> > Hi,
> > 
> > we've got a recent bug report[1], that lscpu segfaults on aarch64 board running
> > 5.15.y kernel. It is working fine on 5.10.y kernel. 
> > 
> > I've tracked it down[2] to the issue with `topology/thread_siblings` which
> > apart from very strange file size returns empty content. I assume, that it's
> > somehow related to the changes done in commit bb9ec13d156e ("topology: use
> > bin_attribute to break the size limitation of cpumap ABI"), but I didn't tried
> > to revert it yet to verify it.
> >
> 
> This is actually due to a fix for that since returning 0 size breaks
> things as well.
> 
>   7ee951acd31a drivers/base: fix userspace break from using bin_attributes for cpumap and cpulist
> 
> The fix for small number of cpus as you have is now in Greg's driver core tree
> 
>   d7f06bdd6ee8 drivers/base: Fix unsigned comparison to -1 in CPUMAP_FILE_MAX_BYTES
> 
> and should work it's way back to stable trees soon.

That should fix up the file size issue.

The main problem being reported here is:

> > Kernel 5.15.68:
> > 
> >   root@OpenWrt:/# uname -a
> >   Linux OpenWrt 5.15.68 #0 SMP Wed Sep 21 05:54:21 2022 aarch64 GNU/Linux
> > 
> >   root@OpenWrt:/# find /sys -name thread_siblings -exec ls -al {} \;
> >   -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu1/topology/thread_siblings
> >   -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu0/topology/thread_siblings
> > 
> >   root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
> >   root@OpenWrt:/# 

Nothing in the file in 5.15, yet 5.10:

> > 
> > Kernel 5.10.138:
> > 
> >   root@OpenWrt:/# uname -a
> >   Linux OpenWrt 5.10.138 #0 SMP Sat Sep 3 02:55:34 2022 aarch64 GNU/Linux
> > 
> >   root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
> >   2
> >   1

Has data in the files.

What caused that change?

thanks,

greg k-h
