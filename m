Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09E5F3CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJDGZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJDGZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:25:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBE3FA0C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:25:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F1BD6602295;
        Tue,  4 Oct 2022 07:25:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664864753;
        bh=SKezE7CWPgfXm3/Tax16ki0ozvuZApf+OIft4DuG+TM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d5A3QyxXIONb9g6i9SwSEDngbB3UVE68WGCDh6Eqf1TvYBaE4WPlbOPZDrBZsdbal
         e76ze1NblpyWg3cdAk2YWNkjWt6Fg7/h1KEg/YKTB55AzC0K9zA9gejwc5tC2+SFPx
         BBe71DW3+g/e7Z7/dxB+HUuFta6LX8qNSI7im0JdaYeA48A3ufeH732YysQSIYwpyc
         PtKmb5jWiCtCCX8y+r35dzMDgayFKIPkQaDrZ0Gi2wx/MQFZKzkV9KkAN5xF8VjGgC
         SVMgr/ZQuoY7LfH1NYJK0zm6nliJ/f6itWWK/lqKDEeEOxZPs6andwiYeOVE6w1bxu
         RHI+hWP6DKM0A==
Date:   Tue, 4 Oct 2022 08:25:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Message-ID: <20221004082550.1c819fc8@collabora.com>
In-Reply-To: <482a4114-eeb1-2303-2896-8e480abda876@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
        <482a4114-eeb1-2303-2896-8e480abda876@alliedtelesis.co.nz>
Organization: Collabora
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 21:46:31 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> Hi All,
> 
> On 27/09/22 15:47, Chris Packham wrote:
> > From: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> >
> > Originally the absence of the marvell,nand-keep-config property caused
> > the setup_data_interface function to be provided. However when
> > setup_data_interface was moved into nand_controller_ops the logic was
> > unintentionally inverted. Update the logic so that only if the
> > marvell,nand-keep-config property is present the bootloader NAND config
> > kept.
> >
> > Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> > Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>  
> 
> Just following up on this. I know things have probably been busy with 
> the 6.0 release but it's been a week so I figured I'd give this a bump.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> > ---
> >
> > Notes:
> >      I think this is a bug that's been lurking for 4 years or so. I'm not
> >      sure that's particularly long in the life of an embedded device but it
> >      does make me wonder if there have been other bug reports about it.
> >      
> >      We noticed this because we had a bootloader that used maxed out NAND
> >      timings which made the time it took the kernel to do anything on the
> >      file system longer than we expected.
> >
> >   drivers/mtd/nand/raw/marvell_nand.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> > index 2455a581fd70..b248c5f657d5 100644
> > --- a/drivers/mtd/nand/raw/marvell_nand.c
> > +++ b/drivers/mtd/nand/raw/marvell_nand.c
> > @@ -2672,7 +2672,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
> >   	chip->controller = &nfc->controller;
> >   	nand_set_flash_node(chip, np);
> >   
> > -	if (!of_property_read_bool(np, "marvell,nand-keep-config"))
> > +	if (of_property_read_bool(np, "marvell,nand-keep-config"))
> >   		chip->options |= NAND_KEEP_TIMINGS;
> >   
> >   	mtd = nand_to_mtd(chip)  

