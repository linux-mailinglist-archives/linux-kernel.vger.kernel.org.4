Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7E6A6FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCAPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCAPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:35:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C50311EC;
        Wed,  1 Mar 2023 07:35:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D3E5CE1D0A;
        Wed,  1 Mar 2023 15:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC7C433D2;
        Wed,  1 Mar 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677684896;
        bh=4+Tu/cIC0hHMrGoD7ESG5uRx2d2hbjOQ2mt+puZ4g0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfUaAtP4P5sN1WaMFyAPHgvMfQZ6Une0MYHJigdyMNeT154pPRgujXPqmYJAzpAwE
         4EoJtLlU+N3/77Jvhxxcn8K+aTRDG4FVBCM0EUR9KZVx5Wmo+u4fiAmEWXFGIxTIVG
         I+xhSmVEzka1keAMhr6IJ++XwZcv7YPvwWgqOm2s=
Date:   Wed, 1 Mar 2023 16:34:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
Message-ID: <Y/9wnXde3OiyHh8S@kroah.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301152239.531194-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 04:22:31PM +0100, Miquel Raynal wrote:
> Hello,
> 
> Following Greg's opposition to merge the current nvmem layout support
> proposal [1], arguing that it would eventually grow the size of the
> Linux kernel and asking for some "modularization" support, here is a
> proposal to turn layout drivers into regular tristate drivers.
> 
> The first three patches are preparation changes in order to extend (and
> fix) a little bit the of/device.c support. The fix does not seem to
> impact most of the current users so I guess it can live with the rest of
> the series in order to avoid future merge conflicts.
> 
> The nvmem core is then extended to support the absence of layouts and
> possibly lead to probe deferrals when relevant.
> 
> Finally, the two existing layout drivers are converted into modules and
> their Kconfig symbols changed to tristate.
> 
> The base series on which these changes apply is still contained in [1],
> I would prefer to keep it as it was and apply this series on top of it.
> 
> Tests have been conducted on a Marvell Prestera switch with the mvpp2
> Ethernet driver calling for a MAC address stored in the ONIE TLV table
> available through a layout driver in an EEPROM/MTD device.
> 
> [1] https://github.com/miquelraynal/linux/tree/nvmem-next/layouts

These look sane to me, thanks for making the changes.

greg k-h
