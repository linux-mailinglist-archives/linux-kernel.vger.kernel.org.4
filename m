Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C1724A69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbjFFRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbjFFRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C621715
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF83463084
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C6C433EF;
        Tue,  6 Jun 2023 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686072932;
        bh=UMECjLyKoDgOf1iUuBeZPH1zIg/2fRCfJk9pDlTsHQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqT3L7twwNcgZtv2Qal4xTrQtgcIcBBSGh0V8Hza8T3qJtrRUQOWGXcCx8YKz+AHh
         vnuX1cedxDU847HfDMHLMFJVI3rTMk6daRzJVTRc38R9HmuMWGvJE8qxgfy83qiHBz
         tl2Br7T/aaaRqpFEWxY2+vqzVwOPeCa3li3wrKLE=
Date:   Tue, 6 Jun 2023 19:35:29 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Moti Haimovski <mhaimovski@habana.ai>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "david.m.ertman@intel.com" <david.m.ertman@intel.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] make AUXILIARY_BUS config selection clearer
Message-ID: <2023060655-dictation-abrasion-5d44@gregkh>
References: <20230606133528.197335-1-mhaimovski@habana.ai>
 <20230606-aspirate-evident-00b27a98a718@wendy>
 <AM9PR02MB7706888212798FE0CC8213D6D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
 <20230606-sushi-clunky-8e816f5b206d@spud>
 <AM9PR02MB7706F1E489D4B54E9502D4B4D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9PR02MB7706F1E489D4B54E9502D4B4D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:28:17PM +0000, Moti Haimovski wrote:
> 
> 
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, 6 June 2023 18:05
> > To: Moti Haimovski <mhaimovski@habana.ai>
> > Cc: Conor Dooley <conor.dooley@microchip.com>;
> > gregkh@linuxfoundation.org; david.m.ertman@intel.com;
> > ogabbay@kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] make AUXILIARY_BUS config selection clearer
> > 
> > On Tue, Jun 06, 2023 at 02:50:21PM +0000, Moti Haimovski wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com> On Tue, Jun 06,
> > 2023
> > > > at 04:35:28PM +0300, Moti Haimovski wrote:
> > > > > Add a display string and a help section to the config
> > > > > AUXILIARY_BUS section under the "Generic Driver Options" menu in
> > > > > order to make its selection clearer.
> > > >
> > > > I am a wee bit confused, since it is not explicitly mentioned here,
> > > > why is this now going to be user visible/selectable? What was wrong
> > > > with the drivers that needed it selecting it?
> > 
> > (please don't top post)
> > 
> > >  Noting is wrong with the drivers 😊
> > >
> > > I've stumbled that issue when trying to figure-out how to manipulate
> > > the auxiliary-bus selection Via "make menuconfig"
> > > The issue is that with the current Kconfig when you run " make
> > menuconfig" and enter the
> > > Device Drivers --->     Generic Driver Options --->   Sub-menu then there is
> > no mentioning of
> > >  the Auxiliary bus although it is the first entry in drivers/base/Kconfig that
> > this menu is presenting.
> > > So, the user has no idea that this option exists and no way to manipulate it
> > via menconfig.
> > 
> > That's the point of how it currently is though, no?
> > We don't allow users to set the option, but rather any device driver that
> > needs it, selects it.
> > That way, a person configuring their kernel for some hardware just needs to
> > enable the drivers for their hardware and knowledge of kernel internals is
> > not needed.
> > 
> > Is there a particular driver, perhaps in drivers/accel, that does not select the
> > option, which is why you are trying to set it yourself?
> 
> No, nothing specific. Just saw it and thought it is an issue to address, 
> sent a private mail to the author (Dave Ertman <david.m.ertman@intel.com>)
> Who replied that he was unaware that it was a naked bool in the base/Kconfig file!
> And there is no reason that he is aware of for it to be that way.
> So, I've added it.

The reason is that as Conor says, it is not a user-selectable option, it
comes in by virtue of a driver that requires it enabling it, that's all.

thanks,

greg k-h
