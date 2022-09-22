Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605A5E6374
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiIVNTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiIVNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9EECCE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663852732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2KiW8ubxj4itDHVmzCDT6sx86ivO/DdDP0BaFbVWv8=;
        b=dSxPVKGDsu0/X7ZjKIDIZhSWNC5HkoPENFZzkQGj2e06pIaOijrNH9Fquecm1PO6zgiCGA
        4cgK413sc2MK8PBFWnM2Lkh38rRgnrMG6/sb5i34z4fRtmLbKvKI4py0EKcedxeP8yfRSw
        OiTZWKOr2plAx4eH+P3xvxuKb11ExzU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-Ava7A5KsMAyNiHjAgYi4Xg-1; Thu, 22 Sep 2022 09:18:49 -0400
X-MC-Unique: Ava7A5KsMAyNiHjAgYi4Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F344186E926;
        Thu, 22 Sep 2022 13:18:48 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAF0C2027061;
        Thu, 22 Sep 2022 13:18:48 +0000 (UTC)
Date:   Thu, 22 Sep 2022 09:18:47 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyxXoPmtTZHCr5pR@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:40:00PM +0200 Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2022 at 08:32:10AM -0400, Phil Auld wrote:
> > On Thu, Sep 22, 2022 at 01:32:17PM +0200 Petr Štetiar wrote:
> > > Hi,
> > > 
> > > we've got a recent bug report[1], that lscpu segfaults on aarch64 board running
> > > 5.15.y kernel. It is working fine on 5.10.y kernel. 
> > > 
> > > I've tracked it down[2] to the issue with `topology/thread_siblings` which
> > > apart from very strange file size returns empty content. I assume, that it's
> > > somehow related to the changes done in commit bb9ec13d156e ("topology: use
> > > bin_attribute to break the size limitation of cpumap ABI"), but I didn't tried
> > > to revert it yet to verify it.
> > >
> > 
> > This is actually due to a fix for that since returning 0 size breaks
> > things as well.
> > 
> >   7ee951acd31a drivers/base: fix userspace break from using bin_attributes for cpumap and cpulist
> > 
> > The fix for small number of cpus as you have is now in Greg's driver core tree
> > 
> >   d7f06bdd6ee8 drivers/base: Fix unsigned comparison to -1 in CPUMAP_FILE_MAX_BYTES
> > 
> > and should work it's way back to stable trees soon.
> 
> That should fix up the file size issue.
> 
> The main problem being reported here is:
> 
> > > Kernel 5.15.68:
> > > 
> > >   root@OpenWrt:/# uname -a
> > >   Linux OpenWrt 5.15.68 #0 SMP Wed Sep 21 05:54:21 2022 aarch64 GNU/Linux
> > > 
> > >   root@OpenWrt:/# find /sys -name thread_siblings -exec ls -al {} \;
> > >   -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu1/topology/thread_siblings
> > >   -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu0/topology/thread_siblings
> > > 
> > >   root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
> > >   root@OpenWrt:/# 
> 
> Nothing in the file in 5.15, yet 5.10:
> 
> > > 
> > > Kernel 5.10.138:
> > > 
> > >   root@OpenWrt:/# uname -a
> > >   Linux OpenWrt 5.10.138 #0 SMP Sat Sep 3 02:55:34 2022 aarch64 GNU/Linux
> > > 
> > >   root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
> > >   2
> > >   1
> 
> Has data in the files.
>

Good point. My eyes latched on to that huge file size for some reason ;)

> What caused that change?

I've seen the size cause problems for tools. Are we sure that it's the empty file and not
the size causing issues?  Maybe something is treating that as signed again for a count of
-1 bytes (which seems like it would be a bug anyway)?


Cheers,
Phil

>
> thanks,
> 
> greg k-h
> 

-- 

