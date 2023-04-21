Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9E6EA8DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDULJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDULJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43193F6;
        Fri, 21 Apr 2023 04:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D01061654;
        Fri, 21 Apr 2023 11:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF3FC433EF;
        Fri, 21 Apr 2023 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682075350;
        bh=lmNia07ZER0CBxltSg2zLh3RRHlpope5dUs5elkjwww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJohQZI/1n5YgSB2/dKB/fsfDxMle61fpiSt9jLuEWEOTbBdZzVlsl5iMwsFNU0bj
         9rHI6npDEXkTk+KznKGXkIP/l7QQGUH1TaIIj0wH02wAHI7yZDHZvBQQQ0xeOFmlPH
         f7F9c4pqac8HEgPC6aHfMWe45hiItfdNJkjQXa8k=
Date:   Fri, 21 Apr 2023 13:08:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: phy: add usb phy notify port status API
Message-ID: <ZEJux2KTnGw-WE1A@kroah.com>
References: <20230421080333.18681-1-stanley_chang@realtek.com>
 <ZEJHLR27pVwVI3_J@kroah.com>
 <efd6e621210a407db9c153712f362366@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efd6e621210a407db9c153712f362366@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:32:19AM +0000, Stanley Chang[昌育德] wrote:
> > 
> > On Fri, Apr 21, 2023 at 04:03:31PM +0800, Stanley Chang wrote:
> > > In Realtek SoC, the parameter of usb phy is designed to can dynamic
> > > tuning base on port status. Therefore, add a notify callback of phy
> > > driver when usb port status change.
> > >
> > > Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> > > ---
> > >  drivers/usb/core/hub.c  | 13 +++++++++++++  include/linux/usb/phy.h |
> > > 14 ++++++++++++++
> > >  2 files changed, 27 insertions(+)
> > 
> > We can not add callbacks in the kernel that are not actually used, otherwise
> > they will just be instantly removed.
> > 
> > Please submit any drivers that need this change at the same time so that we
> > can verify that the callback is actually correct and needed, otherwise we can
> > not take this change.
> > 
> 
> In this stage, we usb phy driver is not at linux upstream. 

Then obviously we can not take this change (nor would you want us to.)

> For the android GKI, we have to add this callback to upstream or use the vendor hook of android.
> I will plan to upstream the realtek usb phy driver.

As you already have this driver, why not send it to us now?

thanks,

greg k-h
