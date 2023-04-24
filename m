Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67256ECA72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDXKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDXKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D1358C;
        Mon, 24 Apr 2023 03:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A8B62039;
        Mon, 24 Apr 2023 10:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A91C433D2;
        Mon, 24 Apr 2023 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682332565;
        bh=/Af+Rd/o2c2r2mMbmyISnDuiLQcI1v2nbaVFsmdZWSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHxdlKTGOlPp9TgI+6vXg4eGrhIhkI2T7k5lGwru1WJz2RZdb3hBn6m2lTeB/dUt4
         VvVZXaPoThozJVpEEnWsWJezwXC9fEY0Q9qD+4KRgjbSOyDkmHaBix9RX0zaDsXsAe
         5X62UAQmJNM3YXav3JFpCgXW00wLyQZJlOQCVPyU=
Date:   Mon, 24 Apr 2023 12:36:02 +0200
From:   greg kroah-hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5qKB5a6H6Iiq?= <lihuya@hust.edu.cn>
Cc:     thinh nguyen <thinh.nguyen@synopsys.com>,
        "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] usb: dwc3: remove dead code in dwc3_otg_get_irq
Message-ID: <2023042437-bovine-brunette-c067@gregkh>
References: <20230323053946.53094-1-lihuya@hust.edu.cn>
 <20230324182853.rbguxi2lng2mhm3s@synopsys.com>
 <4d6dd98f.41e10.187b27043ca.Coremail.lihuya@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d6dd98f.41e10.187b27043ca.Coremail.lihuya@hust.edu.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 04:45:14PM +0800, 梁宇航 wrote:
> > -----Original Messages-----
> > From: "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>
> > Sent Time: 2023-03-25 02:28:56 (Saturday)
> > To: lihuya <lihuya@hust.edu.cn>
> > Cc: "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>, "hust-os-kernel-patches@googlegroups.com" <hust-os-kernel-patches@googlegroups.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] usb: dwc3: remove dead code in dwc3_otg_get_irq
> > 
> > On Thu, Mar 23, 2023, lihuya wrote:
> > > platform_get_irq() only return non-zero irq number on success, or
> > > negative error number on failure.
> > > 
> > > There is no need to check the return value of platform_get_irq()
> > > to determine the return value of dwc3_otg_get_irq(), removing
> > > them to solve this problem.
> > > 
> > > Signed-off-by: lihuya <lihuya@hust.edu.cn>
> > > ---
> > >  drivers/usb/dwc3/drd.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> > > index 039bf241769a..c2e09700212d 100644
> > > --- a/drivers/usb/dwc3/drd.c
> > > +++ b/drivers/usb/dwc3/drd.c
> > > @@ -154,11 +154,6 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
> > >  		goto out;
> > >  
> > >  	irq = platform_get_irq(dwc3_pdev, 0);
> > > -	if (irq > 0)
> > > -		goto out;
> > > -
> > > -	if (!irq)
> > > -		irq = -EINVAL;
> > >  
> > >  out:
> > >  	return irq;
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > 
> > Thanks,
> > Thinh
> 
> Hi Thinh,
> 
> I'm checking in about my patch submission for usb dwc3 that was 
> "ack'ed" on 3/25, but hasn't been merged into the subtree yet. 
> Could you please provide me with an update on its status and let 
> me know if there are any issues or concerns that need to be addressed?

It's not in my queue anywhere, so it needs to be resent if anyone wants
this applied.

thanks,

greg k-h
