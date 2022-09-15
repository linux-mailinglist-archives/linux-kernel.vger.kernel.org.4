Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59635B95E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiIOIDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIOIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:03:01 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB5F97504
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:02:55 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 9257E201390;
        Thu, 15 Sep 2022 08:02:52 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7FDA78060E; Thu, 15 Sep 2022 10:02:35 +0200 (CEST)
Date:   Thu, 15 Sep 2022 10:02:35 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, laforge@gnumonks.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Paul Fulghum <paulkf@microgate.com>,
        akpm@osdl.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <20220915020834.GA110086@ubuntu>
 <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Sep 15, 2022 at 09:35:51AM +0200 schrieb Arnd Bergmann:
> On Thu, Sep 15, 2022, at 4:08 AM, Hyunwoo Kim wrote:
> > There are 3 other pcmica drivers in the path 
> > "drivers/char/pcmcia/synclink_cs.c", 
> > the path of the "synclink_cs.c" driver I reported the UAF to.
> > A similar UAF occurs in the "cm4000_cs.c" and "cm4040_cs.c" drivers. 
> > (this does not happen in scr24x_cs.c)
> ...
> > In the cm4000_cs.c driver, the race condition flow is tricky because of 
> > the start/stop_monitor() functions.
> >
> > The overall flow is similar to cm4040_cs.c.
> > Added one race condition to bypass the "dev->monitor_running" check.
> >
> >
> > So, should the above two drivers be removed from the kernel like the 
> > synclink_cs.c driver?
> >
> > Or should I submit a patch that fixes the UAF?
> 
> There is a good chance that we can remove both now, along with the
> synclink_cs. The scr24x driver is from 2016, but of course the
> hardware is much older. The cm4040/cm4000 drivers are from 2005.
> My guess is that the hardware still exists in actively used systems,
> but none of them get upgraded to modern kernels any more.
> 
> Let's just ask the driver authors (Lubomir and Harald) if they
> think the drivers may still be needed.

Actually, I'd prefer to apply a patch to fix this now-known problem first,
even if we deactive / remove these drivers immediately afterwards.

Thanks,
	Dominik
