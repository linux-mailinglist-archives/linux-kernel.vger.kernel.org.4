Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB67B6D4D68
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjDCQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDCQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B14171C;
        Mon,  3 Apr 2023 09:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31B362110;
        Mon,  3 Apr 2023 16:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA6CC433D2;
        Mon,  3 Apr 2023 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680538859;
        bh=7wJuBBzfI2v5fDx8D36TlbKuKLEt4oKtWWPJeFjUnt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAB6L47yTDcJcs+xXOfZ5odhgOS7sbSmh26MMtatukCZWKdx/y3gTBWJvjgkpCYMk
         A2s0s35jLBMMfpHHTl23lxaVfGxP9b00LMDX0YXjAN462/hZ9BZlkt7+NUC/JZYLI6
         V+t8APrREdQK31WOdlUvRSwCRU6sG3ZDeEDqr8qc=
Date:   Mon, 3 Apr 2023 18:20:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <blogic@openwrt.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: vpe-cmp: remove module owner pointer from struct
 class usage.
Message-ID: <2023040347-case-encourage-39d4@gregkh>
References: <2023040242-pursuable-frown-48d8@gregkh>
 <20230403155804.GA12122@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403155804.GA12122@alpha.franken.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:58:04PM +0200, Thomas Bogendoerfer wrote:
> On Sun, Apr 02, 2023 at 11:05:45AM +0200, Greg Kroah-Hartman wrote:
> > In commit 6e30a66433af ("driver core: class: remove struct module owner
> > out of struct class"), the module owner pointer was removed from struct
> > class, but this was missed for the mips vpe-cmp code due to lack of
> > build testing (and it being burried under a very unused config
> > settings.)  Fix this up by removing the module pointer to resolve the
> > build error.
> > 
> > Note, there are other problems with the driver model usage in this file
> > (static struct device usage, empty device release function, etc.), so it
> > probably could use some good cleaning up, but odds are this driver
> > really isn't used so hopefully it will just be removed entirely someday
> > soon as part of the general "remove unused arches" cleanup that is
> > slowly happening.
> > 
> > Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> > Cc: John Crispin <blogic@openwrt.org>
> > Cc: Qais Yousef <Qais.Yousef@imgtec.com>
> > Cc: Steven J. Hill <Steven.Hill@imgtec.com>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > Cc: linux-mips@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202304020802.xbRTJKjW-lkp@intel.com/
> > Fixes: 6e30a66433af ("driver core: class: remove struct module owner out of struct class")
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/mips/kernel/vpe-cmp.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
> > index 92140edb3ce3..4ef7f49a4c6d 100644
> > --- a/arch/mips/kernel/vpe-cmp.c
> > +++ b/arch/mips/kernel/vpe-cmp.c
> > @@ -79,7 +79,6 @@ static void vpe_device_release(struct device *cd)
> >  
> >  static struct class vpe_class = {
> >  	.name = "vpe",
> > -	.owner = THIS_MODULE,
> >  	.dev_release = vpe_device_release,
> >  	.dev_groups = vpe_groups,
> >  };
> > -- 
> > 2.40.0
> 
> I guess this should go the same way as commit 6e30a66433af, therefore
> 
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, I'll take it through my tree.

greg k-h
