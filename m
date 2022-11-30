Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0D63CFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiK3HXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3HXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:23:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAE5A6FD;
        Tue, 29 Nov 2022 23:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B3361A43;
        Wed, 30 Nov 2022 07:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57062C433C1;
        Wed, 30 Nov 2022 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669793011;
        bh=BouBNRCk7VMkSrWdY9OTkq4jJTsEHyMSvB+y3ScjJAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ollyNHVLYcXcHoT4FP7JEYoPce0c8okKCP/xekRlPzvUftpZWCX85rCloGqoZn5ND
         ++Ig5LfkrBQiQpz6mrzGUTbjTeNSCjp4dTceNC9FKsbmSs5jWsluJcK2Asl6jgTFqm
         HUnsEOYmBNHeWWwl2J9CUwRewoJUltU+Ksv4jNMM=
Date:   Wed, 30 Nov 2022 08:23:28 +0100
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
Message-ID: <Y4cE8MvAS8bpcQmW@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
 <Y0A+Y3uNzpzGx0Ey@kroah.com>
 <dfe167cf-5d4e-6fc7-c954-25f719b1e843@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfe167cf-5d4e-6fc7-c954-25f719b1e843@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:39:59AM +0530, Manjunatha Venkatesh wrote:
> 
> On 10/7/2022 8:27 PM, Greg Kroah-Hartman wrote:
> > Caution: EXT Email
> > 
> > On Fri, Oct 07, 2022 at 07:34:25PM +0530, Manjunatha Venkatesh wrote:
> > > On 9/14/2022 8:39 PM, Arnd Bergmann wrote:
> > > > Caution: EXT Email
> > > > 
> > > > On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
> > > > 
> > > > > NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> > > > > are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> > > > > Firmware Download on every device boot. More details on the SR1XX Family
> > > > > can be found athttps://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fproducts%2F%3AUWB-TRIMENSION&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=y3t8eT%2BIX1OP%2B1wu%2B8hWp2HI%2FhnZj32L%2BDCcIA7m9hs%3D&amp;reserved=0
> > > > > 
> > > > > The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> > > > > Interface (UCI).  The corresponding details are available in the FiRa
> > > > > Consortium Website (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.firaconsortium.org%2F&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xhFUUcJ7a3oU6pefXHTunBCI73%2Fy2PnnwsTn1KZbeFk%3D&amp;reserved=0).
> > > > I know nothing about UWB, so I have no idea if the user interface
> > > > you propose here makes sense. My guess is that there is a good chance
> > > > that there are other implementations of UWB that would not work
> > > > with this specific driver interface, so you probably need a
> > > > slightly higher-level abstraction.
> > > > 
> > > > We had an older subsystem that was called UWB and that got removed
> > > > a while ago:
> > > > 
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fstaging%2Fuwb%3Fid%3Dcaa6772db4c1deb5d9add48e95d6eab50699ee5e&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gcF%2B%2FzD%2F0TWJ5AEJvXCGv5n%2FrPg2qXJigedOq4IeVPI%3D&amp;reserved=0
> > > > 
> > > > Is that the same UWB or something completely different?
> > > Basically, it is SPI device driver which supports UCI(Ultra-wide band
> > > Command Interface) packet structure. It is not same as in mentioned link.
> > Why isn't this just a normal SPI driver and you do the "UCI" commands
> > from userspace through the device node there?
> > 
> > I know I asked this before, but I can't remember the answer, sorry, so
> > please include that in the changelog information when you resubmit.
> > 
> > thanks,
> > 
> > greg k-h
> The IO Handshake needed with SR1XX Family of SOCs cannot use the RAW SPI
> Module's APIs and hence custom APIs are added for communication with the
> UWBS,

I do not understand, what "IO handshake"?  What is missing from the
userspace spi api that is needed here?

> With this will get required throughput for UWBS use cases to avoid multiple
> round trip between user  and kernel mode.

Based on the speed of the SPI bus, this should not be an issue at all.
If it is, please provide us real performance numbers showing the
problem, as there are ways of speeding that up.

thanks,

greg k-h
