Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02269610CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJ1JRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1JRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECE1C69EA;
        Fri, 28 Oct 2022 02:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12609626C2;
        Fri, 28 Oct 2022 09:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E775CC433D7;
        Fri, 28 Oct 2022 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666948628;
        bh=QYTUjeWCWVOv+PHsUUrYftAhlJD6Nl7P/CQ1gw9EUiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLkFDgjTqqK3a5hjfEQ2jY4cFnTqAIR/m35tcaC3BtLjQocfVUDRF0Vr0Z0N/328d
         9N/YnKS0iZhIv6CxaxqqpSD6F7lXioCTkLHp/6nQW+SDxDfOgujODIt5Y3BNpkox5c
         2wzUkYpxpd7QjuIiFZNDR9Yf0PiVZ8w0cqFw1uFs=
Date:   Fri, 28 Oct 2022 11:17:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Lei Yu <yulei.sh@bytedance.com>, Felipe Balbi <balbi@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
Message-ID: <Y1ueEYJk2epT/g4J@kroah.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:04:52AM +0000, Neal Liu wrote:
> > > Thanks for your feedback.
> > > I tried to reproduce it on my side, and it cannot be reproduce it.
> > > Here are my test sequences:
> > > 1. emulate one of the vhub port to usb ethernet through Linux gadget
> > > (ncm)
> > 
> > We are using rndis instead of ncm.
> > 
> > > 2. connect BMC vhub to Host
> > > 3. BMC & Host can ping each other (both usb eth dev default mtu is
> > > 1500) 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu to
> > > 2000, it's maxmtu is 1500)
> > 
> > Not sure if it's related, but in my case (USB rndis, Debian 10 OS) it should be
> > able to set MTU to 2000.
> 
> Using rndis is able to set MTU to 2000, and the issue can be reproduced.

Please NEVER use rndis anymore.  I need to go just delete that driver
from the tree.

It is insecure-by-design and will cause any system that runs it to be
instantly compromised and it can not be fixed.  Never trust it.

Even for data throughput tests, I wouldn't trust it as it does odd
things with packet sizes as you show here.

thanks,

greg k-h
