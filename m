Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9135B3E76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIISBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIISBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01BB0B15
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8BB62092
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C71C433D6;
        Fri,  9 Sep 2022 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662746481;
        bh=xfbOxDMrBC+FLEHLKPnZtY1D4mafiObgMUwlegIp9tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPKiCmZhdjpHrlMw8iB5JZku3rbdbxwk3JBzC76PbqNcXua+sHecFwMwli+3iYxH+
         NcXMGAA5xqfNSVkDYVzAEstK61VL2iQUivdcudhteOu4AtEKij+oByPEf7DnbPdmMV
         BCY3d+mgi0yqIcZosc2y0ETX1PtZyPB/E5dmA3VA=
Date:   Fri, 9 Sep 2022 20:01:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>,
        GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH] staging: rtl8192e: Fix return type for implementation of
 ndo_start_xmit
Message-ID: <Yxt/bjvVgC3H8mr6@kroah.com>
References: <20220908203243.GA23048@matrix-ESPRIMO-P710>
 <YxrxywN9wDypohyY@kroah.com>
 <YxryqJs4k3B26/7o@kroah.com>
 <a0c8fa9d-cc86-b39b-e65f-e8a0ccf12a15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c8fa9d-cc86-b39b-e65f-e8a0ccf12a15@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:20:09PM +0200, Philipp Hortmann wrote:
> On 9/9/22 10:00, Greg Kroah-Hartman wrote:
> > On Fri, Sep 09, 2022 at 09:56:59AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 08, 2022 at 10:32:43PM +0200, Philipp Hortmann wrote:
> > > > CFI (Control Flow Integrity) is a safety feature allowing the system to
> > > > detect and react should a potential control flow hijacking occurs. In
> > > > particular, the Forward-Edge CFI protects indirect function calls by
> > > > ensuring the prototype of function that is actually called matches the
> > > > definition of the function hook.
> > > > 
> > > > Since Linux now supports CFI, it will be a good idea to fix mismatched
> > > > return type for implementation of hooks. Otherwise this would get
> > > > cought out by CFI and cause a panic.
> > > > 
> > > > Use enums from netdev_tx_t as return value instead, then change return
> > > > type to netdev_tx_t.
> > > > 
> > > > Suggested-by: Dan Carpenter <error27@gmail.com>
> > > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > > ---
> > > > Tested with rtl8192e
> > > > Transferred this patch over wlan connection of rtl8192e
> > > > ---
> > > >   drivers/staging/rtl8192e/rtllib.h    |  2 +-
> > > >   drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
> > > >   2 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > Someone sent the same patch before you did:
> > > 	https://lore.kernel.org/r/20220905130053.10731-1-guozihua@huawei.com
> > > 
> > 
> > This patch does not apply to my tree either :(
> > 
> > Please rebase and resubmit.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Sorry Greg,
> 
> I cannot find my error.
> I just downloaded the patch and applied it to the staging-next branch and
> that worked fine.

Try the staging-testing branch please.

thanks,

greg k-h
