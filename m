Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74B5EA817
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiIZONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIZOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:12:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97D13F10;
        Mon, 26 Sep 2022 05:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 515C5CE112F;
        Mon, 26 Sep 2022 12:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1FFC433C1;
        Mon, 26 Sep 2022 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664195001;
        bh=zJEciUTP3+aG+EbLavhrKXahpwLSGkfJv3iF/kQWSrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbyrea2moJjfhNJ9wppnS3mkMIjCqY+vQS3CSOZmxwWQLx2eKP4kMjgE8qZhWtNoJ
         pKmIH6TZssORI4AHPo4YmeV5a0KOXEneaudIRGSfdCrvYNCKtXmMBAms/hPJNugGGT
         RgKyTfEuHOekvEeRbOsJVLIX7g84Sl3d5tiC4EdhdazO5hPiifXbcPUW39bO6Ykqhs
         5ft4KC7n8I5kEgVvh/gXW+A965RPTidsNMZ2KmZWVF5c+Ksw5NYSMuYDTrAKHIRn40
         n99d1dmKGuwTJe6IAkLgOvMKoP/dqEg8AFcY8NmYGnNj2lWGt7Opg07Z6qgAseJnyr
         KO+oaJCR9cPpQ==
Received: by pali.im (Postfix)
        id 54A1D8A3; Mon, 26 Sep 2022 14:23:18 +0200 (CEST)
Date:   Mon, 26 Sep 2022 14:23:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     maukka@ext.kapsi.fi, Andrew Lunn <andrew@lunn.ch>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
Message-ID: <20220926122318.qmt4dnes7caua333@pali>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
 <Yy2iqE8XgXe8qYd9@lunn.ch>
 <20220923180226.vmjcefxlujg2r6u3@pali>
 <74f2b413a617a4315cc34a0ef386dd8d@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74f2b413a617a4315cc34a0ef386dd8d@ext.kapsi.fi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Elad! I hope that would not bothering you. We are doing here
cleanup of kernel code for older Marvell SoCs (Orion) and there one
unknown thing about 88F5181's 0x10008 register. See below.

On Monday 26 September 2022 14:56:48 maukka@ext.kapsi.fi wrote:
> On 23.9.2022 21:02, Pali Rohár wrote:
> > On Friday 23 September 2022 14:12:24 Andrew Lunn wrote:
> > > > > > +	if (of_machine_is_compatible("dlink,dns323a1")) {
> > > > > > +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
> > > > >
> > > > > I spotted this in dns323-setup.c as well. Do you have any idea what it
> > > > > does?
> > > > >
> > > >
> > > > No idea. I have tried to replicate what was in dns323-setup.c as exactly as
> > > > possible.
> > > > I can try to leave it out and see if anything changes.
> > > 
> > > It is best to keep what we don't understand. It will be there for a
> > > reason.
> > > 
> > > 	Andrew
> > 
> > Hello! I tried to index all publicly available Marvell SoC
> > documentations into kernel documentation subfolder:
> > https://docs.kernel.org/arm/marvell.html
> > 
> > For Orion there is linked Datasheet and User Manual, so you could try to
> > find in those documents that mentioned register and check what it is
> > doing.
> 
> MPP_DEV_CTRL refers to register at address 0x10008. According to the 88F5152
> user manual it's
> 'Device Multiplex Control Register' Offset: 0x10008.
> 
> Bits    Field     Type/InitVal     Description
> [31:0]  Reserved  RES 0x03FF0000   Reserved. NOTE: Must be 0x03FF0000'.
> 
> DEV_D[31:16] receives no hits in the documentation, only to DEV_D[15:0] are
> referred.

In linked public document I found same thing. Register is for 88F5182
reserved. (You have typo in comment, it is 88F5182, not *52).

> Maybe 88F5151 is different, hard to say.

I have feeling that for 88F5181 it is not reserved and has to be
configured correctly. (Also typo in your comment, it is 88F5181, not *51).
But I have not found any copy of 88F5181 user manual document on internet.

In past 88F518x and 88F528x documents and user manuals were available
publicly on Marvell website, visible from web archive:
https://web.archive.org/web/20080607215437/http://www.marvell.com/products/media/index.jsp

But Marvell deleted these documents from their public website and for
kernel developers they are now probably lost. I do not know about any
other backups.


Elad, could you please help us? Do you have access to functional
specifications / user manuals for 88F518x and 88F528x or have
information how kernel developers can get access to those documents?
Hopefully they were not totally lost. We just need explanation for
register 'Device Multiplex Control Register' Offset: 0x10008.
