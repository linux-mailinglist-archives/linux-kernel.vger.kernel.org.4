Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269DD682AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjAaKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAaKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:42:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15E2103
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F88B819A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DDBC433D2;
        Tue, 31 Jan 2023 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675161717;
        bh=eGUAfG1aA+cV1cJFm8hH6BQTvwivBct/NtMbkr2+k4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5f/31hq3NBgmw6DUNbDymxmJkeo4fnrX0famO5jn0ou4o5kBwSKAgcItySPfZR87
         Op/bJQIPztaPn165N89UnAHgX0AivODxVJQDprq1STuc/GgEA1Vm0cNX39YwPaXFgQ
         xCk0VwLkAAcIzUz0iEBqsElm+orKp929Fy/4i5CU=
Date:   Tue, 31 Jan 2023 11:41:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9jwcdYcFQ9f8+mR@kroah.com>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
 <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:19:36AM +0100, Guru Mehar Rachaputi wrote:
> On Tue, Jan 31, 2023 at 06:22:23AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 31, 2023 at 03:11:38AM +0100, Guru Mehar Rachaputi wrote:
> > > (struct pi433_tx_cfg)->bit_rate is modified from u16 to u32 to
> > > support bit rates up to 300kbps per the spec
> > 
> > What spec?
> > 
> > And how can changing the size of a variable that crosses the user/kernel
> > boundry like this change the bit rate max?
> >
> Honestly, I followed the TODO file suggestion.

Do you have this hardware to test with?

> > > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > > ---
> > >  drivers/staging/pi433/pi433_if.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > > index 25ee0b77a32c..1f8ffaf02d99 100644
> > > --- a/drivers/staging/pi433/pi433_if.h
> > > +++ b/drivers/staging/pi433/pi433_if.h
> > > @@ -51,7 +51,7 @@ enum option_on_off {
> > >  #define PI433_TX_CFG_IOCTL_NR	0
> > >  struct pi433_tx_cfg {
> > >  	__u32			frequency;
> > > -	__u16			bit_rate;
> > > +	__u32			bit_rate;
> > >  	__u32			dev_frequency;
> > >  	enum modulation		modulation;
> > >  	enum mod_shaping	mod_shaping;
> > 
> > And didn't you just break existing userspace code?  If not, how?  If so,
> > how did you test this?
> >
> My apologies, I did not study code. While testing, the probe function of
> pi433 driver didn't appear in the lsmod operation. I suspected my
> testing was wrong.

You have to test the existing applications that talk to the device to
ensure that this works properly.  This change just breaks the
user/kernel api and doesn't actually change anything to work different
than that :(

thanks,

greg k-h
