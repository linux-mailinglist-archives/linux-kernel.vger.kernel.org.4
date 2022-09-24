Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97975E8A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiIXIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiIXIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AADB969
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D925611C1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B163C433C1;
        Sat, 24 Sep 2022 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664009184;
        bh=CcEEfEzmwgcNfVrRYjABgYWLl6nWS4p/VMRs14C4hro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcHsy0doGginUWgjwPxrp/H3kbhKcR4wIR9uNQQ/y2NSfOaAbIxgWKy3EwT603iED
         XY9RVIObc13AtgwD7/bwikbPyhbB/B7t20TyA76f+9S1iEq09XNdt0HD2auwzdUQWI
         lNXIAUeSSq5oAi55bY0bEi9xg75LB4+61I0PW+uU=
Date:   Sat, 24 Sep 2022 10:46:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix memory leak when using debugfs_lookup()
Message-ID: <Yy7D3hmH9dYDUsdR@kroah.com>
References: <20220902133724.278133-1-gregkh@linuxfoundation.org>
 <bcd0cc5153457fb52566519a76e7b5b4@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd0cc5153457fb52566519a76e7b5b4@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 04:01:36PM +0200, Michael Walle wrote:
> Hi,
> 
> Am 2022-09-02 15:37, schrieb Greg Kroah-Hartman:
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  Fix this up to be much
> > simpler logic and only create the root debugfs directory once when the
> > driver is first accessed.  That resolves the memory leak and makes
> > things more obvious as to what the intent is.
> > 
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Cc: Pratyush Yadav <pratyush@kernel.org>
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mtd/spi-nor/debugfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/debugfs.c
> > b/drivers/mtd/spi-nor/debugfs.c
> > index df76cb5de3f9..3aab595e82d1 100644
> > --- a/drivers/mtd/spi-nor/debugfs.c
> > +++ b/drivers/mtd/spi-nor/debugfs.c
> > @@ -228,11 +228,11 @@ static void spi_nor_debugfs_unregister(void *data)
> > 
> >  void spi_nor_debugfs_register(struct spi_nor *nor)
> >  {
> > -	struct dentry *rootdir, *d;
> > +	static struct dentry *rootdir;
> > +	struct dentry *d;
> >  	int ret;
> > 
> >  	/* Create rootdir once. Will never be deleted again. */
> > -	rootdir = debugfs_lookup(SPI_NOR_DEBUGFS_ROOT, NULL);
> 
> IIRC I had that one and it didn't work with spi-nor as a module.
> Wouldn't it try to create the root dir twice if you remove the module
> and load it again?

Yes it would, that is a use-model I did not consider at all, thanks.
I'll rework this.

greg k-h
