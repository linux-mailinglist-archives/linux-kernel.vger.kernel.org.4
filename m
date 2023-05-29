Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45DD714CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjE2PHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2PHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:07:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AE9F;
        Mon, 29 May 2023 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=bVUwQzHP30Vg4mnAd3/C05krhQKpGJEL5ELBzTTg5EU=; b=iY
        WiSRLJ85N1umBhkytgtspGtffQRJTDGzvLb+wyVNgfqHF/VkMCy4dSdZukzAcVlwxQvdzCjzFz85W
        eKor92aBor5iDE31gc0inl0ZLOk329Cd8svpe8OJUJGhX0NnPvcZG/TR3aNHCLJHAoRzRDKF1H83B
        35y2vhwqftmpg38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q3eSc-00EEl8-VU; Mon, 29 May 2023 17:07:02 +0200
Date:   Mon, 29 May 2023 17:07:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <8f05a48c-37dc-457c-a9f8-8c7428ceba9b@lunn.ch>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
 <604467c7-c5d6-38b1-be98-42c7da031416@alliedtelesis.co.nz>
 <CACRpkdYGD5z4rrFsBGm8ihHEvWBep6sgqXPXSn2Q38jGod58GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYGD5z4rrFsBGm8ihHEvWBep6sgqXPXSn2Q38jGod58GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:19:02AM +0200, Linus Walleij wrote:
> On Wed, May 17, 2023 at 11:30 PM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> 
> > > Why does the MCU have no in-kernel driver?
> >
> > There isn't any PoE PSE infrastructure in the kernel. I'm not really
> > sure what it'd look like either as the hardware designs are all highly
> > customized and often have very specialized requirements. Even the vendor
> > reference boards tend to use the i2c userspace interface and punt
> > everything to a specialist application.
> >
> > Of course if anyone is thinking about adding PoE PSE support in-kernel
> > I'd be very keen to be involved.

There is net/ethtool/pse-pd.c.

      Andrew
