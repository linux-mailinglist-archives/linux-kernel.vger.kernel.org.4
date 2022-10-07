Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E115F7A26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJGO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJGO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB9CA881;
        Fri,  7 Oct 2022 07:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E3F61D52;
        Fri,  7 Oct 2022 14:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E66C433C1;
        Fri,  7 Oct 2022 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665154618;
        bh=Zfvt0wexCVsNrahiRALkq97xPZe65m8xOeAuDN+wsto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpE/y38xZ2Q1aCWbYcYn4ZnB/6HDd5M74URvl1eMOjf4ZWjl55/dBMmyzIpmW8+oo
         aQaL0OrZgf/gowSxZAmTc2p8A6G9lZ+BThkrKMM3GpfKRNWRBdwi7+PGZBPNhWurlE
         awVjPVgO002qcVsZyKFhiaTG/LVEx/h9IXwvQZng=
Date:   Fri, 7 Oct 2022 16:57:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <Y0A+Y3uNzpzGx0Ey@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 07:34:25PM +0530, Manjunatha Venkatesh wrote:
> 
> On 9/14/2022 8:39 PM, Arnd Bergmann wrote:
> > Caution: EXT Email
> > 
> > On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
> > 
> > > NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> > > are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> > > Firmware Download on every device boot. More details on the SR1XX Family
> > > can be found athttps://www.nxp.com/products/:UWB-TRIMENSION
> > > 
> > > The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> > > Interface (UCI).  The corresponding details are available in the FiRa
> > > Consortium Website (https://www.firaconsortium.org/).
> > I know nothing about UWB, so I have no idea if the user interface
> > you propose here makes sense. My guess is that there is a good chance
> > that there are other implementations of UWB that would not work
> > with this specific driver interface, so you probably need a
> > slightly higher-level abstraction.
> > 
> > We had an older subsystem that was called UWB and that got removed
> > a while ago:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/uwb?id=caa6772db4c1deb5d9add48e95d6eab50699ee5e
> > 
> > Is that the same UWB or something completely different?
> Basically, it is SPI device driver which supports UCI(Ultra-wide band
> Command Interface) packet structure. It is not same as in mentioned link.

Why isn't this just a normal SPI driver and you do the "UCI" commands
from userspace through the device node there?

I know I asked this before, but I can't remember the answer, sorry, so
please include that in the changelog information when you resubmit.

thanks,

greg k-h
