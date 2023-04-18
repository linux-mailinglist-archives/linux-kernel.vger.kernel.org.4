Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24D6E5D31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDRJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A44ED0;
        Tue, 18 Apr 2023 02:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD02623EA;
        Tue, 18 Apr 2023 09:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E5C433EF;
        Tue, 18 Apr 2023 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681809502;
        bh=21GaLtq11RA+qsTtJLEfA6pcxGxP9rB+BSO0oKeaE90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ql7DNEQjyGtJ7hlrXC5JPkAFTc6KYKvg213Jf1M5u82abnDjXDMTf2ohQjKY+0D/i
         XFIS87svl+ekXS7pYLf7wH80GSaR3Run/ghC+Kzke2BQQQDSitYp60xwvTNzNrPsj7
         7Z56EF9yJ6baFyECrd0NRmvOIUJlRVqTczCz1HVg=
Date:   Tue, 18 Apr 2023 11:18:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     VaibhaavRam.TL@microchip.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        arnd@arndb.de
Subject: Re: [PATCH v9 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
Message-ID: <2023041825-reviving-property-3e3a@gregkh>
References: <20230413105318.6070-1-vaibhaavram.tl@microchip.com>
 <20230413105318.6070-2-vaibhaavram.tl@microchip.com>
 <51847629489852d493af928580c5a2de@walle.cc>
 <49405ea2bb0bee16a41ce88b7d679ff714823585.camel@microchip.com>
 <8b7b98e60fd871cc7aafda6f9b4e146a@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b7b98e60fd871cc7aafda6f9b4e146a@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:00:18AM +0200, Michael Walle wrote:
> Am 2023-04-17 14:47, schrieb VaibhaavRam.TL@microchip.com:
> > > > +#include <linux/auxiliary_bus.h>
> > > > +#include <linux/bio.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <linux/kthread.h>
> > > 
> > > Is this needed? I don't see any threads. Also bio.h. Please double
> > > check
> > > your includes.
> > Ok, Will remove in next version of patch
> > > > +     if (priv != NULL)
> > > > +             rb = priv->reg_base;
> > > > +     else
> > > > +             return -ENODEV;
> > > 
> > > Unneeded check, priv cannot be NULL, right?
> > Ok, I think this can be removed
> > > > +
> > > > +             data = readl(rb +
> > > > MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> > > > +             if (ret < 0 || data & OTP_FAIL_BIT)
> > > > +                     break;
> > > 
> > > No error handling?
> > We have implemented short read which returns count of successful bytes
> > read and therefore userspace will recognise the situation when the
> > requested count is not obtained.
> 
> I'll leave that up to Greg, but I'd prefer a proper error to userspace.
> I'm not sure if you'd need to differentiate between a short read/write
> and an error.

A short read isn't an error, it's just returning the amount of data
present which might be less than the buffer passed in, which is totally
normal.  If there is an error, return an error.

thanks,

greg k-h
