Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6262EA17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiKRANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiKRANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:13:21 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE67666
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=PuApb2pByjk98IZchlL2evjxCv1+LxfcRXQWp9SAu+4=; b=N3
        T1+fOh2/fK1epLVAaYd7TGL8sFiN+NFvM7chaaz0tgCgVt47SzidXZxOPdBwpY7DenTAqvlI7+YOf
        GYaQDIYc2itiZLw9hEx1HYYuQd1V7kAr3n2uhbBjjQ5F4CEq6ARchcHubG35UTE8CuLheamsd8Xnl
        /UUeWE2S0sIYMaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ovozg-002kCI-PH; Fri, 18 Nov 2022 01:12:32 +0100
Date:   Fri, 18 Nov 2022 01:12:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in
 structures"
Message-ID: <Y3bN8I7DlxRUZumH@lunn.ch>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-2-umang.jain@ideasonboard.com>
 <166870135963.50677.14827688186331561108@Monstersaurus>
 <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
 <Y3Z3Is8u4wGZfKU5@kroah.com>
 <c5e03c65-2994-6518-c79d-f6ad1557c4e0@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e03c65-2994-6518-c79d-f6ad1557c4e0@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > >    struct vchiq_mmal_port {
> > > > > -       u32 enabled:1;
> > > > > +       bool enabled:1;
> > > > Is this a direct revert with 'git revert' ?
> > > 
> > > No. It had conflicts plus I added the ':1' initialization to keep the logic
> > > same (in case 'enabled' gets used directly). Similar pattern come up with:
> > >      ($) git grep 'bool' -- '*.[h]' | grep '\:1'
> > > 
> > > So it shouldn't be an issue.
> > Please don't do that "bool foo:1" makes no sense.  Drop the ":1"
> > please.
> 
> It won't affect this patch but if you take a look at 2/3 - you'll see a bool
> flag 'in_use' that needs to be initialized (as it's getting used directly).
> 
> I can move the initialization part in the function (_init() or something)
> and drop the ":1" as you mentioned. That's  fine as well but I do find
> patterns of 'bool foo:1' in the codebase so I assumed it would be safe to
> use.

Does :1 really initialise the variable? In "u32 enabled:1" it means
this is a 1 bit wide bit field. It seems odd that bool is somehow
special and :1 means something else.

	Andrew
